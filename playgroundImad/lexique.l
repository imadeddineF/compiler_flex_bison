%option yylineno
/* Importation C */
%{
  #include<ctype.h>
  #include<stdio.h>
  #include <string.h>
  #include "syntaxique.tab.h" 
  int nb_ligne=1;
  int nb_colonne=1;    
%}



/* Expressions régulières */
lettre [a-zA-Z]  
lettreMaj[A-Z]
underscore _
chiffre [0-9]
IDF {lettreMaj}({lettre}|{chiffre}|{underscore})*
/* NUM 0|[1-9][0-9]* */
NUM [0-9]+ 
/* SIGNEDNUM [+-]?{NUM} // this may cause a conflict */
/* SIGNEDNUM ({NUM})|([+-]{NUM})  */
SIGNEDNUM [+-]?[0-9]+
REAL 0\.[0-9]+|[1-9][0-9]*\.[0-9]+
SIGNEDREAL [+-]?{REAL}
TEXT \"[^\"]*\"
commentaire_sur_ligne --[^\n]*##
commentaire_multi_lignes \{-(.|\n)*?-\}



/* Règles de production */
%%
"DEBUT" { nb_colonne += strlen(yytext); printf("\n\033[32m[SUCCESS]  KeyWord:DEBUT reconnu\033[0m\n");}
"FIN" { 
  nb_colonne += strlen(yytext); 
  printf("\033[32m[SUCCESS]  KeyWord:FIN reconnu\033[0m\n");
  printf("\033[34m================================== Compilation End ==================================== \033[0m\n");
  exit(0); // to make sure the program ends after FIN
}
"TEXT" { nb_colonne += strlen(yytext); printf("\033[32m[SUCCESS] KeyWord pour le type:TEXT reconnu\033[0m\n");}
"NUM" { nb_colonne += strlen(yytext); printf("\033[32m[SUCCESS]  KeyWord pour le type:NUM reconnu\033[0m\n");}
"REAL" { nb_colonne += strlen(yytext); printf("\033[32m[SUCCESS]  KeyWord pour le type:REAL reconnu\033[0m\n");}
"EXECUTION" {nb_colonne += strlen(yytext); printf("\033[32m[SUCCESS]  KeyWord:EXECUTION reconnu\033[0m\n");}
"SI" {nb_colonne += strlen(yytext); printf("\033[32m[SUCCESS]  KeyWord:SI reconnu\033[0m\n");}
"ALORS" {nb_colonne += strlen(yytext); printf("\033[32m[SUCCESS]  KeyWord:ALORS reconnu\033[0m\n");}
"SINON" {nb_colonne += strlen(yytext); printf("\033[32m[SUCCESS]  KeyWord:SINON reconnu\033[0m\n");}
"TANTQUE" {nb_colonne += strlen(yytext); printf("\033[32m[SUCCESS]  KeyWord:TANTQUE reconnu\033[0m\n");}
"FAIRE" {nb_colonne += strlen(yytext); printf("\033[32m[SUCCESS]  KeyWord:FAIRE reconnu\033[0m\n");}
"FIXE" {nb_colonne += strlen(yytext); printf("\033[32m[SUCCESS]  KeyWord:FIXE reconnu\033[0m\n");}
"affiche" {nb_colonne += strlen(yytext); printf("\033[32m[SUCCESS]  KeyWord:affiche reconnu\033[0m\n");}
"lire" {nb_colonne += strlen(yytext); printf("\033[32m[SUCCESS]  KeyWord:lire reconnu\033[0m\n");}
"OU" { nb_colonne += strlen(yytext); printf("\033[32m[SUCCESS] KeyWord:OU reconnu\033[0m\n"); }
"ET" { nb_colonne += strlen(yytext); printf("\033[32m[SUCCESS] KeyWord:ET reconnu\033[0m\n"); }
"NON" { nb_colonne += strlen(yytext); printf("\033[32m[SUCCESS] KeyWord:NON reconnu\033[0m\n"); }
"{" { nb_colonne += strlen(yytext); printf("\033[32m[SUCCESS] LFBRA reconnu\033[0m\n");}
"}" { nb_colonne += strlen(yytext); printf("\033[32m[SUCCESS] RTBRA reconnu\033[0m\n"); }
"[" { nb_colonne += strlen(yytext); printf("\033[32m[SUCCESS] LFSQBRA reconnu\033[0m\n"); }
"]" { nb_colonne += strlen(yytext); printf("\033[32m[SUCCESS] RTSQBRA reconnu\033[0m\n"); }
"(" { nb_colonne += strlen(yytext); printf("\033[32m[SUCCESS] LFPar reconnu\033[0m\n"); }
")" { nb_colonne += strlen(yytext);printf("\033[32m[SUCCESS] RTPar reconnu\033[0m\n"); }
"-" { nb_colonne += strlen(yytext); printf("\033[32m[SUCCESS] MINS reconnu\033[0m\n"); }
"+" { nb_colonne += strlen(yytext); printf("\033[32m[SUCCESS] PLS reconnu\033[0m\n"); }
"*" { nb_colonne += strlen(yytext); printf("\033[32m[SUCCESS] MULT reconnu\033[0m\n"); }
"/" { nb_colonne += strlen(yytext); printf("\033[32m[SUCCESS] DIV reconnu\033[0m\n"); }
"," { nb_colonne += strlen(yytext); printf("\033[32m[SUCCESS] ',' reconnu\033[0m\n"); }
";" { nb_colonne += strlen(yytext); printf("\033[32m[SUCCESS] '; reconnu\033[0m\n"); }
"=" { nb_colonne += strlen(yytext); printf("\033[32m[SUCCESS] '=' reconnu\033[0m\n"); }
":" { nb_colonne += strlen(yytext); printf("\033[32m[SUCCESS] ':' reconnu\033[0m\n");}
"<-" { nb_colonne += strlen(yytext); printf("\033[32m[SUCCESS] '<-' reconnu\033[0m\n"); } // just switch the order
"<" { nb_colonne += strlen(yytext); printf("\033[32m[SUCCESS] '<' reconnu\033[0m\n"); }
"<=" { nb_colonne += strlen(yytext); printf("\033[32m[SUCCESS] '<=' reconnu\033[0m\n"); }
">" { nb_colonne += strlen(yytext); printf("\033[32m[SUCCESS] '>' reconnu\033[0m\n"); }
">=" { nb_colonne += strlen(yytext); printf("\033[32m[SUCCESS] '>=' reconnu\033[0m\n"); }
"!=" { nb_colonne += strlen(yytext); printf("\033[32m[SUCCESS] '!=' reconnu\033[0m\n"); }

