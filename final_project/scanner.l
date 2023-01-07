%option noyywrap
%{
#include "parser.tab.h"
#include <string.h>
%}

AND         and
OR          or
NOT         not
MOD         mod
LETTER      [a-z]
DIGIT       [0-9]
PRINTNUM    print-num
PRINTBOOL   print-bool
IF          if
DEFINE      define
ID          {LETTER}({LETTER}|{DIGIT}|-)*
BOOLT       #t
BOOLF       #f
POSITIVE    [1-9]{DIGIT}*
NAGATIVE    -{POSITIVE}
NUMBER      0|{POSITIVE}|{NAGATIVE}

%%

{PRINTNUM}  {
                yylval.ca = yytext;
                return(print_num);
            }

{PRINTBOOL} {
                yylval.ca = yytext;
                return(print_bool);
            }

{IF}        {
                yylval.ca = yytext;
                return(iff);
            }

{DEFINE}    {
                yylval.ca = yytext;
                return(def);
            }

{AND}       {
                yylval.ca = yytext;
                return(and);
            }

{OR}        {
                yylval.ca = yytext;
                return(or);
            }

{NOT}       {
                yylval.ca = yytext;
                return(not);
            }

{MOD}       {
                yylval.ca = yytext;
                return(mod);
            }

{NUMBER}    {
                yylval.ival = atoi(yytext);
                return(number);
            }

{ID}        {
                yylval.ca = yytext;
                return(id);
            }

{BOOLT}     {
                yylval.ival = 1;
                return(boolval);
            }

{BOOLF}     {
                yylval.ival = 0;
                return(boolval);
            }

" "|[\t]|[\r]|[\n]  {}

"+"|"-"|"*"|"/"|">"|"<"|"="|"("|")"     {
                                            return(yytext[0]);
                                        }

.           {return(yytext[0]);}

%%