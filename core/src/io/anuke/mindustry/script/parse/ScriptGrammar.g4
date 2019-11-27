grammar ScriptGrammar;

file: statement*;

statement
 : assignStatement
 | callStatement
 | fixStatement
 ;

assignStatement: expr COLON expr;
callStatement: (expr DOT)? call;
fixStatement: fix expr | expr fix;

call: ID LPAREN arguments RPAREN;
arguments: (expr (COMMA expr)*)?;

parameters: typedArg | LPAREN typedArg* RPAREN;
typedArg: type ID;

expr
 : expr binary expr				#binaryExpr
 | expr DOT ID					#accessExpr
 | expr LSQUARE expr RSQUARE	#arrayAccessExpr
 | expr DOT call				#callExpr
 | call							#callExpr
 | expr fix						#postfixExpr
 | fix expr						#prefixExpr
 | literal						#literalExpr
 | function						#functionExpr
 | ID                           #idExpr
 ;

binary
 : PLUS
 | MINUS
 | DIVIDE
 | MULTIPLY
 | MULTIPLY MULTIPLY
 | LSHIFT
 | RSHIFT
 | AND
 | OR
 | XOR
 ;

literal
 : TRUE		#boolLit
 | FALSE	#boolLit
 | INT_LIT	#numLit
 | DEC_LIT	#numLit
 ;

type
 : NUM
 | BOOLEAN
 | ID
 ;

fix
 : PLUS PLUS
 | MINUS MINUS
 ;

function: parameters ARROW LBRACE statement* RBRACE;

TRUE: 'true';
FALSE: 'false';

NUM: 'num';
BOOLEAN: 'boolean';

fragment DIGIT: [0-9];
INT_LIT: DIGIT+;
DEC_LIT: DIGIT+? DOT DIGIT+;

PLUS: '+';
MINUS: '-';
DIVIDE: '/';
MULTIPLY: '*';
LSHIFT: '<<';
RSHIFT: '>>';
AND: '&&';
OR: '||';
XOR: '^^';

DOT: '.';
COMMA: ',';
COLON: ':';
ARROW: '->';
LPAREN: '(';
RPAREN: ')';
LSQUARE: '[';
RSQUARE: ']';
LBRACE: '{';
RBRACE: '}';

ID: LETTER (LETTER | DIGIT)*;
LETTER: [a-zA-Z_];

WS: [ \t\r\n] -> skip;