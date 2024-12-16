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
/* commentaire_sur_ligne "--[^\n]*##" */
/* commentaire_multi_lignes "\\{-([^-]|-)*-\\}" */
commentaire_sur_ligne --[^\n]*##
commentaire_multi_lignes \{-(.|\n)*?-\}

/* Règles de production */
%%
"DEBUT"          { printf("Token: DEBUT\n"); return DEBUT; }
"FIN"            { printf("Token: FIN\n"); return FIN; }
"EXECUTION"      { printf("Token: EXECUTION\n"); return EXECUTION; }
"SI"             { printf("Token: SI\n"); return SI; }
"ALORS"          { printf("Token: ALORS\n"); return ALORS; }
"SINON"          { printf("Token: SINON\n"); return SINON; }
"TANTQUE"        { printf("Token: TANTQUE\n"); return TANTQUE; }
"FAIRE"          { printf("Token: FAIRE\n"); return FAIRE; }
"FIXE"           { printf("Token: FIXE\n"); return FIXE; }
"affiche"        { printf("Token: AFFICHE\n"); return AFFICHE; }
"lire"           { printf("Token: LIRE\n"); return LIRE; }
"OU"             { printf("Token: OU\n"); return OU; }
"ET"             { printf("Token: ET\n"); return ET; }
"NON"            { printf("Token: NON\n"); return NON; }
"{"              { printf("Token: ACCOLADE_OUVRANTE\n"); return ACCOLADE_OUVRANTE; }
"}"              { printf("Token: ACCOLADE_FERMANTE\n"); return ACCOLADE_FERMANTE; }
"("              { printf("Token: PARENTHOISE_OUVRANTE\n"); return PARENTHOISE_OUVRANTE; }
")"              { printf("Token: PARENTHOISE_FERMANTE\n"); return PARENTHOISE_FERMANTE; }
"+"              { printf("Token: PLUS\n"); return PLUS; }
"-"              { printf("Token: MOINS\n"); return MOINS; }
"*"              { printf("Token: MULT\n"); return MULT; }
"/"              { printf("Token: DIV\n"); return DIV; }
","              { printf("Token: VIRGULE\n"); return VIRGULE; }
";"              { printf("Token: POINT_VIRGULE\n"); return POINT_VIRGULE; }
":"              { printf("Token: DEUX_POINTS\n"); return DEUX_POINTS; }
"="              { printf("Token: EGAL\n"); return EGAL; }
"<"              { printf("Token: INF\n"); return INF; }
">"              { printf("Token: SUP\n"); return SUP; }
"!="             { printf("Token: DIFFERENT\n"); return DIFFERENT; }
"<="             { printf("Token: INF_EGAL\n"); return INF_EGAL; }
">="             { printf("Token: SUP_EGAL\n"); return SUP_EGAL; }
"<-"             { printf("Token: AFFECTION\n"); return AFFECTION; }

{IDF} {
  printf("Token: IDF (%s)\n", yytext); 
  yylval.texte = strdup(yytext);
  return IDF;
}

{TEXT} {
  printf("Token: TEXT (%s)\n", yytext);
  yylval.texte = strdup(yytext);
  return TEXT;
}

{NUM} {
  printf("Token: NUM (%s)\n", yytext);
  yylval.entier = atoi(yytext);
  return NUM;
}

{REAL} {
  printf("Token: REAL (%s)\n", yytext);
  yylval.reel = atof(yytext);
  return REAL;
}

{commentaire_sur_ligne}  { 
  printf("-- Commentaire sur une ligne --\n");
}

{commentaire_multi_lignes} {
  char* ptr = yytext;
  while ((ptr = strchr(ptr, '\n')) != NULL) {
    nb_ligne++;
    ptr++;
  }
  printf("{- Commentaire sur plusieurs lignes -}\n");
}

[ \t]+  { /* Ignorer les espaces et tabulations sans affecter la colonne */ }
\n      { nb_ligne++; nb_colonne = 1; }  /* Avancer à la ligne suivante */

. {
  fprintf(stderr, "Erreur lexicale sur '%s' à la ligne %d, colonne %d\n", yytext, nb_ligne, nb_colonne);
  return ERR;
}
%%
