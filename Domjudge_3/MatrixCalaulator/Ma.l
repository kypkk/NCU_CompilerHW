%option noyywrap
%{
#include "Ma.tab.h"
int col=0;
void yyerror(const char *);
%}

%%
[0-9]+ {
    col+=yyleng;
    yylval.ival = atoi(yytext);
    return NUM;
}

"+"|"-"|"*" {
    col+=yyleng;
    yylval.loc = col;
    return yytext[0];
}

"^T" {
    col+=yyleng;
    return TRS;
}

"("|")"|"["|"]"|"," {
    col+=yyleng;
    return yytext[0];
}

[ \t]+	  {
    col+=yyleng;
}

\n        {
    return yytext[0];
}

.	      {
    yyerror("invalid input");
}
%%