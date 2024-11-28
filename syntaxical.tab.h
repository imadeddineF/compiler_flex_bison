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

#ifndef YY_YY_SYNTAXICAL_TAB_H_INCLUDED
# define YY_YY_SYNTAXICAL_TAB_H_INCLUDED
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
    aff = 258,                     /* aff  */
    point = 259,                   /* point  */
    po = 260,                      /* po  */
    pf = 261,                      /* pf  */
    vg = 262,                      /* vg  */
    idf = 263,                     /* idf  */
    pvg = 264,                     /* pvg  */
    mc_then = 265,                 /* mc_then  */
    mc_if = 266,                   /* mc_if  */
    mc_else = 267,                 /* mc_else  */
    mc_program = 268,              /* mc_program  */
    mc_endif = 269,                /* mc_endif  */
    mc_character = 270,            /* mc_character  */
    mc_real = 271,                 /* mc_real  */
    mc_enddo = 272,                /* mc_enddo  */
    mc_read = 273,                 /* mc_read  */
    mc_write = 274,                /* mc_write  */
    mc_integer = 275,              /* mc_integer  */
    mc_endr = 276,                 /* mc_endr  */
    mc_routine = 277,              /* mc_routine  */
    mc_equivalence = 278,          /* mc_equivalence  */
    mc_dowhile = 279,              /* mc_dowhile  */
    mc_end = 280,                  /* mc_end  */
    mc_call = 281,                 /* mc_call  */
    mc_dimension = 282,            /* mc_dimension  */
    mc_logical = 283,              /* mc_logical  */
    cst_char = 284,                /* cst_char  */
    opar_plus = 285,               /* opar_plus  */
    opar_moins = 286,              /* opar_moins  */
    opar_div = 287,                /* opar_div  */
    opar_mult = 288,               /* opar_mult  */
    cst_bool = 289,                /* cst_bool  */
    cst_int = 290,                 /* cst_int  */
    cst_real = 291,                /* cst_real  */
    op_gt = 292,                   /* op_gt  */
    op_lt = 293,                   /* op_lt  */
    op_eq = 294,                   /* op_eq  */
    op_ge = 295,                   /* op_ge  */
    op_le = 296,                   /* op_le  */
    op_and = 297,                  /* op_and  */
    op_or = 298,                   /* op_or  */
    op_ne = 299                    /* op_ne  */
  };
  typedef enum yytokentype yytoken_kind_t;
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 23 "syntaxical.y"
 
   int entier; 
   float reel;
   char* str;
   struct 
   {
       char *type;
   }exp;

#line 118 "syntaxical.tab.h"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;


int yyparse (void);


#endif /* !YY_YY_SYNTAXICAL_TAB_H_INCLUDED  */
