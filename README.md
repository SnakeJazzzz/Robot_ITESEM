# ITESM Robot Language Compiler (Team #1)

This project aims to develop a robot language compiler for simulating the CPU of a car robot. The compiler is built using Flex and Bison to parse polite language commands, validate them, and generate assembly-like instructions for the robot to execute.

## Description of the Problem

Industry 4.0 has led to the emergence of smart factories, where robots play a crucial role in manufacturing processes. To efficiently control these robots, a robot programming language and compiler are necessary. This project focuses on creating a compiler for a simplified robot language that supports movement and turning instructions.

## Definition of Automata

The CPU simulator logic is specified using Flex and Bison. Flex generates a lexical analyzer to tokenize input sentences, while Bison generates a parser to validate the grammar and generate assembly-like instructions.

## Definition of CFG and Lexemes

The context-free grammar (CFG) defines the structure of valid sentences in the robot language. Lexemes are defined using regular expressions in Flex to recognize keywords, numbers, and directions.

## Tokens
"Robot"                         { return ROBOT; }
"please"                        { return PLEASE; }
"move"                          { return MOVE; }
"blocks"                        { return BLOCKS; }
"ahead"                         { return AHEAD; }
"and"                           { return AND; }
"then"                          { return THEN; }
"turn"                          { return TURN; }
"degrees"                       { return DEGREES; }
"."                             { return DOT; }
[0-9]+                          { yylval.num = atoi(yytext); return NUMBER; }
[\n]                            { return EOL; }
[ \t]                           ; /* Ignore whitespace */
.                               { return yytext[0]; }

## CFG
G = {V, Σ, R, S }

V = {commands, command, polite_command, action_list, optional_then, action, move_action, turn_action}

Σ = {ROBOT, PLEASE, MOVE, TURN, NUMBER, BLOCKS, AHEAD, DEGREES, AND, THEN, DOT, EOL}

R= 
commands 	    →  commands command | ε
command 	    → polite_command DOT EOL | polite_command EOL
polite_command → ROBOT PLEASE action_list
action_list           → action | action_list AND optional_then action
optional_then      → ε | THEN
action                  → move_action | turn_action
move_action       → MOVE NUMBER BLOCKS AHEAD
turn_action         → TURN NUMBER DEGREES

S = commands



## List of Sample Inputs

### Valid Sentences:

- "Robot please move 2 blocks ahead"
- "Robot please move 3 blocks ahead and then turn 90 degrees, then move 2 blocks"

### Invalid Sentences:

- "Robot moves 2 blocks"
- "Robot moves 2 blocks quickly"
- "Move 2 blocks right now"
- "Robot 2 blocks moves"
- "Moves Robot 2 blocks and turn 89 degrees"
