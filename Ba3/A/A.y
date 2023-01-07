%{
#include <stdio.h>
#include <iostream>
#include <string>


using namespace std;

long long answer = 0;
int correct = 1;
int yylex();
void yyerror(const char *message);
%}

%union {
    long ivalue;
}
%token ADD
%token SUB
%token PER
%token COB
%token <ivalue> INUMBER
%type <ivalue> formula
%type <ivalue> exp

%%
input : exp { answer = $1; }
	  ; 
exp : exp ADD exp	{ $$ = $1 + $3; }
	| exp SUB exp	{ $$ = $1 - $3; }
    | exp SUB INUMBER {
        if($3 > 2147483647){
            cout << "Wrong Formula" << endl;
            exit(0);
        }
        $$ = $1 - $3;}
    | exp ADD INUMBER {
        if($3 > 2147483647){
            cout << "Wrong Formula" << endl;
            exit(0);
        }
        $$ = $1 + $3;}
    | INUMBER {
        if($1 > 2147483647){
            cout << "Wrong Formula" << endl;
            exit(0);
        }
        $$ = $1;}
    | exp SUB formula {$$ = $1 - $3;}
    | exp ADD formula {$$ = $1 + $3;}
    | formula { $$ = $1;}
    ; 

formula : PER INUMBER INUMBER   {
                                if($2 < $3 || $2 > 12 || $3 > 12){
                                    cout << "Wrong Formula" << endl;
                                    exit(0);
                                }
                                long long ans = 1;
                                for(int i = $2; i > $2 - $3; i--){
                                    ans *= i;
                                    // cout << i << endl;
                                    // cout << ans << endl;
                                }
                                $$ = ans;
                                // cout << "permutation " << $$ << endl;
                            }
        | COB INUMBER INUMBER   {
                                if($2 < $3 || $2 > 12 || $3 > 12){
                                    cout << "Wrong Formula" << endl;
                                    exit(0);
                                }
                                long long ans = 1;
                                for(int i = $2; i > $2 - $3; i--){
                                    ans *= i;
                                }
                                for(int i = $3; i > 0; i--){
                                    ans /= i;
                                }
                                $$ = ans;
                                // cout << "combination" << endl;
                            }
        ; 
%%
void yyerror ( const char *message )
{
	correct  = 0;
}
int main(int argc, char *argv[]) {
    yyparse();
	if ( correct  == 1 ) {
        cout << answer << endl;
	}
	else {
		cout << "Wrong Formula" << endl;
	} 
    return(0);
}