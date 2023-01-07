%{
    #include <iostream>
    #include <stack>

    int yylex(void);
    void yyerror(const char *);

    std::stack<int> s;
%}

%union{
    int ival;
}

/* declarations */
%token <ival> NUM
%token ADD
%token SUB
%token MUL
%token DIV
%token MOD
%token INC
%token DEC
%token LOAD
%token COPY
%token DELETE
%token SWITCH
%type <ival> expr

%%
program : lines         {
                            if (s.size() != 1) {
                                std::cout << "Invalid format" << std::endl;
                                exit(0);
                            }
                            else
                                std::cout << s.top() << std::endl;
                        }
lines   : lines line    {;}
        | line          {;}
        ;
        
line    : expr '\n'     {;}
        | expr          {;}
        | '\n'          {;}
        ;

expr    : LOAD NUM  {s.push($2);}
        | ADD           {
                            if (s.size() < 2) {
                                std::cout << "Invalid format" << std::endl;
                                exit(0);
                            }
                            else {
                                int a = s.top();
                                s.pop();
                                int b = s.top();
                                s.pop();
                                s.push(a + b);
                            }
                        }
        | SUB           {
                            if (s.size() < 2) {
                                std::cout << "Invalid format" << std::endl;
                                exit(0);
                            }
                            else {
                                int a = s.top();
                                s.pop();
                                int b = s.top();
                                s.pop();
                                s.push(a - b);
                            }
                        }
        | MUL           {
                            if (s.size() < 2) {
                                std::cout << "Invalid format" << std::endl;
                                exit(0);
                            }
                            else {
                                int a = s.top();
                                s.pop();
                                int b = s.top();
                                s.pop();
                                s.push(a * b);
                            }
                        }
        | DIV           {
                            if (s.size() < 2) {
                                std::cout << "Invalid format" << std::endl;
                                exit(0);
                            }
                            else {
                                int a = s.top();
                                s.pop();
                                int b = s.top();
                                s.pop();
                                if(b == 0){
                                    std::cout << "Divide by ZERO" << std::endl;
                                }
                                else{
                                    s.push(a / b);
                                }
                            }
                        }
        | MOD           {
                            if (s.size() < 2) {
                                std::cout << "Invalid format" << std::endl;
                                exit(0);
                            }
                            else {
                                int a = s.top();
                                s.pop();
                                int b = s.top();
                                s.pop();
                                s.push(a % b);
                            }
                        }
        | INC           {
                            if (s.size() < 1) {
                                std::cout << "Invalid format" << std::endl;
                                exit(0);
                            }
                            else {
                                int a = s.top();
                                s.pop();
                                a += 1;
                                s.push(a);
                            }
                        }
        | DEC           {
                            if (s.size() < 1) {
                                std::cout << "Invalid format" << std::endl;
                                exit(0);
                            }
                            else {
                                int a = s.top();
                                s.pop();
                                a -= 1;
                                s.push(a);
                            }
                        }
        | COPY          {
                            if(s.size() < 1){
                                std::cout << "Invalid format" << std::endl;
                                exit(0);
                            }else{
                                int a = s.top();
                                s.push(a);
                            }
                        }
        | DELETE        {
                            if(s.size() < 1){
                                std::cout << "Invalid format" << std::endl;
                                exit(0);
                            }else{
                                s.pop();
                            }
                        }
        | SWITCH        {
                            if(s.size() < 2){
                                std::cout << "Invalid format" << std::endl;
                                exit(0);
                            }else{
                                int a = s.top();
                                s.pop();
                                int b = s.top();
                                s.pop();
                                s.push(a);
                                s.push(b);
                            }
                        }
        ;

%%

void yyerror(const char *message) {
    std::cout << "Invalid format" << std::endl;
}

int main(void) {
    yyparse();
    return 0;
}