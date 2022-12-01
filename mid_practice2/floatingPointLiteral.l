%option noyywrap

dy    ^[1-9][0-9]*\n
ft    ^[1-9]?(\.[0-9]*)?\n
sn    ^[1-9][0-9]*(\.[0-9]+)?([eE][-+]?[0-9]+)?\n

%%
{dy} 
{ft} {ECHO;}
{sn} {ECHO;}
.
\n

%%

int main(void)
{
    yylex();
    return 0;
}