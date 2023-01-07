%{
#include <stdio.h>
#include <string.h>
#include <math.h>

float consequence;
int correct = 1;
int yylex();
void yyerror(const char *message);
%}
%union {
    float ivalue;
}
%token LOAD
%token ADD
%token SUB
%token MUL
%token DIV
%token INC
%token DEC
%token <ivalue> INUMBER
%type <ivalue> exp

%%
input : exp { consequence = $1; }
	; 
exp : INUMBER {$$=$1;} 
        |exp exp ADD	{ $$ = $1 + $2; }
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
		printf( "%.1f\n", consequence);
	}
	else {
		printf ( "Wrong Formula\n" );
	} 
    return(0);
}