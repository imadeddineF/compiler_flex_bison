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

#ifndef YY_YY_OUT_SYNTAXIQUE_TAB_H_INCLUDED
# define YY_YY_OUT_SYNTAXIQUE_TAB_H_INCLUDED
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
    SIGNEDNUM = 259,               /* SIGNEDNUM  */
    REAL = 260,                    /* REAL  */
    SIGNEDREAL = 261,              /* SIGNEDREAL  */
    TEXT = 262,                    /* TEXT  */
    IDF = 263,                     /* IDF  */
    SI = 264,                      /* SI  */
    ALORS = 265,                   /* ALORS  */
    SINON = 266,                   /* SINON  */
    TANTQUE = 267,                 /* TANTQUE  */
    FAIRE = 268,                   /* FAIRE  */
    DEBUT = 269,                   /* DEBUT  */
    FIN = 270,                     /* FIN  */
    EXECUTION = 271,               /* EXECUTION  */
    FIXE = 272,                    /* FIXE  */
    AFFICHE = 273,                 /* AFFICHE  */
    LIRE = 274,                    /* LIRE  */
    ACCOLADE_OUVRANTE = 275,       /* ACCOLADE_OUVRANTE  */
    ACCOLADE_FERMANTE = 276,       /* ACCOLADE_FERMANTE  */
    PARENTHOISE_OUVRANTE = 277,    /* PARENTHOISE_OUVRANTE  */
    PARENTHOISE_FERMANTE = 278,    /* PARENTHOISE_FERMANTE  */
    CROCHET_OUVRANT = 279,         /* CROCHET_OUVRANT  */
    CROCHET_FERMANT = 280,         /* CROCHET_FERMANT  */
    PLUS = 281,                    /* PLUS  */
    MOINS = 282,                   /* MOINS  */
    MULT = 283,                    /* MULT  */
    DIV = 284,                     /* DIV  */
    VIRGULE = 285,                 /* VIRGULE  */
    POINT_VIRGULE = 286,           /* POINT_VIRGULE  */
    DEUX_POINTS = 287,             /* DEUX_POINTS  */
    EGAL = 288,                    /* EGAL  */
    INF = 289,                     /* INF  */
    SUP = 290,                     /* SUP  */
    DIFFERENT = 291,               /* DIFFERENT  */
    INF_EGAL = 292,                /* INF_EGAL  */
    SUP_EGAL = 293,                /* SUP_EGAL  */
    AFFECTION = 294,               /* AFFECTION  */
    OU = 295,                      /* OU  */
    ET = 296,                      /* ET  */
    NON = 297,                     /* NON  */
    ERR = 298,                     /* ERR  */
    TYPE_NUM = 299,                /* TYPE_NUM  */
    TYPE_REAL = 300,               /* TYPE_REAL  */
    TYPE_TEXT = 301,               /* TYPE_TEXT  */
    TYPE_SIGNEDNUM = 302,          /* TYPE_SIGNEDNUM  */
    TYPE_SIGNEDREAL = 303          /* TYPE_SIGNEDREAL  */
  };
  typedef enum yytokentype yytoken_kind_t;
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 25 "src/syntaxique.y"

    int entier;
    double reel;
    char* texte;

#line 118 "out/syntaxique.tab.h"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;


int yyparse (void);


#endif /* !YY_YY_OUT_SYNTAXIQUE_TAB_H_INCLUDED  */
