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
}

%token <entier> NUM SIGNEDNUM       // Integer tokens
%token <reel> REAL SIGNEDREAL       // Real tokens
%token <texte> TEXT IDF             // Text and Identifier tokens

%type <texte> type                  // Non-terminal for types (NUM, REAL, TEXT)
%type <texte> constantT
%type <reel> constantR
%type <entier> constantN
%type <entier> expressionN
%type <reel> expressionR
%type <texte> expressionT


%token DEBUT FIN EXECUTION SI ALORS SINON TANTQUE FAIRE FIXE 
%token AFFICHE LIRE
%token LFBRA RTBRA LFSQBRA RTSQBRA LFPar RTPar /*QUOT */
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
program://check
    DEBUT declarations EXECUTION LFBRA instructions RTBRA FIN
    {
        afficher(); // Print symbol table
        printf("Programme syntaxiquement correct.\n");
        YYACCEPT;
    }
    ;


declarations://Check
    declarations declaration
    | /* empty */  // No declarations
    ;

constantN://check
    NUM { $$ = strdup(yytext); }
    |IDF
    | SIGNEDNUM { $$ = strdup(yytext); }
    ;

constantR://check
    REAL { $$ = strdup(yytext); }
    |IDF
    | SIGNEDREAL { $$ = strdup(yytext); }
    ;

constantT://Check
    TEXT { $$ = strdup(yytext); }
    |IDF
    ;

declaration://check
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

    | FIXE type COLON IDF AFFECT constantN SEMICOLON {
        if (recherche($4) != -1) {
            printf("Erreur: Double déclaration de la constante '%s' à la ligne %d.\n", $4, nb_ligne);
        } else {
            inserer($4, "Constante", $2, "Oui");
            printf("Constante déclarée: Type %s, Nom %s, Valeur %s.\n", $2, $4, $6);
        }
    }
    
    | FIXE type COLON IDF AFFECT constantR SEMICOLON {
        if (recherche($4) != -1) {
            printf("Erreur: Double déclaration de la constante '%s' à la ligne %d.\n", $4, nb_ligne);
        } else {
            inserer($4, "Constante", $2, "Oui");
            printf("Constante déclarée: Type %s, Nom %s, Valeur %s.\n", $2, $4, $6);
        }
    }
    | FIXE type COLON IDF AFFECT constantT SEMICOLON {
        if (recherche($4) != -1) {
            printf("Erreur: Double déclaration de la constante '%s' à la ligne %d.\n", $4, nb_ligne);
        } else {
            inserer($4, "Constante", $2, "Oui");
            printf("Constante déclarée: Type %s, Nom %s, Valeur %s.\n", $2, $4, $6);
        }
    }
    ;
    
array_access://check
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


type://check
    NUM { $$ = strdup("NUM"); }
    | REAL { $$ = strdup("REAL"); }
    | TEXT { $$ = strdup("TEXT"); }
;

instructions://check
    instructions instruction
    | instruction
    ;

instruction://check
    affectation
    | array_access
    | ConditionSI_ALORS_SINON
    | BoucleTANTQUE
    | Affiche_Lire_operation
    ;
