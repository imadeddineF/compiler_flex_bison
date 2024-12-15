/* Importation C */
%{
extern YYSTYPE yylval;
#include<ctype.h>
#include<stdio.h>
#include <string.h>
#include "syntaxique.tab.h" 
#include "ts.h"
extern  int nb_ligne;
extern  int nb_colonne;
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
  return DEBUT;  // Retourne le token DEBUT
}
"FIN" {
  nb_colonne += strlen(yytext);
  return FIN;  // Retourne le token FIN
}
"TEXT" {
  nb_colonne += strlen(yytext);
  return TEXT;  // Retourne le token TEXT
}
"NUM" {
  nb_colonne += strlen(yytext);
  return NUM;  // Retourne le token NUM
}
"REAL" {
  nb_colonne += strlen(yytext);
  return REAL;  // Retourne le token REAL
}
"EXECUTION" {
  nb_colonne += strlen(yytext);
  return EXECUTION;  // Retourne le token EXECUTION
}
"SI" {
  nb_colonne += strlen(yytext);
  return SI;  // Retourne le token SI
}
"ALORS" {
  nb_colonne += strlen(yytext);
  return ALORS;  // Retourne le token ALORS
}
"SINON" {
  nb_colonne += strlen(yytext);
  return SINON;  // Retourne le token SINON
}
"TANTQUE" {
  nb_colonne += strlen(yytext);
  return TANTQUE;  // Retourne le token TANTQUE
}
"FAIRE" {
  nb_colonne += strlen(yytext);
  return FAIRE;  // Retourne le token FAIRE
}
"FIXE" {
  nb_colonne += strlen(yytext);
  return FIXE;  // Retourne le token FIXE
}
"affiche" {
  nb_colonne += strlen(yytext);
  return AFFICHE;  // Retourne le token AFFICHE
}
"lire" {
  nb_colonne += strlen(yytext);
  return LIRE;  // Retourne le token LIRE
}
"OU" {
  nb_colonne += strlen(yytext);
  return OU;  // Retourne le token OU
}
"ET" {
  nb_colonne += strlen(yytext);
  return ET;  // Retourne le token ET
}
"NON" {
  nb_colonne += strlen(yytext);
  return NON;  // Retourne le token NON
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
  yylval.str=strdup(yytext); inserer(yytext,"idf"); 
  return IDF;  // Retourne le token IDF
}



{commentaire_sur_ligne} {
  nb_colonne += strlen(yytext);  // Update the column number based on the length of the comment
}

{commentaire_multi_lignes} {
  char* ptr = yytext;  // Pointer to start of the matched text
  while ((ptr = strchr(ptr, '\n')) != NULL) {  // Loop through newlines
    nb_ligne++;  // Increment the line number for each newline
    ptr++;  // Move past the newline character
  }
  nb_colonne = 1;  
}


{TEXT} {
  nb_colonne += strlen(yytext);
  return TEXT;  // Retourne le token TEXT
}

{NUM} {
  int val = atoi(yytext);  // Convert string to integer
  if (val < 0 || val > 32767) {  // Range check for NUM
    return ERR;  // Retourne une erreur pour une valeur hors de portée
  } else {
    return NUM;  // Retourne le token NUM
  }
}

{SIGNEDNUM} {
  int val = atoi(yytext);  // Convert string to integer
  if (val < -32768 || val > 32767) {  // Range check for SIGNEDNUM
    return ERR;  // Retourne une erreur pour une valeur hors de portée
  } else {
    return SIGNEDNUM;  // Retourne le token SIGNEDNUM
  }
}

{REAL} {
  double val = atof(yytext);  // Convert string to double
  if (val < 0.0 || val > 32767.0) {  // Range check for REAL
    return ERR;  // Retourne une erreur pour une valeur hors de portée
  } else {
    return REAL;  // Retourne le token REAL
  }
}

{SIGNEDREAL} {
  double val = atof(yytext);  // Convert string to double
  if (val < -32768.0 || val > 32767.0) {  // Range check for SIGNEDREAL
    return ERR;  // Retourne une erreur pour une valeur hors de portée
  } else {
    return SIGNEDREAL;  // Retourne le token SIGNEDREAL
  }
}
. {printf ("erreur lexical sur l'entite %s a la ligne %d a la colonne %d",yytext,nb_ligne,col); return err;}
%%