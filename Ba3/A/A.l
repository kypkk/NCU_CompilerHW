%{
#include "A.tab.h"
%}

PER     (P|p)
COB     (C|c)

%%
\n        {}
[ \t]+	  {}
{PER}      { return PER;}
{COB}      { return COB;}
"+" 	{ return ADD; }
"-"	{ return SUB; }
[1-9][0-9]*	{ yylval.ivalue = atol(yytext); return( INUMBER ); }
0       {yylval.ivalue = atoi(yytext); return(INUMBER);}
.		{ printf ( "Wrong Formula\n" ); }
%%