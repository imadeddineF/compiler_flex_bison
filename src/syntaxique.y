%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int nb_ligne = 1;
int nb_colonne = 1;

char sauvType [20]; // Sauvegarde du type de la variable  ---> Utilisé pour la comparaison de type
int yylex();

void yyerror(const char* s) {
	fprintf(stderr, "Erreur syntaxique: %s, ligne %d, colonne %d\n", s, nb_ligne, nb_colonne);
}

void initialisation(); // Initialisation de TS
void afficher(); // Affichage de TS
void rechercher(const char* entite, const char* code, const char* type, float val, int categorie); // Recherche d'une entité dans TS
void insererType(const char* name, const char* type); // Insertion d'une entité dans TS
int rechercheNonDeclare(const char* name); // Recherche d'une entité non déclarée dans TS
int CompType(const char* name, const char* type); // Comparaison de type d'une entité dans TS
%}

/* Déclarations de types et tokens */
%union {
    int entier;
    double reel;
    char* texte;
}

%token <entier> NUM SIGNEDNUM
%token <reel> REAL SIGNEDREAL
%token <texte> TEXT
%token <texte> IDF
%token SI ALORS SINON TANTQUE FAIRE DEBUT FIN EXECUTION FIXE AFFICHE LIRE
%token ACCOLADE_OUVRANTE ACCOLADE_FERMANTE
%token PARENTHOISE_OUVRANTE PARENTHOISE_FERMANTE
%token CROCHET_OUVRANT CROCHET_FERMANT
%token PLUS MOINS MULT DIV VIRGULE POINT_VIRGULE
%token DEUX_POINTS EGAL INF SUP DIFFERENT INF_EGAL SUP_EGAL AFFECTION 
%token OU ET NON ERR // cant't remove this since it's used in the lexical code
%token TYPE_NUM TYPE_REAL TYPE_TEXT TYPE_SIGNEDNUM TYPE_SIGNEDREAL

/* order is important for the priority (bottom >>>> top) */
%left OU           // Lower precedence    
%left ET                
%right NON             
%nonassoc INF INF_EGAL SUP SUP_EGAL // it reads as the order
%left EGAL DIFFERENT    
%left PLUS MOINS        
%left MULT DIV         // Higher precedence

%start programme      // the root non-terminal of the grammar




%%

programme
    : DEBUT declarations EXECUTION bloc FIN
      { 
				printf("\n════════════════════════════════════════════════════════════════════════════════\n");
				printf("Programme valide ✅");
				printf("\n════════════════════════════════════════════════════════════════════════════════\n");
			}
;

/* should be considered */
declarations
    : declaration declarations
    |
;

declaration
    : FIXE type_variable DEUX_POINTS IDF EGAL expression POINT_VIRGULE
    | type_variable DEUX_POINTS IDF POINT_VIRGULE
    | type_variable DEUX_POINTS IDF CROCHET_OUVRANT expression CROCHET_FERMANT POINT_VIRGULE // ---> Tabeau
		| table
;

variables 
    : type_variable liste_vars POINT_VIRGULE variables
		| FIXE type_variable DEUX_POINTS IDF EGAL liste_conts POINT_VIRGULE variables

type_variable
    : TYPE_NUM {strcpy(sauvType,"NUM");}
    | TYPE_REAL {strcpy(sauvType,"REAL");}
    | TYPE_TEXT {strcpy(sauvType,"TEXT");}
    | TYPE_SIGNEDNUM {strcpy(sauvType,"SIGNEDNUM");}
    | TYPE_SIGNEDREAL {strcpy(sauvType,"SIGNEDREAL");}
;

