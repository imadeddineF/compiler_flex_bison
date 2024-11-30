%{
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include "ts.h" 
#include "syntaxical.tab.h" 

extern int nb_ligne; 
extern int nb_colonne;  
// char currentScope[10];   
char currentScope[10] = "GLOBAL";  
char typeidf[10];      
extern YYSTYPE yylval; 

// Enhanced error reporting
void print_warning(const char* message, int ligne, int colonne) {
  printf("WARNING: %s à la ligne: %d, colonne %d\n", message, ligne, colonne);
}

// Advanced range checking
int is_valid_num_range(long long val) {
  return (val >= -32768 && val <= 32767);
}

int is_valid_real_range(double val) {
  return (val >= -32768.0 && val <= 32767.0);
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
/* commentaire_sur_ligne "--"".*?"##""
commentaire_multi_lignes \{\-(.|\n)*?\-\} */
commentaire_sur_ligne --[^#\n]*##
commentaire_multi_lignes \{-(.|\n)*?-\}

/* Type Keywords */
TYPE_NUM "NUM"
TYPE_REAL "REAL"
TYPE_TEXT "TEXT"

%%
"DEBUT" { 
	rechercher(yytext, "Mot cle", "", nb_ligne, "", 1, "Début du programme"); 
	strcpy(currentScope, "GLOBAL");
	nb_colonne += strlen(yytext); 
	return mc_debut; 
}
"FIN" { 
	rechercher(yytext, "Mot cle", "", nb_ligne, "", 1, "Fin du programme"); 
	nb_colonne += strlen(yytext); 
	return mc_fin; 
}
"EXECUTION" {
  rechercher(yytext, "Mot cle", "", nb_ligne, "", 1, "Début de l'exécution"); 
  nb_colonne += strlen(yytext); 
  return mc_execution;
}
"SI" {
  rechercher(yytext, "Mot cle", "", nb_ligne, "", 1, "Condition SI"); 
  nb_colonne += strlen(yytext); 
  return mc_si;
}
"ALORS" {
  rechercher(yytext, "Mot cle", "", nb_ligne, "", 1, "Bloc ALORS"); 
  nb_colonne += strlen(yytext); 
  return mc_alors;
}
"SINON" {
  rechercher(yytext, "Mot cle", "", nb_ligne, "", 1, "Bloc SINON"); 
  nb_colonne += strlen(yytext); 
  return mc_sinon;
}
"TANTQUE" {
  rechercher(yytext, "Mot cle", "", nb_ligne, "", 1, "Boucle TANTQUE"); 
  nb_colonne += strlen(yytext); 
  return mc_tantque;
}
"FAIRE" {
  rechercher(yytext, "Mot cle", "", nb_ligne, "", 1, "Mot-clé FAIRE"); 
  nb_colonne += strlen(yytext); 
  return mc_faire;
}
"FIXE" {
  rechercher(yytext, "Mot cle", "", nb_ligne, "", 1, "Déclaration de constante"); 
  nb_colonne += strlen(yytext); 
  return mc_fixe;
}
"affiche" {
  rechercher(yytext, "Fonction", "", nb_ligne, "", 1, "Fonction d'affichage"); 
  nb_colonne += strlen(yytext); 
  return func_affiche;
}
"lire" {
  rechercher(yytext, "Fonction", "", nb_ligne, "", 1, "Fonction de lecture"); 
  nb_colonne += strlen(yytext); 
  return func_lire;
}
"{" { 
	rechercher(yytext, "Symbole", "Accolade ouvrante", nb_ligne, "", 2, ""); 
	nb_colonne += strlen(yytext); 
	return acc_ouvrante; 
}
"}" { 
	rechercher(yytext, "Symbole", "Accolade fermante", nb_ligne, "", 2, ""); 
	nb_colonne += strlen(yytext); 
	return acc_fermante; 
}
"[" { 
	rechercher(yytext, "Symbole", "Crochet ouvrant", nb_ligne, "", 2, ""); 
	nb_colonne += strlen(yytext); 
	return cro_ouvrante; 
}
"]" { 
	rechercher(yytext, "Symbole", "Crochet fermant", nb_ligne, "", 2, ""); 
	nb_colonne += strlen(yytext); 
	return cro_fermante; 
}
"(" { 
  rechercher(yytext, "Symbole", "Parenthèse ouvrante", nb_ligne, "", 2, ""); 
  nb_colonne += strlen(yytext); 
  return par_ouvrante; 
}
")" { 
  rechercher(yytext, "Symbole", "Parenthèse fermante", nb_ligne, "", 2, ""); 
  nb_colonne += strlen(yytext); 
  return par_fermante; 
}
"-" { 
	rechercher(yytext, "soustraction", "", nb_ligne, "", 2, ""); 
	nb_colonne += strlen(yytext); 
	return opar_moins; 
}
"+" { 
	rechercher(yytext, "addition", "", nb_ligne, "", 2, ""); 
	nb_colonne += strlen(yytext); 
	return opar_plus; 
}
"*" { 
	rechercher(yytext, "multiplication", "", nb_ligne, "", 2, ""); 
	nb_colonne += strlen(yytext); 
	return opar_mult; 
}
"/" { 
	rechercher(yytext, "division", "", nb_ligne, "", 2, ""); 
	nb_colonne += strlen(yytext); 
	return opar_div; 
}
"OU" { 
	rechercher(yytext, "Mot cle", "", nb_ligne, "", 1, ""); 
	nb_colonne += strlen(yytext); 
	return op_ou; 
}
"ET" { 
	rechercher(yytext, "Mot cle", "", nb_ligne, "", 1, ""); 
	nb_colonne += strlen(yytext); 
	return op_et; 
}
"NON" { 
	rechercher(yytext, "Mot cle", "", nb_ligne, "", 1, ""); 
	nb_colonne += strlen(yytext); 
	return op_non; 
}
"," { 
	rechercher(yytext, "Séparateur", "", nb_ligne, "", 2, ""); 
	nb_colonne += strlen(yytext); 
	return separator; 
}
";" { 
	rechercher(yytext, "Séparateur", "", nb_ligne, "", 2, ""); 
	nb_colonne += strlen(yytext); 
	return separator; 
}
"=" { 
	rechercher(yytext, "egalite", "", nb_ligne, "", 2, ""); 
	nb_colonne += strlen(yytext); 
	return aff; 
}
":" {
  rechercher(yytext, "Séparateur", "", nb_ligne, "", 2, "Déclaration de type"); 
  nb_colonne += strlen(yytext); 
  return type_separator;
}
"<-" {
  rechercher(yytext, "Affectation", "", nb_ligne, "", 2, "Affectation de variable"); 
  nb_colonne += strlen(yytext); 
  return affect_sign;
}
"<" { 
	rechercher(yytext, "Inferieur_a", "", nb_ligne, "", 2, ""); 
	nb_colonne += strlen(yytext); 
	return op_lt; 
}
"<=" { 
	rechercher(yytext, "Inferieur_ou_egal", "", 
	nb_ligne, "", 2, ""); nb_colonne += strlen(yytext); 
	return op_le; 
}
">" { 
	rechercher(yytext, "Superieur_a", "", nb_ligne, "", 2, ""); 
	nb_colonne += strlen(yytext); 
	return op_gt; 
}
">=" { 
	rechercher(yytext, "Superieur_ou_egal", "", nb_ligne, "", 2, ""); 
	nb_colonne += strlen(yytext); 
	return op_ge; 
}
"!=" { 
	rechercher(yytext, "Different_de", "", nb_ligne, "", 2, ""); 
	nb_colonne += strlen(yytext); 
	return op_ne; 
}

{commentaire_sur_ligne} {
  // Ignore single line comments but track line and column
  nb_ligne += (strchr(yytext, '\n') != NULL);
  nb_colonne = 1;
}

{commentaire_multi_lignes} {
  // Count newlines in multiline comments to update line number
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
  if (!is_valid_num_range(val)) {
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
  if (!is_valid_real_range(val)) {
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

