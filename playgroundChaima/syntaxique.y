%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int nb_ligne = 1;
int nb_colonne = 1;


// why we declared this function here ?
// void yyerror(const char* s) {
//     fprintf(stderr, "Erreur syntaxique: %s, ligne %d, colonne %d\n", s, nb_ligne, nb_colonne);
// }
%}

/* Déclarations de types et tokens */
%union {
    int entier;
    double reel;
    char* texte;
}

%token <entier> NUM SIGNEDNUM
%token <reel> REAL SIGNEDREAL
%token <texte> TEXT
%token <texte> IDF
%token SI ALORS SINON TANTQUE FAIRE DEBUT FIN EXECUTION FIXE AFFICHE LIRE
%token ACCOLADE_OUVRANTE ACCOLADE_FERMANTE
%token PARENTHOISE_OUVRANTE PARENTHOISE_FERMANTE
%token CROCHET_OUVRANT CROCHET_FERMANT
%token PLUS MOINS MULT DIV VIRGULE POINT_VIRGULE
%token DEUX_POINTS EGAL INF SUP DIFFERENT INF_EGAL SUP_EGAL AFFECTION 
%token OU ET NON ERR
%token TYPE_NUM TYPE_REAL TYPE_TEXT TYPE_SIGNEDNUM TYPE_SIGNEDREAL


/* order is important for the priority (bottom >>>> top) */
%left OU           // Lower precedence    
%left ET                
%right NON             
%nonassoc INF INF_EGAL SUP SUP_EGAL
%left EGAL DIFFERENT    
%left PLUS MOINS        
%left MULT DIV         // Higher precedence
/* nzido ! maybe ------- */

%start programme      // the root non-terminal of the grammar

%%

programme
    : DEBUT declarations EXECUTION bloc FIN
        { printf("Programme valide ✅\n"); }
    ;

declarations
    : declaration declarations
    | /* vide */
    ;


declaration
    :  FIXE type_variable DEUX_POINTS IDF EGAL expression POINT_VIRGULE
    |  type_variable DEUX_POINTS IDF POINT_VIRGULE
    |  table
    ;

type_variable
    : TYPE_NUM
    | TYPE_REAL
    | TYPE_TEXT
    | TYPE_SIGNEDNUM
    | TYPE_SIGNEDREAL
    ;

affect
    : IDF AFFECTION expression POINT_VIRGULE
    | table
    ; 

bloc
    :  ACCOLADE_OUVRANTE instructions ACCOLADE_FERMANTE 
    ;

instructions
    : instruction instructions
    | /* vide */
    ;

instruction
    : AFFICHE PARENTHOISE_OUVRANTE liste_arguments PARENTHOISE_FERMANTE POINT_VIRGULE
    | LIRE IDF POINT_VIRGULE
    | condition
    | boucle
    | affect
    ;


condition
    : SI PARENTHOISE_OUVRANTE expression PARENTHOISE_FERMANTE ALORS bloc SINON bloc
    | SI PARENTHOISE_OUVRANTE expression PARENTHOISE_FERMANTE ALORS bloc SINON condition
    | SI PARENTHOISE_OUVRANTE expression PARENTHOISE_FERMANTE ALORS bloc SINON boucle
    | SI PARENTHOISE_OUVRANTE expression PARENTHOISE_FERMANTE ALORS bloc
    ;

boucle
    : TANTQUE PARENTHOISE_OUVRANTE expression PARENTHOISE_FERMANTE FAIRE bloc
    | TANTQUE PARENTHOISE_OUVRANTE expression PARENTHOISE_FERMANTE FAIRE boucle
    ;

table
    : type_variable DEUX_POINTS IDF CROCHET_OUVRANT NUM CROCHET_FERMANT POINT_VIRGULE
    | IDF CROCHET_OUVRANT NUM CROCHET_FERMANT AFFECTION valeur POINT_VIRGULE
    ;

liste_arguments
    : TEXT
    | IDF
    | liste_arguments VIRGULE TEXT
    | liste_arguments VIRGULE IDF
    ;

chiffre
    : NUM
    | REAL
    | SIGNEDNUM
    | SIGNEDREAL
    ;

valeur
    : NUM
    | REAL
    | SIGNEDNUM
    | SIGNEDREAL
    | TEXT
    ;

expression
    : NUM
    | REAL
    | SIGNEDNUM
    | SIGNEDREAL
    | condition
    | boucle
    | IDF
    | TEXT
    | expression PLUS expression
    | expression MOINS expression
    | expression MULT expression
    | expression DIV expression
    | expression EGAL expression
    | expression INF expression
    | expression SUP expression
    | expression DIFFERENT expression
    | expression INF_EGAL expression
    | expression SUP_EGAL expression
    | expression ET expression
    | expression OU expression
    | NON expression 
    ;

%%

yyerror(const char* s) {
    fprintf(stderr, "Erreur syntaxique: %s, ligne %d, colonne %d\n", s, nb_ligne, nb_colonne);
}

int main() {
    printf("Debut de l'analyse.\n");
    /* return ttparse();  // why <e are returning yparse() ? */
    yyparse();
    return 0;
}