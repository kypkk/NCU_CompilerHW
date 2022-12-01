%option noyywrap

WO    ^[a-zA-Z]+$
IP    ^(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$
EM    ^[0-9a-zA-z]+@([a-zA-Z0-9]+\.)+[a-zA-z0-9]+

%%

{WO} {ECHO; printf(" is a word\n");}
{IP} {ECHO; printf(" is an IP address\n");}
{EM} {ECHO; printf(" is an email address\n");}

.
\n

%%

int main(void)
{
    yylex();
    return 0;
}