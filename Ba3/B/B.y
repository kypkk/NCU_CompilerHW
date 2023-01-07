%{
    #include <iostream>
    #include <stack>

    using namespace std;

    int yylex(void);
    void yyerror(const char *);

    std::stack<int> s;
%}

%union{
    int ival;
}

/* declarations */
%token TRU
%token FAL
%token ANDOP
%token ANDCL
%token OROP
%token ORCL
%token NOTOP
%token NOTCL

%type <ival> expr

%%
program : lines         {
                            if(s.top() == 0){
                                cout << "false" << endl;
                            }else{
                                cout << "true" << endl;
                            }
                        }
lines   : lines line    {;}
        | line          {;}
        ;
        
line    : expr '\n'     {;}
        | expr          {;}
        | '\n'          {;}
        ;

expr    : TRU {s.push(1);}
        | FAL {s.push(0);}
        | ANDOP {s.push(2);}
        | OROP {s.push(3);}
        | NOTOP {s.push(4);}
        | ANDCL {
                    int a = 1;
                    while(s.top() != 2){
                        int b = s.top();
                        s.pop();
                        a = (a & b);
                    }
                    s.pop();
                    s.push(a);
                }
        | ORCL  {
                    int a = 0;
                    while(s.top() != 3){
                        int b = s.top();
                        s.pop();
                        a = (a | b);
                    }
                    s.pop();
                    s.push(a);
                }
        | NOTCL {
                    int a = s.top();
                    s.pop();
                    s.pop();
                    s.push(!a);
                }
        ;
%%

void yyerror(const char *message) {
    cout << "Invalid format" << endl;
}

int main(void) {
    yyparse();
    return 0;
}