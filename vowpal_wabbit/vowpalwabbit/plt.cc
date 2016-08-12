#include <float.h>
#include <math.h>
#include <stdio.h>
#include <sstream>
#include <unordered_map>
#include <unordered_set>
#include <algorithm>
#include <vector>
#include <queue>

#include "reductions.h"
#include "vw.h"

using namespace std;
using namespace LEARNER;

#define MY_LOG false
#define LOG if(MY_LOG) cout

#define MULTILABEL

typedef struct{
    uint32_t n;
    float p;
} node;

typedef struct{
    uint32_t l;
    float p;
} label;

struct plt {
    vw* all;
    uint32_t k; // number of labels
    uint32_t t; // number of tree nodes
    float inner_threshold;  // inner threshold
    bool positive_labels;   // print positive labels
};

// y = f(x) -> [0, 1]
inline float logistic_link(float in) { return 1.0f / (1.0f + exp(-in)); }

void learn_node(plt& p, base_learner& base, example& ec, uint32_t n, bool positive) {

    LOG << "\nLEARN NODE: N: " << n << " P?: " << positive << " ";
    ec.l.simple = { positive ? 1.f : -1.f, 0.f, 0.f};
    base.learn(ec, n);

    LOG << " PP: " << ec.partial_prediction << " S: " << ec.pred.scalar << " P: " << ec.pred.prob;

}

void learn(plt& p, base_learner& base, example& ec){

    std::string tag(ec.tag.begin());
    LOG << "LEARN EXAMPLE: TAG: " << tag << " ";

    // multiclass only
    //MULTICLASS::label_t ld = ec.l.multi;

    // multilabel - doesn't work?
    //MULTILABEL::labels multilabels = ec.l.multilabels;

    // multilabel with cost
    COST_SENSITIVE::label ec_labels = ec.l.cs; //example labels

    unordered_set<uint32_t> n_positive; // positive nodes
    unordered_set<uint32_t> n_negative; // negative nodes

    if (ec_labels.costs.size() > 0) {

        for (auto& cl : ec_labels.costs) {
            LOG << "L: " << cl.class_index << ":" <<cl.partial_prediction << " ";

            // leaf index ( -2 because labels in {1..k})
            uint32_t tn = cl.class_index + p.k - 2;
            n_positive.insert(tn);

            LOG << tn << " ";
            while(tn > 0) {
                tn = floor((tn - 1)/2);
                LOG << tn << " ";
                n_positive.insert(tn);
            }
        }

        queue<uint32_t> n_queue; // nodes queue
        n_queue.push(0);

        while(!n_queue.empty()) {
            uint32_t n = n_queue.front(); // current node index
            n_queue.pop();

            if (n < p.k - 1) {
                uint32_t n_left_child = 2 * n + 1; // node left child index
                uint32_t n_right_child = 2 * n + 2; // node right child index

                bool n_left_child_positive
                        = n_positive.find(n_left_child) != n_positive.end();
                bool n_right_child_positive
                        = n_positive.find(n_right_child) != n_positive.end();

                if (n_left_child_positive) {
                    n_queue.push(n_left_child);
                    if (!n_right_child_positive)
                        n_negative.insert(n_right_child);
                }

                if (n_right_child_positive) {
                    n_queue.push(n_right_child);
                    if (!n_left_child_positive)
                        n_negative.insert(n_left_child);
                }
            }
        }
    }
    else
    {
        n_negative.insert(0);
    }

    for(auto& n : n_positive)
        learn_node(p, base, ec, n, true);

    for(auto& n : n_negative)
        learn_node(p, base, ec, n, false);

    ec.l.cs = ec_labels;

    LOG << "\nLEARN END\n";
}

void predict_node(plt& p, base_learner& base, example& ec, uint32_t n) {

    LOG << "\nPREDICT NODE: N: " << n << " ";
    ec.l.simple = {FLT_MAX, 0.0f, 0.0f};
    base.predict(ec, n);

    LOG << " PP: " << ec.partial_prediction << " S: " << ec.pred.scalar << " P: " << ec.pred.prob;

}