//-----------------------------------------------------------------------------------------------------------
affectation:
    IDF AFFECT expressionN SEMICOLON {
        int index = recherche($1); 
        if (index == -1) {
            printf("Erreur: Variable '%s' non déclarée à la ligne %d.\n", $1, nb_ligne);
        } else if (strcmp(ts[index].Constant, "Oui") == 0) {
            printf("Erreur: Tentative de modification de la constante '%s' à la ligne %d.\n", $1, nb_ligne);
        } else if (strcmp(ts[index].Type, "NUM") != 0) {
            printf("Erreur: Type incompatible pour '%s' à la ligne %d.\n", $1, nb_ligne);
        } else {
            printf("Affectation: '%s' reçoit une nouvelle valeur de type NUM.\n", $1);
        }
    }
    |IDF AFFECT expressionR SEMICOLON {
        int index = recherche($1);
        if (index == -1) {
            printf("Erreur: Variable '%s' non déclarée à la ligne %d.\n", $1, nb_ligne);
        } else if (strcmp(ts[index].Constant, "Oui") == 0) {
            printf("Erreur: Tentative de modification de la constante '%s' à la ligne %d.\n", $1, nb_ligne);
        } else if (strcmp(ts[index].Type, "REAL") != 0) {
            printf("Erreur: Type incompatible pour '%s' à la ligne %d.\n", $1, nb_ligne);
        } else {
            printf("Affectation: '%s' reçoit une nouvelle valeur de type NUM.\n", $1);
        }
    }
    |IDF AFFECT expressionT SEMICOLON {
        int index = recherche($1);
        if (index == -1) {
            printf("Erreur: Variable '%s' non déclarée à la ligne %d.\n", $1, nb_ligne);
        } else if (strcmp(ts[index].Constant, "Oui") == 0) {
            printf("Erreur: Tentative de modification de la constante '%s' à la ligne %d.\n", $1, nb_ligne);
        } else if (strcmp(ts[index].Type, "TEXT") != 0) {
            printf("Erreur: Type incompatible pour '%s' à la ligne %d.\n", $1, nb_ligne);
        } else {
            printf("Affectation: '%s' reçoit une nouvelle valeur de type NUM.\n", $1);
        }
    }
    | array_access AFFECT expressionN SEMICOLON {
        int index = recherche($1);
        if (index == -1) {
            printf("Erreur: Tableau '%s' non déclaré à la ligne %d.\n", $1, nb_ligne);
        } else if (strcmp(ts[index].CodeEntite, "Tableau") != 0) {
            printf("Erreur: '%s' n'est pas un tableau à la ligne %d.\n", $1, nb_ligne);
        } else {
            printf("Affectation: '%s[%d]' reçoit une nouvelle valeur.\n", $1, $3);
        }
    }
    | array_access AFFECT expressionR SEMICOLON {
        int index = recherche($1);
        if (index == -1) {
            printf("Erreur: Tableau '%s' non déclaré à la ligne %d.\n", $1, nb_ligne);
        } else if (strcmp(ts[index].CodeEntite, "Tableau") != 0) {
            printf("Erreur: '%s' n'est pas un tableau à la ligne %d.\n", $1, nb_ligne);
        } else {
            printf("Affectation: '%s[%d]' reçoit une nouvelle valeur.\n", $1, $3);
        }
    }
    | array_access AFFECT expressionT SEMICOLON {
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

//-----------------------------------------------------------------------------------------------------------------------
expressionN :
    NUM { $$ = $1; }
    | IDF {
        int index = recherche($1);
        if (index == -1) {
            printf("Erreur: Variable '%s' non déclarée à la ligne %d.\n", $1, nb_ligne);
            $$ = 0; // Default value
        } else if (strcmp(ts[index].Type, "NUM") != 0) {
            printf("Erreur: Incompatibilité de type pour '%s' à la ligne %d.\n", $1, nb_ligne);
            $$ = 0;
        } else {
            $$ = atoi(ts[index].Valeur); // Retrieve the value
        }
    }
    |SIGNEDNUM { $$ = $1; }
    |expressionN DIV expressionN
    { 
            if ($3 == 0) { 
                printf("Erreur: Division par 0 à la ligne %d, colonne %d\n", nb_ligne, nb_colonne); 
                // Handle the error (e.g., return a default value, exit) 
            } else { 
                $$ = $1 / $3; 
            } 
        } 
    |expressionN MULT expressionN { $$ = $1*$3 }
    |expressionN PLS expressionN { $$ = $1+$3 }
    |expressionN MINS expressionN { $$ = $1-$3 }
    ;

expressionR :
    REAL { $$ = $1; }
     | IDF {
        int index = recherche($1);
        if (index == -1) {
            printf("Erreur: Variable '%s' non déclarée à la ligne %d.\n", $1, nb_ligne);
            $$ = 0; // Default value
        } else if (strcmp(ts[index].Type, "REAL") != 0) {
            printf("Erreur: Incompatibilité de type pour '%s' à la ligne %d.\n", $1, nb_ligne);
            $$ = 0;
        } else {
            $$ = atoi(ts[index].Valeur); // Retrieve the value
        }
    }
    |SIGNEDREAL { $$ = $1; }
    |expressionR DIV expressionR
    { 
            if ($3 == 0.000) { 
                printf("Erreur: Division par 0 à la ligne %d, colonne %d\n", nb_ligne, nb_colonne); 
                // Handle the error (e.g., return a default value, exit) 
            } else { 
                $$ = $1 / $3; 
            } 
        } 
    |expressionR MULT expressionR { $$ = $1*$3 }
    |expressionR PLS expressionR { $$ = $1+$3 }
    |expressionR MINS expressionR { $$ = $1-$3 }
    ;

expressionT :
     TEXT
     |IDF
     ;


//-----------------------------------------------------------------------------------------------------------------------
ConditionSI_ALORS_SINON:
    SI LFPar condition RTPar ALORS LFBRA instructions RTBRA
    | SI LFPar condition RTPar ALORS LFBRA instructions RTBRA SINON LFBRA instructions RTBRA
    ;
//--------------------------------------------------------vvvvvv____________________________________________________________________
condition:
      condition OU condition
    | condition ET condition
    | expressionN LESS expressionN
    | expressionN LESS_EQ expressionN
    | expressionN GREATER expressionN
    | expressionN GREATER_EQ expressionN
    | expressionN EQUAL expressionN
    | expressionN NOT_EQUAL expressionN
    | NON condition
    | expressionR LESS expressionR
    | expressionR LESS_EQ expressionR
    | expressionR GREATER expressionR
    | expressionR GREATER_EQ expressionR
    | expressionR EQUAL expressionR
    | expressionR NOT_EQUAL expressionR
    ;
//-------------------------------------------------------------------------------------------------------------------------------
BoucleTANTQUE:
    TANTQUE LFPar condition RTPar FAIRE LFBRA instructions RTBRA
    ;

Affiche_Lire_operation:
      AFFICHE LFPar expressionN RTPar SEMICOLON {
        printf("Affichage: Expression affichée.\n");
    }
    | AFFICHE LFPar expressionR RTPar SEMICOLON {
        printf("Affichage: Expression affichée.\n");
    }
    | AFFICHE LFPar expressionT RTPar SEMICOLON {
        printf("Affichage: Expression affichée.\n");
    }
    | LIRE LFPar IDF RTPar SEMICOLON {
        if (!is_declared($3)) {
            yyerror("Variable non déclarée.");
        } else {
            printf("Lecture: Variable %s\n", $3);
        }
    }
    |AFFICHE LFPar TEXT RTPar SEMICOLON {
        printf("Affichage: Expression affichée.\n");
    }
    |AFFICHE LFPar TEXT COMMA expressionN RTPar SEMICOLON {
        printf("Affichage: Expression affichée.\n");
    }
    |AFFICHE LFPar TEXT COMMA expressionR RTPar SEMICOLON {
        printf("Affichage: Expression affichée.\n");
    }

    ;

%%
main ()
{ yyparse();
}
yywrap ()
{}

void yyerror(const char* s) {
    printf("Erreur Syntaxique à la ligne %d, colonne %d: %s\n", nb_ligne, nb_colonne, s);
}
