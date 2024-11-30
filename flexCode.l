%{
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include "ts.h" 
#include "syntaxical.tab.h" 

extern int nb_ligne; 
extern int nb_colonne;  

char currentScope[10] = "GLOBAL";  
char typeidf[10];      
extern YYSTYPE yylval; 

void print_warning(const char* message, int ligne, int colonne) {
  printf("WARNING: %s à la ligne: %d, colonne %d\n", message, ligne, colonne);
}
%}

lettre [a-zA-Z]  
lettre_maj [A-Z] 
underscore _
chiffre [0-9]
IDF {lettre_maj}({lettre}|{chiffre}|{underscore})*
NUM [-]?[0-9]+
REAL [-]?[0-9]+\.[0-9]+
LOGICAL "TRUE"|"FALSE"
TEXT \"[^\"]*\"
commentaire_sur_ligne --[^#\n]*##
commentaire_multi_lignes \{-(.|\n)*?-\}

TYPE_NUM "NUM"
TYPE_REAL "REAL"
TYPE_TEXT "TEXT"

%%
"DEBUT" { 
	nb_colonne += strlen(yytext); 
	return mc_debut; 
}
"FIN" { 
	nb_colonne += strlen(yytext); 
	return mc_fin; 
}
"EXECUTION" {
  nb_colonne += strlen(yytext); 
  return mc_execution;
}
"SI" {
  nb_colonne += strlen(yytext); 
  return mc_si;
}
"ALORS" {
  nb_colonne += strlen(yytext); 
  return mc_alors;
}
"SINON" {
  nb_colonne += strlen(yytext); 
  return mc_sinon;
}
"TANTQUE" {
  nb_colonne += strlen(yytext); 
  return mc_tantque;
}
"FAIRE" {
  nb_colonne += strlen(yytext); 
  return mc_faire;
}
"FIXE" {
  nb_colonne += strlen(yytext); 
  return mc_fixe;
}
"affiche" {
  nb_colonne += strlen(yytext); 
  return func_affiche;
}
"lire" {
  nb_colonne += strlen(yytext); 
  return func_lire;
}
"{" { 
	nb_colonne += strlen(yytext); 
	return acc_ouvrante; 
}
"}" { 
	nb_colonne += strlen(yytext); 
	return acc_fermante; 
}
"[" { 
	nb_colonne += strlen(yytext); 
	return cro_ouvrante; 
}
"]" { 
	nb_colonne += strlen(yytext); 
	return cro_fermante; 
}
"(" { 
  nb_colonne += strlen(yytext); 
  return par_ouvrante; 
}
")" { 
  nb_colonne += strlen(yytext); 
  return par_fermante; 
}
"-" { 
	nb_colonne += strlen(yytext); 
	return opar_moins; 
}
"+" { 
	nb_colonne += strlen(yytext); 
	return opar_plus; 
}
"*" { 
	nb_colonne += strlen(yytext); 
	return opar_mult; 
}
"/" { 
	nb_colonne += strlen(yytext); 
	return opar_div; 
}
"OU" { 
	nb_colonne += strlen(yytext); 
	return op_ou; 
}
"ET" { 
	nb_colonne += strlen(yytext); 
	return op_et; 
}
"NON" { 
	nb_colonne += strlen(yytext); 
	return op_non; 
}
"," { 
	nb_colonne += strlen(yytext); 
	return separator; 
}
";" { 
	nb_colonne += strlen(yytext); 
	return separator; 
}
"=" { 
	nb_colonne += strlen(yytext); 
	return aff; 
}
":" {
  nb_colonne += strlen(yytext); 
  return type_separator;
}
"<-" {
  nb_colonne += strlen(yytext); 
  return affect_sign;
}
"<" { 
	nb_colonne += strlen(yytext); 
	return op_lt; 
}
"<=" { 
	nb_ligne, "", 2, ""); nb_colonne += strlen(yytext); 
	return op_le; 
}
">" { 
	nb_colonne += strlen(yytext); 
	return op_gt; 
}
">=" { 
	nb_colonne += strlen(yytext); 
	return op_ge; 
}
"!=" { 
	nb_colonne += strlen(yytext); 
	return op_ne; 
}

{commentaire_sur_ligne} {
  nb_ligne += (strchr(yytext, '\n') != NULL);
  nb_colonne = 1;
}

{commentaire_multi_lignes} {
  char* ptr = yytext;
  while ((ptr = strchr(ptr, '\n')) != NULL) {
    nb_ligne++;
    ptr++;
  }
  nb_colonne = 1;
}

{LOGICAL} {
  yylval.str = strdup(yytext); 
	rechercher(yytext, "CST LOGICAL", "LOGICAL", nb_ligne, yytext, 0, ""); 
	nb_colonne += strlen(yytext); 
	return cst_bool; 
}

{TYPE_TEXT} {
  rechercher(yytext, "Type", "TEXT", nb_ligne, "", 1, ""); 
  strcpy(typeidf, "TEXT");
  nb_colonne += strlen(yytext); 
  return type_text;
}

{TYPE_NUM} {
  rechercher(yytext, "Type", "NUM", nb_ligne, "", 1, ""); 
  strcpy(typeidf, "NUM");
  nb_colonne += strlen(yytext); 
  return type_num;
}

{TYPE_REAL} {
  rechercher(yytext, "Type", "REAL", nb_ligne, "", 1, ""); 
  strcpy(typeidf, "REAL");
  nb_colonne += strlen(yytext); 
  return type_real;
}

{TEXT} { 
	rechercher(yytext, "CST CHARACTER", "TEXT", nb_ligne, yytext, 0, ""); 
	yylval.str = strdup(yytext); 
	nb_colonne += strlen(yytext); 
	return cst_char; 
}

{NUM} {
  long long val = atoll(yytext);
  if (!(val >= -32768 && val <= 32767)) {
    report_error("Numérique", "Valeur d'entier hors plage", nb_ligne, nb_colonne);
    return error_token;
  }
  rechercher(yytext, "CST INTEGER", "INTEGER", nb_ligne, "", 0, "");
  yylval.reel = atof(yytext);
  nb_colonne += strlen(yytext);
  return cst_int;
}

{REAL} {
  double val = atof(yytext);
  if (!(val >= -32768.0 && val <= 32767.0)) {
    report_error("Numérique", "Valeur réelle hors plage", nb_ligne, nb_colonne);
    return error_token;
  }
  rechercher(yytext, "CST REEL", "REEL", nb_ligne, "", 0, "");
  yylval.reel = val;
  nb_colonne += strlen(yytext);
  return cst_real;
}

{IDF} {
  if (strlen(yytext) > 10) {
    report_error("Identificateur", "Identificateur trop long", nb_ligne, nb_colonne);
    return error_token;
  }
  rechercher(yytext, "IDF", typeidf, nb_ligne, "", 0, currentScope);
  yylval.str = strdup(yytext);
  nb_colonne += strlen(yytext);
  return idf;
}

[ \t] { 
	nb_colonne += strlen(yytext); 
}

\n { 
	nb_ligne++; nb_colonne = 1; 
}

. { 
	printf("Erreur lexicale: %s à la ligne: %d, colonne : %d\n", yytext, nb_ligne, nb_colonne); 
	nb_colonne += strlen(yytext); 
}
%%