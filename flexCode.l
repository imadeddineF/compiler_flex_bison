%{
#include<stdio.h>
int nb_ligne=1;
int nb_colonne=1;    
%}
/* -- Partie : Expressions régulières -- */
lettre [a-zA-Z]  

underscore _
chiffre [0-9]
IDF ({lettre}|{chiffre}|{underscore})*
NUM 0|[1-9][0-9]*
SIGNEDNUM [+-]?{NUM}
REAL 0\.[0-9]+|[1-9][0-9]*\.[0-9]+
SIGNEDREAL [+-]?{REAL}

LOGICAL "TRUE"|"FALSE"
TEXT \"[^\"]*\"
commentaire_sur_ligne --[^\n]*##
commentaire_multi_lignes \{-(.|\n)*?-\}
/* -- Partie : Règles de production -- */
%%
"TEXT" { nb_colonne += strlen(yytext); printf(" KeyWord pour le type:TEXT reconnu\n");}
"NUM" { nb_colonne += strlen(yytext); printf(" KeyWord pour le type:REAL reconnu\n");}
"REAL" { nb_colonne += strlen(yytext); printf(" KeyWord pour le type:REAL reconnu\n");}
"DEBUT" { nb_colonne += strlen(yytext); printf(" KeyWord:DEBUT reconnu\n");}
"FIN" { nb_colonne += strlen(yytext); printf(" KeyWord:FIN reconnu\n");}
"EXECUTION" {nb_colonne += strlen(yytext); printf(" KeyWord:EXECUTION reconnu\n");}
"SI" {nb_colonne += strlen(yytext); printf(" KeyWord:SI reconnu\n");}
"ALORS" {nb_colonne += strlen(yytext); printf(" KeyWord:ALORS reconnu\n");}
"SINON" {nb_colonne += strlen(yytext); printf(" KeyWord:SINON reconnu\n");}
"TANTQUE" {nb_colonne += strlen(yytext); printf(" KeyWord:TANTQUE reconnu\n");}
"FAIRE" {nb_colonne += strlen(yytext); printf(" KeyWord:FAIRE reconnu\n");}
"FIXE" {nb_colonne += strlen(yytext); printf(" KeyWord:FIXE reconnu\n");}
"affiche" {nb_colonne += strlen(yytext); printf(" KeyWord:affiche reconnu\n");}
"lire" {nb_colonne += strlen(yytext); printf(" KeyWord:lire reconnu\n");}
"{" { nb_colonne += strlen(yytext); printf(" LFBRA reconnu\n");}
"}" { nb_colonne += strlen(yytext); printf(" RTBRA reconnu\n"); }
"[" { nb_colonne += strlen(yytext); printf(" LFSQBRA reconnu\n"); }
"]" { nb_colonne += strlen(yytext); printf(" RTSQBRA reconnu\n"); }
"(" { nb_colonne += strlen(yytext); printf(" LFPar reconnu\n"); }
")" { nb_colonne += strlen(yytext);printf(" RTPar reconnu\n"); }
"-" { nb_colonne += strlen(yytext); printf(" MINS reconnu\n"); }
"+" { nb_colonne += strlen(yytext); printf(" PLS reconnu\n"); }
"*" { nb_colonne += strlen(yytext); printf(" MULT reconnu\n"); }
"/" { nb_colonne += strlen(yytext); printf(" DIV reconnu\n"); }
"OU" { nb_colonne += strlen(yytext); printf(" KeyWord:OU reconnu\n"); }
"ET" { nb_colonne += strlen(yytext); printf(" KeyWord:ET reconnu\n"); }
"NON" { nb_colonne += strlen(yytext); printf(" KeyWord:NON reconnu\n"); }
"," { nb_colonne += strlen(yytext); printf(" , reconnu\n"); }
";" { nb_colonne += strlen(yytext); printf(" ; reconnu\n"); }
"=" { nb_colonne += strlen(yytext); printf(" = reconnu\n"); }
":" {nb_colonne += strlen(yytext); printf(" : reconnu\n");}
"<-" {nb_colonne += strlen(yytext); printf(" <- reconnu\n");}
"<" { nb_colonne += strlen(yytext); printf(" < reconnu\n"); }
"<=" { nb_colonne += strlen(yytext); printf(" <= reconnu\n"); }
">" { nb_colonne += strlen(yytext); printf(" > reconnu\n"); }
">=" { nb_colonne += strlen(yytext); printf(" >= reconnu\n"); }
"!=" { nb_colonne += strlen(yytext); printf(" != reconnu\n"); }

