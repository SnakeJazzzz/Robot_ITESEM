%{
#include <stdio.h>
#include <string.h>
#include "y.tab.h"

void yyerror(char *s);
int yylex(void);
void process_command(char* action, int value);
%}

%token ROBOT PLEASE MOVE TURN NUMBER BLOCKS DEGREES AHEAD AND DOT EOL

%%
command:
    polite_command EOL { printf("Command processed.\n"); }
    ;

polite_command:
    ROBOT PLEASE action_list DOT
    ;

action_list:
    action
    | action_list AND action
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

void yyerror(char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

void process_command(char* action, int value) {
    if(strcmp(action, "MOVE") == 0) {
        printf("Move %d blocks.\n", value);
    } else if(strcmp(action, "TURN") == 0) {
        printf("Turn %d degrees.\n", value);
    } else {
        printf("Unknown action.\n");
    }
}

int main(void) {
    printf("Please enter a command:\n");
    yyparse();
    return 0;
}
