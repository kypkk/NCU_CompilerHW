%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>

    int yylex(void);
    void yyerror(const char *message);

    typedef struct Node{
        char s[10000];
        int content;
        struct Node *next;
    }node;

    struct Node *first;
    struct Node *now;
    struct Node *temp;
%}

%union{
    int ival;
    char *ca;
    char st[10000];
}

/* terminals 也就是 scanner scan 出來的東西 */
%token <ca> and
%token <ca> or
%token <ca> not
%token <ca> mod
%token <ival> number
%token <ca> id
%token <ca> iff
%token <ca> def
%token <ival> boolval
%token <ca> print_num
%token <ca> print_bool

/* nonterminals 我自己瞎定義的 */
%type <st> PROGRAM
%type <st> STMT
%type <st> PRINT_STMT
%type <st> DEF_STMT
%type <st> VARIABLE
%type <ival> EXP
%type <ival> IF_EXP
%type <ival> TEST_EXP
%type <ival> THEN_EXP
%type <ival> ELSE_EXP
%type <ival> NUM_EXP
%type <ival> PLUS
%type <ival> PLUS_EXP
%type <ival> MINUS
%type <ival> MULTIPLY
%type <ival> MULTIPLY_EXP
%type <ival> DIVIDE
%type <ival> MODULUS
%type <ival> GREATER
%type <ival> SMALLER
%type <ival> EQUAL
%type <ival> EQUAL_EXP
%type <ival> LOGICAL_OP
%type <ival> AND_OP
%type <ival> AND_EXP
%type <ival> OR_OP
%type <ival> OR_EXP
%type <ival> NOT_OP

/* precedence 優先值最下面的優先值越高 */
%left '+'
%left '-'
%left '*'
%left '/'
%left '('
%left ')'
%left '<'
%left '>'
%left '='

%%

PROGRAM     : PROGRAM STMT          {}
            | STMT                  {}
            ;

STMT        : EXP                   {}
            | PRINT_STMT            {}
            | DEF_STMT              {}
            ;

PRINT_STMT  : '(' print_num EXP ')' {
                                        printf("%d\n",$3);
                                    }
            | '(' print_bool EXP ')'{
                                        if($3 == 1){
                                            printf("#t\n");
                                        }
                                        else if($3 == 0){
                                            printf("#f\n");
                                        }
                                    }
            ;

DEF_STMT    : '(' def VARIABLE EXP ')'  {
                                            temp = malloc(sizeof(node));
                                            strcpy(temp->s,$3);
                                            temp->content = $4;
                                            temp->next = 0;
                                            now->next = temp;
                                            now = temp;
                                        }
            ;

EXP         : boolval               {
                                        $$ = $1;
                                    }
            | number                {
                                        $$ = $1;
                                    }
            | NUM_EXP                {
                                        $$ = $1;
                                    }
            | LOGICAL_OP            {
                                        $$ = $1;
                                    }
            | IF_EXP                {
                                        $$ = $1;
                                    }
            | VARIABLE              {
                                        temp = first->next;
                                        while(temp){
                                            if(strcmp(temp->s,$1) == 0){
                                                $$ = temp->content;
                                                break;
                                            }
                                            else{
                                                temp = temp->next;
                                            }
                                        }
                                    }
            ;

VARIABLE    : id                    {
                                        strcpy($$,$1);
                                    }
            ;

IF_EXP      : '(' iff TEST_EXP THEN_EXP ELSE_EXP ')'    {
                                                            if($3 == 1){
                                                                $$ = $4;
                                                            }
                                                            else if($3 == 0){
                                                                $$ = $5;
                                                            }
                                                        }
            ;

TEST_EXP    : EXP                   {
                                        $$ = $1;
                                    }
            ;

THEN_EXP    : EXP                   {
                                        $$ = $1;
                                    }
            ;

ELSE_EXP    : EXP                   {
                                        $$ = $1;
                                    }
            ;

NUM_EXP     : PLUS                  {
                                        $$ = $1;
                                        }
            | MINUS                 {
                                        $$ = $1;
                                    }
            | MULTIPLY              {
                                        $$ = $1;
                                    }
            | DIVIDE                {
                                        $$ = $1;
                                    }
            | MODULUS               {
                                        $$ = $1;
                                    }
            | GREATER               {
                                        $$ = $1;
                                    }
            | SMALLER               {
                                        $$ = $1;
                                    }
            | EQUAL                 {
                                        $$ = $1;
                                    }
            ;

