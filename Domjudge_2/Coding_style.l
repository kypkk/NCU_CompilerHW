%{
    unsigned int tab = 0;
%}
eol             \n
tab             \t
%%
"{"             { printf("%s", yytext); tab++;}
"\n}"           { tab--; printf("\n"); for(int i = 0; i < tab; i++) printf("\t"); printf("}"); }
"}"             { tab--; printf("%s", yytext); }
"\n"            { printf("\n"); for(int i = 0; i < tab; i++) printf("\t"); }
"\t"            { /* do nothing */ }
.               { printf("%s", yytext); }
%%
int main(int argc, char *argv[])
{
    yylex();
    return(0);
}