#include <fstream>
#include <iostream>
#include <string>
#include <vector>
#include <algorithm>
#include <unordered_set>
#include <unordered_map>

using namespace std;

vector<string> split(string text, char d = ','){
    vector<string> result;
    const char *str = text.c_str();

    do {
        const char *begin = str;
        while(*str != d && *str) ++str;
        result.push_back(string(begin, str));
    } while (0 != *str++);

    return result;
}

int main(int argc, char* argv[]){

    unordered_set<int> classesSet;
    vector<int> classesVector;
    unordered_map<int, int> classesMap;
    string line;

    if(argc < 2) {
        cout << "Not enough arguments.\n";
        exit(1);
    }
    
    // Map classes
    for(int i = 1; i < argc; ++i){
        string filePath = string(argv[i]);

        ifstream originalFile;
        originalFile.open(filePath);
    
        while(getline(originalFile, line)){
            size_t i = 0;
            while(line[i] != ' ') ++i;
            auto lineLabels = split(line.substr(0,i));

            for(auto labelString : lineLabels){
                int label = stoi(labelString);
                if(classesSet.find(label) == classesSet.end()){
                    classesSet.insert(label);
                    classesVector.push_back(label);
                }
            }
        }
        
        originalFile.close();
    }

    sort(classesVector.begin(), classesVector.end());
    for(int i = 0; i < classesVector.size(); ++i) classesMap.insert({classesVector[i], i + 1});

    // Output remaped files
    for(int i = 1; i < argc; ++i){
        string filePath = string(argv[i]);

        ifstream originalFile;
        originalFile.open(filePath);

        ofstream newFile;
        newFile.open(filePath + ".new");

        while(getline(originalFile, line)) {
            size_t i = 0;
            while (line[i] != ' ') ++i;

            auto lineLabels = split(line.substr(0,i));
            string lineFeatures = line.substr(i);
            
            for(auto labelString : lineLabels){
                int label = stoi(labelString);
                if(classesMap.find(label) == classesMap.end()){
                    cout << "Class " << label << "doesn't have mapping!\n";
                    exit(1);
                }
                newFile << classesMap[label] << " ";
            }
            
            newFile << lineFeatures << endl;
            
        }

        originalFile.close();
        newFile.close();
    }
    
    cout << "NUMBER OF MAPED LABELS: " << classesVector.size();

    exit(0);
}

