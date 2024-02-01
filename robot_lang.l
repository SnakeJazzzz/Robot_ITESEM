%{
#include "y.tab.h"
%}

%%

"Robot"                         { return ROBOT; }
"please"                        { return PLEASE; }
"move"                          { return MOVE; }
"blocks"                        { return BLOCKS; }
"ahead"                         { return AHEAD; }
"and"                           { return AND; }
"turn"                          { return TURN; }
"degrees"                       { return DEGREES; }
[0-9]+                          { yylval.num = atoi(yytext); return NUMBER; }
[\n]                            { return EOL; }
[ \t]                           ; /* Ignore whitespace */
.                               { return yytext[0]; }

%%

int yywrap(void) {
    return 1;
}

