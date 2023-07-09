grammar Sparql;

queryUnit: query;

query: prologue (selectQuery) valuesClause EOF;

prologue: ( baseDecl | prefixDecl )*;

baseDecl: 'BASE' IRIREF;

prefixDecl: 'PREFIX' PNAME_NS IRIREF;

selectQuery: selectClause dataClause* whereClause solutionModifier;
subSelect: selectClause whereClause solutionModifier valuesClause;

selectClause: 'SELECT' ('DISTINCT'|'REDUCED')? ((var | ('(' expression 'as' var ')'))+ | '*');
dataClause: ;
whereClause: ;
solutionModifier: ;

valuesClause: ('VALUES' dataBlock)?;

dataBlock: ;

groupGraphPattern: ;
var: ;
expression: ;

existsFunction: 'EXISTS' groupGraphPattern;
notExistsFunction: 'NOT' 'EXISTS' groupGraphPattern;
rdfLiteral: string (LANGTAG | ('^^' iri))?;
numericLiteral: numericLiteralUnsigned | numericLiteralPositive | numericLiteralNegative;
numericLiteralUnsigned: INTEGER | DECIMAL | DOUBLE;
numericLiteralPositive: INTEGER_POSITIVE | DECIMAL_POSITIVE | DOUBLE_POSITIVE;
numericLiteralNegative: INTEGER_NEGATIVE | DECIMAL_NEGATIVE | DOUBLE_NEGATIVE;
booleanLiteral: 'true' | 'false';
string: ;
iri: IRIREF | prefixedName;
prefixedName: PNAME_LN | PNAME_NS;
blankNode: ;


// IRIREF: '<' ( ~('<' | '>' | '"' | '{' | '}' | '|' | '^' | '\\' | '`') | (PN_CHARS))* '>'; //'<' ([^<>"{}|^`\]-[#x00-#x20])* '>'
IRIREF: ;
PNAME_NS: ;
PNAME_LN: ;
VAR1: '?' VARNAME;
VAR2: '$'VARNAME;
VARNAME: (PN_CHARS_U);
PN_CHARS_BASE
    : [A-Z]
    | [a-z]
    | [\u00C0-\u00D6]
    | [\u00D8-\u00F6]
    | [\u00F8-\u02FF]
    | [\u0370-\u037D]
    | [\u037F-\u1FFF]
    | [\u200C-\u200D]
    | [\u2070-\u218F]
    | [\u2C00-\u2FEF]
    | [\u3001-\uD7FF]
    | [\uF900-\uFDCF]
    | [\uFDF0-\uFFFD]
    //| [#x10000-#xEFFFF]
    ;
PN_CHARS_U: PN_CHARS_BASE | '_';
PN_CHARS: PN_CHARS_U | '-' | [0-9] | '\u00B7' | [\u0300-\u036F] | [\u203F-\u2040];
PN_PREFIX: PN_CHARS_BASE ((PN_CHARS | '.')* PN_CHARS)?;
LANGTAG: '@' [a-zA-Z]+ ('-' [a-zA-Z0-9]+)*;
INTEGER: [0-9]+;
DECIMAL: [0-9]* '.' [0-9]+;
DOUBLE: ([0-9]+ '.' [0-9]* EXPONENT) | ('.' [0-9]+ EXPONENT) | ([0-9]+ EXPONENT);
INTEGER_POSITIVE: '+' INTEGER;
INTEGER_NEGATIVE: '-' INTEGER;
DECIMAL_POSITIVE: '+' DECIMAL;
DECIMAL_NEGATIVE: '-' DECIMAL;
DOUBLE_POSITIVE: '+' DOUBLE;
DOUBLE_NEGATIVE: '-' DOUBLE;
EXPONENT: [eE] [+-]? [0-9]+;
WS: (' '|'\t'|'\n'|'\r')+ -> skip;