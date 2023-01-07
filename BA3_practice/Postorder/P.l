%{
#include "P.tab.h"
%}

%%
\n        {}
[ \t]+	  {}
"+" 	{ return ADD; }
"-"	{ return SUB; }
"*"	{ return MUL; }
"/"	{ return DIV;}
[0-9]+("\."[0-9]+)*	{ yylval.ivalue = atof(yytext); return( INUMBER ); }
.		{ printf ( "Wrong Formula\n" ); }
%%