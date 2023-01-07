%{
    #include <iostream>

    using namespace std;

    int yylex(void);
    void yyerror(const char *);
    void semantic_err(const int );
%}

%union{
    int ival;
    int loc;
    struct def{
        int row;
        int col;
    }mat;
}

/* declarations */
%type <mat> matrix
%type <mat> expr
%token <ival> NUM

/* precedences */
%left <loc> '+' '-'
%left <loc> '*'
%right TRS

%%
line    : expr '\n'                  {cout << "Accepted" << endl;}
        ;

expr    : expr '+' expr             {
                                        if($1.row == $3.row && $1.col == $3.col){
                                            $$ = $1;
                                        }else{
                                            semantic_err($2);
                                            return 0;
                                        }
                                    }
        | expr '-' expr             {
                                        if($1.row == $3.row && $1.col == $3.col){
                                            $$ = $1;
                                        }else{
                                            semantic_err($2);
                                            return 0;
                                        }
                                    }
        | expr '*' expr             {
                                        if($1.col == $3.row){
                                            $$.row = $1.row;
                                            $$.col = $3.col;
                                        }else{
                                            semantic_err($2);
                                            return 0;
                                        }
                                    }
        | '(' expr ')'              {$$ = $2;}
        | expr TRS                  {
                                        $$.row = $1.col;
                                        $$.col = $1.row;
                                    }
        | matrix
        ;

matrix  : '['NUM','NUM']'       {
                                        $$.row = $2;
                                        $$.col = $4;
                                    }
        ;
%%
void semantic_err(const int col_num) {
    cout << "Semantic error on col " << col_num << endl;
}

void yyerror(const char *message){
    cerr << message << endl;
}

int main(int argc, char *argv[]){
    yyparse();
    return 0;
}