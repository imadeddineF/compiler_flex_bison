%{
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include "ts.h" 
#include "syntaxical.tab.h" 

extern int nb_ligne; 
extern int nb_colonne;  
char currentScope[10];   
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
IDF {lettre_maj}({lettre}|{chiffre}|{underscore}|{chiffre})
NUM [-]?[0-9]+
REAL [-]?[0-9]+\.[0-9]+
LOGICAL "TRUE"|"FALSE"
TEXT \"[^\"]*\"
/* commentaire_sur_ligne "--"".*?"##""
commentaire_multi_lignes \{\-(.|\n)*?\-\} */
commentaire_sur_ligne --[^#\n]*##
commentaire_multi_lignes \{-(.|\n)*?-\}

%%
"DEBUT" { 
	rechercher(yytext, "Mot cle", "", nb_ligne, "", 1, "Début du programme"); 
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
"=" { 
	rechercher(yytext, "egalite", "", nb_ligne, "", 2, ""); 
	nb_colonne += strlen(yytext); 
	return aff; 
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
"OR" { 
	rechercher(yytext, "Mot cle", "", nb_ligne, "", 1, ""); 
	nb_colonne += strlen(yytext); 
	return op_or; 
}
"AND" { 
	rechercher(yytext, "Mot cle", "", nb_ligne, "", 1, ""); 
	nb_colonne += strlen(yytext); 
	return op_and; 
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

{TEXT} { 
	rechercher(yytext, "CST CHARACTER", "TEXT", nb_ligne, yytext, 0, ""); 
	yylval.str = strdup(yytext); 
	nb_colonne += strlen(yytext); 
	return cst_char; 
}

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

