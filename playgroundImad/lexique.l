%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "syntaxique.tab.h"
#include "ts.h"

extern int nb_ligne;
extern int nb_colonne;

extern YYSTYPE yylval;
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
/* NUM [+-]?{chiffre}* */
/* REAL [-+]?{chiffre}*"."{chiffre}* */
TEXT \"[^\"]*\"

/* commentaire_sur_ligne "--[^\n]*##" */
/* commentaire_multi_lignes "\\{-([^-]|-)*-\\}" */
commentaire_sur_ligne --[^\n]*##
commentaire_multi_lignes \{-(.|\n)*?-\}





/* Règles de production */
%%
\n          { nb_ligne++; nb_colonne = 1; }  // Handle newlines: Increment line, reset column ---> go to next line
\t          { nb_colonne += 4; }  // Handle tabs: Increment column by 4 (or adjust as needed)
[ \t]       { nb_colonne += strlen(yytext); } // Handle spaces and tabs (update column)


"DEBUT"          { rechercher(yytext,"Mot Cle"," ",0,1); nb_colonne += strlen(yytext); printf("Token: DEBUT\n"); return DEBUT; }
"FIN"            { rechercher(yytext,"Mot Cle"," ",0,1); nb_colonne += strlen(yytext); printf("Token: FIN\n"); return FIN; }
"EXECUTION"      { rechercher(yytext,"Mot Cle"," ",0,1); nb_colonne += strlen(yytext); printf("Token: EXECUTION\n"); return EXECUTION; }
"SI"             { rechercher(yytext,"Mot Cle"," ",0,1); nb_colonne += strlen(yytext); printf("Token: SI\n"); return SI; }
"ALORS"          { rechercher(yytext,"Mot Cle"," ",0,1); nb_colonne += strlen(yytext); printf("Token: ALORS\n"); return ALORS; }
"SINON"          { rechercher(yytext,"Mot Cle"," ",0,1); nb_colonne += strlen(yytext); printf("Token: SINON\n"); return SINON; }
"TANTQUE"        { rechercher(yytext,"Mot Cle"," ",0,1); nb_colonne += strlen(yytext); printf("Token: TANTQUE\n"); return TANTQUE; }
"FAIRE"          { rechercher(yytext,"Mot Cle"," ",0,1); nb_colonne += strlen(yytext); printf("Token: FAIRE\n"); return FAIRE; }
"FIXE"           { rechercher(yytext,"Mot Cle"," ",0,1); nb_colonne += strlen(yytext); printf("Token: FIXE\n"); return FIXE; }
"affiche"        { rechercher(yytext,"Mot Cle"," ",0,1); nb_colonne += strlen(yytext); printf("Token: AFFICHE\n"); return AFFICHE; }
"lire"           { rechercher(yytext,"Mot Cle"," ",0,1); nb_colonne += strlen(yytext); printf("Token: LIRE\n"); return LIRE; }
"OU"             { rechercher(yytext,"Mot Cle"," ",0,1); nb_colonne += strlen(yytext); printf("Token: OU\n"); return OU; }
"ET"             { rechercher(yytext,"Mot Cle"," ",0,1); nb_colonne += strlen(yytext); printf("Token: ET\n"); return ET; }
"NON"            { rechercher(yytext,"Mot Cle"," ",0,1); nb_colonne += strlen(yytext); printf("Token: NON\n"); return NON; }
"!="             { rechercher(yytext,"separateur"," ",0,2); nb_colonne += strlen(yytext); printf("Token: DIFFERENT\n"); return DIFFERENT; }
"<="             { rechercher(yytext,"separateur"," ",0,2); nb_colonne += strlen(yytext); printf("Token: INF_EGAL\n"); return INF_EGAL; }
">="             { rechercher(yytext,"separateur"," ",0,2); nb_colonne += strlen(yytext); printf("Token: SUP_EGAL\n"); return SUP_EGAL; }
"<-"             { rechercher(yytext,"separateur"," ",0,2); nb_colonne += strlen(yytext); printf("Token: AFFECTION\n"); return AFFECTION; }
"{"              { rechercher(yytext,"separateur"," ",0,2); nb_colonne += strlen(yytext); printf("Token: ACCOLADE_OUVRANTE\n"); return ACCOLADE_OUVRANTE; }
"}"              { rechercher(yytext,"separateur"," ",0,2); nb_colonne += strlen(yytext); printf("Token: ACCOLADE_FERMANTE\n"); return ACCOLADE_FERMANTE; }
"("              { rechercher(yytext,"separateur"," ",0,2); nb_colonne += strlen(yytext); printf("Token: PARENTHOISE_OUVRANTE\n"); return PARENTHOISE_OUVRANTE; }
")"              { rechercher(yytext,"separateur"," ",0,2); nb_colonne += strlen(yytext); printf("Token: PARENTHOISE_FERMANTE\n"); return PARENTHOISE_FERMANTE; }
"["              { rechercher(yytext,"separateur"," ",0,2); nb_colonne += strlen(yytext); printf("Token: CROCHET_OUVRANT\n"); return CROCHET_OUVRANT; }
"]"              { rechercher(yytext,"separateur"," ",0,2); nb_colonne += strlen(yytext); printf("Token: CROCHET_FERMANT\n"); return CROCHET_FERMANT; }
"+"              { rechercher(yytext,"separateur"," ",0,2); nb_colonne += strlen(yytext); printf("Token: PLUS\n"); return PLUS; }
"-"              { rechercher(yytext,"separateur"," ",0,2); nb_colonne += strlen(yytext); printf("Token: MOINS\n"); return MOINS; }
"*"              { rechercher(yytext,"separateur"," ",0,2); nb_colonne += strlen(yytext); printf("Token: MULT\n"); return MULT; }
"/"              { rechercher(yytext,"separateur"," ",0,2); nb_colonne += strlen(yytext); printf("Token: DIV\n"); return DIV; }
","              { rechercher(yytext,"separateur"," ",0,2); nb_colonne += strlen(yytext); printf("Token: VIRGULE\n"); return VIRGULE; }
";"              { rechercher(yytext,"separateur"," ",0,2); nb_colonne += strlen(yytext); printf("Token: POINT_VIRGULE\n"); return POINT_VIRGULE; }
":"              { rechercher(yytext,"separateur"," ",0,2); nb_colonne += strlen(yytext); printf("Token: DEUX_POINTS\n"); return DEUX_POINTS; }
"="              { rechercher(yytext,"separateur"," ",0,2); nb_colonne += strlen(yytext); printf("Token: EGAL\n"); return EGAL; }
"<"              { rechercher(yytext,"separateur"," ",0,2); nb_colonne += strlen(yytext); printf("Token: INF\n"); return INF; }
">"              { rechercher(yytext,"separateur"," ",0,2); nb_colonne += strlen(yytext); printf("Token: SUP\n"); return SUP; }
"NUM"            { rechercher(yytext,"Mot Cle"," ",0,1); nb_colonne += strlen(yytext); printf("Token: TYPE_NUM\n"); return TYPE_NUM; }
"REAL"           { rechercher(yytext,"Mot Cle"," ",0,1); nb_colonne += strlen(yytext); printf("Token: TYPE_REAL\n"); return TYPE_REAL; }
"SIGNEDNUM"      { rechercher(yytext,"Mot Cle"," ",0,1); nb_colonne += strlen(yytext); printf("Token: TYPE_SIGNEDNUM\n"); return TYPE_SIGNEDNUM; }
"SIGNEDREAL"     { rechercher(yytext,"Mot Cle"," ",0,1); nb_colonne += strlen(yytext); printf("Token: TYPE_SIGNEDREAL\n"); return TYPE_SIGNEDREAL; }
"TEXT"           { rechercher(yytext,"Mot Cle"," ",0,1); nb_colonne += strlen(yytext); printf("Token: TYPE_TEXT\n"); return TYPE_TEXT; }