{commentaire_sur_ligne} {
  nb_colonne += strlen(yytext);  // Update the column number based on the length of the comment
  printf("\033[32m[SUCCESS]  Commentaire sur ligne reconnu\033[0m\n");
}

{commentaire_multi_lignes} {
  char* ptr = yytext;  // Pointer to start of the matched text
  while ((ptr = strchr(ptr, '\n')) != NULL) {  // Loop through newlines
    nb_ligne++;  // Increment the line number for each newline
    ptr++;  // Move past the newline character
  }
  nb_colonne = 1;  
  printf("\033[32m[SUCCESS]  Commentaire sur multi lignes reconnu\033[0m\n");
}

{TEXT} {
  printf("This text is correct: %s\n", yytext); /* Print the text literal*/ 
  nb_colonne += strlen(yytext);
}

{NUM} {
  int val = atoi(yytext);  // Convert string to integer
  if (val < 0 || val > 32767) {  // Range check for NUM
    printf("\033[31m[ERROR]  Valeur d'entier hors plage (%s) à la ligne %d, colonne %d\033[0m\n", yytext, nb_ligne, nb_colonne);
  } else {
    printf("\033[32m[SUCCESS]  Num number est reconnu: %s\033[0m\n", yytext);  // Print message for valid number
  }
  nb_colonne += strlen(yytext);  // Always update the column number
}

