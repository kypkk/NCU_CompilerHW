%{
#include <stdio.h>
#include <iostream>
#include <string>


using namespace std;

float answer;
int correct = 1;
int yylex();
void yyerror(const char *message);
%}

%union {
    float ivalue;
}
%token ADD
%token SUB
%token MUL
%token DIV
%token <ivalue> INUMBER
%type <ivalue> exp

%%
input : exp { answer = $1; }
	  ; 
exp : INUMBER {$$=$1;} 
    | exp exp ADD	{ $$ = $1 + $2; }
	| exp exp SUB	{ $$ = $1 - $2; }
	| exp exp MUL	{ $$ = $2 * $1; }
	| exp exp DIV	{ $$ = $1 / $2; }
    ; 
%%
void yyerror ( const char *message )
{
	correct  = 0;
}
int main(int argc, char *argv[]) {
    yyparse();
	if ( correct  == 1 ) {
        printf("%.1f\n", answer);
	}
	else {
		cout << "Wrong Formula" << endl;
	} 
    return(0);
}