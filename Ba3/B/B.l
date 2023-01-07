%{
    #include "B.tab.h"
    void yyerror(const char *);
%}

%%


\n {
    return yytext[0];
}

"<true/>" {
    return TRU;
}

"<false/>" {
    return FAL;
}

"<and>" {
    return ANDOP;
}

"</and>" {
    return ANDCL;
}

"<or>" {
    return OROP;
}

"</or>" {
    return ORCL;
}

"<not>" {
    return NOTOP;
}

"</not>" {
    return NOTCL;
}

[ \t]+ {
    ;
}

. {
    yyerror("invalid input");
}

%%