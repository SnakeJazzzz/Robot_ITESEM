%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "y.tab.h"

FILE *asmFile;

int yylex(void);
void yyerror(const char *s);
void open_asm_file();
void close_asm_file();
void process_command(char* action, int value);

%}

%union {
    int num;
}

%token <num> NUMBER
%token ROBOT PLEASE MOVE TURN BLOCKS DEGREES AHEAD AND EOL THEN DOT

%%
commands:
    | commands command
    ;

command:
    polite_command DOT EOL { printf("Command processed with a dot.\n"); }
    | polite_command EOL   { printf("Command processed without a dot.\n"); }
    ;

polite_command:
    ROBOT PLEASE action_list
    ;

action_list:
    action
    | action_list AND optional_then action
    ;

optional_then:
    /* Empty */
    | THEN
    ;

action:
    move_action
    | turn_action
    ;

move_action:
    MOVE NUMBER BLOCKS AHEAD { process_command("MOVE", $2); }
    ;

turn_action:
    TURN NUMBER DEGREES { process_command("TURN", $2); }
    ;

%%

void open_asm_file() {
    asmFile = fopen("instructions.asm", "w");
    if (asmFile == NULL) {
        fprintf(stderr, "Could not open instructions.asm for writing.\n");
        exit(1);
    }
}

void close_asm_file() {
    if (asmFile) {
        fclose(asmFile);
    }
}

void process_command(char* action, int value) {
    if (strcmp(action, "MOVE") == 0) {
        fprintf(asmFile, "MOV,%d\n", value);
    } else if (strcmp(action, "TURN") == 0) {
        fprintf(asmFile, "TURN,%d\n", value);
    }
}

void yyerror(const char *s) {
    extern char *yytext;
    fprintf(stderr, "Error: %s at symbol \"%s\"\n", s, yytext);
}

int main(void) {
    open_asm_file();
    printf("Please enter a command:\n");
    yyparse();
    close_asm_file();
    return 0;
}