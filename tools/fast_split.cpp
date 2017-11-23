#include <fstream>
#include <iostream>
#include <string>
#include <vector>

using namespace std;

vector<string> split(string text, char d = ' '){
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

    int sets = 1;
    string datafilePath, splitfilePath, outfilePath;

    if(argc >= 4){
        datafilePath = string(argv[1]);
        splitfilePath = string(argv[2]);
        outfilePath = string(argv[3]);
    }
    else{
        cout << "Not enough arguments.\n";
        exit(1);
    }

    ifstream datafile, splitfile;
    datafile.open(datafilePath);
    splitfile.open(splitfilePath);

    // Load data
    vector<string> dataLines;
    string line;
    while(getline(datafile, line)) dataLines.push_back(line);

    // Check number of sets
    getline(splitfile, line);
    sets = split(line).size();

    // Create files
    vector<ofstream*> outfiles;
    for(int i = 0; i < sets; ++i){
        ofstream *file = new ofstream(outfilePath + to_string(i));
        outfiles.push_back(file);
    }

    cout << dataLines.size() << "\n";

    // Output data to files
    do{
        auto columns = split(line);
        for(int i = 0; i < sets; ++i) {
            int lineNumber = stoi(columns[i]);
            if (lineNumber > dataLines.size()) {
                cerr << "Out of examples range.\n";
                continue;
            }
            string outLine = dataLines[lineNumber - 1] + "\n";
            *outfiles[i] << outLine;
        }
    } while(getline(splitfile, line));

    for(int i = 0; i < sets; ++i){
        outfiles[i]->close();
    }

    cout << "SPLIT TO " << sets << " DATASETS.\n";
    
    exit(0);
}

