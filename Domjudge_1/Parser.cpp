#include <iostream>
#include <vector>
#include <regex>
#include <string>


// regex
enum TokenType {id, strlit, lbr, rbr, dot};
const std::regex ID("[A-Za-z_][A-Za-z0-9_]*");
const std::regex STRLIT("[^\"]");

// function prototype
void Parser();
void stmts();
void stmt();
void primary();
void primary_tail();


std::vector<std::pair<TokenType, std::string> > Split(std::string input);
bool IsID(const std::string);
bool IsSTRLIT(const std::string);

// global parameters
std::vector<std::pair<TokenType, std::string> > tokens;
int idx;
std::string ans = "";
bool correct = true;

// main
int main(){

    std::string input;
    while(std::cin >> input){
        correct = true;
        tokens = Split(input);
        idx = 0;
        ans = "";
        stmts();
        if(correct){
            std::cout << ans;
        }else{
            std::cout << "invalid input\n";
        }
        
    }
    return 0;
}

// Scanner for the input tokens 
std::vector<std::pair<TokenType, std::string> > Split(std::string input){
    int begin_pos = 0, end_pos = 0;
    
    std::vector<std::pair<TokenType, std::string> > tokens; 

    while(end_pos != input.size()){
        begin_pos = end_pos;
        end_pos++;

        if(IsID(std::string( 1, input.at(begin_pos)))){
            while(end_pos != input.size()){
                if(IsID(input.substr(begin_pos, end_pos - begin_pos + 1))){
                    end_pos++;
                    if(end_pos == input.size()){
                        break;
                    }
                }else {
                    break;
                }
            }

            tokens.push_back(std::pair<TokenType, std::string>(id, input.substr(begin_pos, end_pos - begin_pos)));
        }else if(input.at(begin_pos) == '\"'){
            while(end_pos != input.size()){
                if(input.at(end_pos) != '\"'){
                    if(end_pos + 1 == input.size()){
                        correct = false;
                    }
                    if(!IsSTRLIT(std::string( 1, input.at(end_pos)))){
                        correct = false;
                    }
                    end_pos++;
                } else{
                    end_pos++;
                    break;
                }
            }

            tokens.push_back(std::pair<TokenType, std::string>(strlit,  input.substr(begin_pos, end_pos - begin_pos)));
        }else{
            switch (input.at(begin_pos)) {
			case '(':
				tokens.push_back(std::pair<TokenType, std::string>
				(lbr, ""));
				break;
			case ')':
				tokens.push_back(std::pair<TokenType, std::string>
				(rbr, ""));
				break;
			case '.':
				tokens.push_back(std::pair<TokenType, std::string>
				(dot, ""));
				break;
            default:
                correct = false;
            }
        }
    }

    return tokens;
}

inline bool IsID(const std::string token) {
    return std::regex_match(token, ID);
}

inline bool IsSTRLIT(const std::string token) {
    return std::regex_match(token, STRLIT);
}

// Recursive descent Parser starts here
void stmts(){
    if((tokens[idx].first == id || tokens[idx].first == strlit) && idx != tokens.size()){
        stmt();
        stmts();
    }else{
        if(idx == tokens.size()) return;
        else correct = false;
    }
}

void stmt(){
    if(idx == tokens.size()) return;
    switch(tokens[idx].first){
        case id:
            primary();
            break;
        case strlit:
            ans += "STRLIT ";
            ans += tokens[idx].second;
            ans += "\n";
            idx++;
            return;
        case lbr:
            correct = false;
            return;
        case dot:
            correct = false;

            return;
        case rbr:
            return;
        default:
            return;
    }
};

void primary(){
    if(idx == tokens.size()) return;
    if(tokens[idx].first == id){
        ans += "ID ";
        ans += tokens[idx].second;
        ans += "\n";
        idx++;
        primary_tail();
    }else{
        correct = false;

        return;
    }
};

void primary_tail(){
    if(idx == tokens.size()) return;
    switch(tokens[idx].first){
        case dot:
            if(tokens[idx].first == dot && tokens[idx+1].first == id){
                ans += "DOT .";
                ans += "\n";
                ans += "ID ";
                ans += tokens[idx + 1].second;
                ans += "\n";
                idx+=2;
                primary_tail();
            }else{
                correct = false;

                return;
            }
            break;
        case lbr:
            ans += "LBR (";
            ans += "\n";
            idx++;
            stmt();
            if(tokens[idx].first != rbr || idx == tokens.size()){
                correct = false;

                return;
            }else{
                ans += "RBR )";
                ans += "\n";
                idx++;
            }
            primary_tail();
            break;
        default:
            correct = false;

            return;
    }
};
