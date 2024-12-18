%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int nb_ligne = 1;
int nb_colonne = 1;

extern int yylex();
void yyerror(const char* s);

// Déclaration des fonctions de la table des symboles
extern int recherche(char entite[]);
extern void inserer(char entite[], char code[], int type, int type_donnee);
extern void affecter(char entite[], int is_int, double value);
extern void affecter_texte(char entite[], const char* texte);
extern void afficher();
%}

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

%left OU               
%left ET                
%right NON             
%nonassoc INF INF_EGAL SUP SUP_EGAL
%left EGAL DIFFERENT    
%left PLUS MOINS        
%left MULT DIV          

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
    : FIXE type_variable DEUX_POINTS IDF EGAL expression POINT_VIRGULE
        {
            if (recherche($4) != -1) {
                yyerror("Erreur: Double déclaration de variable.");
            } else {
                inserer($4, "FIXE", 0, $1);  // Insertion de la variable dans la table
                affecter($4, 1, $6);  // Affectation de la valeur à la variable
            }
        }
    | type_variable DEUX_POINTS IDF POINT_VIRGULE
        {
            if (recherche($3) != -1) {
                yyerror("Erreur: Double déclaration de variable.");
            } else {
                inserer($3, "VARIABLE", 0, $1);
            }
        }
    | table
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
        {
            int idx = recherche($1);
            if (idx == -1) {
                yyerror("Erreur: Variable non déclarée.");
            } else {
                // Vérification de la compatibilité des types
                if (ts[idx].type_donnee != $3.type_donnee) {
                    yyerror("Erreur: Incompatibilité de type.");
                } else {
                    affecter($1, 1, $3.reel);
                }
            }
        }
    ;

bloc
    : ACCOLADE_OUVRANTE instructions ACCOLADE_FERMANTE
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
        {
            if ($3.reel == 0) {
                yyerror("Erreur: Division par zéro.");
            }
        }
    ;

table
    : type_variable DEUX_POINTS IDF CROCHET_OUVRANT NUM CROCHET_FERMANT POINT_VIRGULE
        {
            if ($6 <= 0) {
                yyerror("Erreur: Dépassement de la taille du tableau.");
            }
            inserer($3, "TABLEAU", 1, $1);  // Insertion dans la table des symboles
        }
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
    | IDF
    | TEXT
    | expression PLUS expression
    | expression MOINS expression
    | expression MULT expression
    | expression DIV expression
        {
            if ($3 == 0) {
                yyerror("Erreur: Division par zéro.");
            }
        }
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

int main() {
    printf("Debut de l'analyse.\n");
    return yyparse();
}

void yyerror(const char* s) {
    fprintf(stderr, "Erreur: %s\n", s);
    exit(1);
}
