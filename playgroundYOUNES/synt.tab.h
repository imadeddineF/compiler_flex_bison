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

#ifndef YY_YY_SYNT_TAB_H_INCLUDED
# define YY_YY_SYNT_TAB_H_INCLUDED
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
    DEBUT = 264,                   /* DEBUT  */
    FIN = 265,                     /* FIN  */
    EXECUTION = 266,               /* EXECUTION  */
    SI = 267,                      /* SI  */
    ALORS = 268,                   /* ALORS  */
    SINON = 269,                   /* SINON  */
    TANTQUE = 270,                 /* TANTQUE  */
    FAIRE = 271,                   /* FAIRE  */
    FIXE = 272,                    /* FIXE  */
    AFFICHE = 273,                 /* AFFICHE  */
    LIRE = 274,                    /* LIRE  */
    LFBRA = 275,                   /* LFBRA  */
    RTBRA = 276,                   /* RTBRA  */
    LFSQBRA = 277,                 /* LFSQBRA  */
    RTSQBRA = 278,                 /* RTSQBRA  */
    LFPar = 279,                   /* LFPar  */
    RTPar = 280,                   /* RTPar  */
    PLS = 281,                     /* PLS  */
    MINS = 282,                    /* MINS  */
    MULT = 283,                    /* MULT  */
    DIV = 284,                     /* DIV  */
    OU = 285,                      /* OU  */
    ET = 286,                      /* ET  */
    NON = 287,                     /* NON  */
    COMMA = 288,                   /* COMMA  */
    SEMICOLON = 289,               /* SEMICOLON  */
    COLON = 290,                   /* COLON  */
    AFFECT = 291,                  /* AFFECT  */
    LESS = 292,                    /* LESS  */
    LESS_EQ = 293,                 /* LESS_EQ  */
    GREATER = 294,                 /* GREATER  */
    GREATER_EQ = 295,              /* GREATER_EQ  */
    EQUAL = 296,                   /* EQUAL  */
    NOT_EQUAL = 297                /* NOT_EQUAL  */
  };
  typedef enum yytokentype yytoken_kind_t;
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 18 "synt.y"

    int entier;        // For NUM values
    double reel;       // For REAL values
    char* texte;       // For TEXT values
    int taille;        // For array sizes

#line 113 "synt.tab.h"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;


int yyparse (void);


#endif /* !YY_YY_SYNT_TAB_H_INCLUDED  */
