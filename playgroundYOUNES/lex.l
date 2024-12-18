%{
  #include<ctype.h>
  #include<stdio.h>
  #include <string.h>
  #include "synt.tab.h" 
  #include "ts.h"

extern YYSTYPE yylval;
  extern int nb_ligne;
extern int nb_colonne;   
%}



/* Expressions régulières */
lettre [a-zA-Z]  
lettreMaj[A-Z]
underscore _
chiffre [0-9]
IDF {lettreMaj}({lettre}|{chiffre}|{underscore})*
NUM 0|[1-9][0-9]*
SIGNEDNUM [+-]({NUM})
REAL 0\.[0-9]+|[1-9][0-9]*\.[0-9]+
SIGNEDREAL [+-]({REAL})
TEXT \"[^\"]*\"
commentaire_sur_ligne --[^\n]*##
commentaire_multi_lignes \{-(.|\n)*?-\}



/* Règles de production */
%%
"DEBUT" { nb_colonne += strlen(yytext); printf("\033[32m[SUCCESS]  KeyWord:DEBUT reconnu\033[0m\n",yytext); return DEBUT;}
"FIN" { nb_colonne += strlen(yytext); printf("\033[32m[SUCCESS]  KeyWord:FIN reconnu\033[0m\n",yytext); return FIN;}
"TEXT" { nb_colonne += strlen(yytext); printf("\033[32m[SUCCESS] KeyWord pour le type:TEXT reconnu\033[0m\n",yytext); return TEXT;}
"NUM" { nb_colonne += strlen(yytext); printf("\033[32m[SUCCESS]  KeyWord pour le type:NUM reconnu\033[0m\n",yytext); return NUM;}
"REAL" { nb_colonne += strlen(yytext); printf("\033[32m[SUCCESS]  KeyWord pour le type:REAL reconnu\033[0m\n",yytext); return REAL; }
"EXECUTION" {nb_colonne += strlen(yytext); printf("\033[32m[SUCCESS]  KeyWord:EXECUTION reconnu\033[0m\n",yytext);return EXECUTION;}
"SI" {nb_colonne += strlen(yytext); printf("\033[32m[SUCCESS]  KeyWord:SI reconnu\033[0m\n",yytext); return SI;}
"ALORS" {nb_colonne += strlen(yytext); printf("\033[32m[SUCCESS]  KeyWord:ALORS reconnu\033[0m\n",yytext); return ALORS;}
"SINON" {nb_colonne += strlen(yytext); printf("\033[32m[SUCCESS]  KeyWord:SINON reconnu\033[0m\n",yytext); return SINON;}
"TANTQUE" {nb_colonne += strlen(yytext); printf("\033[32m[SUCCESS]  KeyWord:TANTQUE reconnu\033[0m\n",yytext); return TANQUE;}
"FAIRE" {nb_colonne += strlen(yytext); printf("\033[32m[SUCCESS]  KeyWord:FAIRE reconnu\033[0m\n",yytext);return FAIRE;}
"FIXE" {nb_colonne += strlen(yytext); printf("\033[32m[SUCCESS]  KeyWord:FIXE reconnu\033[0m\n",yytext); return FIXE;}
"affiche" {nb_colonne += strlen(yytext); printf("\033[32m[SUCCESS]  KeyWord:affiche reconnu\033[0m\n",yytext); return AFFICHE;}
"lire" {nb_colonne += strlen(yytext); printf("\033[32m[SUCCESS]  KeyWord:lire reconnu\033[0m\n",yytext); return LIRES;}
"OU" { nb_colonne += strlen(yytext); printf("\033[32m[SUCCESS] KeyWord:OU reconnu\033[0m\n",yytext); return OU;}
"ET" { nb_colonne += strlen(yytext); printf("\033[32m[SUCCESS] KeyWord:ET reconnu\033[0m\n",yytext); return ET;}
"NON" { nb_colonne += strlen(yytext); printf("\033[32m[SUCCESS] KeyWord:NON reconnu\033[0m\n",yytext); return NON;}
"[" { nb_colonne += strlen(yytext); printf("\033[32m[SUCCESS] LFSQBRA reconnu\033[0m\n",yytext); return LFSQBRA;}
"]" { nb_colonne += strlen(yytext); printf("\033[32m[SUCCESS] RTSQBRA reconnu\033[0m\n",yytext); return RTSQBRA;}
"{" { nb_colonne += strlen(yytext); printf("\033[32m[SUCCESS] LFBRA reconnu\033[0m\n", yytext); return LFBRA; }
"}" { nb_colonne += strlen(yytext); printf("\033[32m[SUCCESS] RTBRA reconnu\033[0m\n", yytext); return RTBRA; }
"(" { nb_colonne += strlen(yytext); printf("\033[32m[SUCCESS] LFPar reconnu\033[0m\n", yytext); return LFPar; }
")" { nb_colonne += strlen(yytext); printf("\033[32m[SUCCESS] RTPar reconnu\033[0m\n", yytext); return RTPar; }
"-" { nb_colonne += strlen(yytext); printf("\033[32m[SUCCESS] MINS reconnu\033[0m\n",yytext); return MINS;}
"+" { nb_colonne += strlen(yytext); printf("\033[32m[SUCCESS] PLS reconnu\033[0m\n",yytext); return PLS;}
"*" { nb_colonne += strlen(yytext); printf("\033[32m[SUCCESS] MULT reconnu\033[0m\n",yytext); return MULT;}
"/" { nb_colonne += strlen(yytext); printf("\033[32m[SUCCESS] DIV reconnu\033[0m\n",yytext); return DIV;}
"," { nb_colonne += strlen(yytext); printf("\033[32m[SUCCESS] ',' reconnu\033[0m\n",yytext); return COMMA;}
";" { nb_colonne += strlen(yytext); printf("\033[32m[SUCCESS] '; reconnu\033[0m\n",yytext); return SEMICOLON;}
"=" { nb_colonne += strlen(yytext); printf("\033[32m[SUCCESS] '=' reconnu\033[0m\n",yytext); return EQUAL;}
":" {nb_colonne += strlen(yytext); printf("\033[32m[SUCCESS] ':' reconnu\033[0m\n",yytext); return COLON;}
"<-" {nb_colonne += strlen(yytext); printf("\033[32m[SUCCESS] '<-' reconnu\033[0m\n",yytext); return AFFECT;}
"<" { nb_colonne += strlen(yytext); printf("\033[32m[SUCCESS] '<' reconnu\033[0m\n",yytext); return LESS;}
"<=" { nb_colonne += strlen(yytext); printf("\033[32m[SUCCESS] '<=' reconnu\033[0m\n",yytext); return LESS_EQ; }
">" { nb_colonne += strlen(yytext); printf("\033[32m[SUCCESS] '>' reconnu\033[0m\n",yytext); return GREATER; }
">=" { nb_colonne += strlen(yytext); printf("\033[32m[SUCCESS] '>=' reconnu\033[0m\n",yytext); return GREATER_EQ;}
"!=" { nb_colonne += strlen(yytext); printf("\033[32m[SUCCESS] '!=' reconnu\033[0m\n",yytext);return NOT_EQUAL;}


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
  return TEXT; 
}

