%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int nb_ligne = 1;
int nb_colonne = 1;

void yyerror(const char* s) {
    fprintf(stderr, "Erreur syntaxique: %s, ligne %d, colonne %d\n", s, nb_ligne, nb_colonne);
}
%}

/* Déclarations de types et tokens */
%union {
    int entier;
    double reel;
    char* texte;
}

%token <entier> NUM
%token <reel> REAL
%token <texte> TEXT
%token <texte> IDF
%token SI ALORS SINON TANTQUE FAIRE DEBUT FIN EXECUTION FIXE AFFICHE LIRE
%token ACCOLADE_OUVRANTE ACCOLADE_FERMANTE
%token PARENTHOISE_OUVRANTE PARENTHOISE_FERMANTE
%token PLUS MOINS MULT DIV VIRGULE POINT_VIRGULE
%token DEUX_POINTS EGAL INF SUP DIFFERENT INF_EGAL SUP_EGAL AFFECTION
%token OU ET NON ERR

%left PLUS MOINS
%left MULT DIV
%nonassoc INF INF_EGAL SUP SUP_EGAL EGAL DIFFERENT

%start programme

%%

programme
    : DEBUT declarations EXECUTION bloc FIN
        { printf("Programme valide.\n"); }
    ;

declarations
    : declaration declarations
    | /* vide */
    ;

declaration
    : FIXE IDF AFFECTION expression POINT_VIRGULE
    | FIXE IDF AFFECTION TEXT POINT_VIRGULE
    ;

bloc
    : ACCOLADE_OUVRANTE instructions ACCOLADE_FERMANTE
    ;

instructions
    : instruction instructions
    | /* vide */
    ;

instruction
    : IDF AFFECTION expression POINT_VIRGULE
    | AFFICHE PARENTHOISE_OUVRANTE liste_arguments PARENTHOISE_FERMANTE POINT_VIRGULE
    | LIRE IDF POINT_VIRGULE
    ;

liste_arguments
    : TEXT
    | TEXT VIRGULE IDF
    ;

expression
    : NUM
    | REAL
    | MOINS NUM
    | MOINS REAL
    | IDF
    | expression PLUS expression
    | expression MOINS expression
    | expression MULT expression
    | expression DIV expression
    ;

%%

int main() {
    printf("Début de l'analyse.\n");
    return yyparse();
}