liste_vars 
    : IDF AFFECTION NUM VIRGULE liste_vars {
		if (rechercheNonDeclare($1)==0) {
			insererType($1,sauvType);
		} else {
			printf("****Erreur a la ligne %d et la colonne %d,la variable %s est deja declaree ****\n", N,C, $1);
		} if (CompType($1,"INTEGER")==0) {
			printf("****Erreur a la ligne %d et la colonne %d \n", N,C, $1);
		}
	}
	| IDF AFFECTION SIGNEDNUM VIRGULE liste_vars {
		if (rechercheNonDeclare($1)==0) {
			insererType($1,sauvType);
		} else {
			printf("****Erreur a la ligne %d et la colonne %d,la variable %s est deja declaree ****\n", N,C, $1);
		} if (CompType($1,"SIGNEDNUM")==0) {
			printf("****Erreur a la ligne %d et la colonne %d \n", N,C, $1);
		}
	}
    | IDF AFFECTION NUM {
        if (rechercheNonDeclare($1)==0) {
			insererType($1,sauvType);
		} else {
			printf("****Erreur a la ligne %d et la colonne %d,la variable %s est deja declaree ****\n", N,C, $1);
		} if (CompType($1,"INTEGER")==0) {
			printf("****Erreur a la ligne %d et la colonne %d \n", N,C, $1);
		}
    }    
	| IDF AFFECTION SIGNEDNUM {
		if (rechercheNonDeclare($1)==0) {
			insererType($1,sauvType);
		} else {
			printf("****Erreur a la ligne %d et la colonne %d,la variable %s est deja declaree ****\n", N,C, $1);
		} if (CompType($1,"SIGNEDNUM")==0) {
			printf("****Erreur a la ligne %d et la colonne %d \n", N,C, $1);
		}
	}
    | IDF VIRGULE liste_vars {
		if (rechercheNonDeclare($1)==0) {
			insererType($1,sauvType);
		} else {
			printf("****Erreur a la ligne %d et la colonne %d,la variable %s est deja declaree ****\n", N,C, $1);
		}
	}
    | IDF {
		if (rechercheNonDeclare($1)==0) {
			insererType($1,sauvType);
		} else {
			printf("****Erreur a la ligne %d et la colonne %d,la variable %s est deja declaree ****\n", N,C, $1);
		}
	}
    | IDF AFFECTION REAL VIRGULE liste_vars {
		if (rechercheNonDeclare($1)==0) {
			insererType($1,sauvType);
		} else {
			printf("****Erreur a la ligne %d et la colonne %d,la variable %s est deja declaree ****\n", N,C, $1);
		} if (CompType($1,"FLOAT")==0) {
			printf("****Erreur a la ligne %d et la colonne %d : ICOMPATIBILITE DE TYPE de la variable %s ****\n", N,C, $1);
		}
	}
	| IDF AFFECTION SIGNEDREAL VIRGULE liste_vars {
		if (rechercheNonDeclare($1)==0) {
			insererType($1,sauvType);
		} else {
			printf("****Erreur a la ligne %d et la colonne %d,la variable %s est deja declaree ****\n", N,C, $1);
		} if (CompType($1,"SIGNEDREAL")==0) {
			printf("****Erreur a la ligne %d et la colonne %d : ICOMPATIBILITE DE TYPE de la variable %s ****\n", N,C, $1);
		}
	}
    | IDF AFFECTION REAL {
		if (rechercheNonDeclare($1)==0) {
			insererType($1,sauvType);
		} else {
			printf("****Erreur a la ligne %d et la colonne %d,la variable %s est deja declaree ****\n", N,C, $1);
		} if (CompType($1,"FLOAT")==0) {
			printf("****Erreur a la ligne %d et la colonne %d : ICOMPATIBILITE DE TYPE de la variable %s ****\n", N,C, $1);
		}
	}
	| IDF AFFECTION SIGNEDREAL {
		if (rechercheNonDeclare($1)==0) {
			insererType($1,sauvType);
		} else {	
			printf("****Erreur a la ligne %d et la colonne %d,la variable %s est deja declaree ****\n", N,C, $1);
		} if (CompType($1,"SIGNEDREAL")==0) {
			printf("****Erreur a la ligne %d et la colonne %d : ICOMPATIBILITE DE TYPE de la variable %s ****\n", N,C, $1);
		}
	}
    | IDF AFFECTION TEXT VIRGULE liste_vars {
		if (rechercheNonDeclare($1)==0) {
			insererType($1,sauvType);
		} else {
			printf("****Erreur a la ligne %d et la colonne %d,la variable %s est deja declaree ****\n", N,C, $1);
		} if (CompType($1,"STRING")==0) {
			printf("****Erreur semantique a la ligne %d et la colonne %d : ICOMPATIBILITE DE TYPE de la variable %s ****\n", N,C, $1);
		}
	}
    | IDF AFFECTION TEXT {
		if (rechercheNonDeclare($1)==0) {
			insererType($1,sauvType);
		} else {
			printf("****Erreur a la ligne %d et la colonne %d,la variable %s est deja declaree ****\n", N,C, $1);
		} if (CompType($1,"STRING")==0) {
			printf("****Erreur a la ligne %d et la colonne %d : ICOMPATIBILITE DE TYPE de la variable %s ****\n", N,C, $1);
		}
	}