{NUM} {
  int val = atoi(yytext);  // Convert string to integer
  if (val < 0 || val > 32767)   // Range check for NUM
    printf("\033[31m[ERROR] Valeur d'entier hors plage (%s) à la ligne %d, colonne %d\033[0m\n", yytext, nb_ligne, nb_colonne);
  nb_colonne += strlen(yytext);  // Always update the column number
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
  double val = atof(yytext);  // Convert string to double
  if (val < 0.0 || val > 32767.0)  // Range check for REAL
    printf("\033[31m[ERROR] Valeur réelle hors plage (%s) à la ligne %d, colonne %d\033[0m\n", yytext, nb_ligne, nb_colonne);
  nb_colonne += strlen(yytext);  // Always update the column number
  return REAL;
}

{SIGNEDREAL} {
  double val = atof(yytext);  // Convert string to double
  if (val < -32768.0 || val > 32767.0)   // Range check for SIGNEDREAL
    printf("\033[31m[ERROR] Valeur réelle signée hors plage (%s) à la ligne %d, colonne %d\033[0m\n", yytext, nb_ligne, nb_colonne);
  nb_colonne += strlen(yytext);  // Always update the column number
  return SIGNEDREAL;
}

{IDF} {
    int len = strlen(yytext);

    // Length check
    if (len > 10) {
        fprintf(stderr, "\033[31m[ERROR] Identificateur trop long (%s) à la ligne %d, colonne %d\033[0m\n", yytext, nb_ligne, nb_colonne);
        return ERROR_TOKEN;
    }

    // Check for consecutive underscores
    for (int i = 1; yytext[i] != '\0'; i++) {
        if (yytext[i] == '_' && yytext[i - 1] == '_') {
            fprintf(stderr, "\033[31m[ERROR] Identificateur contient deux underscores successifs (%s) à la ligne %d, colonne %d\033[0m\n", yytext, nb_ligne, nb_colonne);
            return ERROR_TOKEN;
        }
    }

    // Validate identifier in the symbol table
    int index = recherche(yytext);
    if (index == -1) {
        fprintf(stderr, "\033[31m[ERROR] Identificateur non déclaré (%s) à la ligne %d, colonne %d\033[0m\n", yytext, nb_ligne, nb_colonne);
        return ERROR_TOKEN;
    } else {
        strcpy(yylval.texte, ts[index].Type); // Assign the type from the symbol table to `yylval`
        nb_colonne += len;
        return IDF;
    }
}



[ \t] { 
	nb_colonne += strlen(yytext); 
}

\n { 
	nb_ligne++; nb_colonne = 1; 
}

. { 
  fprintf(stderr, "\033[31m[ERROR] lexicale: %s à la ligne: %d, colonne : %d\033[0m\n", yytext, nb_ligne, nb_colonne);
  nb_colonne += strlen(yytext);
  return ERROR_TOKEN;
}

%%


int yywrap() {
  return 1;
}

