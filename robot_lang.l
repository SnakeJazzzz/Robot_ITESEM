%{
#include "y.tab.h"
%}

%%

[ \t]+               ; /* Ignore whitespace */

Robot                { return ROBOT; }
please               { return PLEASE; }

move                 { return MOVE; }
turn                 { return TURN; }

[0-9]+               { yylval = atoi(yytext); return NUMBER; }

"blocks"             { return BLOCKS; }
"degrees"            | "degree" { return DEGREES; }

ahead                { return AHEAD; }
"and"                { return AND; }

\.{1}                { return DOT; } /* Ensure only one period is matched */

\n                   { return EOL; }

%%

int yywrap() {
    return 1;
}

