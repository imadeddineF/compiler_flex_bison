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
NUM 0|[1-9][0-9]*
SIGNEDNUM [+-]?{NUM}
REAL 0\.[0-9]+|[1-9][0-9]*\.[0-9]+
SIGNEDREAL [+-]?{REAL}
TEXT \"[^\"]*\"
commentaire_sur_ligne --[^\n]*##
commentaire_multi_lignes \{-(.|\n)*?-\}



/* Règles de production */
%%



"DEBUT"        { nb_colonne += strlen(yytext); printf("\033[32m[SUCCESS] KeyWord: DEBUT reconnu\033[0m\n"); return DEBUT; }
"FIN"          { nb_colonne += strlen(yytext); printf("\033[32m[SUCCESS] KeyWord: FIN reconnu\033[0m\n"); return FIN; }
"TEXT"         { nb_colonne += strlen(yytext); printf("\033[32m[SUCCESS] KeyWord: TEXT reconnu\033[0m\n"); return TEXT; }
"NUM"          { nb_colonne += strlen(yytext); printf("\033[32m[SUCCESS] KeyWord: NUM reconnu\033[0m\n"); return NUM; }
"REAL"         { nb_colonne += strlen(yytext); printf("\033[32m[SUCCESS] KeyWord: REAL reconnu\033[0m\n"); return REAL; }
"EXECUTION"    { nb_colonne += strlen(yytext); printf("\033[32m[SUCCESS] KeyWord: EXECUTION reconnu\033[0m\n"); return EXECUTION; }
"SI"           { nb_colonne += strlen(yytext); printf("\033[32m[SUCCESS] KeyWord: SI reconnu\033[0m\n"); return SI; }
"ALORS"        { nb_colonne += strlen(yytext); printf("\033[32m[SUCCESS] KeyWord: ALORS reconnu\033[0m\n"); return ALORS; }
"SINON"        { nb_colonne += strlen(yytext); printf("\033[32m[SUCCESS] KeyWord: SINON reconnu\033[0m\n"); return SINON; }
"TANTQUE"      { nb_colonne += strlen(yytext); printf("\033[32m[SUCCESS] KeyWord: TANTQUE reconnu\033[0m\n"); return TANTQUE; }
"FAIRE"        { nb_colonne += strlen(yytext); printf("\033[32m[SUCCESS] KeyWord: FAIRE reconnu\033[0m\n"); return FAIRE; }
"FIXE"         { nb_colonne += strlen(yytext); printf("\033[32m[SUCCESS] KeyWord: FIXE reconnu\033[0m\n"); return FIXE; }
"affiche"      { nb_colonne += strlen(yytext); printf("\033[32m[SUCCESS] KeyWord: affiche reconnu\033[0m\n"); return affiche; }
"lire"         { nb_colonne += strlen(yytext); printf("\033[32m[SUCCESS] KeyWord: lire reconnu\033[0m\n"); return lire; }


"OU"           { nb_colonne += strlen(yytext); printf("\033[32m[SUCCESS] KeyWord: OU reconnu\033[0m\n"); return OU; }
"ET"           { nb_colonne += strlen(yytext); printf("\033[32m[SUCCESS] KeyWord: ET reconnu\033[0m\n"); return ET; }
"NON"          { nb_colonne += strlen(yytext); printf("\033[32m[SUCCESS] KeyWord: NON reconnu\033[0m\n"); return NON; }


"{"            { nb_colonne += strlen(yytext); printf("\033[32m[SUCCESS] Symbol: '{' reconnu\033[0m\n"); return LFBRA; }
"}"            { nb_colonne += strlen(yytext); printf("\033[32m[SUCCESS] Symbol: '}' reconnu\033[0m\n"); return RTBRA; }
"["            { nb_colonne += strlen(yytext); printf("\033[32m[SUCCESS] Symbol: '[' reconnu\033[0m\n"); return LFSQBRA; }
"]"            { nb_colonne += strlen(yytext); printf("\033[32m[SUCCESS] Symbol: ']' reconnu\033[0m\n"); return RTSQBRA; }
"("            { nb_colonne += strlen(yytext); printf("\033[32m[SUCCESS] Symbol: '(' reconnu\033[0m\n"); return LFPar; }
")"            { nb_colonne += strlen(yytext); printf("\033[32m[SUCCESS] Symbol: ')' reconnu\033[0m\n"); return RTPar; }
"-"            { nb_colonne += strlen(yytext); printf("\033[32m[SUCCESS] Symbol: '-' reconnu\033[0m\n"); return MINUS; }
"+"            { nb_colonne += strlen(yytext); printf("\033[32m[SUCCESS] Symbol: '+' reconnu\033[0m\n"); return PLUS; }
"*"            { nb_colonne += strlen(yytext); printf("\033[32m[SUCCESS] Symbol: '*' reconnu\033[0m\n"); return MULT; }
"/"            { nb_colonne += strlen(yytext); printf("\033[32m[SUCCESS] Symbol: '/' reconnu\033[0m\n"); return DIV; }
","            { nb_colonne += strlen(yytext); printf("\033[32m[SUCCESS] Symbol: ',' reconnu\033[0m\n"); return COMMA; }
";"            { nb_colonne += strlen(yytext); printf("\033[32m[SUCCESS] Symbol: ';' reconnu\033[0m\n"); return PVIRG ; }
"="            { nb_colonne += strlen(yytext); printf("\033[32m[SUCCESS] Symbol: '=' reconnu\033[0m\n"); return EQUAL; }
":"            { nb_colonne += strlen(yytext); printf("\033[32m[SUCCESS] Symbol: ':' reconnu\033[0m\n"); return COLON; }
"<-"           { nb_colonne += strlen(yytext); printf("\033[32m[SUCCESS] Symbol: '<-' reconnu\033[0m\n"); return AFFECT; }
"<"            { nb_colonne += strlen(yytext); printf("\033[32m[SUCCESS] Symbol: '<' reconnu\033[0m\n"); return LESS; }
"<="           { nb_colonne += strlen(yytext); printf("\033[32m[SUCCESS] Symbol: '<=' reconnu\033[0m\n"); return LEQ; }
">"            { nb_colonne += strlen(yytext); printf("\033[32m[SUCCESS] Symbol: '>' reconnu\033[0m\n"); return GREATER; }
">="           { nb_colonne += strlen(yytext); printf("\033[32m[SUCCESS] Symbol: '>=' reconnu\033[0m\n"); return GEQ; }
"!="           { nb_colonne += strlen(yytext); printf("\033[32m[SUCCESS] Symbol: '!=' reconnu\033[0m\n"); return NEQ; }