{commentaire_sur_ligne} {
  nb_ligne += (strchr(yytext, '\n') != NULL);  // Increment line number if newline is in comment
  nb_colonne = 1;  // Reset column to 1 at the start of the new line
}

{commentaire_multi_lignes} {
  char* ptr = yytext;  // Pointer to start of the matched text
  while ((ptr = strchr(ptr, '\n')) != NULL) {  // Loop through newlines
    nb_ligne++;  // Increment the line number for each newline
    ptr++;  // Move past the newline character
  }
  nb_colonne = 1;  // Reset column to 1 at the start of a new line
}

{LOGICAL} {printf("This logical value is correct: %s\n", yytext);/* Print the logical value*/nb_colonne += strlen(yytext);}

{TEXT} {printf("This text is correct: %s\n", yytext); /* Print the text literal*/ nb_colonne += strlen(yytext);}

{NUM} {
  int val = atoi(yytext);  // Convert string to integer using atoi
  if (val < 0 || val > 32767) {  // Range check for NUM
    printf("Erreur: Valeur d'entier hors plage à la ligne %d, colonne %d\n", nb_ligne, nb_colonne);  // Print error message
    return 0;  // Return 0 to indicate error
  }
  printf("This number is correct: %s\n", yytext);  // Print message for valid number
  nb_colonne += strlen(yytext);}

{SIGNEDNUM} {
  int val = atoi(yytext);  // Convert string to integer using atoi
  if (val < -32768 || val > 32767) {  // Range check for SIGNEDNUM
    printf("Erreur: Valeur d'entier signé hors plage à la ligne %d, colonne %d\n", nb_ligne, nb_colonne);  // Print error message
    return 0;  // Return 0 to indicate error
  }
  printf("This signed number is correct: %s\n", yytext);  // Print message for valid signed number
  nb_colonne += strlen(yytext);}

{REAL} {
  double val = atof(yytext);  // Convert string to double using atof
  if (val < 0.0 || val > 32767.0) {  // Range check for REAL
    printf("Erreur: Valeur réelle hors plage à la ligne %d, colonne %d\n", nb_ligne, nb_colonne);  // Print error message
    return 0;  // Return 0 to indicate error
  }
  printf("This real number is correct: %s\n", yytext);  // Print message for valid real number
  nb_colonne += strlen(yytext);}


{SIGNEDREAL} {
  double val = atof(yytext);  // Convert string to double using atof
  if (val < -32768.0 || val > 32767.0) {  // Range check for SIGNEDREAL
    printf("Erreur: Valeur réelle signée hors plage à la ligne %d, colonne %d\n", nb_ligne, nb_colonne);  // Print error message
    return 0;  // Return 0 to indicate error
  }
  printf("This signed real number is correct: %s\n", yytext);  // Print message for valid signed real number
  nb_colonne += strlen(yytext);}

{IDF} { 
  if (strlen(yytext) > 10) {  // Check if the identifier length is greater than 10
    printf("Erreur: Identificateur trop long à la ligne %d, colonne %d\n", nb_ligne, nb_colonne);  // Print error message
    return 0;  // Return 0 to indicate error
  }
  printf("Valid identifier: %s\n", yytext);  // Print the valid identifier
  nb_colonne += strlen(yytext);  // Update the column number with the length of the identifier
}



[ \t] { 
	nb_colonne += strlen(yytext); }

\n { 
	nb_ligne++; nb_colonne = 1; }

. { 
	printf("Erreur lexicale: %s à la ligne: %d, colonne : %d\n", yytext, nb_ligne, nb_colonne); 
	nb_colonne += strlen(yytext); }
%%