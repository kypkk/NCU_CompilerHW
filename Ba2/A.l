%{
    unsigned int par = 0;
    unsigned int mul = 0;
    unsigned int s = 0;
%}

SINCOM    [/][/]
CO        cout
COO       [ ]<<[ ]
IFT       if[(]true[)][ ][{]
IFF       if[(]false[)][ ][{]
MULCOMa   [/][*]
MULCOMb   [*][/]
%%
{SINCOM}    {
    if(mul == 0){
        printf("#");
    }else{
        printf("//");
    }
    s = 1;}
{MULCOMa}    {
    printf("\"\"\"");
    mul = 1;
    }
{MULCOMb}    {
    printf("\"\"\"");
    mul = 0;
    }
{CO}        {
    if(mul == 1 || s == 1){
        printf("cout");

    }else{
        printf("print");
    }}
{COO}       {
    if(mul == 1 || s == 1){
        printf(" << ");

    }else{
        if(par == 0){
            par = 1;
            printf("(");
        }else{
            par = 0;
            printf(")");
        }
    }
    
}
{IFT}       {
    if(mul == 0){
        printf("if True:");
    }else{
        printf("if(true) {");
    }}
{IFF}       {if(mul == 0){
        printf("if False:");
    }else{
        printf("if(false) {");
    }}
"\t"  {printf("\t");}
"{"   {
    if(mul != 0){
        printf("{");
    }
}
"\t}\n" {if(mul != 0){
        printf("\t}\n");
    }}
"}\n" {
    if(mul != 0){
        printf("}\n");
    }
}
"\n"  {
    printf("\n");
    if(s != 0) {
        s = 0;
    }
}
"endl;" {
    if(mul != 0 || s != 0){
        printf("endl;");

    }
}
";"   {
    if(mul != 0){
        printf(";");
    }
}
.     {ECHO;}

%%

int main(void)
{
    yylex();
    return 0;
}