{commentaire_sur_ligne} {
  nb_colonne += strlen(yytext);
  // Pas besoin de retourner un token pour un commentaire
}

{commentaire_multi_lignes} {
  char* ptr = yytext;
  while ((ptr = strchr(ptr, '\n')) != NULL) {
    nb_ligne++;
    ptr++;
  }
  nb_colonne = 1;
  // Pas besoin de retourner un token pour un commentaire
}

{TEXT} {
  printf("This text is correct: %s\n", yytext);
  nb_colonne += strlen(yytext);
  yylval.sval = strdup(yytext);  
  return TEXT;
}


{NUM} {
  int val = atoi(yytext);
  if (val < 0 || val > 32767) {
    printf("\033[31m[ERROR] Valeur d'entier hors plage (%s) à la ligne %d, colonne %d\033[0m\n", yytext, nb_ligne, nb_colonne);
  } else {
    printf("\033[32m[SUCCESS] This number is correct: %s\033[0m\n", yytext);
    yylval.ival = val;  // Associe la valeur entière au token
    nb_colonne += strlen(yytext);
    return NUM;
  }
  nb_colonne += strlen(yytext);
}


{SIGNEDNUM} {
  int val = atoi(yytext);
  if (val < -32768 || val > 32767) {
    printf("\033[31m[ERROR] Valeur d'entier signé hors plage (%s) à la ligne %d, colonne %d\033[0m\n", yytext, nb_ligne, nb_colonne);
  } else {
    printf("\033[32m[SUCCESS] This signed number is correct: %s\033[0m\n", yytext);
    yylval.ival = val;  // Associe la valeur entière au token
    nb_colonne += strlen(yytext);
    return SIGNEDNUM;
  }
  nb_colonne += strlen(yytext);
}


{REAL} {
  double val = atof(yytext);
  if (val < 0.0 || val > 32767.0) {
    printf("\033[31m[ERROR] Valeur réelle hors plage (%s) à la ligne %d, colonne %d\033[0m\n", yytext, nb_ligne, nb_colonne);
  } else {
    printf("\033[32m[SUCCESS] This real number is correct: %s\033[0m\n", yytext);
    yylval.rval = val;  // Associe la valeur double au token
    nb_colonne += strlen(yytext);
    return REAL;
  }
  nb_colonne += strlen(yytext);
}


{SIGNEDREAL} {
  double val = atof(yytext);
  if (val < -32768.0 || val > 32767.0) {
    printf("\033[31m[ERROR] Valeur réelle signée hors plage (%s) à la ligne %d, colonne %d\033[0m\n", yytext, nb_ligne, nb_colonne);
  } else {
    printf("\033[32m[SUCCESS] This signed real number is correct: %s\033[0m\n", yytext);
    yylval.rval = val;  // Associe la valeur double au token
    nb_colonne += strlen(yytext);
    return SIGNEDREAL;
  }
  nb_colonne += strlen(yytext);
}


{IDF} {
  int consecutive_underscores = 0;
  size_t len = strlen(yytext);
  int i ;
  for ( i = 1; yytext[i] != '\0'; i++) {
    if (yytext[i] == '_' && yytext[i - 1] == '_') {
      consecutive_underscores = 1;
      break;
    }
  }
  if (len > 10) {
    printf("\033[31m[ERROR] Identificateur trop long (%s) à la ligne %d, colonne %d\033[0m\n", yytext, nb_ligne, nb_colonne);
  } else if (consecutive_underscores) {
    printf("\033[31m[ERROR] Identificateur contient deux underscores successifs (%s) à la ligne %d, colonne %d\033[0m\n", yytext, nb_ligne, nb_colonne);
  } else {
    printf("\033[32m[SUCCESS] Valid identifier: %s\033[0m\n", yytext);
    yylval.sval = strdup(yytext);  // Associe la valeur string au token
    nb_colonne += len;
    return IDENTIFICATEUR;
  }
  nb_colonne += len;
}


[ \t] {
  nb_colonne += strlen(yytext);
}


\n {
  nb_ligne++;
  nb_colonne = 1;
}


. {
  printf("\033[31m[ERROR] lexicale: %s à la ligne: %d, colonne : %d\033[0m\n", yytext, nb_ligne, nb_colonne);
  nb_colonne += strlen(yytext);
}
%%


int yywrap() {
  return 1;
}

/* Only use it if you are dealing with lexical code without the syntaxical */
/*int main() {
  printf("\n\033[34m======================== Compilation Start ========================\033[0m\n");
  yylex();
  printf("\033[34m======================== Compilation End ========================== \033[0m\n");
}*/ 

