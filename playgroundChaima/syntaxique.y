%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "ts.h"

extern int yylineno;
extern int nb_colonne;

void yyerror(const char* s) {
    fprintf(stderr, "Erreur syntaxique: %s, ligne %d, colonne %d\n", s, yylineno, nb_colonne);
}
%}

/* Déclaration des types de données */
%union {
    int entier;
    double reel;
    char* texte;
    int bool_val;  
}

%token <entier> NUM
%token <reel> REAL
%token <texte> TEXT
%token <texte> IDF

%token SI ALORS SINON
%token TANTQUE FAIRE
%token DEBUT FIN EXECUTION
%token FIXE AFFICHE LIRE
%token ET OU NON
%token EGAL DIFFERENT INF INF_EGAL SUP SUP_EGAL
%token PLUS MOINS MULT DIV

%type <entier> declaration
%type <entier> expression
%type <bool_val> condition
%type <texte> type constante


/* Priorités et associativité */
%left OU
%left ET
%right NON
%nonassoc EGAL DIFFERENT INF INF_EGAL SUP SUP_EGAL
%left PLUS MOINS
%left MULT DIV

/* Point de départ */
%start programme

%%

programme
    : DEBUT declarations EXECUTION bloc FIN
        { printf("Programme valide\n"); }
    ;

declarations
    : declaration declarations
    | /* vide */
    ;

declaration
    : type ':' IDF ';'
        { 
            if (verifier_double_declaration($3)) {
                fprintf(stderr, "Erreur: double déclaration de la variable %s\n", $3);
                YYERROR;
            } else {
                inserer($3, $1);
            }
        }
    | FIXE type ':' IDF '=' constante ';'
        { 
            if (verifier_double_declaration($4)) {
                fprintf(stderr, "Erreur: double déclaration de la constante %s\n", $4);
                YYERROR;
            } else {
                inserer_constante($4, $2, $6);
            }
        }
    | type ':' IDF '[' NUM ']' ';'
        { 
            if ($5 <= 0) {
                fprintf(stderr, "Erreur: taille de tableau non valide (%d)\n", $5);
                YYERROR;
            } else if (verifier_double_declaration($3)) {
                fprintf(stderr, "Erreur: double déclaration du tableau %s\n", $3);
                YYERROR;
            } else {
                inserer_tableau($3, $1, $5);
            }
        }
    ;

type
    : TEXT { $$ = TEXT; }
    | NUM { $$ = NUM; }
    | REAL { $$ = REAL; }
    ;

constante
    : NUM { $$ = $1; }
    | REAL { $$ = $1; }
    | TEXT { $$ = $1; }
    ;

bloc
    : '{' instructions '}'
    ;

instructions
    : instruction instructions
    | /* vide */
    ;

instruction
    : IDF '<-' expression ';'
        { 
            if (!verifier_declaration($1)) {
                fprintf(stderr, "Erreur: variable non déclarée (%s)\n", $1);
                YYERROR;
            } else if (est_constante($1)) {
                fprintf(stderr, "Erreur: modification de la valeur d'une constante (%s)\n", $1);
                YYERROR;
            } else {
                printf("Affectation: %s <- %d\n", $1, $3);
            }
        }
    | AFFICHE '(' expression ')' ';'
        { 
            printf("%d\n", $3);
        }
    | LIRE '(' IDF ')' ';'
        { 
            if (!verifier_declaration($3)) {
                fprintf(stderr, "Erreur: variable non déclarée (%s)\n", $3);
                YYERROR;
            }
        }
    | SI '(' condition ')' ALORS bloc SINON bloc
        { }
    | SI '(' condition ')' ALORS bloc
        { }
    | TANTQUE '(' condition ')' FAIRE bloc
        { }
    ;

expression
    : expression PLUS expression
        { $$ = $1 + $3; }
    | expression MOINS expression
        { $$ = $1 - $3; }
    | expression MULT expression
        { $$ = $1 * $3; }
    | expression DIV expression
        { 
            if ($3 == 0) {
                fprintf(stderr, "Erreur: division par 0\n");
                YYERROR;
            }
            $$ = $1 / $3;
        }
    | '(' expression ')'
        { $$ = $2; }
    | NUM
        { $$ = $1; }
    | REAL
        { $$ = $1; }
    | IDF
        { 
            if (!verifier_declaration($1)) {
                fprintf(stderr, "Erreur: variable non déclarée (%s)\n", $1);
                YYERROR;
            }
            $$ = recuperer_valeur($1);
        }
    ;

condition
    : expression INF expression
        { $$ = $1 < $3; }
    | expression INF_EGAL expression
        { $$ = $1 <= $3; }
    | expression SUP expression
        { $$ = $1 > $3; }
    | expression SUP_EGAL expression
        { $$ = $1 >= $3; }
    | expression EGAL expression
        { $$ = $1 == $3; }
    | expression DIFFERENT expression
        { $$ = $1 != $3; }
    | NON condition
        { $$ = !$2; }
    | condition ET condition
        { $$ = $1 && $3; }
    | condition OU condition
        { $$ = $1 || $3; }
    ;

%%

int main() {
    printf("Début de l'analyse syntaxique\n");
    return yyparse();
}
