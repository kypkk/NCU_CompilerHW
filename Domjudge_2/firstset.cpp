#include <iostream>
#include <unordered_map>
#include <set>
#include <vector>
#include <string>
#include <cctype>

using namespace std;

unordered_map<char, vector<string>> rule;
unordered_map<char, set<char>> first;

void FindFirst(char ch);

int main(){
    char ch;
    string s;
    while (cin >> ch >> s) {
		if (s == "ND_OF_GRAMMAR") 
            break;
		size_t pos;
		while (pos = s.find('|'), pos != string::npos) {
			rule[ch].push_back(s.substr(0, pos));
			s.erase(0, pos + 1);
		}
		rule[ch].push_back(s);
	}
    for (char ch = 'A'; ch <= 'Z'; ch++){
        if (rule.find(ch) == rule.end())
            continue;
        if (first.find(ch) == first.end())
            FindFirst(ch);
    }
    for (char ch = 'A'; ch <= 'Z'; ch++){
        if (first.find(ch) == first.end())
            continue;
        cout << ch << " ";
        for (auto it = first[ch].begin(); it != first[ch].end(); it++)
            cout << *it;
        cout << endl;
    }
	cout << "END_OF_FIRST" << endl;


    return 0;
}

void FindFirst(char ch){
    for(int i = 0; i < rule[ch].size(); i++){
        set<char> tmpRule;
        for(int j = 0; j < rule[ch][i].size(); j++){
            char tmp = rule[ch][i][j];
            set<char> tmpFirst;
            //terminal
            if (islower(tmp) || tmp == ';' || tmp == '$'){
                tmpFirst.insert(tmp);
            }
            //nonterminal
            else{
                if (first.find(tmp) == first.end())
                    FindFirst(tmp);
                tmpFirst.insert(first[tmp].begin(), first[tmp].end());
            }
            tmpRule.insert(tmpFirst.begin(), tmpFirst.end());
            if (tmpFirst.find(';') == tmpFirst.end()){
                tmpRule.erase(';');
                break;
            }
        }
        first[ch].insert(tmpRule.begin(), tmpRule.end());
    }
};