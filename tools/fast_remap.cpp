#include <fstream>
#include <iostream>
#include <string>
#include <vector>
#include <algorithm>
#include <unordered_set>
#include <unordered_map>

using namespace std;

inline vector<string> split(string text, char d = ' '){
    vector<string> result;
    const char *str = text.c_str();

    do {
        string str_d = string("") + d;
        const char *begin = str;
        while(*str != d && *str) ++str;
        string token = string(begin, str);
        if(token.length() && token != str_d)
            result.push_back(string(begin, str));
    } while (0 != *str++);

    return result;
}

inline size_t labelsSubStrEndPos(string line){
    size_t i = 0;
    while (line[i] != '|' && line[i] != ':' && i < line.length()) ++i;
    if (i >= line.length() && line[i] == ':') return 0;
    else return i;
}

int main(int argc, char* argv[]) {

    size_t lowestLabel = 1, highestLabel = 0, realLowestLabel = -1;
    vector<int> labelsVector;
    string line;

    if (argc < 2) {
        cout << "Not enough arguments.\n";
        exit(1);
    }

    // Map labels
    {
        cout << "Collecting classes/labels ...\n";
        unordered_set<int> labelsSet;

        for (int i = 1; i < argc; ++i) {
            string filePath = string(argv[i]);

            ifstream originalFile;
            originalFile.open(filePath);

            while (getline(originalFile, line)) {
                size_t i = labelsSubStrEndPos(line);
                if(i == 0) continue;

                auto lineLabels = split(line.substr(0, i), ',');
                for (auto labelString : lineLabels) {
                    int label = stoi(labelString);
                    if (labelsSet.find(label) == labelsSet.end()) {
                        labelsSet.insert(label);
                        labelsVector.push_back(label);

                        if (realLowestLabel > label) {
                            realLowestLabel = label;
                            if (lowestLabel > label) lowestLabel = label;
                        }
                        else if (highestLabel < label) highestLabel = label;
                    }
                }
            }

            originalFile.close();
        }
    }

    // Check if classes/labels needs remapping
    int labelsRange = highestLabel - lowestLabel + 1;
    cout << "Real lowest label: " << realLowestLabel << endl;
    cout << "Lowest label: " << lowestLabel << endl;
    cout << "Highest label: " << highestLabel << endl;
    cout << "Range of labels: " << labelsRange << endl;
    cout << "Unique labels: " << labelsVector.size() << endl;

    if(labelsRange == labelsVector.size()){
        cout << "There is no need to remap classes/labels.\n";
        exit(0);
    }


    // Output remapped files
    {
        cout << "Remapping " << labelsVector.size() << " classes/labels ..." << endl;
        unordered_map<int, int> labelsMap;

        sort(labelsVector.begin(), labelsVector.end());
        for(int i = 0; i < labelsVector.size(); ++i) labelsMap.insert({labelsVector[i], i + lowestLabel});
        labelsVector.clear();

        for(int i = 1; i < argc; ++i){
            string filePath = string(argv[i]);

            ifstream originalFile;
            originalFile.open(filePath);

            ofstream newFile;
            newFile.open(filePath + ".remapped");

            while(getline(originalFile, line)) {
                size_t i = labelsSubStrEndPos(line);
                if(i == 0) continue;

                auto lineLabels = split(line.substr(0,i), ',');
                string lineFeatures = line.substr(i);

                for(auto labelString : lineLabels){
                    int label = stoi(labelString);
                    if(labelsMap.find(label) == labelsMap.end()){
                        cout << "Class/Label " << label << "doesn't have mapping!\n";
                        exit(1);
                    }
                    newFile << labelsMap[label] << " ";
                }

                newFile << lineFeatures << endl;

            }

            originalFile.close();
            newFile.close();
        }
    }

    exit(0);
}