;

liste_conts 
    : IDF AFFECTION NUM VIRGULE liste_conts {
		if (rechercheNonDeclare($1)==0) {
			insererType($1,sauvType);
		} else {
			printf("****Erreur a la ligne %d et la colonne %d,la variable %s est deja declaree ****\n", N,C, $1);
		}
        if (CompType($1,"INTEGER")==0) {
			printf("****Erreur a la ligne %d et la colonne %d : ICOMPATIBILITE DE TYPE de la variable %s ****\n", N,C, $1);
		}
	}
	| IDF AFFECTION SIGNEDNUM VIRGULE liste_conts {
		if (rechercheNonDeclare($1)==0) {
			insererType($1,sauvType);
		} else {
			printf("****Erreur a la ligne %d et la colonne %d,la variable %s est deja declaree ****\n", N,C, $1);
		}
		if (CompType($1,"SIGNEDNUM")==0) {
			printf("****Erreur a la ligne %d et la colonne %d : ICOMPATIBILITE DE TYPE de la variable %s ****\n", N,C, $1);
		}
	}
    | IDF AFFECTION NUM {
		if (rechercheNonDeclare($1)==0) {
			insererType($1,sauvType);
		} else {
			printf("****Erreur a la ligne %d et la colonne %d,la variable %s est deja declaree ****\n", N,C, $1);
		}
        if (CompType($1,"INTEGER")==0) {
			printf("****Erreur a la ligne %d et la colonne %d : ICOMPATIBILITE DE TYPE de la variable %s ****\n", N,C, $1);
		}
	}
	| IDF AFFECTION SIGNEDNUM {
		if (rechercheNonDeclare($1)==0) {
			insererType($1,sauvType);
		} else {
			printf("****Erreur a la ligne %d et la colonne %d,la variable %s est deja declaree ****\n", N,C, $1);
		}
		if (CompType($1,"SIGNEDNUM")==0) {
			printf("****Erreur a la ligne %d et la colonne %d : ICOMPATIBILITE DE TYPE de la variable %s ****\n", N,C, $1);
		}
	}
    | IDF AFFECTION REAL REAL liste_conts {
		if (rechercheNonDeclare($1)==0) {
			insererType($1,sauvType);
		} else {
			printf("****Erreur a la ligne %d et la colonne %d,la variable %s est deja declaree ****\n", N,C, $1);
		}
        if (CompType($1,"FLOAT")==0) {
			printf("****Erreur a la ligne %d et la colonne %d : ICOMPATIBILITE DE TYPE de la variable %s ****\n", N,C, $1);
		}
	}
	| IDF AFFECTION SIGNEDREAL SIGNEDREAL liste_conts {
		if (rechercheNonDeclare($1)==0) {
			insererType($1,sauvType);
		} else {
			printf("****Erreur a la ligne %d et la colonne %d,la variable %s est deja declaree ****\n", N,C, $1);
		}
		if (CompType($1,"SIGNEDREAL")==0) {
			printf("****Erreur a la ligne %d et la colonne %d : ICOMPATIBILITE DE TYPE de la variable %s ****\n", N,C, $1);
		}
	}
    | IDF AFFECTION REAL {
		if (rechercheNonDeclare($1)==0) {
			insererType($1,sauvType);
		} else {
			printf("****Erreur a la ligne %d et la colonne %d,la variable %s est deja declaree ****\n", N,C, $1);
		} if (CompType($1,"FLOAT")==0) {
			printf("****Erreur a la ligne %d et la colonne %d : ICOMPATIBILITE DE TYPE de la variable %s ****\n", N,C, $1);
		}
	}
	| IDF AFFECTION SIGNEDREAL {
		if (rechercheNonDeclare($1)==0) {
			insererType($1,sauvType);
		} else {
			printf("****Erreur a la ligne %d et la colonne %d,la variable %s est deja declaree ****\n", N,C, $1);
		} if (CompType($1,"SIGNEDREAL")==0) {	
			printf("****Erreur a la ligne %d et la colonne %d : ICOMPATIBILITE DE TYPE de la variable %s ****\n", N,C, $1);
		}
	}
    | IDF AFFECTION TEXT VIRGULE liste_conts {
		if (rechercheNonDeclare($1)==0) {
			insererType($1,sauvType);
		} else {
			printf("****Erreur a la ligne %d et la colonne %d,la variable %s est deja declaree ****\n", N,C, $1);
		} if (CompType($1,"STRING")==0) {
			printf("****Erreur a la ligne %d et la colonne %d : ICOMPATIBILITE DE TYPE de la variable %s ****\n", N,C, $1);
		}
	}
    | IDF AFFECTION TEXT {
		if (rechercheNonDeclare($1)==0) {
			insererType($1,sauvType);
		} else {
			printf("****Erreur a la ligne %d et la colonne %d,la variable %s est deja declaree**** \n", N,C, $1);
		}
        if (CompType($1,"STRING")==0) {
			printf("****Erreur a la ligne %d et la colonne %d : ICOMPATIBILITE DE TYPE de la variable %s ****\n", N,C, $1);
		}
	} 
    | IDF VIRGULE liste_conts {
		if (rechercheNonDeclare($1)==0) {
			insererType($1,sauvType);
		} else {
			printf("****Erreur a la ligne %d et la colonne %d,la variable %s est deja declaree ****\n", N,C, $1);
		}
	}
    | IDF {
		if (rechercheNonDeclare($1)==0) {
			insererType($1,sauvType);
		} else {
			printf("****Erreur a la ligne %d et la colonne %d,la variable %s est deja declaree ****\n", N,C, $1);
		}
	}
