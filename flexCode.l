%{
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include "ts.h" 
#include "synt.tab.h"
extern int nb_ligne; // Line number
extern int nb_colonne; // Column number
extern YYSTYPE yylval;


%}

%%
\n              { line_num++; col_num = 1; }
.               { col_num++; /* other lexing rules */ }
"DEBUT"         { col_num += 5; return DEBUT; }
"EXECUTION"     { col_num += 9; return EXECUTION; }
"FIN"           { col_num += 3; return FIN; }

// Commentaire sur une seule ligne: -- ... ##----------------------------------------------------------------------------------------------------
"--"[^\n]*"##" {/* Ignorer commentaire*/ nb_colonne += strlen(yytext); /* Incrementer colonne avec commentaire length*/ }
// Commentaire sur lignes multiples:-------------------------------------------------------------------------------------------------------------
"{-" {
    // Début d'un commentaire multi-ligne
    int nesting = 1; // Compteur pour gérer les commentaires imbriqués (si autorisés)
    while (nesting > 0) {
        int c = input(); // Lire le prochain caractère

        if (c == EOF) {
            // Si on atteint la fin du fichier avant de fermer le commentaire
            printf("Erreur lexicale: Commentaire multi-ligne non terminé à la ligne %d, colonne %d\n", nb_ligne, nb_colonne);
            exit(1); // Quitter avec une erreur
        }

        if (c == '-') {
            c = input(); // Lire le caractère suivant pour vérifier '}'
            if (c == '}') {
                nesting--; // Décrémenter le niveau d'imbrication
            } else if (c == EOF) {
                // Si la fin du fichier est atteinte après '-'
                printf("Erreur lexicale: Commentaire multi-ligne non terminé à la ligne %d, colonne %d\n", nb_ligne, nb_colonne);
                exit(1); // Quitter avec une erreur
            } else {
                unput(c); // Remettre le caractère s'il ne s'agit pas de '}'
            }
        } else if (c == '{') {
            c = input(); // Lire le caractère suivant pour vérifier '-'
            if (c == '-') {
                nesting++; // Incrémenter le niveau d'imbrication pour les commentaires imbriqués
            } else if (c == EOF) {
                // Si la fin du fichier est atteinte après '{'
                printf("Erreur lexicale: Commentaire multi-ligne non terminé à la ligne %d, colonne %d\n", nb_ligne, nb_colonne);
                exit(1); // Quitter avec une erreur
            } else {
                unput(c); // Remettre le caractère s'il ne s'agit pas de '-'
            }
        } else if (c == '\n') {
            // Gérer les sauts de ligne dans le commentaire
            nb_ligne++;      // Incrémenter le numéro de ligne
            nb_colonne = 1;  // Réinitialiser le numéro de colonne au début de la nouvelle ligne
        } else {
            nb_colonne++;    // Incrémenter le numéro de colonne pour tous les autres caractères
        }
    }
}
//----------------------------------------------------------------------------------------------------------------------------------------------------------

[A-Z][A-Z0-9_]{0,9} { col_num += yyleng; yylval.id = strdup(yytext); return IDENTIFIER; }
[0-9]+          { col_num += yyleng; yylval.num = atoi(yytext); return NUM; }
[0-9]+\.[0-9]+  { col_num += yyleng; yylval.real = atof(yytext); return REAL; }
\"[^\"]*\"      { col_num += yyleng; yylval.text = strdup(yytext); return TEXT; }
"("             { col_num++; return LPAREN; }
")"             { col_num++; return RPAREN; }
"{"             { col_num++; return LBRACE; }
"}"             { col_num++; return RBRACE; }
"<-"            { col_num += 2; return ASSIGN; }
"SI"            { col_num += 2; return SI; }
"ALORS"         { col_num += 5; return ALORS; }
"SINON"         { col_num += 5; return SINON; }
"TANTQUE"       { col_num += 7; return TANTQUE; }
"FAIRE"         { col_num += 5; return FAIRE; }
"affiche"       { col_num += 7; return AFFICHE; }
"lire"          { col_num += 4; return LIRE; }
[ \t\n]         { /* Ignorer les espaces blancs */ col_num++; }
.               { fprintf(stderr, "Erreur lexicale à la ligne %d, colonne %d\n", line_num, col_num); }
%%
//------------------------------------------------------------------------------------------------------------------------------------------------------------