void predict(plt& p,  base_learner& base, example& ec){

    std::string tag(ec.tag.begin());
    LOG << "PREDICT EXAMPLE: TAG: " << tag << " ";

    COST_SENSITIVE::label ec_labels = ec.l.cs; //example's labels
    float *ec_probs = calloc_or_throw<float>(p.k);

    queue<node> node_queue;
    vector<label> label_positive;

    node_queue.push({0, 1.0f});

    while(!node_queue.empty()) {
        node node = node_queue.front(); // current node
        node_queue.pop();

        predict_node(p, base, ec, node.n);
        float cp = node.p * logistic_link(ec.pred.scalar); // current probability
        //float cp = 0;

        if(cp > p.inner_threshold) {

            if (node.n < p.k - 1) {
                uint32_t n_left_child = 2 * node.n + 1; // node left child index
                uint32_t n_right_child = 2 * node.n + 2; // node right child index
                node_queue.push({n_left_child, cp});
                node_queue.push({n_right_child, cp});
            }
            else{
                uint32_t l = node.n - p.k + 2;

                LOG << "\nPOSITIVE LABEL: "<< l << ":" << cp;

                label_positive.push_back({l, cp});
                ec_probs[l - 1] = cp;
            }
        }
    }

    if(p.positive_labels){
        ec.pred.probs = ec_probs;
    }

    ec.l.cs = ec_labels;

    LOG << "\nPREDINCT END\n";
}

void finish_example_positive_labels(vw& all, plt& p, example& ec){

    //TODO: raport losses, weight, features

    std::string tag(ec.tag.begin());
    LOG << "FINISH EXAMPLE: TAG: " << tag << " ";

    uint32_t pred = 0;
    for (uint32_t i = 1; i < p.k; ++i)
        if (ec.pred.probs[i] > ec.pred.probs[pred])
            pred = i;
    pred++; // prediction is {1..k} index (not 0)

    char temp_str[10];
    ostringstream output_stream;
    for (uint32_t i = 0; i < p.k; ++i) {
        if (ec.pred.probs[i] > p.inner_threshold) {
            if (i > 0) output_stream << ' ';
            if (all.sd->ldict) {
                substring ss = all.sd->ldict->get(i + 1);
                output_stream << string(ss.begin, ss.end - ss.begin);
            }
            else
                output_stream << i + 1;

            sprintf(temp_str, "%f", ec.pred.probs[i]);
            output_stream << ':' << temp_str;
        }
    }
    for (int sink : all.final_prediction_sink)
        all.print_text(sink, output_stream.str(), ec.tag);

    all.sd->update(ec.test_only, 0.0f, ec.l.multi.weight, ec.num_features);

    MULTICLASS::print_update_with_probability(all, ec, pred);
    free(ec.pred.probs);
    VW::finish_example(all, &ec);
}

void pass_end(plt& p){
    LOG << "END OF PASS(EPOCH) " << p.all->passes_complete << "\n";
}

void examples_end(plt& p){
    LOG << "END OF ALL EXAMPLES\n";
}

void finish(plt& p){
    LOG << "FINISH\n";
}

void save_load(plt& p, io_buf& model_file, bool read, bool text){
    LOG << "ADDITIONAL SAVE/LOAD\n";
}

base_learner* plt_setup(vw& all) //learner setup
{
    if (missing_option<size_t, true>(all, "plt", "Use probabilistic label tree for multiclass/label with <k> labels"))
        return nullptr;
    new_options(all, "plt options")
            ("inner_threshold", po::value<float>(), "threshold for positive label (default 0.15)")
            ("positive_labels", "print all positive labels");
    add_options(all);

    plt& data = calloc_or_throw<plt>();
    data.k = (uint32_t)all.vm["plt"].as<size_t>();
    data.t = 2 * data.k - 1;
    data.inner_threshold = 0.15;
    data.positive_labels = false;
    data.all = &all;

    // multiclass learner and parser
    learner<plt> &l = init_multiclass_learner(&data, setup_base(all), learn, predict, all.p, data.k);

    //learner<plt> &l = init_learner(&data, setup_base(all), learn, predict);

    // override parser type with multilabel with cost parser
    all.p->lp = COST_SENSITIVE::cs_label;
    all.cost_sensitive = make_base(l);

    // parse options
    if (all.vm.count("inner_threshold"))
        data.inner_threshold = all.vm["inner_threshold"].as<float>();

    if( all.vm.count("positive_labels") ) {
        data.positive_labels = true;
        l.set_finish_example(finish_example_positive_labels);
    }

    // override parser type with multilabel parser - doesn't work?
    //all.p->lp = MULTILABEL::multilabel;
    //all.delete_prediction = MULTILABEL::multilabel.delete_label;

    // register other functions
    //l.set_save_load(save_load);
    //l.set_end_pass(pass_end);
    //l.set_end_examples(examples_end);
    //l.set_finish(finish);

    LOG << "PLT: K: " << data.k << " T: " << data.t << " IT: " << data.inner_threshold << "\n";


    return all.cost_sensitive;

    //if multiclass/multilabel
    //return make_base(l);
}


