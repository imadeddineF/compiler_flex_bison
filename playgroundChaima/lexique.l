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
SIGNEDNUM [+-]({NUM})
REAL 0\.[0-9]+|[1-9][0-9]*\.[0-9]+
SIGNEDREAL [+-]({REAL})
TEXT \"[^\"]*\"

/* commentaire_sur_ligne "--[^\n]*##" */
/* commentaire_multi_lignes "\\{-([^-]|-)*-\\}" */
commentaire_sur_ligne --[^\n]*##
commentaire_multi_lignes \{-(.|\n)*?-\}

/* Règles de production */
%%
"DEBUT"          { nb_colonne += strlen(yytext); printf("Token: DEBUT\n"); return DEBUT; }
"FIN"            { nb_colonne += strlen(yytext); printf("Token: FIN\n"); return FIN; }
"EXECUTION"      { nb_colonne += strlen(yytext); printf("Token: EXECUTION\n"); return EXECUTION; }
"SI"             { nb_colonne += strlen(yytext); printf("Token: SI\n"); return SI; }
"ALORS"          { nb_colonne += strlen(yytext); printf("Token: ALORS\n"); return ALORS; }
"SINON"          { nb_colonne += strlen(yytext); printf("Token: SINON\n"); return SINON; }
"TANTQUE"        { nb_colonne += strlen(yytext); printf("Token: TANTQUE\n"); return TANTQUE; }
"FAIRE"          { nb_colonne += strlen(yytext); printf("Token: FAIRE\n"); return FAIRE; }
"FIXE"           { nb_colonne += strlen(yytext); printf("Token: FIXE\n"); return FIXE; }
"affiche"        { nb_colonne += strlen(yytext); printf("Token: AFFICHE\n"); return AFFICHE; }
"lire"           { nb_colonne += strlen(yytext); printf("Token: LIRE\n"); return LIRE; }
"OU"             { nb_colonne += strlen(yytext);printf("Token: OU\n"); return OU; }
"ET"             { nb_colonne += strlen(yytext); printf("Token: ET\n"); return ET; }
"NON"            { nb_colonne += strlen(yytext); printf("Token: NON\n"); return NON; }
">"              { nb_colonne += strlen(yytext); printf("Token: SUP\n"); return SUP; }
"!="             { nb_colonne += strlen(yytext); printf("Token: DIFFERENT\n"); return DIFFERENT; }
"<="             { nb_colonne += strlen(yytext); printf("Token: INF_EGAL\n"); return INF_EGAL; }
">="             { nb_colonne += strlen(yytext); printf("Token: SUP_EGAL\n"); return SUP_EGAL; }
"<-"             { nb_colonne += strlen(yytext); printf("Token: AFFECTION\n"); return AFFECTION; }
"{"              { nb_colonne += strlen(yytext); printf("Token: ACCOLADE_OUVRANTE\n"); return ACCOLADE_OUVRANTE; }
"}"              { nb_colonne += strlen(yytext); printf("Token: ACCOLADE_FERMANTE\n"); return ACCOLADE_FERMANTE; }
"("              { nb_colonne += strlen(yytext); printf("Token: PARENTHOISE_OUVRANTE\n"); return PARENTHOISE_OUVRANTE; }
")"              { nb_colonne += strlen(yytext); printf("Token: PARENTHOISE_FERMANTE\n"); return PARENTHOISE_FERMANTE; }
"+"              { nb_colonne += strlen(yytext); printf("Token: PLUS\n"); return PLUS; }
"-"              { nb_colonne += strlen(yytext); printf("Token: MOINS\n"); return MOINS; }
"*"              { nb_colonne += strlen(yytext); printf("Token: MULT\n"); return MULT; }
"/"              { nb_colonne += strlen(yytext); printf("Token: DIV\n"); return DIV; }
","              { nb_colonne += strlen(yytext); printf("Token: VIRGULE\n"); return VIRGULE; }
";"              { nb_colonne += strlen(yytext); printf("Token: POINT_VIRGULE\n"); return POINT_VIRGULE; }
":"              { nb_colonne += strlen(yytext); printf("Token: DEUX_POINTS\n"); return DEUX_POINTS; }
"="              { nb_colonne += strlen(yytext); printf("Token: EGAL\n"); return EGAL; }
"<"              { nb_colonne += strlen(yytext); printf("Token: INF\n"); return INF; }

{IDF} {
  
  int consecutive_underscores = 0;
    size_t len = strlen(yytext);

    // Check for consecutive underscores
    int i;
    for (i = 1; yytext[i] != '\0'; i++) {
        if (yytext[i] == '_' && yytext[i - 1] == '_') {
            consecutive_underscores = 1;
            break;
        }
    }
    
    // Validate identifier length and underscores
    if (len > 10) {
        fprintf(stderr, "\033[31m[ERROR] Identificateur trop long (%s) à la ligne %d, colonne %d\033[0m\n", yytext, nb_ligne, nb_colonne);
        return ERR;  // Return an error token for invalid identifiers
    } else if (consecutive_underscores) {
        fprintf(stderr, "\033[31m[ERROR] Identificateur contient deux underscores successifs (%s) à la ligne %d, colonne %d\033[0m\n", yytext, nb_ligne, nb_colonne);
        return ERR;  // Return an error token for invalid identifiers
    }

    // If valid, check the symbol table
  printf("Token: IDF (%s)\n", yytext); 
    yylval.texte = strdup(yytext); // Assign yytext to yylval for Bison
    nb_colonne += len;
    return IDF;
}


{TEXT} {
  printf("Token: TEXT (%s)\n", yytext);
  yylval.texte = strdup(yytext);
  nb_colonne += strlen(yytext);
  return TEXT;
}

{NUM} {
  printf("Token: NUM (%s)\n", yytext);
  yylval.entier = atoi(yytext);
  nb_colonne += strlen(yytext);
  return NUM;
}

{SIGNEDNUM} {
  int val = atoi(yytext);  // Convert string to integer
  if (val < -32768 || val > 32767)  // Range check for SIGNEDNUM
    printf("\033[31m[ERROR] Valeur d'entier signé hors plage (%s) à la ligne %d, colonne %d\033[0m\n", yytext, nb_ligne, nb_colonne);
  nb_colonne += strlen(yytext);  // Always update the column number
  return SIGNEDNUM;
}

{REAL} {
  printf("Token: REAL (%s)\n", yytext);
  yylval.reel = atof(yytext);
  nb_colonne += strlen(yytext);
  return REAL;
}
{SIGNEDREAL} {
  double val = atof(yytext);  // Convert string to double
  if (val < -32768.0 || val > 32767.0)   // Range check for SIGNEDREAL
    printf("\033[31m[ERROR] Valeur réelle signée hors plage (%s) à la ligne %d, colonne %d\033[0m\n", yytext, nb_ligne, nb_colonne);
  nb_colonne += strlen(yytext);  // Always update the column number
  return SIGNEDREAL;
}
{commentaire_sur_ligne}  { 
  nb_colonne += strlen(yytext);
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
