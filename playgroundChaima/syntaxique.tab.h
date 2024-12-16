
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
     REAL = 259,
     TEXT = 260,
     IDF = 261,
     SI = 262,
     ALORS = 263,
     SINON = 264,
     TANTQUE = 265,
     FAIRE = 266,
     DEBUT = 267,
     FIN = 268,
     EXECUTION = 269,
     FIXE = 270,
     AFFICHE = 271,
     LIRE = 272,
     ACCOLADE_OUVRANTE = 273,
     ACCOLADE_FERMANTE = 274,
     PARENTHOISE_OUVRANTE = 275,
     PARENTHOISE_FERMANTE = 276,
     PLUS = 277,
     MOINS = 278,
     MULT = 279,
     DIV = 280,
     VIRGULE = 281,
     POINT_VIRGULE = 282,
     DEUX_POINTS = 283,
     EGAL = 284,
     INF = 285,
     SUP = 286,
     DIFFERENT = 287,
     INF_EGAL = 288,
     SUP_EGAL = 289,
     AFFECTION = 290,
     OU = 291,
     ET = 292,
     NON = 293,
     ERR = 294
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
#line 99 "syntaxique.tab.h"
} YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
#endif

extern YYSTYPE yylval;


