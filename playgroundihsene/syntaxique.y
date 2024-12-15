%{
  #include <stdio.h>
  #include <stdlib.h>
  #include <string.h>
  #include "ts.h"
  extern int yylineno;
  extern char* yytext;
  void yyerror(const char *s);
  SymbolTable* symbol_table; // Global symbol table
  int nb_ligne=1;
  int col=1;
 void yyerror(char *msg);
%}

// Déclaration des types
%union {
  int ival;
  double rval;
  char *sval;
}

%token  TEXT 
%token DEBUT FIN EXECUTION SI ALORS SINON TANTQUE FAIRE FIXE affiche lire
%token OU ET NON
%token LFBRA RTBRA LFSQBRA RTSQBRA LFPar RTPar
%token MINUS PLUS MULT DIV COMMA EQUAL COLON 
%token  NUM
%token  SIGNEDNUM
%token  REAL 
%token  SIGNEDREAL
%token  TEXTE
%token PVIRG
%token AFFECT
%token LESS
%token LEQ
%token GREATER
%token GEQ
%token NEQ

// Tokens

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
%left LESS GREATER LEQ GEQ EQUAL DIFFERENT
%left PLUS MINUS
%left MULT DIV
%right MOINS_UNAIRE

%%

// Début du programme
programme:
    DEBUT {
        symbol_table = create_symbol_table();
    }
    liste_declarations
    EXECUTION LFBRA liste_instructions RTBRA FIN {
        print_symbol_table(symbol_table);
        free_symbol_table(symbol_table);
        printf("Programme syntaxiquement correct.\n");
        $$ = NULL;
    }
    ;

// Bloc d'instructions
bloc:
    LFBRA liste_instructions RTBRA {
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
/*
fixe_declaration:
FIXE IDENTIFICATEUR AFFECT expression PVIRG { printf("Déclaration de %s avec valeur %d\n", $2, $4); }
;
*/

declaration:
    NUM COLON IDENTIFICATEUR PVIRG {
        if (!insert_symbol(symbol_table, $3, ST_TYPE_INTEGER, 0)) {
            yyerror("Variable déjà déclarée.");
        }
        free($3);
        $$ = NULL;
    }
    | REAL COLON IDENTIFICATEUR PVIRG {
        if (!insert_symbol(symbol_table, $3, ST_TYPE_REAL, 0)) {
            yyerror("Variable déjà déclarée.");
        }
        free($3);
        $$ = NULL;
    }
    | TEXT COLON IDENTIFICATEUR PVIRG {
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
    IDENTIFICATEUR AFFECT expression PVIRG {
        if (!check_symbol_exists(symbol_table, $1)) {
            yyerror("Variable non déclarée.");
        }
        free($1);
        $$ = NULL;
    }
    | IDENTIFICATEUR LFSQBRA expression RTSQBRA AFFECT expression PVIRG {
        if (!check_symbol_exists(symbol_table, $1)) {
            yyerror("Tableau non déclaré.");
        }
        free($1);
        $$ = NULL;
    }
    ;

// Sélection
selection:
    SI LFPar condition RTPar ALORS bloc {
        $$ = NULL;
    }
    | SI LFPar condition RTPar ALORS bloc SINON bloc {
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
    expression LESS expression {
        $$ = NULL;
    }
    | expression GREATER expression {
        $$ = NULL;
    }
    | expression LEQ expression {
        $$ = NULL;
    }
    | expression GEQ expression {
        $$ = NULL;
    }
    | expression EQUAL expression {
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
    | IDENTIFICATEUR LFSQBRA expression RTSQBRA {
        if (!check_symbol_exists(symbol_table, $1)) {
            yyerror("Tableau non déclaré.");
        }
        free($1);
        $$ = NULL;
    }
    | expression PLUS expression {
        $$ = NULL;
    }
    | expression MINUS expression {
        $$ = NULL;
    }
    | expression MULT expression {
        $$ = NULL;
    }
    | expression DIV expression {
        $$ = NULL;
    }
    | LFPar expression RTPar {
        $$ = NULL;
    }
    | MINUS expression %prec MOINS_UNAIRE {
        $$ = NULL;
    }
    ;

// Entrée/Sortie
entree_sortie:
    affiche LFPar expression RTPar PVIRG {
        $$ = NULL;
    }
    | lire LFPar IDENTIFICATEUR RTPar PVIRG {
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
    fprintf(stderr, "[Erreur] %s à la ligne %d,et colonne: %d près de '%s'.\n", s, yylineno,nb_colonne, yytext);
}

// Point d'entrée
int main() {
    printf("Début de l'analyse syntaxique...\n");
    yyparse();
    printf("Analyse terminée.\n");
    return 0;
}