;

bloc
    : ACCOLADE_OUVRANTE instructions ACCOLADE_FERMANTE
;

instructions
    : instruction instructions
    |
;

instruction 
	: IDF AFFECTION expression POINT_VIRGULE  
	| table   
  | instruction_si 
  | boucle_tantque 
  | AFFICHE PARENTHOISE_OUVRANTE TEXT PARENTHOISE_FERMANTE POINT_VIRGULE
  | AFFICHE PARENTHOISE_OUVRANTE IDF PARENTHOISE_FERMANTE POINT_VIRGULE
	| AFFICHE PARENTHOISE_OUVRANTE TEXT VIRGULE IDF PARENTHOISE_FERMANTE POINT_VIRGULE
	| AFFICHE PARENTHOISE_OUVRANTE IDF VIRGULE TEXT PARENTHOISE_FERMANTE POINT_VIRGULE
  | LIRE PARENTHOISE_OUVRANTE TEXT PARENTHOISE_FERMANTE POINT_VIRGULE
  | LIRE PARENTHOISE_OUVRANTE IDF PARENTHOISE_FERMANTE POINT_VIRGULE
	| 
;

instruction_si
    : SI PARENTHOISE_OUVRANTE condition PARENTHOISE_FERMANTE ALORS bloc SINON bloc // -----> SI & SINON
    | SI PARENTHOISE_OUVRANTE condition PARENTHOISE_FERMANTE ALORS bloc   // -----> SI
	  | SI PARENTHOISE_OUVRANTE condition PARENTHOISE_FERMANTE ALORS bloc SINON SI PARENTHOISE_OUVRANTE condition PARENTHOISE_FERMANTE ALORS bloc  // -----> SI & SINON SI
