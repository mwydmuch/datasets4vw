#include <fstream>
#include <iostream>
#include <string>
#include <vector>
#include <algorithm>
#include <unordered_set>
#include <unordered_map>

using namespace std;

vector<string> split(string text, char d = ' '){
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

int main(int argc, char* argv[]){

    unordered_set<int> labelsSet;
    vector<int> labelsVector;
    unordered_map<int, int> labelsMap;
    string line;

    if(argc < 2) {
        cout << "Not enough arguments.\n";
        exit(1);
    }
    
    // Map labels
    for(int i = 1; i < argc; ++i){
        string filePath = string(argv[i]);

        ifstream originalFile;
        originalFile.open(filePath);
    
        while(getline(originalFile, line)){
            size_t i = 0;
            while(line[i] != '|' && i < line.length()) ++i;
            if(i >= line.length()) continue;

            auto lineLabels = split(line.substr(0,i));
            for(auto labelString : lineLabels){
                int label = stoi(labelString);
                if(labelsSet.find(label) == labelsSet.end()){
                    labelsSet.insert(label);
                    labelsVector.push_back(label);
                }
            }
        }
        
        originalFile.close();
    }

    sort(labelsVector.begin(), labelsVector.end());
    for(int i = 0; i < labelsVector.size(); ++i) labelsMap.insert({labelsVector[i], i + 1});

    // Output remapped files
    for(int i = 1; i < argc; ++i){
        string filePath = string(argv[i]);

        ifstream originalFile;
        originalFile.open(filePath);

        ofstream newFile;
        newFile.open(filePath + ".new");

        while(getline(originalFile, line)) {
            size_t i = 0;
            while(line[i] != '|' && i < line.length()) ++i;
            if(i >= line.length()) continue;

            auto lineLabels = split(line.substr(0,i));
            string lineFeatures = line.substr(i);
            
            for(auto labelString : lineLabels){
                int label = stoi(labelString);
                if(labelsMap.find(label) == labelsMap.end()){
                    cout << "Class " << label << "doesn't have mapping!\n";
                    exit(1);
                }
                newFile << labelsMap[label] << " ";
            }
            
            newFile << lineFeatures << endl;
            
        }

        originalFile.close();
        newFile.close();
    }
    
    cout << "NUMBER OF MAPPED LABELS: " << labelsVector.size() << endl;

    exit(0);
}

