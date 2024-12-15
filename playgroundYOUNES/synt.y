%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#include "ts.h"


int nb_ligne=1;
int nb_colonne=1; 

extern char *yytext;  // Declare yytext here
extern int yylex();
void yyerror(const char* s);

%}

/* Token Definitions */
%union {
    int entier;        // For NUM values
    double reel;       // For REAL values
    char* texte;       // For TEXT values
    int taille;        // For array sizes
}

%token <entier> NUM SIGNEDNUM       // Integer tokens
%token <reel> REAL SIGNEDREAL       // Real tokens
%token <texte> TEXT IDF             // Text and Identifier tokens

%type <texte> type                  // Non-terminal for types (NUM, REAL, TEXT)
%type <entier> constant
 

%token DEBUT FIN EXECUTION SI ALORS SINON TANTQUE FAIRE FIXE
%token AFFICHE LIRE
%token LFBRA RTBRA LFSQBRA RTSQBRA LFPar RTPar
%token PLS MINS MULT DIV OU ET NON
%token COMMA SEMICOLON COLON AFFECT LESS LESS_EQ GREATER GREATER_EQ EQUAL NOT_EQUAL

/* Operator Precedence */
%left OU
%left ET
%left NON
%left LESS LESS_EQ GREATER GREATER_EQ EQUAL NOT_EQUAL
%left PLS MINS
%left MULT DIV


%start program

/* Grammar Rules */
%%
program:
    DEBUT declarations EXECUTION LFBRA instructions RTBRA FIN
    {
        afficher(); // Print symbol table
        printf("Programme syntaxiquement correct.\n");
        YYACCEPT;
    }
    ;


declarations:
    declarations declaration
    | /* empty */  // No declarations
    ;

constant:
    NUM { $$ = strdup(yytext); }
    | SIGNEDNUM { $$ = strdup(yytext); }
    | REAL { $$ = strdup(yytext); }
    | SIGNEDREAL { $$ = strdup(yytext); }
    | TEXT { $$ = strdup(yytext); }
    ;

declaration:
    type COLON IDF SEMICOLON {
        if (recherche($3) != -1) {
            printf("Erreur: Double déclaration de l'entité '%s' à la ligne %d.\n", $3, nb_ligne);
        } else {
            inserer($3, "Variable", $1, "Non");
            printf("Variable déclarée: Type %s, Nom %s.\n", $1, $3);
        }
    }
    | type COLON IDF LFSQBRA NUM RTSQBRA SEMICOLON {
    if (recherche($3) != -1) {
        printf("Erreur: Double déclaration du tableau '%s' à la ligne %d.\n", $3, nb_ligne);
    } else if ($5 <= 0) {
        printf("Erreur: Taille du tableau '%s' invalide (%d) à la ligne %d.\n", $3, $5, nb_ligne);
    } else {
        char size[10];
        sprintf(size, "%d", $5); // Convert size to string
        inserer($3, "Tableau", $1, size);
        printf("Tableau déclaré: Type %s, Nom %s, Taille %d.\n", $1, $3, $5);
    }
}

    | FIXE type COLON IDF AFFECT constant SEMICOLON {
        if (recherche($4) != -1) {
            printf("Erreur: Double déclaration de la constante '%s' à la ligne %d.\n", $4, nb_ligne);
        } else {
            inserer($4, "Constante", $2, "Oui");
            printf("Constante déclarée: Type %s, Nom %s, Valeur %s.\n", $2, $4, $6);
        }
    }
    ;
    
array_access:
    IDF LFSQBRA NUM RTSQBRA {
        int index = recherche($1);
        if (index == -1) {
            printf("Erreur: Tableau '%s' non déclaré à la ligne %d.\n", $1, nb_ligne);
        } else if (strcmp(ts[index].CodeEntite, "Tableau") != 0) {
            printf("Erreur: '%s' n'est pas un tableau à la ligne %d.\n", $1, nb_ligne);
        } else if ($3 >= atoi(ts[index].Constant)) {
            printf("Erreur: Dépassement de la taille du tableau '%s' à la ligne %d (taille maximale: %s).\n", $1, nb_ligne, ts[index].Constant);
        } else {
            printf("Accès au tableau '%s[%d]' validé.\n", $1, $3);
        }
    }
    ;


type:
    NUM { $$ = strdup("NUM"); }
    | REAL { $$ = strdup("REAL"); }
    | TEXT { $$ = strdup("TEXT"); }
;

instructions:
    instructions instruction
    | instruction
    ;

instruction:
    affectation
    | array_access
    | ConditionSI_ALORS_SINON
    | BoucleTANTQUE
    | Affiche_Lire_operation
    ;

affectation:
    IDF AFFECT expression SEMICOLON {
        int index = recherche($1);
        if (index == -1) {
            printf("Erreur: Variable '%s' non déclarée à la ligne %d.\n", $1, nb_ligne);
        } else if (strcmp(ts[index].Constant, "Oui") == 0) {
            printf("Erreur: Tentative de modification de la constante '%s' à la ligne %d.\n", $1, nb_ligne);
        } else {
            printf("Affectation: '%s' reçoit une nouvelle valeur.\n", $1);
        }
    }
    | array_access AFFECT expression SEMICOLON {
        int index = recherche($1);
        if (index == -1) {
            printf("Erreur: Tableau '%s' non déclaré à la ligne %d.\n", $1, nb_ligne);
        } else if (strcmp(ts[index].CodeEntite, "Tableau") != 0) {
            printf("Erreur: '%s' n'est pas un tableau à la ligne %d.\n", $1, nb_ligne);
        } else {
            printf("Affectation: '%s[%d]' reçoit une nouvelle valeur.\n", $1, $3);
        }
    }
    ;



expression : 
     NUM 
    | SIGNEDNUM 
    | REAL 
    | SIGNEDREAL 
    | IDF 
    | array_access
    | expression PLS expression 
    | expression MINS expression 
    | expression MULT expression 
    | expression DIV expression 
        { 
            if ($3 == 0) { 
                printf("Erreur: Division par 0 à la ligne %d, colonne %d\n", nb_ligne, nb_colonne); 
                // Handle the error (e.g., return a default value, exit) 
            } else { 
                $$ = $1 / $3; 
            } 
        } 

    ;

ConditionSI_ALORS_SINON:
    SI LFPar condition RTPar ALORS LFBRA instructions RTBRA
    | SI LFPar condition RTPar ALORS LFBRA instructions RTBRA SINON LFBRA instructions RTBRA
    ;

condition:
      condition OU condition
    | condition ET condition
    | expression LESS expression
    | expression LESS_EQ expression
    | expression GREATER expression
    | expression GREATER_EQ expression
    | expression EQUAL expression
    | expression NOT_EQUAL expression
    | NON condition
    ;

BoucleTANTQUE:
    TANTQUE LFPar condition RTPar FAIRE LFBRA instructions RTBRA
    ;

Affiche_Lire_operation:
    AFFICHE LFPar expression RTPar SEMICOLON {
        printf("Affichage: Expression affichée.\n");
    }
    | LIRE LFPar IDF RTPar SEMICOLON {
        if (!is_declared($3)) {
            yyerror("Variable non déclarée.");
        } else {
            printf("Lecture: Variable %s\n", $3);
        }
    }

%%

/* Error Handling */
void yyerror(const char* s) {
    printf("Erreur Syntaxique à la ligne %d, colonne %d: %s\n", nb_ligne, nb_colonne, s);
}
