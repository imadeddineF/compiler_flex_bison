
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
     SI = 264,
     ALORS = 265,
     SINON = 266,
     TANTQUE = 267,
     FAIRE = 268,
     DEBUT = 269,
     FIN = 270,
     EXECUTION = 271,
     FIXE = 272,
     AFFICHE = 273,
     LIRE = 274,
     ACCOLADE_OUVRANTE = 275,
     ACCOLADE_FERMANTE = 276,
     PARENTHOISE_OUVRANTE = 277,
     PARENTHOISE_FERMANTE = 278,
     PLUS = 279,
     MOINS = 280,
     MULT = 281,
     DIV = 282,
     VIRGULE = 283,
     POINT_VIRGULE = 284,
     DEUX_POINTS = 285,
     EGAL = 286,
     INF = 287,
     SUP = 288,
     DIFFERENT = 289,
     INF_EGAL = 290,
     SUP_EGAL = 291,
     AFFECTION = 292,
     OU = 293,
     ET = 294,
     NON = 295,
     ERR = 296,
     TYPE_NUM = 297,
     TYPE_REAL = 298,
     TYPE_TEXT = 299,
     TYPE_SIGNEDNUM = 300,
     TYPE_SIGNEDREAL = 301
   };
#endif



#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
{

/* Line 1676 of yacc.c  */
#line 15 "syntaxique.y"

    int entier;
    double reel;
    char* texte;



/* Line 1676 of yacc.c  */
#line 106 "syntaxique.tab.h"
} YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
#endif

extern YYSTYPE yylval;


