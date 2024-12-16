/* A Bison parser, made by GNU Bison 3.8.2.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2021 Free Software Foundation,
   Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <https://www.gnu.org/licenses/>.  */

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

/* DO NOT RELY ON FEATURES THAT ARE NOT DOCUMENTED in the manual,
   especially those whose name start with YY_ or yy_.  They are
   private implementation details that can be changed or removed.  */

#ifndef YY_YY_SYNTAXIQUE_TAB_H_INCLUDED
# define YY_YY_SYNTAXIQUE_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token kinds.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    YYEMPTY = -2,
    YYEOF = 0,                     /* "end of file"  */
    YYerror = 256,                 /* error  */
    YYUNDEF = 257,                 /* "invalid token"  */
    NUM = 258,                     /* NUM  */
    REAL = 259,                    /* REAL  */
    TEXT = 260,                    /* TEXT  */
    IDF = 261,                     /* IDF  */
    SI = 262,                      /* SI  */
    ALORS = 263,                   /* ALORS  */
    SINON = 264,                   /* SINON  */
    TANTQUE = 265,                 /* TANTQUE  */
    FAIRE = 266,                   /* FAIRE  */
    DEBUT = 267,                   /* DEBUT  */
    FIN = 268,                     /* FIN  */
    EXECUTION = 269,               /* EXECUTION  */
    FIXE = 270,                    /* FIXE  */
    AFFICHE = 271,                 /* AFFICHE  */
    LIRE = 272,                    /* LIRE  */
    ACCOLADE_OUVRANTE = 273,       /* ACCOLADE_OUVRANTE  */
    ACCOLADE_FERMANTE = 274,       /* ACCOLADE_FERMANTE  */
    PARENTHOISE_OUVRANTE = 275,    /* PARENTHOISE_OUVRANTE  */
    PARENTHOISE_FERMANTE = 276,    /* PARENTHOISE_FERMANTE  */
    PLUS = 277,                    /* PLUS  */
    MOINS = 278,                   /* MOINS  */
    MULT = 279,                    /* MULT  */
    DIV = 280,                     /* DIV  */
    VIRGULE = 281,                 /* VIRGULE  */
    POINT_VIRGULE = 282,           /* POINT_VIRGULE  */
    DEUX_POINTS = 283,             /* DEUX_POINTS  */
    EGAL = 284,                    /* EGAL  */
    INF = 285,                     /* INF  */
    SUP = 286,                     /* SUP  */
    DIFFERENT = 287,               /* DIFFERENT  */
    INF_EGAL = 288,                /* INF_EGAL  */
    SUP_EGAL = 289,                /* SUP_EGAL  */
    AFFECTION = 290,               /* AFFECTION  */
    OU = 291,                      /* OU  */
    ET = 292,                      /* ET  */
    NON = 293,                     /* NON  */
    ERR = 294                      /* ERR  */
  };
  typedef enum yytokentype yytoken_kind_t;
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 15 "syntaxique.y"

    int entier;
    double reel;
    char* texte;

#line 109 "syntaxique.tab.h"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;


int yyparse (void);


#endif /* !YY_YY_SYNTAXIQUE_TAB_H_INCLUDED  */
