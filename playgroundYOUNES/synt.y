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
%type <entier> array_size
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

array_size:
    NUM { $$ = $1; }  // Array size must be a positive integer (NUM)
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
            printf("Erreur: Double déclaration de la variable '%s' à la ligne %d.\n", $3, nb_ligne);
        } else {
            inserer($3, $1); // Insert into symbol table
            printf("Variable déclarée: Type %s, Nom %s.\n", $1, $3);
        }
    }
    | type COLON IDF LFSQBRA array_size RTSQBRA SEMICOLON {
        if (recherche($3) != -1) {
            printf("Erreur: Double déclaration du tableau '%s' à la ligne %d.\n", $3, nb_ligne);
        } else if ($5 <= 0) {
            printf("Erreur: Taille du tableau '%s' invalide (%d) à la ligne %d.\n", $3, $5, nb_ligne);
        } else {
            inserer($3, $1); // Insert into symbol table
            printf("Tableau déclaré: Type %s, Nom %s, Taille %d.\n", $1, $3, $5);
        }
    }
    | FIXE type COLON IDF AFFECT constant SEMICOLON {
        if (recherche($4) != -1) {
            printf("Erreur: Double déclaration de la constante '%s' à la ligne %d.\n", $4, nb_ligne);
        } else {
            inserer($4, $2); // Insert constant into symbol table
            printf("Constante déclarée: Type %s, Nom %s, Valeur %s.\n", $2, $4, $6);
        }
    }
    ;



type:
    "NUM" { $$ = strdup("NUM"); }
    | "REAL" { $$ = strdup("REAL"); }
    | "TEXT" { $$ = strdup("TEXT"); }
;

instructions:
    instructions instruction
    | instruction
    ;

instruction:
    affectation
    | ConditionSI_ALORS_SINON
    | BoucleTANTQUE
    | Affiche_Lire_operation
    ;

affectation:
    IDF AFFECT expression {
        if (recherche($1) == -1) {
            printf("Erreur: Variable '%s' non déclarée à la ligne %d.\n", $1, nb_ligne);
        } else {
            printf("Affectation: Variable %s mise à jour.\n", $1);
        }
    }
    ;

expression : 
      expression PLS expression 
        { $$ = $1 + $3; } 
    | expression MINS expression 
        { $$ = $1 - $3; } 
    | expression MULT expression 
        { $$ = $1 * $3; } 
    | expression DIV expression 
        { 
            if ($3 == 0) { 
                printf("Erreur: Division par 0 à la ligne %d, colonne %d\n", nb_ligne, nb_colonne); 
                // Handle the error (e.g., return a default value, exit) 
            } else { 
                $$ = $1 / $3; 
            } 
        } 
    | NUM 
        { $$ = $1; } 
    | SIGNEDNUM 
        { $$ = $1; } 
    | REAL 
        { $$ = $1; } 
    | SIGNEDREAL 
        { $$ = $1; } 
    | IDF 
        { 
            // Look up the value of the identifier 
            // (e.g., in a symbol table) 
            // and assign it to $$ 
        } 
    ;

ConditionSI_ALORS_SINON:
    SI LFPar condition RTPar ALORS LFBRA instructions RTBRA
    | SI LFPar condition RTPar ALORS LFBRA instructions RTBRA SINON LFBRA instructions RTBRA
    ;

condition:
    expression LESS expression
    | expression LESS_EQ expression
    | expression GREATER expression
    | expression GREATER_EQ expression
    | expression EQUAL expression
    | expression NOT_EQUAL expression
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
