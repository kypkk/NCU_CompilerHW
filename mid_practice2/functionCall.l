%option noyywrap

sn    ^[A-Za-z_][A-Za-z0-9_]*[\(]((([A-Za-z_][A-Za-z0-9_]*[\,][ ])*([A-Za-z_][A-Za-z0-9_]*))|([A-Za-z_][A-Za-z0-9_]*)?)?[\)][\n]?

%%

{sn} {ECHO;}
.
\n

%%

int main(void)
{
    //function call
    yylex();
    return 0;
}