{SIGNEDNUM} {
  int val = atoi(yytext);  // Convert string to integer
  if (val < -32768 || val > 32767) {  // Range check for SIGNEDNUM
    printf("\033[31m[ERROR]  Valeur d'entier signé hors plage (%s) à la ligne %d, colonne %d\033[0m\n", yytext, nb_ligne, nb_colonne);
  } else {
    printf("\033[32m[SUCCESS]  This signed number is correct: %s\033[0m\n", yytext);  // Print message for valid signed number
  }
  nb_colonne += strlen(yytext);  // Always update the column number
}

{REAL} {
  double val = atof(yytext);  // Convert string to double
  if (val < 0.0 || val > 32767.0) {  // Range check for REAL
    printf("\033[31m[ERROR]  Valeur réelle hors plage (%s) à la ligne %d, colonne %d\033[0m\n", yytext, nb_ligne, nb_colonne);
  } else {
    printf("\033[32m[SUCCESS]  Real number est reconnu: %s\033[0m\n", yytext);  // Print message for valid real number
  }
  nb_colonne += strlen(yytext);  // Always update the column number
}

{SIGNEDREAL} {
  double val = atof(yytext);  // Convert string to double
  if (val < -32768.0 || val > 32767.0) {  // Range check for SIGNEDREAL
    printf("\033[31m[ERROR]  Valeur réelle signée hors plage (%s) à la ligne %d, colonne %d\033[0m\n", yytext, nb_ligne, nb_colonne);
  } else {
    printf("\033[32m[SUCCESS]  This signed real number is correct: %s\033[0m\n", yytext);  // Print message for valid signed real number
  }
  nb_colonne += strlen(yytext);  // Always update the column number
}


{IDF} { 
  int consecutive_underscores = 0;
  size_t len = strlen(yytext);
  int i;
  for ( i = 1; yytext[i] != '\0'; i++) {
    if (yytext[i] == '_' && yytext[i-1] == '_') {
      consecutive_underscores = 1;  // Found two consecutive underscores
      break;  // No need to check further
    }
  }
  // Check conditions
  if (len > 10) {  // Length check
    printf("\033[31m[ERROR]  Identificateur trop long (%s) à la ligne %d, colonne %d\033[0m\n", yytext, nb_ligne, nb_colonne);
  } else if (consecutive_underscores) {  // Check for consecutive underscores
    printf("\033[31m[ERROR]  Identificateur contient deux underscores successifs (%s) à la ligne %d, colonne %d\033[0m\n", yytext, nb_ligne, nb_colonne);
  } else {
    printf("\033[32m[SUCCESS]  Identificateur reconnu: %s\033[0m\n", yytext);
    // yylval.sval = strdup(yytext); // no need
    // nb_colonne += len; // no need
    // return IDENTIFICATEUR; // no need
  }
  // nb_colonne += len;  
  nb_colonne += strlen(yytext);  // simply always update the column number
}

[ \t] { 
	nb_colonne += strlen(yytext); 
}

\n { 
	nb_ligne++; nb_colonne = 1; 
}

. {
  printf("\033[31m[ERROR]  Lexicale: %s à la ligne: %d, colonne : %d\033[0m\n", yytext, nb_ligne, nb_colonne); 
	nb_colonne += strlen(yytext); 
}
%%


/* int yywrap() {
  return 1;
} */

/* Only use it if you are dealing with lexical code without the syntaxical */
/*int main() {
  printf("\n\033[34m======================== Compilation Start ========================\033[0m\n");
  yylex();
  printf("\033[34m======================== Compilation End ========================== \033[0m\n");
}*/