;


condition
    : expression INF expression
    | expression INF_EGAL expression
    | expression SUP expression
    | expression SUP_EGAL expression
    | expression EGAL expression
    | expression DIFFERENT expression
    | expression ET expression
    | expression OU expression
    | NON expression
;

boucle_tantque
    : TANTQUE PARENTHOISE_OUVRANTE expression PARENTHOISE_FERMANTE FAIRE bloc
    | TANTQUE PARENTHOISE_OUVRANTE expression PARENTHOISE_FERMANTE FAIRE bloc boucle_tantque
;

table
  : IDF CROCHET_OUVRANT NUM CROCHET_FERMANT AFFECTION NUM POINT_VIRGULE
	| IDF CROCHET_OUVRANT NUM CROCHET_FERMANT AFFECTION REAL POINT_VIRGULE
	| IDF CROCHET_OUVRANT NUM CROCHET_FERMANT AFFECTION SIGNEDNUM POINT_VIRGULE
	| IDF CROCHET_OUVRANT NUM CROCHET_FERMANT AFFECTION SIGNEDREAL POINT_VIRGULE
	| IDF CROCHET_OUVRANT NUM CROCHET_FERMANT AFFECTION TEXT POINT_VIRGULE
	| IDF CROCHET_OUVRANT NUM CROCHET_FERMANT AFFECTION IDF POINT_VIRGULE
		{
		  // to make sure the index size is not negative
			if ($3 < 0) {
				yyerror("Array index cannot be negative");
			}
		}
;


expression
    : expression_arithmetique
    | expression_logique
		| expression_chars
;

expression_logique
    : expression ET expression
    | expression OU expression
    | expression INF expression
    | expression SUP expression
    | expression EGAL expression
    | expression DIFFERENT expression
    | expression INF_EGAL expression
    | expression SUP_EGAL expression
    | NON expression
    | PARENTHOISE_OUVRANTE expression_logique PARENTHOISE_FERMANTE
;

expression_arithmetique
    : NUM
    | REAL
    | SIGNEDNUM
    | SIGNEDREAL
    | IDF
    | IDF CROCHET_OUVRANT NUM CROCHET_FERMANT
    | expression_arithmetique PLUS expression_arithmetique
    | expression_arithmetique MOINS expression_arithmetique
    | expression_arithmetique MULT expression_arithmetique
		| NUM DIV NUM 
			{if ($3 == 0) printf("Erreur division sur 0\n");}
    | REAL DIV REAL 
			{if ($3 == 0) printf("Erreur division sur 0\n");}
    | expression_arithmetique DIV expression_arithmetique
		
    | PARENTHOISE_OUVRANTE expression_arithmetique PARENTHOISE_FERMANTE
;
    | PARENTHOISE_OUVRANTE expression_arithmetique PARENTHOISE_FERMANTE
;

expression_chars 
	: TEXT
;



%%


int main() {
		printf("\n════════════════════════════════════════════════════════════════════════════════\n");
    printf("Debut de l'analyse:");
		printf("\n════════════════════════════════════════════════════════════════════════════════\n");
    initialisation();
    yyparse(); 
    printf("\n");
    afficher();
}

