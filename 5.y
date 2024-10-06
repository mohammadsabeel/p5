%{
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
int var_count=0;
void yyerror(const char *s);
int yylex();
extern FILE *yyin;
%}

%union{
char * str;
}

%token <str> IDENTIFIER
%token INT FLOAT CHAR DOUBLE NUM 

%%
program: declerations
;
declerations: decleration ';'
            | declerations decleration ';'
            ;
decleration: type var_list
           ;
type: INT
    | FLOAT 
    |CHAR 
    |DOUBLE
    ;
var_list: var
    | var_list ',' var
    ;
var : identifier
    |identifier '['']'
    |identifier '[' NUM ']'
    ;
identifier: IDENTIFIER
        {
        var_count++;
        }
        ;
%%
void yyerror(const char *s)
{
        fprintf(stderr, "Error is %s\n",s);
}

int main(int argc , char **argv)
{
        if(argc<2)
        {
        fprintf(stderr, "Usage:%s<input file>\n", argv[0]);
        return 1;
        }
FILE *file = fopen(argv[1],"r");
        if(!file)
        {
        perror("Error opening file!");
        return 1;
        }
        
        yyin=file;
        yyparse();
        printf("No of variables declared are:%d\n", var_count);
        fclose(file);
        return 0;
        }






















