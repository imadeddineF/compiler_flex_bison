%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "syntaxique.tab.h"

extern YYSTYPE yylval;
extern int nb_ligne;
extern int nb_colonne;

#define YY_DECL int yylex(void)
%}

/* Expressions régulières */
lettre [a-zA-Z]
lettreMaj [A-Z]
underscore _
chiffre [0-9]
IDF {lettreMaj}({lettre}|{chiffre}|{underscore})*
NUM -?[0-9]+
REAL -?[0-9]*\.[0-9]+
TEXT \"[^\"]*\"
commentaire_sur_ligne "--[^\n]*##"
commentaire_multi_lignes "\\{-([^-]|-)*-\\}"

/* Règles de production */
%%
"DEBUT"          { return DEBUT; }
"FIN"            { return FIN; }
"EXECUTION"      { return EXECUTION; }
"SI"             { return SI; }
"ALORS"          { return ALORS; }
"SINON"          { return SINON; }
"TANTQUE"        { return TANTQUE; }
"FAIRE"          { return FAIRE; }
"FIXE"           { return FIXE; }
"affiche"        { return AFFICHE; }
"lire"           { return LIRE; }
"OU"             { return OU; }
"ET"             { return ET; }
"NON"            { return NON; }
"{"              { return ACCOLADE_OUVRANTE; }
"}"              { return ACCOLADE_FERMANTE; }
"("              { return PARENTHOISE_OUVRANTE; }
")"              { return PARENTHOISE_FERMANTE; }
"+"              { return PLUS; }
"-"              { return MOINS; }
"*"              { return MULT; }
"/"              { return DIV; }
","              { return VIRGULE; }
";"              { return POINT_VIRGULE; }
":"              { return DEUX_POINTS; }
"="              { return EGAL; }
"<"              { return INF; }
">"              { return SUP; }
"!="             { return DIFFERENT; }
"<="             { return INF_EGAL; }
">="             { return SUP_EGAL; }
"<-"             { return AFFECTION; }

{IDF} {
  yylval.texte = strdup(yytext);
  return IDF;
}

{TEXT} {
  yylval.texte = strdup(yytext);
  return TEXT;
}

{NUM} {
  yylval.entier = atoi(yytext);
  return NUM;
}

{REAL} {
  yylval.reel = atof(yytext);
  return REAL;
}

{commentaire_sur_ligne} { /* Ignorer les commentaires sur une ligne */ }

{commentaire_multi_lignes} {
  char* ptr = yytext;
  while ((ptr = strchr(ptr, '\n')) != NULL) {
    nb_ligne++;
    ptr++;
  }
}

[ \t]+          { nb_colonne += yyleng; }  /* Compter les espaces/tabulations */
\n              { nb_ligne++; nb_colonne = 1; }  /* Avancer à la ligne suivante */

. {
  fprintf(stderr, "Erreur lexicale sur '%s' à la ligne %d, colonne %d\n", yytext, nb_ligne, nb_colonne);
  return ERR;
}
%%
