/* Importation C */
%{
extern YYSTYPE yylval;
#include <ctype.h>
#include <stdio.h>
#include <string.h>
#include "syntaxique.tab.h"
#include "ts.h"
extern int nb_ligne;
extern int nb_colonne;
%}

/* Expressions régulières */
lettre [a-zA-Z]
lettreMaj [A-Z]
underscore _
chiffre [0-9]
IDF {lettreMaj}({lettre}|{chiffre}|{underscore})*
NUM 0|[1-9][0-9]*
SIGNEDNUM [+-]?{NUM}
REAL 0\.[0-9]+|[1-9][0-9]*\.[0-9]+
SIGNEDREAL [+-]?{REAL}
TEXT \"[^\"]*\"
cst [1-9][0-9]*|0
commentaire_sur_ligne --[^\n]*##
commentaire_multi_lignes \{-(.|\n)*?-\}

/* Règles de production */
%%

"DEBUT" {
  nb_colonne += strlen(yytext);
  return DEBUT;
}
"FIN" {
  nb_colonne += strlen(yytext);
  return FIN;
}
"TEXT" {
  nb_colonne += strlen(yytext);
  return TEXT;
}
"NUM" {
  nb_colonne += strlen(yytext);
  return NUM;
}
"REAL" {
  nb_colonne += strlen(yytext);
  return REAL;
}
"EXECUTION" {
  nb_colonne += strlen(yytext);
  return EXECUTION;
}
"SI" {
  nb_colonne += strlen(yytext);
  return SI;
}
"ALORS" {
  nb_colonne += strlen(yytext);
  return ALORS;
}
"SINON" {
  nb_colonne += strlen(yytext);
  return SINON;
}
"TANTQUE" {
  nb_colonne += strlen(yytext);
  return TANTQUE;
}
"FAIRE" {
  nb_colonne += strlen(yytext);
  return FAIRE;
}
"FIXE" {
  nb_colonne += strlen(yytext);
  return FIXE;
}
"affiche" {
  nb_colonne += strlen(yytext);
  return AFFICHE;
}
"lire" {
  nb_colonne += strlen(yytext);
  return LIRE;
}
"OU" {
  nb_colonne += strlen(yytext);
  return OU;
}
"ET" {
  nb_colonne += strlen(yytext);
  return ET;
}
"NON" {
  nb_colonne += strlen(yytext);
  return NON;
}

"{"      { return ACCOLADE_OUVRANTE; }
"}"      { return ACCOLADE_FERMANTE; }
"["      { return CROCHET_OUVRANT; }
"]"      { return CROCHET_FERMANT; }
"("      { return PARENTHOISE_OUVRANTE; }
")"      { return PARENTHOISE_FERMANTE; }
"+"      { return PLUS; }
"-"      { return MOINS; }
"*"      { return MULT; }
"/"      { return DIV; }
","      { return VIRGULE; }
";"      { return POINT_VIRGULE; }
":"      { return DEUX_POINTS; }
"="      { return EGAL; }
"<"      { return INF; }
">"      { return SUP; }
"!="    { return DIFFERENT; }
"<="    { return INF_EGAL; }
">="    { return SUP_EGAL; }
"->"    { return AFFECTION; }

{IDF} {
  yylval.texte = strdup(yytext);
  inserer(yytext, "idf");
  return IDF;
}

{commentaire_sur_ligne} {
  nb_colonne += strlen(yytext);
}

{commentaire_multi_lignes} {
  char* ptr = yytext;
  while ((ptr = strchr(ptr, '\n')) != NULL) {
    nb_ligne++;
    ptr++;
  }
  nb_colonne = 1;
}

{TEXT} {
  nb_colonne += strlen(yytext);
  return TEXT;
}

{NUM} {
  int val = atoi(yytext);
  if (val < 0 || val > 32767) {
    return ERR;
  } else {
    return NUM;
  }
}

{SIGNEDNUM} {
  int val = atoi(yytext);
  if (val < -32768 || val > 32767) {
    return ERR;
  } else {
    return SIGNEDNUM;
  }
}

{REAL} {
  double val = atof(yytext);
  if (val < 0.0 || val > 32767.0) {
    return ERR;
  } else {
    return REAL;
  }
}

{SIGNEDREAL} {
  double val = atof(yytext);
  if (val < -32768.0 || val > 32767.0) {
    return ERR;
  } else {
    return SIGNEDREAL;
  }
}

. { printf("Erreur lexicale sur l'entité %s à la ligne %d à la colonne %d", yytext, nb_ligne, nb_colonne); return ERR; }

%%

