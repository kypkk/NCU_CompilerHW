%{
    #include "S.tab.h"
    void yyerror(const char *);
%}

%%
[0-9]+ {
    yylval.ival = atoi(yytext); // atoi make the string number into integer number 
    return NUM;
}

\n {
    return yytext[0];
}

"add" {
    return ADD;
}

"sub" {
    return SUB;
}

"mul" {
    return MUL;
}

"mod" {
    return MOD;
}

"inc" {
    return INC;
}

"dec" {
    return DEC;
}

"load" {
    return LOAD;
}

[ \t]+ {
    ;
}

. {
    yyerror("invalid input");
}

%%