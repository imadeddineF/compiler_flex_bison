%{
  #include <stdio.h>
  #include <stdlib.h>
  #include <string.h>
  #include "ts.h"
  extern int yylex();
  extern int yylineno;
  extern char* yytext;
  void yyerror(const char *s);
  // Global symbol table
  SymbolTable* symbol_table;
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
%token ASSIGNMENT  // Assignment operator

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
    DEBUT {
      // Initialize symbol table when program starts
      symbol_table = create_symbol_table();
    }
    liste_declarations 
    EXECUTION 
    '{' 
    liste_instructions 
    '}' 
    FIN {
      // Print symbol table for debugging
      print_symbol_table(symbol_table);
      // Free symbol table at end of program
      free_symbol_table(symbol_table);
      printf("Programme syntactically correct\n"); 
    }
		;

liste_declarations:
    declaration
    | liste_declarations declaration
    ;

declaration:
    TYPE_NUM ':' IDENTIFICATEUR ';' 
    {
      // Insert integer variable
      if (!insert_symbol(symbol_table, $3, ST_TYPE_INTEGER, 0)) {
        char error_msg[100];
        snprintf(error_msg, sizeof(error_msg), "Duplicate or invalid variable declaration: %s", $3);
        yyerror(error_msg);
      }
      free($3);  // Free the string after use
    }
    | TYPE_REAL ':' IDENTIFICATEUR ';' 
    {
      // Insert real variable
      if (!insert_symbol(symbol_table, $3, ST_TYPE_REAL, 0)) {
        char error_msg[100];
        snprintf(error_msg, sizeof(error_msg), "Duplicate or invalid variable declaration: %s", $3);
        yyerror(error_msg);
      }
      free($3);  // Free the string after use
    }
    | TYPE_TEXT ':' IDENTIFICATEUR ';' 
    {
      // Insert text variable
      if (!insert_symbol(symbol_table, $3, ST_TYPE_STRING, 0)) {
        char error_msg[100];
        snprintf(error_msg, sizeof(error_msg), "Duplicate or invalid variable declaration: %s", $3);
        yyerror(error_msg);
      }
      free($3);  // Free the string after use
    }
    | FIXE TYPE_NUM ':' IDENTIFICATEUR '=' NOMBRE_ENTIER ';'
    {
      // Insert constant integer
      if (!insert_symbol(symbol_table, $4, ST_TYPE_CONSTANT, 1)) {
        char error_msg[100];
        snprintf(error_msg, sizeof(error_msg), "Duplicate constant declaration: %s", $4);
        yyerror(error_msg);
      } else {
        // Update constant value
        int val = $6;
        update_symbol_value(symbol_table, $4, &val);
      }
      free($4);  // Free the string after use
    }
    | FIXE TYPE_REAL ':' IDENTIFICATEUR '=' NOMBRE_REEL ';'
    {
      // Insert constant real
      if (!insert_symbol(symbol_table, $4, ST_TYPE_REAL, 1)) {
        char error_msg[100];
        snprintf(error_msg, sizeof(error_msg), "Duplicate constant declaration: %s", $4);
        yyerror(error_msg);
      } else {
        // Update constant value
        double val = $6;
        update_symbol_value(symbol_table, $4, &val);
      }
      free($4);  // Free the string after use
    }
    | FIXE TYPE_TEXT ':' IDENTIFICATEUR '=' CHAINE_TEXTE ';'
    {
      // Insert constant text
      if (!insert_symbol(symbol_table, $4, ST_TYPE_STRING, 1)) {
        char error_msg[100];
        snprintf(error_msg, sizeof(error_msg), "Duplicate constant declaration: %s", $4);
        yyerror(error_msg);
      } else {
        // Update constant value
        update_symbol_value(symbol_table, $4, $6);
        free($6);  // Free the string literal
      }
      free($4);  // Free the identifier
    }
    | TYPE_NUM ':' IDENTIFICATEUR '[' NOMBRE_ENTIER ']' ';'
    {
      // Insert integer array
      if (!insert_symbol(symbol_table, $3, ST_TYPE_INTEGER_ARRAY, 0)) {
        char error_msg[100];
        snprintf(error_msg, sizeof(error_msg), "Duplicate array declaration: %s", $3);
        yyerror(error_msg);
      }
      free($3);  // Free the string after use
    }
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
    {
      // Check if variable exists before assignment
      if (!check_symbol_exists(symbol_table, $1)) {
        char error_msg[100];
        snprintf(error_msg, sizeof(error_msg), "Variable not declared: %s", $1);
        yyerror(error_msg);
      }
      free($1);  // Free the identifier after use
    }
    | IDENTIFICATEUR '[' expression ']' ASSIGNMENT expression ';'
    {
      // Check if array exists before assignment
      if (!check_symbol_exists(symbol_table, $1)) {
        char error_msg[100];
        snprintf(error_msg, sizeof(error_msg), "Array not declared: %s", $1);
        yyerror(error_msg);
      }
      free($1);  // Free the identifier after use
    }
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
    {
      // Check if variable exists when used
      if (!check_symbol_exists(symbol_table, $1)) {
        char error_msg[100];
        snprintf(error_msg, sizeof(error_msg), "Variable not declared: %s", $1);
        yyerror(error_msg);
      }
      free($1);  // Free the identifier after use
    }
    | IDENTIFICATEUR '[' expression ']'
    {
      // Check if array exists when used
      if (!check_symbol_exists(symbol_table, $1)) {
        char error_msg[100];
        snprintf(error_msg, sizeof(error_msg), "Array not declared: %s", $1);
        yyerror(error_msg);
      }
      free($1);  // Free the identifier after use
    }
    | expression '+' expression
    | expression '-' expression
    | expression '*' expression
    | expression '/' expression
    {
      // Optional: Maybe we will add division by zero check
    }
    | '(' expression ')'
    | '-' expression %prec MOINS_UNAIRE
    ;

entree_sortie:
    AFFICHE '(' expression ')' ';'
    | LIRE '(' IDENTIFICATEUR ')' ';'
    {
      // Check if variable exists before reading
      if (!check_symbol_exists(symbol_table, $3)) {
        char error_msg[100];
        snprintf(error_msg, sizeof(error_msg), "Variable not declared: %s", $3);
        yyerror(error_msg);
      }
      free($3);  // Free the identifier after use
    }
    ;

%%

void yyerror(const char *s) {
  fprintf(stderr, "\033[31m[ERROR] %s at line %d, near token '%s'\033[0m\n", s, yylineno, yytext);
  /* exit(1); */ // removed to allow full error reporting
}



int main() {
  printf("\n\033[34m================================== Compilation Start ==================================\033[0m\n");
  yyparse();
  return 0;
}