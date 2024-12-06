%{
	#include <stdio.h>
	#include <stdlib.h>
	#include <string.h>
	extern int yylex();
	extern int yylineno;
	extern char* yytext;
	void yyerror(const char *s);
%}

// Define token types
%union {
  int ival;       // For integer values
  double rval;    // For real values
  char* sval;     // For string values and identifiers
}

// Token definitions
%token DEBUT FIN EXECUTION
%token SI ALORS SINON TANTQUE FAIRE
%token FIXE 
%token AFFICHE LIRE
%token TYPE_NUM TYPE_REAL TYPE_TEXT
%token MOINS_EGALE PLUS_EGALE INF_EGALE SUP_EGALE DIFFERENT
%token ET OU NON
%token ASSIGNMENT  // New token for assignment operator

// Define token types from lexical analyzer
%token <sval> IDENTIFICATEUR
%token <ival> NOMBRE_ENTIER
%token <rval> NOMBRE_REEL
%token <sval> CHAINE_TEXTE

// Define non-terminal types
%type <sval> programme bloc declaration liste_declarations 
%type <sval> instruction liste_instructions 
%type <sval> expression condition affectation 
%type <sval> iteration selection entree_sortie

// Operator precedence (from lowest to highest)
%left OU
%left ET 
%left NON
%left '<' '>' INF_EGALE SUP_EGALE '=' DIFFERENT 
%left '+' '-'
%left '*' '/'
%precedence MOINS_UNAIRE

%%
// Grammar rules start here
programme: 
    DEBUT liste_declarations EXECUTION '{' liste_instructions '}' FIN 
    { printf("Programme syntactically correct\n"); }
    ;

liste_declarations:
    declaration
    | liste_declarations declaration
    ;

declaration:
    TYPE_NUM ':' IDENTIFICATEUR ';'
    | TYPE_REAL ':' IDENTIFICATEUR ';'
    | TYPE_TEXT ':' IDENTIFICATEUR ';'
    | FIXE TYPE_NUM ':' IDENTIFICATEUR '=' NOMBRE_ENTIER ';'
    | FIXE TYPE_REAL ':' IDENTIFICATEUR '=' NOMBRE_REEL ';'
    | FIXE TYPE_TEXT ':' IDENTIFICATEUR '=' CHAINE_TEXTE ';'
    | TYPE_NUM ':' IDENTIFICATEUR '[' NOMBRE_ENTIER ']' ';'
    ;

liste_instructions:
    instruction
    | liste_instructions instruction
    ;

instruction:
    affectation
    | selection
    | iteration
    | entree_sortie
    ;

affectation:
    IDENTIFICATEUR ASSIGNMENT expression ';'
    | IDENTIFICATEUR '[' expression ']' ASSIGNMENT expression ';'
    ;

selection:
    SI '(' condition ')' ALORS '{' liste_instructions '}' 
    | SI '(' condition ')' ALORS '{' liste_instructions '}' SINON '{' liste_instructions '}'
    ;

iteration:
    TANTQUE condition FAIRE '{' liste_instructions '}'
    ;

condition:
    expression '<' expression
    | expression '>' expression
    | expression INF_EGALE expression
    | expression SUP_EGALE expression
    | expression '=' expression
    | expression DIFFERENT expression
    | condition ET condition
    | condition OU condition
    | NON condition
    ;

expression:
    NOMBRE_ENTIER
    | NOMBRE_REEL
    | CHAINE_TEXTE
    | IDENTIFICATEUR
    | IDENTIFICATEUR '[' expression ']'
    | expression '+' expression
    | expression '-' expression
    | expression '*' expression
    | expression '/' expression
    | '(' expression ')'
    | '-' expression %prec MOINS_UNAIRE
    ;

entree_sortie:
    AFFICHE '(' expression ')' ';'
    | LIRE '(' IDENTIFICATEUR ')' ';'
    ;

%%

void yyerror(const char *s) {
  fprintf(stderr, "Syntax Error: %s at line %d, near token '%s'\n", s, yylineno, yytext);
}

int main() {
  printf("\n\033[34m======================== Compilation Start ========================\033[0m\n");
  printf("Starting syntactic analysis...\n");
  printf("Enter your code file path: ");
  yyparse();
  printf("Syntactic analysis complete.\n");
  printf("\033[34m======================== Compilation End ========================== \033[0m\n");
  return 0;
}