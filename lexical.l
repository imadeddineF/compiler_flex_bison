%{
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include "ts.h" // Inclusion du fichier d'en-tête pour la table des symboles
#include "syntaxical.tab.h" // Inclusion de l'en-tête généré par Bison (analyseur syntaxique)

// Déclarations externes
extern int nb_ligne; // initialiser nb_ligne à 0 ailleurs
extern int nb_colonne;  // Variable pour suivre le numéro de colonne
char currentScope[10];   // Variable pour stocker la portée actuelle
char typeidf[10];      // Type de l'identificateur
extern YYSTYPE yylval; // Structure pour stocker la valeur du token (renvoyé à Bison)

// Fonction pour afficher les warnings
void print_warning(const char* message, int ligne, int colonne) {
    printf("WARNING: %s à la ligne %d, colonne %d\n", message, ligne, colonne);
}
%}

// Définition des règles de correspondance pour les lexèmes (tokens)

// Lettres, chiffres et autres symboles
// Correspond à une lettre (minuscule ou majuscule) 
lettre [a-zA-Z]  
// Correspond à une lettre majuscule
lettre_maj [A-Z] 
// Correspond au caractère underscore "_"
underscore _
// Correspond à un chiffre
chiffre [0-9]
// Identificateur : commence par une majuscule puis lettres, chiffres ou underscores
IDF {lettre_maj}({lettre}|{chiffre}|{underscore}){0,9}
// Nombre entier (optionnellement précédé d'un signe négatif)
NUM [-]?[0-9]+
// Nombre réel (optionnellement précédé d'un signe négatif)
REAL [-]?[0-9]+\.[0-9]+
// Constantes logiques TRUE ou FALSE
LOGICAL "TRUE"|"FALSE"
// Chaîne de caractères (tout ce qui est entre guillemets)
TEXT \"[^\"]*\"
// Commentaires sur une ligne
commentaire_sur_ligne "--"[^#\n]*"##"
 // Commentaires multi-lignes
commentaire_multi /\{-([^{}-]|\n)*-\}/

%%

// Retourne le token pour le mot-clé "DEBUT"
"DEBUT" { rechercher(yytext, "Mot cle", "", nb_ligne, "", 1, "Début du programme"); nb_colonne += strlen(yytext); return mc_debut; }
// Retourne le token pour le mot-clé "FIN"
"FIN" { rechercher(yytext, "Mot cle", "", nb_ligne, "", 1, "Fin du programme"); nb_colonne += strlen(yytext); return mc_fin; }
"{" { rechercher(yytext, "Symbole", "Accolade ouvrante", nb_ligne, "", 2, ""); nb_colonne += strlen(yytext); return acc_ouvrante; }
"}" { rechercher(yytext, "Symbole", "Accolade fermante", nb_ligne, "", 2, ""); nb_colonne += strlen(yytext); return acc_fermante; }
"=" { rechercher(yytext, "egalite", "", nb_ligne, "", 2, ""); nb_colonne += strlen(yytext); return aff; }
"-" { rechercher(yytext, "soustraction", "", nb_ligne, "", 2, ""); nb_colonne += strlen(yytext); return opar_moins; }
"+" { rechercher(yytext, "addition", "", nb_ligne, "", 2, ""); nb_colonne += strlen(yytext); return opar_plus; }
"*" { rechercher(yytext, "multiplication", "", nb_ligne, "", 2, ""); nb_colonne += strlen(yytext); return opar_mult; }
"/" { rechercher(yytext, "division", "", nb_ligne, "", 2, ""); nb_colonne += strlen(yytext); return opar_div; }
"OR" { rechercher(yytext, "Mot cle", "", nb_ligne, "", 1, ""); nb_colonne += strlen(yytext); return op_or; }
"AND" { rechercher(yytext, "Mot cle", "", nb_ligne, "", 1, ""); nb_colonne += strlen(yytext); return op_and; }
"<" { rechercher(yytext, "Inferieur_a", "", nb_ligne, "", 2, ""); nb_colonne += strlen(yytext); return op_lt; }
"<=" { rechercher(yytext, "Inferieur_ou_egal", "", nb_ligne, "", 2, ""); nb_colonne += strlen(yytext); return op_le; }
">" { rechercher(yytext, "Superieur_a", "", nb_ligne, "", 2, ""); nb_colonne += strlen(yytext); return op_gt; }
">=" { rechercher(yytext, "Superieur_ou_egal", "", nb_ligne, "", 2, ""); nb_colonne += strlen(yytext); return op_ge; }
"=" { rechercher(yytext, "Egal_a", "", nb_ligne, "", 2, ""); nb_colonne += strlen(yytext); return op_eq; }
"!=" { rechercher(yytext, "Different_de", "", nb_ligne, "", 2, ""); nb_colonne += strlen(yytext); return op_ne; }
{LOGICAL} { yylval.str = strdup(yytext); rechercher(yytext, "CST LOGICAL", "LOGICAL", nb_ligne, yytext, 0, ""); nb_colonne += strlen(yytext); return cst_bool; }
{TEXT} { rechercher(yytext, "CST CHARACTER", "TEXT", nb_ligne, yytext, 0, ""); yylval.str = strdup(yytext); nb_colonne += strlen(yytext); return cst_char; }
{NUM} {
    if (atoi(yytext) > 32767 || atoi(yytext) < -32768) {
        print_warning("Nombre trop grand", nb_ligne, nb_colonne);
    } else {
        rechercher(yytext, "CST INTEGER", "INTEGER", nb_ligne, "", 0, "");
        yylval.reel = atof(yytext);
    }
    nb_colonne += strlen(yytext);
    return cst_int;
}
{REAL} {
    if (atof(yytext) > 32767 || atof(yytext) < -32768) {
        print_warning("Nombre réel trop grand", nb_ligne, nb_colonne);
    } else {
        rechercher(yytext, "CST REEL", "REEL", nb_ligne, "", 0, "");
        yylval.reel = atof(yytext);
    }
    nb_colonne += strlen(yytext);
    return cst_real;
}
{IDF} {
    if (strlen(yytext) > 10) {
        print_warning("Identificateur trop long", nb_ligne, nb_colonne);
    } else {
        rechercher(yytext, "IDF", "", nb_ligne, "", 0, currentScope);
        yylval.str = strdup(yytext);
    }
    nb_colonne += strlen(yytext);
    return idf;
}
[ \t] { nb_colonne += strlen(yytext); }
\n { nb_ligne++; nb_colonne = 1; }
. { printf("Erreur lexicale : %s (non reconnu), ligne : %d, colonne : %d\n", yytext, nb_ligne, nb_colonne); nb_colonne += strlen(yytext); }

%%
