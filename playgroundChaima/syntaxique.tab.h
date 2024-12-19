
/* A Bison parser, made by GNU Bison 2.4.1.  */

/* Skeleton interface for Bison's Yacc-like parsers in C
   
      Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002, 2003, 2004, 2005, 2006
   Free Software Foundation, Inc.
   
   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.
   
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.
   
   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.
   
   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */


/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     NUM = 258,
     SIGNEDNUM = 259,
     REAL = 260,
     SIGNEDREAL = 261,
     TEXT = 262,
     IDF = 263,
     TYPE_NUM = 264,
     TYPE_REAL = 265,
     TYPE_TEXT = 266,
     TYPE_SIGNEDNUM = 267,
     TYPE_SIGNEDREAL = 268,
     type_variable = 269,
     SI = 270,
     ALORS = 271,
     SINON = 272,
     TANTQUE = 273,
     FAIRE = 274,
     DEBUT = 275,
     FIN = 276,
     EXECUTION = 277,
     FIXE = 278,
     AFFICHE = 279,
     LIRE = 280,
     ACCOLADE_OUVRANTE = 281,
     ACCOLADE_FERMANTE = 282,
     PARENTHOISE_OUVRANTE = 283,
     PARENTHOISE_FERMANTE = 284,
     CROCHET_OUVRANT = 285,
     CROCHET_FERMANT = 286,
     PLUS = 287,
     MOINS = 288,
     MULT = 289,
     DIV = 290,
     VIRGULE = 291,
     POINT_VIRGULE = 292,
     DEUX_POINTS = 293,
     EGAL = 294,
     INF = 295,
     SUP = 296,
     DIFFERENT = 297,
     INF_EGAL = 298,
     SUP_EGAL = 299,
     AFFECTION = 300,
     OU = 301,
     ET = 302,
     NON = 303,
     ERR = 304,
     LOWER = 305
   };
#endif



#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
{

/* Line 1676 of yacc.c  */
#line 12 "syntaxique.y"

    int entier;         // pour les entiers
    double reel;        // pour les réels
    char* texte;        // pour les chaînes de caractères
    struct { int type_donnee; int taille; } tableau;  // pour les tableaux



/* Line 1676 of yacc.c  */
#line 111 "syntaxique.tab.h"
} YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
#endif

extern YYSTYPE yylval;