PLUS        : '(' '+' PLUS_EXP ')'  {
                                        $$ = $3;
                                    }
            ;

PLUS_EXP    : EXP EXP               {
                                        $$ = $1 + $2;
                                    }
            | PLUS_EXP EXP          {
                                        $$ = $1 + $2;
                                    }
            ;

MINUS       : '(' '-' EXP EXP ')'   {
                                        $$ = $3 - $4;
                                    }
            ;

MULTIPLY    : '(' '*' MULTIPLY_EXP ')'  {
                                            $$ = $3;
                                        }
            ;

MULTIPLY_EXP : EXP EXP              {
                                        $$ = $1 * $2;
                                    }
            | MULTIPLY_EXP EXP      {
                                        $$ = $1 * $2;
                                    }
            ;

DIVIDE      : '(' '/' EXP EXP ')'   {
                                        $$ = $3 / $4;
                                    }
            ;

MODULUS     : '(' mod EXP EXP ')'   {
                                        $$ = $3 % $4;
                                    }
            ;

GREATER     : '(' '>' EXP EXP ')'   {
                                        if($3 > $4){
                                            $$ = 1;
                                        }
                                        else{
                                            $$ = 0;
                                        }
                                    }
            ;

SMALLER     : '(' '<' EXP EXP ')'   {
                                        if($3 < $4){
                                            $$ = 1;
                                        }
                                        else{
                                            $$ = 0;
                                        }
                                    }
            ;

EQUAL       : '(' '=' EQUAL_EXP ')' {
                                        if($3 != 109201521){
                                            $$ = 1;
                                        }
                                        else{
                                            $$ = 0;
                                        }
                                    }
            ;

EQUAL_EXP   : EXP EXP               {
                                        if($1 == $2){
                                            $$ = $1;
                                        }
                                        else{
                                            $$ = 109201521;
                                        }
                                    }
            | EQUAL_EXP EXP         {
                                        if($1 == $2){
                                            $$ = $1;
                                        }
                                        else{
                                            $$ = 109201521;
                                        }
                                    }
            ;

LOGICAL_OP  : AND_OP                {
                                        $$ = $1;
                                    }
            | OR_OP                 {
                                        $$ = $1;
                                    }
            | NOT_OP                {
                                        $$ = $1;
                                    }
            ;

AND_OP      : '(' and AND_EXP ')'   {
                                        if($3 == 1){
                                            $$ = 1;
                                        }
                                        else{
                                            $$ = 0;
                                        }
                                    }
            ;

AND_EXP     : EXP EXP               {
                                        if(($1 & $2) == 1){
                                            $$ = 1;
                                        }
                                        else{
                                            $$ = 0;
                                        }
                                    }
            | AND_EXP EXP           {
                                        if(($1 & $2) == 1){
                                            $$ = 1;
                                        }
                                        else{
                                            $$ = 0;
                                        }
                                    }
            ;

OR_OP       : '(' or OR_EXP ')'     {
                                        if($3 == 1){
                                            $$ = 1;
                                        }
                                        else{
                                            $$ = 0;
                                        }
                                    }
            ;
OR_EXP      : EXP EXP               {
                                        if(($1 | $2) == 1){
                                            $$ = 1;
                                        }
                                        else{
                                            $$ = 0;
                                        }
                                    }
            | OR_EXP EXP            {
                                        if(($1 | $2) == 1){
                                            $$ = 1;
                                        }
                                        else{
                                            $$ = 0;
                                        }
                                    }
            ;

NOT_OP      : '(' not EXP ')'       {
                                        if($3 == 0){
                                            $$ = 1;
                                        }
                                        else if($3 == 1){
                                            $$ = 0;
                                        }
                                    }
            ;

%%

void yyerror(const char *message){
    printf("syntax error\n");
}
int main(int argc,char *argv[]){
    first = malloc(sizeof(node));
    now = first;
    now->next = 0;
    yyparse();
    return(0);
}