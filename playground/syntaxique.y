%{
  #include <stdio.h>
  #include <stdlib.h>
  #include <string.h>
  #include "ts.h"
  extern int yylex();
  extern int yylineno;
  extern char* yytext;
  void yyerror(const char *s);
  SymbolTable* symbol_table; // Global symbol table
%}

// Déclaration des types
%union {
  int ival;
  double rval;
  char* sval;
}

// Tokens
%token DEBUT FIN EXECUTION
%token SI ALORS SINON TANTQUE FAIRE
%token FIXE AFFICHE LIRE
%token TYPE_NUM TYPE_REAL TYPE_TEXT
%token MOINS_EGALE PLUS_EGALE INF_EGALE SUP_EGALE DIFFERENT
%token ET OU NON
%token ASSIGNMENT
%token <sval> IDENTIFICATEUR
%token <ival> NOMBRE_ENTIER
%token <rval> NOMBRE_REEL
%token <sval> CHAINE_TEXTE

// Types des non-terminaux
%type <sval> programme bloc liste_declarations
%type <sval> instruction liste_instructions condition
%type <sval> affectation selection iteration entree_sortie
%type <sval> expression declaration

// Priorité des opérateurs
%left OU
%left ET
%left NON
%left '<' '>' INF_EGALE SUP_EGALE '=' DIFFERENT
%left '+' '-'
%left '*' '/'
%right MOINS_UNAIRE

%%

// Début du programme
programme:
    DEBUT {
        symbol_table = create_symbol_table();
    }
    liste_declarations
    EXECUTION '{' liste_instructions '}' FIN {
        print_symbol_table(symbol_table);
        free_symbol_table(symbol_table);
        printf("Programme syntaxiquement correct.\n");
        $$ = NULL;
    }
    ;

// Bloc d'instructions
bloc:
    '{' liste_instructions '}' {
        $$ = NULL;
    }
    ;

// Déclarations
liste_declarations:
    declaration {
        $$ = NULL;
    }
    | liste_declarations declaration {
        $$ = NULL;
    }
    ;

declaration:
    TYPE_NUM ':' IDENTIFICATEUR ';' {
        if (!insert_symbol(symbol_table, $3, ST_TYPE_INTEGER, 0)) {
            yyerror("Variable déjà déclarée.");
        }
        free($3);
        $$ = NULL;
    }
    | TYPE_REAL ':' IDENTIFICATEUR ';' {
        if (!insert_symbol(symbol_table, $3, ST_TYPE_REAL, 0)) {
            yyerror("Variable déjà déclarée.");
        }
        free($3);
        $$ = NULL;
    }
    | TYPE_TEXT ':' IDENTIFICATEUR ';' {
        if (!insert_symbol(symbol_table, $3, ST_TYPE_STRING, 0)) {
            yyerror("Variable déjà déclarée.");
        }
        free($3);
        $$ = NULL;
    }
    ;

// Liste des instructions
liste_instructions:
    instruction {
        $$ = NULL;
    }
    | liste_instructions instruction {
        $$ = NULL;
    }
    ;

instruction:
    affectation
    | selection
    | iteration
    | entree_sortie
    ;

// Affectation
affectation:
    IDENTIFICATEUR ASSIGNMENT expression ';' {
        if (!check_symbol_exists(symbol_table, $1)) {
            yyerror("Variable non déclarée.");
        }
        free($1);
        $$ = NULL;
    }
    | IDENTIFICATEUR '[' expression ']' ASSIGNMENT expression ';' {
        if (!check_symbol_exists(symbol_table, $1)) {
            yyerror("Tableau non déclaré.");
        }
        free($1);
        $$ = NULL;
    }
    ;

// Sélection
selection:
    SI '(' condition ')' ALORS bloc {
        $$ = NULL;
    }
    | SI '(' condition ')' ALORS bloc SINON bloc {
        $$ = NULL;
    }
    ;

// Itération
iteration:
    TANTQUE condition FAIRE bloc {
        $$ = NULL;
    }
    ;

// Condition
condition:
    expression '<' expression {
        $$ = NULL;
    }
    | expression '>' expression {
        $$ = NULL;
    }
    | expression INF_EGALE expression {
        $$ = NULL;
    }
    | expression SUP_EGALE expression {
        $$ = NULL;
    }
    | expression '=' expression {
        $$ = NULL;
    }
    | expression DIFFERENT expression {
        $$ = NULL;
    }
    | condition ET condition {
        $$ = NULL;
    }
    | condition OU condition {
        $$ = NULL;
    }
    | NON condition {
        $$ = NULL;
    }
    ;

// Expression
expression:
    NOMBRE_ENTIER {
        $$ = NULL;
    }
    | NOMBRE_REEL {
        $$ = NULL;
    }
    | CHAINE_TEXTE {
        $$ = NULL;
    }
    | IDENTIFICATEUR {
        if (!check_symbol_exists(symbol_table, $1)) {
            yyerror("Variable non déclarée.");
        }
        free($1);
        $$ = NULL;
    }
    | IDENTIFICATEUR '[' expression ']' {
        if (!check_symbol_exists(symbol_table, $1)) {
            yyerror("Tableau non déclaré.");
        }
        free($1);
        $$ = NULL;
    }
    | expression '+' expression {
        $$ = NULL;
    }
    | expression '-' expression {
        $$ = NULL;
    }
    | expression '*' expression {
        $$ = NULL;
    }
    | expression '/' expression {
        $$ = NULL;
    }
    | '(' expression ')' {
        $$ = NULL;
    }
    | '-' expression %prec MOINS_UNAIRE {
        $$ = NULL;
    }
    ;

// Entrée/Sortie
entree_sortie:
    AFFICHE '(' expression ')' ';' {
        $$ = NULL;
    }
    | LIRE '(' IDENTIFICATEUR ')' ';' {
        if (!check_symbol_exists(symbol_table, $3)) {
            yyerror("Variable non déclarée.");
        }
        free($3);
        $$ = NULL;
    }
    ;

%%

// Gestion des erreurs
void yyerror(const char *s) {
    fprintf(stderr, "[Erreur] %s à la ligne %d, près de '%s'.\n", s, yylineno, yytext);
}

// Point d'entrée
int main() {
    printf("Début de l'analyse syntaxique...\n");
    yyparse();
    printf("Analyse terminée.\n");
    return 0;
}
