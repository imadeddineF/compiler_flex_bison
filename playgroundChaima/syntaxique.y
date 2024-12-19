%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int nb_ligne = 1;
int nb_colonne = 1;


%}

%union {
    int entier;         // pour les entiers
    double reel;        // pour les réels
    char* texte;        // pour les chaînes de caractères
    struct { int type_donnee; int taille; } tableau;  // pour les tableaux
}

%token <entier> NUM SIGNEDNUM
%token <reel> REAL SIGNEDREAL
%token <texte> TEXT
%token <texte> IDF
%token <texte> TYPE_NUM TYPE_REAL TYPE_TEXT TYPE_SIGNEDNUM TYPE_SIGNEDREAL type_variable
%token SI ALORS SINON TANTQUE FAIRE DEBUT FIN EXECUTION FIXE AFFICHE LIRE
%token ACCOLADE_OUVRANTE ACCOLADE_FERMANTE
%token PARENTHOISE_OUVRANTE PARENTHOISE_FERMANTE
%token CROCHET_OUVRANT CROCHET_FERMANT
%token PLUS MOINS MULT DIV VIRGULE POINT_VIRGULE
%token DEUX_POINTS EGAL INF SUP DIFFERENT INF_EGAL SUP_EGAL AFFECTION 
%token OU ET NON ERR

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
    : FIXE NUM DEUX_POINTS IDF EGAL NUM POINT_VIRGULE
        {
            if (recherche($4) != -1) {
                yyerror("Erreur: Double déclaration de variable.");
            } else {
                inserer($4, "FIXE", 0, NUM);
                affecter($4, 1, $6);
            }
        }
    | FIXE SIGNEDNUM DEUX_POINTS IDF EGAL SIGNEDNUM POINT_VIRGULE
        {
            if (recherche($4) != -1) {
                yyerror("Erreur: Double déclaration de variable.");
            } else {
                inserer($4, "FIXE", 0, SIGNEDNUM);
                affecter($4, 1, $6);
            }
        }
    | FIXE REAL DEUX_POINTS IDF EGAL REAL POINT_VIRGULE
        {
            if (recherche($4) != -1) {
                yyerror("Erreur: Double déclaration de variable.");
            } else {
                inserer($4, "FIXE", 0, REAL);
                affecter($4, 0, $6);
            }
        }
    | FIXE SIGNEDREAL DEUX_POINTS IDF EGAL SIGNEDREAL POINT_VIRGULE
        {
            if (recherche($4) != -1) {
                yyerror("Erreur: Double déclaration de variable.");
            } else {
                inserer($4, "FIXE", 0, SIGNEDREAL);
                affecter($4, 0, $6);
            }
        }
    | FIXE TEXT DEUX_POINTS IDF EGAL TEXT POINT_VIRGULE
        {
            if (recherche($4) != -1) {
                yyerror("Erreur: Double déclaration de variable.");
            } else {
                inserer($4, "FIXE", 0, TEXT);
                _affecter_texte($4, $6);
            }
        }
    | NUM DEUX_POINTS IDF POINT_VIRGULE
        {
            if (recherche($3) != -1) {
                yyerror("Erreur: Double déclaration de variable.");
            } else {
                inserer($3, "VARIABLE", 0, NUM);
            }
        }
    | SIGNEDNUM DEUX_POINTS IDF POINT_VIRGULE
        {
            if (recherche($3) != -1) {
                yyerror("Erreur: Double déclaration de variable.");
            } else {
                inserer($3, "VARIABLE", 0, SIGNEDNUM);
            }
        }
    | REAL DEUX_POINTS IDF POINT_VIRGULE
        {
            if (recherche($3) != -1) {
                yyerror("Erreur: Double déclaration de variable.");
            } else {
                inserer($3, "VARIABLE", 0, REAL);
            }
        }
    | SIGNEDREAL DEUX_POINTS IDF POINT_VIRGULE
        {
            if (recherche($3) != -1) {
                yyerror("Erreur: Double déclaration de variable.");
            } else {
                inserer($3, "VARIABLE", 0, SIGNEDREAL);
            }
        }
    | TEXT DEUX_POINTS IDF POINT_VIRGULE
        {
            if (recherche($3) != -1) {
                yyerror("Erreur: Double déclaration de variable.");
            } else {
                inserer($3, "VARIABLE", 0, TEXT);
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
    : SI PARENTHOISE_OUVRANTE expression_comparative PARENTHOISE_FERMANTE ALORS bloc SINON bloc
    | SI PARENTHOISE_OUVRANTE expression_comparative PARENTHOISE_FERMANTE ALORS bloc SINON condition
    | SI PARENTHOISE_OUVRANTE expression_comparative PARENTHOISE_FERMANTE ALORS bloc SINON boucle
    | SI PARENTHOISE_OUVRANTE expression_comparative PARENTHOISE_FERMANTE ALORS bloc
    ;

boucle

    ;

liste_arguments
    : TEXT
    | IDF
    | liste_arguments VIRGULE TEXT
    | liste_arguments VIRGULE IDF
    ;

expression_comparative
    : NUM INF NUM
    | SIGNEDNUM INF SIGNEDNUM
    | REAL INF REAL    
    | SIGNEDREAL INF SIGNEDREAL    
    | NUM SUP NUM    
    | SIGNEDNUM SUP SIGNEDNUM    
    | REAL SUP REAL
    | SIGNEDREAL SUP SIGNEDREAL
    | NUM EGAL NUM
    | SIGNEDNUM EGAL SIGNEDNUM
    | REAL EGAL REAL
    | SIGNEDREAL EGAL SIGNEDREAL
    ;

affect
    : IDF AFFECTION expression_arithmetique POINT_VIRGULE
    | IDF AFFECTION IDF POINT_VIRGULE
    ;
expression_arithmetique
    : NUM PLUS NUM
        { printf("%d + %d = %d\n", $1, $3, $1 + $3); }
    | SIGNEDNUM PLUS SIGNEDNUM
        { printf("%d + %d = %d\n", $1, $3, $1 + $3); }
    | REAL PLUS REAL
        { printf("%.2f + %.2f = %.2f\n", $1, $3, $1 + $3); }
    | SIGNEDREAL PLUS SIGNEDREAL
        { printf("%.2f + %.2f = %.2f\n", $1, $3, $1 + $3); }
    | IDF PLUS NUM
        { 
            int idx = recherche($1);
            if (idx == -1) yyerror("Erreur: Variable non déclarée.");
            else printf("%s + %d = %.2f\n", $1, $3, get_value(idx) + $3);
        }
    | NUM PLUS IDF
        { 
            int idx = recherche($3);
            if (idx == -1) yyerror("Erreur: Variable non déclarée.");
            else printf("%d + %s = %.2f\n", $1, $3, $1 + get_value(idx));
        }
    | IDF PLUS IDF
        { 
            int idx1 = recherche($1);
            int idx2 = recherche($3);
            if (idx1 == -1 || idx2 == -1) yyerror("Erreur: Variable non déclarée.");
            else printf("%s + %s = %.2f\n", $1, $3, get_value(idx1) + get_value(idx2));
        }
    | NUM MOINS NUM
        { printf("%d - %d = %d\n", $1, $3, $1 - $3); }
    | SIGNEDNUM MOINS SIGNEDNUM
        { printf("%d - %d = %d\n", $1, $3, $1 - $3); }
    | REAL MOINS REAL
        { printf("%.2f - %.2f = %.2f\n", $1, $3, $1 - $3); }
    | SIGNEDREAL MOINS SIGNEDREAL
        { printf("%.2f - %.2f = %.2f\n", $1, $3, $1 - $3); }
    | IDF MOINS NUM
        { 
            int idx = recherche($1);
            if (idx == -1) yyerror("Erreur: Variable non déclarée.");
            else printf("%s - %d = %.2f\n", $1, $3, get_value(idx) - $3);
        }
    | NUM MOINS IDF
        { 
            int idx = recherche($3);
            if (idx == -1) yyerror("Erreur: Variable non déclarée.");
            else printf("%d - %s = %.2f\n", $1, $3, $1 - get_value(idx));
        }
    | IDF MOINS IDF
        { 
            int idx1 = recherche($1);
            int idx2 = recherche($3);
            if (idx1 == -1 || idx2 == -1) yyerror("Erreur: Variable non déclarée.");
            else printf("%s - %s = %.2f\n", $1, $3, get_value(idx1) - get_value(idx2));
        }
    | NUM MULT NUM
        { printf("%d * %d = %d\n", $1, $3, $1 * $3); }
    | SIGNEDNUM MULT SIGNEDNUM
        { printf("%d * %d = %d\n", $1, $3, $1 * $3); }
    | REAL MULT REAL
        { printf("%.2f * %.2f = %.2f\n", $1, $3, $1 * $3); }
    | SIGNEDREAL MULT SIGNEDREAL
        { printf("%.2f * %.2f = %.2f\n", $1, $3, $1 * $3); }
    | IDF MULT NUM
        { 
            int idx = recherche($1);
            if (idx == -1) yyerror("Erreur: Variable non déclarée.");
            else printf("%s * %d = %.2f\n", $1, $3, get_value(idx) * $3);
        }
    | NUM MULT IDF
        { 
            int idx = recherche($3);
            if (idx == -1) yyerror("Erreur: Variable non déclarée.");
            else printf("%d * %s = %.2f\n", $1, $3, $1 * get_value(idx));
        }
    | IDF MULT IDF
        { 
            int idx1 = recherche($1);
            int idx2 = recherche($3);
            if (idx1 == -1 || idx2 == -1) yyerror("Erreur: Variable non déclarée.");
            else printf("%s * %s = %.2f\n", $1, $3, get_value(idx1) * get_value(idx2));
        }
    | NUM DIV NUM
        { 
            if ($3 == 0) yyerror("Erreur: Division par zéro.");
            else printf("%d / %d = %.2f\n", $1, $3, (double)$1 / $3);
        }
    | SIGNEDNUM DIV SIGNEDNUM
        { 
            if ($3 == 0) yyerror("Erreur: Division par zéro.");
            else printf("%d / %d = %.2f\n", $1, $3, (double)$1 / $3);
        }
    | REAL DIV REAL
        { 
            if ($3 == 0.0) yyerror("Erreur: Division par zéro.");
            else printf("%.2f / %.2f = %.2f\n", $1, $3, $1 / $3);
        }
    | SIGNEDREAL DIV SIGNEDREAL
        { 
            if ($3 == 0.0) yyerror("Erreur: Division par zéro.");
            else printf("%.2f / %.2f = %.2f\n", $1, $3, $1 / $3);
        }
    | IDF DIV NUM
        { 
            int idx = recherche($1);
            if (idx == -1) yyerror("Erreur: Variable non déclarée.");
            else if ($3 == 0) yyerror("Erreur: Division par zéro.");
            else printf("%s / %d = %.2f\n", $1, $3, get_value(idx) / $3);
        }
    | NUM DIV IDF
        { 
            int idx = recherche($3);
            if (idx == -1) yyerror("Erreur: Variable non déclarée.");
            else if (get_value(idx) == 0) yyerror("Erreur: Division par zéro.");
            else printf("%d / %s = %.2f\n", $1, $3, $1 / get_value(idx));
        }
    | IDF DIV IDF
        { 
            int idx1 = recherche($1);
            int idx2 = recherche($3);
            if (idx1 == -1 || idx2 == -1) yyerror("Erreur: Variable non déclarée.");
            else if (get_value(idx2) == 0) yyerror("Erreur: Division par zéro.");
            else printf("%s / %s = %.2f\n", $1, $3, get_value(idx1) / get_value(idx2));
        }
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