{NUM} {
  rechercher(yytext,"identificateur"," ",0,0);
  printf("Token: Value of NUM (%s)\n", yytext);
  yylval.entier = atoi(yytext);
  nb_colonne += strlen(yytext);
  return NUM;
}

{SIGNEDNUM} {
  rechercher(yytext,"identificateur"," ",0,0);
  int val = atoi(yytext);  // Convert string to integer
  if (val < -32768 || val > 32767) { // Range check for SIGNEDNUM
    printf("\033[31m[ERROR] Valeur d'entier signé hors plage (%s) à la ligne %d, colonne %d\033[0m\n", yytext, nb_ligne, nb_colonne);
  } else {
    yylval.entier = val;  // Store the signed number in yylval.entier
  }
  nb_colonne += strlen(yytext);  // Always update the column number
  return SIGNEDNUM;
}

{REAL} {
  rechercher(yytext,"identificateur"," ",0,0);
  printf("Token: Value of REAL (%s)\n", yytext);
  yylval.reel = atof(yytext);
  nb_colonne += strlen(yytext);
  return REAL;
}

{SIGNEDREAL} {
  rechercher(yytext,"identificateur"," ",0,0);
  double val = atof(yytext);  // Convert string to double
  if (val < -32768.0 || val > 32767.0) {  // Range check for SIGNEDREAL
    printf("\033[31m[ERROR] Valeur réelle signée hors plage (%s) à la ligne %d, colonne %d\033[0m\n", yytext, nb_ligne, nb_colonne);
  } else {
    yylval.reel = val;  // Store the signed real number in yylval.reel
  }
  nb_colonne += strlen(yytext);  // Always update the column number
  return SIGNEDREAL;
}

{IDF} {
  rechercher(yytext,"identificateur"," ",0,0);
  int consecutive_underscores = 0;
  // size_t len = strlen(yytext);
  // size_t len = yyleng; // Use yyleng instead of strlen(yytext)
  // Check for consecutive underscores
  int i;
  for (i = 1; yytext[i] != '\0'; i++) {
    if (yytext[i] == '_' && yytext[i - 1] == '_') {
      consecutive_underscores = 1;
      break;
    }
  }
  // Validate identifier length and underscores
  if (yyleng > 10) {
    fprintf(stderr, "\033[31m[ERROR] Identificateur trop long (%s) à la ligne %d, colonne %d\033[0m\n", yytext, nb_ligne, nb_colonne);
    return ERR;  // Return an error token for invalid identifiers
  } else if (consecutive_underscores) {
    fprintf(stderr, "\033[31m[ERROR] Identificateur contient deux underscores successifs (%s) à la ligne %d, colonne %d\033[0m\n", yytext, nb_ligne, nb_colonne);
    return ERR;  // Return an error token for invalid identifiers
  } 
  // If valid, check the symbol table
  printf("Token: IDF (%s)\n", yytext); 
  yylval.texte = strdup(yytext); // Assign yytext to yylval for Bison
  nb_colonne += yyleng;
  return IDF;
}

{TEXT} {
  rechercher(yytext,"identificateur"," ",0,0);
  printf("Token: Value of TEXT (%s)\n", yytext);
  yylval.texte = strdup(yytext);
  // inserer(yytext, "TEXT");
  nb_colonne += strlen(yytext);
  return TEXT;
}

{commentaire_sur_ligne}  { 
  rechercher(yytext,"identificateur"," ",0,0);
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


. {
  fprintf(stderr, "Erreur lexicale sur '%s' à la ligne %d, colonne %d\n", yytext, nb_ligne, nb_colonne);
  return ERR;
}

%%