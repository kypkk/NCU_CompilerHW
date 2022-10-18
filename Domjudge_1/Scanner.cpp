#include <iostream>
#include <vector>
#include <string>
#include <regex>

// function prototype
void Scanner(std::string input);

// main
int main(){
    std::string input;
    while(std::cin >> input){
        Scanner(input);
    }
        

    return 0;
}

void Scanner(std::string input){
    std::string num = "";
    for(int i = 0; i < input.size(); i++){
        
        if(isdigit(input[i])){
            if(num == ""){
                std::cout << "NUM ";
            }
            num += input[i];
            if(i+1 == input.size()){
                std::cout << num << std::endl;
            }
        }else{
            if(num != ""){
                std::cout << num << std::endl;
                num = "";
            }
            switch(input[i]){
                case '+':
                    std::cout << "PLUS" << std::endl;
                    break;
                case '-':
                    std::cout << "MINUS" << std::endl;
                    break;
                case '*':
                    std::cout << "MUL" << std::endl;
                    break;
                case '/':
                    std::cout << "DIV" << std::endl;
                    break;
                case '(':
                    std::cout << "LPR" << std::endl;
                    break;
                case ')':
                    std::cout << "RPR" << std::endl;
                    break;
            }
        }
    }

};
