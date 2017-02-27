#include <fstream>
#include <iostream>
#include <string>
#include <vector>
#include <algorithm>
#include <unordered_set>
#include <unordered_map>

using namespace std;

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
            int lineClass = stoi(line.substr(0,i));

            if(classesSet.find(lineClass) == classesSet.end()){
                classesSet.insert(lineClass);
                classesVector.push_back(lineClass);
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

            int lineClass = stoi(line.substr(0, i));
            string lineFeatures = line.substr(i);
            
            if(classesMap.find(lineClass) == classesMap.end()){
                cout << "Class " << lineClass << "doesn't have mapping!\n";
                exit(1);
            }
            
            newFile << classesMap[lineClass] << lineFeatures << endl;
        }

        originalFile.close();
        newFile.close();
    }

    exit(0);
}

