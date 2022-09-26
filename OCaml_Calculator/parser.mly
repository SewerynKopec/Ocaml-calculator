/* Parser file parser.mly */

/* Tokens */
%token <float> FLOAT        /* Float number         */
%token PLUS MINUS MULT DIV  /* + - * / operators    */
%token POW                  /* POWer exponentiation */
%token EOL                  /* End of line          */
%token LBRACKET RBRACKET    /* Symbols: '(' and ')' */

%token <float->float> BI_FUNC /* Built-in functions */

/* TESTING FUNCTIONS */
%token <float->float->float->float> MY_3FUNC /* My 3 args functions */
%token <float -> float -> float -> float -> float -> float> POLY_DRAW
%token <float -> float -> float -> float -> float -> float-> float> POLY_VAL

/* Priority */
%left PLUS MINUS            /* Sequence of mathematical operations  */
%left MULT DIV              /* * an / before plus and minus         */
%left UMINUS                /* Unary minus                          */
/* Unary minus has greater priority than PLUS.
It means that (-x + y) is interpreted as ((-x) + y).                */
%right POW                  /* Priority Pow over +-/*               */

%start line                 /* Entry point */
%type <float> line
%%

line:
    expr EOL                { $1 }        /* Parse line with expression + EndOfLine sign*/
;

expr:
  | FLOAT                   { $1 }        /* Expr == num it treats every num as float*/ 
  | LBRACKET expr RBRACKET  { $2 }        /* '('expr')'  */
  | expr PLUS expr          { $1 +. $3 }  /* num '+' num */
  | expr MINUS expr         { $1 -. $3 }  /* num '-' num */
  | expr MULT expr          { $1 *. $3 }  /* num '*' num */
  | expr DIV expr           { $1 /. $3 }  /* num '/' num */
  | MINUS expr %prec UMINUS { -. $2 }     /* '-'    expr */
  | expr POW expr           { $1 ** $3 }  /* num '^' num */
  | BI_FUNC LBRACKET expr RBRACKET 
                            { $1 $3 }     /* Built in functions with S1 arg */
  /* Here you can add functions */
  | MY_3FUNC LBRACKET expr expr expr RBRACKET   { $1 $3 $4 $5 } /* TESTING sum3 */ 
  | POLY_DRAW expr expr expr expr expr {$1 $2 $3 $4 $5 $6 }
  | POLY_VAL expr expr expr expr expr expr { $1 $2 $3 $4 $5 $6 $7 }

/* End of parser.mly file */
