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
"then"                          { return THEN; }
"turn"                          { return TURN; }
"degrees"                       { return DEGREES; }
"."                             { return DOT; }
[0-9]+                          { yylval.num = atoi(yytext); return NUMBER; }
[\n]                            { return EOL; }
[ \t]                           ; /* Ignore whitespace */
.                               { return yytext[0]; }

%%

int yywrap(void) {
    return 1;
}
