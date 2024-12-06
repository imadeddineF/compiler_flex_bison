/* A Bison parser, made by GNU Bison 3.8.2.  */

/* Bison implementation for Yacc-like parsers in C

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

/* C LALR(1) parser skeleton written by Richard Stallman, by
   simplifying the original so-called "semantic" parser.  */

/* DO NOT RELY ON FEATURES THAT ARE NOT DOCUMENTED in the manual,
   especially those whose name start with YY_ or yy_.  They are
   private implementation details that can be changed or removed.  */

/* All symbols defined below should begin with yy or YY, to avoid
   infringing on user name space.  This should be done even for local
   variables, as they might otherwise be expanded by user macros.
   There are some unavoidable exceptions within include files to
   define necessary library symbols; they are noted "INFRINGES ON
   USER NAME SPACE" below.  */

/* Identify Bison output, and Bison version.  */
#define YYBISON 30802

/* Bison version string.  */
#define YYBISON_VERSION "3.8.2"

/* Skeleton name.  */
#define YYSKELETON_NAME "yacc.c"

/* Pure parsers.  */
#define YYPURE 0

/* Push parsers.  */
#define YYPUSH 0

/* Pull parsers.  */
#define YYPULL 1




/* First part of user prologue.  */
#line 1 "syntaxical.y"

  #include <string.h>
  #include <stdio.h>
  #include <stdlib.h>
  // #include "quads.h"
  void erreurdd(char* idf);
  void erreur_dim(char* idf);
  int getDimension(char entite[], char scope[]);
  void erreurnondec(char* idf);
  char *incomp_type(char* type1, char* type2);
  char *type_idf(char entite[], char scope[]);
  int nb_ligne = 1;
  int nb_colonne = 1;
  extern char currentScope[10];
  extern char typeidf[10];
  char arr[100];

#line 89 "syntaxical.tab.c"

# ifndef YY_CAST
#  ifdef __cplusplus
#   define YY_CAST(Type, Val) static_cast<Type> (Val)
#   define YY_REINTERPRET_CAST(Type, Val) reinterpret_cast<Type> (Val)
#  else
#   define YY_CAST(Type, Val) ((Type) (Val))
#   define YY_REINTERPRET_CAST(Type, Val) ((Type) (Val))
#  endif
# endif
# ifndef YY_NULLPTR
#  if defined __cplusplus
#   if 201103L <= __cplusplus
#    define YY_NULLPTR nullptr
#   else
#    define YY_NULLPTR 0
#   endif
#  else
#   define YY_NULLPTR ((void*)0)
#  endif
# endif

#include "syntaxical.tab.h"
/* Symbol kind.  */
enum yysymbol_kind_t
{
  YYSYMBOL_YYEMPTY = -2,
  YYSYMBOL_YYEOF = 0,                      /* "end of file"  */
  YYSYMBOL_YYerror = 1,                    /* error  */
  YYSYMBOL_YYUNDEF = 2,                    /* "invalid token"  */
  YYSYMBOL_aff = 3,                        /* aff  */
  YYSYMBOL_point = 4,                      /* point  */
  YYSYMBOL_po = 5,                         /* po  */
  YYSYMBOL_pf = 6,                         /* pf  */
  YYSYMBOL_vg = 7,                         /* vg  */
  YYSYMBOL_idf = 8,                        /* idf  */
  YYSYMBOL_pvg = 9,                        /* pvg  */
  YYSYMBOL_mc_then = 10,                   /* mc_then  */
  YYSYMBOL_mc_if = 11,                     /* mc_if  */
  YYSYMBOL_mc_else = 12,                   /* mc_else  */
  YYSYMBOL_mc_program = 13,                /* mc_program  */
  YYSYMBOL_mc_endif = 14,                  /* mc_endif  */
  YYSYMBOL_mc_character = 15,              /* mc_character  */
  YYSYMBOL_mc_real = 16,                   /* mc_real  */
  YYSYMBOL_mc_enddo = 17,                  /* mc_enddo  */
  YYSYMBOL_mc_read = 18,                   /* mc_read  */
  YYSYMBOL_mc_write = 19,                  /* mc_write  */
  YYSYMBOL_mc_integer = 20,                /* mc_integer  */
  YYSYMBOL_mc_endr = 21,                   /* mc_endr  */
  YYSYMBOL_mc_routine = 22,                /* mc_routine  */
  YYSYMBOL_mc_equivalence = 23,            /* mc_equivalence  */
  YYSYMBOL_mc_dowhile = 24,                /* mc_dowhile  */
  YYSYMBOL_mc_end = 25,                    /* mc_end  */
  YYSYMBOL_mc_call = 26,                   /* mc_call  */
  YYSYMBOL_mc_dimension = 27,              /* mc_dimension  */
  YYSYMBOL_mc_logical = 28,                /* mc_logical  */
  YYSYMBOL_cst_char = 29,                  /* cst_char  */
  YYSYMBOL_opar_plus = 30,                 /* opar_plus  */
  YYSYMBOL_opar_moins = 31,                /* opar_moins  */
  YYSYMBOL_opar_div = 32,                  /* opar_div  */
  YYSYMBOL_opar_mult = 33,                 /* opar_mult  */
  YYSYMBOL_cst_bool = 34,                  /* cst_bool  */
  YYSYMBOL_cst_int = 35,                   /* cst_int  */
  YYSYMBOL_cst_real = 36,                  /* cst_real  */
  YYSYMBOL_op_gt = 37,                     /* op_gt  */
  YYSYMBOL_op_lt = 38,                     /* op_lt  */
  YYSYMBOL_op_eq = 39,                     /* op_eq  */
  YYSYMBOL_op_ge = 40,                     /* op_ge  */
  YYSYMBOL_op_le = 41,                     /* op_le  */
  YYSYMBOL_op_and = 42,                    /* op_and  */
  YYSYMBOL_op_or = 43,                     /* op_or  */
  YYSYMBOL_op_ne = 44,                     /* op_ne  */
  YYSYMBOL_YYACCEPT = 45,                  /* $accept  */
  YYSYMBOL_PROG = 46,                      /* PROG  */
  YYSYMBOL_47_1 = 47,                      /* $@1  */
  YYSYMBOL_PP = 48,                        /* PP  */
  YYSYMBOL_49_2 = 49,                      /* $@2  */
  YYSYMBOL_CORP_PROGRAM = 50,              /* CORP_PROGRAM  */
  YYSYMBOL_ROUTINE = 51,                   /* ROUTINE  */
  YYSYMBOL_52_3 = 52,                      /* $@3  */
  YYSYMBOL_CORP_FONCTION = 53,             /* CORP_FONCTION  */
  YYSYMBOL_RETURN = 54,                    /* RETURN  */
  YYSYMBOL_OPAR = 55,                      /* OPAR  */
  YYSYMBOL_TYPE = 56,                      /* TYPE  */
  YYSYMBOL_LIST_PARAMETRE_RT = 57,         /* LIST_PARAMETRE_RT  */
  YYSYMBOL_DECIDF = 58,                    /* DECIDF  */
  YYSYMBOL_TYPEDEC = 59,                   /* TYPEDEC  */
  YYSYMBOL_LIST_DEC = 60,                  /* LIST_DEC  */
  YYSYMBOL_DECLARATION = 61,               /* DECLARATION  */
  YYSYMBOL_AFFECT = 62,                    /* AFFECT  */
  YYSYMBOL_EXPRESSION = 63,                /* EXPRESSION  */
  YYSYMBOL_CALL = 64,                      /* CALL  */
  YYSYMBOL_READ = 65,                      /* READ  */
  YYSYMBOL_WRITE = 66,                     /* WRITE  */
  YYSYMBOL_WRITE_ARGS = 67,                /* WRITE_ARGS  */
  YYSYMBOL_CONDITION = 68,                 /* CONDITION  */
  YYSYMBOL_exp_cnd = 69,                   /* exp_cnd  */
  YYSYMBOL_LALR = 70,                      /* LALR  */
  YYSYMBOL_INSTRUCTION = 71,               /* INSTRUCTION  */
  YYSYMBOL_LIST_INSTRUCTION = 72,          /* LIST_INSTRUCTION  */
  YYSYMBOL_BOUCLE = 73,                    /* BOUCLE  */
  YYSYMBOL_LIST_PARAMETRE_EQ = 74,         /* LIST_PARAMETRE_EQ  */
  YYSYMBOL_EQ = 75,                        /* EQ  */
  YYSYMBOL_CST = 76,                       /* CST  */
  YYSYMBOL_OPLOG = 77,                     /* OPLOG  */
  YYSYMBOL_OPCOMP = 78                     /* OPCOMP  */
};
typedef enum yysymbol_kind_t yysymbol_kind_t;




#ifdef short
# undef short
#endif

/* On compilers that do not define __PTRDIFF_MAX__ etc., make sure
   <limits.h> and (if available) <stdint.h> are included
   so that the code can choose integer types of a good width.  */

#ifndef __PTRDIFF_MAX__
# include <limits.h> /* INFRINGES ON USER NAME SPACE */
# if defined __STDC_VERSION__ && 199901 <= __STDC_VERSION__
#  include <stdint.h> /* INFRINGES ON USER NAME SPACE */
#  define YY_STDINT_H
# endif
#endif

/* Narrow types that promote to a signed type and that can represent a
   signed or unsigned integer of at least N bits.  In tables they can
   save space and decrease cache pressure.  Promoting to a signed type
   helps avoid bugs in integer arithmetic.  */

#ifdef __INT_LEAST8_MAX__
typedef __INT_LEAST8_TYPE__ yytype_int8;
#elif defined YY_STDINT_H
typedef int_least8_t yytype_int8;
#else
typedef signed char yytype_int8;
#endif

#ifdef __INT_LEAST16_MAX__
typedef __INT_LEAST16_TYPE__ yytype_int16;
#elif defined YY_STDINT_H
typedef int_least16_t yytype_int16;
#else
typedef short yytype_int16;
#endif

/* Work around bug in HP-UX 11.23, which defines these macros
   incorrectly for preprocessor constants.  This workaround can likely
   be removed in 2023, as HPE has promised support for HP-UX 11.23
   (aka HP-UX 11i v2) only through the end of 2022; see Table 2 of
   <https://h20195.www2.hpe.com/V2/getpdf.aspx/4AA4-7673ENW.pdf>.  */
#ifdef __hpux
# undef UINT_LEAST8_MAX
# undef UINT_LEAST16_MAX
# define UINT_LEAST8_MAX 255
# define UINT_LEAST16_MAX 65535
#endif

#if defined __UINT_LEAST8_MAX__ && __UINT_LEAST8_MAX__ <= __INT_MAX__
typedef __UINT_LEAST8_TYPE__ yytype_uint8;
#elif (!defined __UINT_LEAST8_MAX__ && defined YY_STDINT_H \
       && UINT_LEAST8_MAX <= INT_MAX)
typedef uint_least8_t yytype_uint8;
#elif !defined __UINT_LEAST8_MAX__ && UCHAR_MAX <= INT_MAX
typedef unsigned char yytype_uint8;
#else
typedef short yytype_uint8;
#endif

#if defined __UINT_LEAST16_MAX__ && __UINT_LEAST16_MAX__ <= __INT_MAX__
typedef __UINT_LEAST16_TYPE__ yytype_uint16;
#elif (!defined __UINT_LEAST16_MAX__ && defined YY_STDINT_H \
       && UINT_LEAST16_MAX <= INT_MAX)
typedef uint_least16_t yytype_uint16;
#elif !defined __UINT_LEAST16_MAX__ && USHRT_MAX <= INT_MAX
typedef unsigned short yytype_uint16;
#else
typedef int yytype_uint16;
#endif

#ifndef YYPTRDIFF_T
# if defined __PTRDIFF_TYPE__ && defined __PTRDIFF_MAX__
#  define YYPTRDIFF_T __PTRDIFF_TYPE__
#  define YYPTRDIFF_MAXIMUM __PTRDIFF_MAX__
# elif defined PTRDIFF_MAX
#  ifndef ptrdiff_t
#   include <stddef.h> /* INFRINGES ON USER NAME SPACE */
#  endif
#  define YYPTRDIFF_T ptrdiff_t
#  define YYPTRDIFF_MAXIMUM PTRDIFF_MAX
# else
#  define YYPTRDIFF_T long
#  define YYPTRDIFF_MAXIMUM LONG_MAX
# endif
#endif

#ifndef YYSIZE_T
# ifdef __SIZE_TYPE__
#  define YYSIZE_T __SIZE_TYPE__
# elif defined size_t
#  define YYSIZE_T size_t
# elif defined __STDC_VERSION__ && 199901 <= __STDC_VERSION__
#  include <stddef.h> /* INFRINGES ON USER NAME SPACE */
#  define YYSIZE_T size_t
# else
#  define YYSIZE_T unsigned
# endif
#endif

#define YYSIZE_MAXIMUM                                  \
  YY_CAST (YYPTRDIFF_T,                                 \
           (YYPTRDIFF_MAXIMUM < YY_CAST (YYSIZE_T, -1)  \
            ? YYPTRDIFF_MAXIMUM                         \
            : YY_CAST (YYSIZE_T, -1)))

#define YYSIZEOF(X) YY_CAST (YYPTRDIFF_T, sizeof (X))


/* Stored state numbers (used for stacks). */
typedef yytype_uint8 yy_state_t;

/* State numbers in computations.  */
typedef int yy_state_fast_t;

#ifndef YY_
# if defined YYENABLE_NLS && YYENABLE_NLS
#  if ENABLE_NLS
#   include <libintl.h> /* INFRINGES ON USER NAME SPACE */
#   define YY_(Msgid) dgettext ("bison-runtime", Msgid)
#  endif
# endif
# ifndef YY_
#  define YY_(Msgid) Msgid
# endif
#endif


#ifndef YY_ATTRIBUTE_PURE
# if defined __GNUC__ && 2 < __GNUC__ + (96 <= __GNUC_MINOR__)
#  define YY_ATTRIBUTE_PURE __attribute__ ((__pure__))
# else
#  define YY_ATTRIBUTE_PURE
# endif
#endif

#ifndef YY_ATTRIBUTE_UNUSED
# if defined __GNUC__ && 2 < __GNUC__ + (7 <= __GNUC_MINOR__)
#  define YY_ATTRIBUTE_UNUSED __attribute__ ((__unused__))
# else
#  define YY_ATTRIBUTE_UNUSED
# endif
#endif

/* Suppress unused-variable warnings by "using" E.  */
#if ! defined lint || defined __GNUC__
# define YY_USE(E) ((void) (E))
#else
# define YY_USE(E) /* empty */
#endif

/* Suppress an incorrect diagnostic about yylval being uninitialized.  */
#if defined __GNUC__ && ! defined __ICC && 406 <= __GNUC__ * 100 + __GNUC_MINOR__
# if __GNUC__ * 100 + __GNUC_MINOR__ < 407
#  define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN                           \
    _Pragma ("GCC diagnostic push")                                     \
    _Pragma ("GCC diagnostic ignored \"-Wuninitialized\"")
# else
#  define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN                           \
    _Pragma ("GCC diagnostic push")                                     \
    _Pragma ("GCC diagnostic ignored \"-Wuninitialized\"")              \
    _Pragma ("GCC diagnostic ignored \"-Wmaybe-uninitialized\"")
# endif
# define YY_IGNORE_MAYBE_UNINITIALIZED_END      \
    _Pragma ("GCC diagnostic pop")
#else
# define YY_INITIAL_VALUE(Value) Value
#endif
#ifndef YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
# define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
# define YY_IGNORE_MAYBE_UNINITIALIZED_END
#endif
#ifndef YY_INITIAL_VALUE
# define YY_INITIAL_VALUE(Value) /* Nothing. */
#endif

#if defined __cplusplus && defined __GNUC__ && ! defined __ICC && 6 <= __GNUC__
# define YY_IGNORE_USELESS_CAST_BEGIN                          \
    _Pragma ("GCC diagnostic push")                            \
    _Pragma ("GCC diagnostic ignored \"-Wuseless-cast\"")
# define YY_IGNORE_USELESS_CAST_END            \
    _Pragma ("GCC diagnostic pop")
#endif
#ifndef YY_IGNORE_USELESS_CAST_BEGIN
# define YY_IGNORE_USELESS_CAST_BEGIN
# define YY_IGNORE_USELESS_CAST_END
#endif


#define YY_ASSERT(E) ((void) (0 && (E)))

#if !defined yyoverflow

/* The parser invokes alloca or malloc; define the necessary symbols.  */

# ifdef YYSTACK_USE_ALLOCA
#  if YYSTACK_USE_ALLOCA
#   ifdef __GNUC__
#    define YYSTACK_ALLOC __builtin_alloca
#   elif defined __BUILTIN_VA_ARG_INCR
#    include <alloca.h> /* INFRINGES ON USER NAME SPACE */
#   elif defined _AIX
#    define YYSTACK_ALLOC __alloca
#   elif defined _MSC_VER
#    include <malloc.h> /* INFRINGES ON USER NAME SPACE */
#    define alloca _alloca
#   else
#    define YYSTACK_ALLOC alloca
#    if ! defined _ALLOCA_H && ! defined EXIT_SUCCESS
#     include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
      /* Use EXIT_SUCCESS as a witness for stdlib.h.  */
#     ifndef EXIT_SUCCESS
#      define EXIT_SUCCESS 0
#     endif
#    endif
#   endif
#  endif
# endif

# ifdef YYSTACK_ALLOC
   /* Pacify GCC's 'empty if-body' warning.  */
#  define YYSTACK_FREE(Ptr) do { /* empty */; } while (0)
#  ifndef YYSTACK_ALLOC_MAXIMUM
    /* The OS might guarantee only one guard page at the bottom of the stack,
       and a page size can be as small as 4096 bytes.  So we cannot safely
       invoke alloca (N) if N exceeds 4096.  Use a slightly smaller number
       to allow for a few compiler-allocated temporary stack slots.  */
#   define YYSTACK_ALLOC_MAXIMUM 4032 /* reasonable circa 2006 */
#  endif
# else
#  define YYSTACK_ALLOC YYMALLOC
#  define YYSTACK_FREE YYFREE
#  ifndef YYSTACK_ALLOC_MAXIMUM
#   define YYSTACK_ALLOC_MAXIMUM YYSIZE_MAXIMUM
#  endif
#  if (defined __cplusplus && ! defined EXIT_SUCCESS \
       && ! ((defined YYMALLOC || defined malloc) \
             && (defined YYFREE || defined free)))
#   include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
#   ifndef EXIT_SUCCESS
#    define EXIT_SUCCESS 0
#   endif
#  endif
#  ifndef YYMALLOC
#   define YYMALLOC malloc
#   if ! defined malloc && ! defined EXIT_SUCCESS
void *malloc (YYSIZE_T); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
#  ifndef YYFREE
#   define YYFREE free
#   if ! defined free && ! defined EXIT_SUCCESS
void free (void *); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
# endif
#endif /* !defined yyoverflow */

#if (! defined yyoverflow \
     && (! defined __cplusplus \
         || (defined YYSTYPE_IS_TRIVIAL && YYSTYPE_IS_TRIVIAL)))

/* A type that is properly aligned for any stack member.  */
union yyalloc
{
  yy_state_t yyss_alloc;
  YYSTYPE yyvs_alloc;
};

/* The size of the maximum gap between one aligned stack and the next.  */
# define YYSTACK_GAP_MAXIMUM (YYSIZEOF (union yyalloc) - 1)

/* The size of an array large to enough to hold all stacks, each with
   N elements.  */
# define YYSTACK_BYTES(N) \
     ((N) * (YYSIZEOF (yy_state_t) + YYSIZEOF (YYSTYPE)) \
      + YYSTACK_GAP_MAXIMUM)

# define YYCOPY_NEEDED 1

/* Relocate STACK from its old location to the new one.  The
   local variables YYSIZE and YYSTACKSIZE give the old and new number of
   elements in the stack, and YYPTR gives the new location of the
   stack.  Advance YYPTR to a properly aligned location for the next
   stack.  */
# define YYSTACK_RELOCATE(Stack_alloc, Stack)                           \
    do                                                                  \
      {                                                                 \
        YYPTRDIFF_T yynewbytes;                                         \
        YYCOPY (&yyptr->Stack_alloc, Stack, yysize);                    \
        Stack = &yyptr->Stack_alloc;                                    \
        yynewbytes = yystacksize * YYSIZEOF (*Stack) + YYSTACK_GAP_MAXIMUM; \
        yyptr += yynewbytes / YYSIZEOF (*yyptr);                        \
      }                                                                 \
    while (0)

#endif

#if defined YYCOPY_NEEDED && YYCOPY_NEEDED
/* Copy COUNT objects from SRC to DST.  The source and destination do
   not overlap.  */
# ifndef YYCOPY
#  if defined __GNUC__ && 1 < __GNUC__
#   define YYCOPY(Dst, Src, Count) \
      __builtin_memcpy (Dst, Src, YY_CAST (YYSIZE_T, (Count)) * sizeof (*(Src)))
#  else
#   define YYCOPY(Dst, Src, Count)              \
      do                                        \
        {                                       \
          YYPTRDIFF_T yyi;                      \
          for (yyi = 0; yyi < (Count); yyi++)   \
            (Dst)[yyi] = (Src)[yyi];            \
        }                                       \
      while (0)
#  endif
# endif
#endif /* !YYCOPY_NEEDED */

/* YYFINAL -- State number of the termination state.  */
#define YYFINAL  6
/* YYLAST -- Last index in YYTABLE.  */
#define YYLAST   267

/* YYNTOKENS -- Number of terminals.  */
#define YYNTOKENS  45
/* YYNNTS -- Number of nonterminals.  */
#define YYNNTS  34
/* YYNRULES -- Number of rules.  */
#define YYNRULES  95
/* YYNSTATES -- Number of states.  */
#define YYNSTATES  202

/* YYMAXUTOK -- Last valid token kind.  */
#define YYMAXUTOK   299


/* YYTRANSLATE(TOKEN-NUM) -- Symbol number corresponding to TOKEN-NUM
   as returned by yylex, with out-of-bounds checking.  */
#define YYTRANSLATE(YYX)                                \
  (0 <= (YYX) && (YYX) <= YYMAXUTOK                     \
   ? YY_CAST (yysymbol_kind_t, yytranslate[YYX])        \
   : YYSYMBOL_YYUNDEF)

/* YYTRANSLATE[TOKEN-NUM] -- Symbol number corresponding to TOKEN-NUM
   as returned by yylex.  */
static const yytype_int8 yytranslate[] =
{
       0,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     1,     2,     3,     4,
       5,     6,     7,     8,     9,    10,    11,    12,    13,    14,
      15,    16,    17,    18,    19,    20,    21,    22,    23,    24,
      25,    26,    27,    28,    29,    30,    31,    32,    33,    34,
      35,    36,    37,    38,    39,    40,    41,    42,    43,    44
};

#if YYDEBUG
/* YYRLINE[YYN] -- Source line where rule number YYN was defined.  */
static const yytype_uint8 yyrline[] =
{
       0,    39,    39,    39,    39,    43,    43,    46,    49,    49,
      59,    61,    63,    64,    65,    68,    69,    70,    71,    74,
      75,    76,    77,    78,    79,    80,    83,    84,    87,    90,
      90,    93,    97,   106,   115,   121,   125,   130,   137,   138,
     142,   143,   144,   148,   152,   155,   158,   162,   163,   164,
     167,   170,   173,   176,   177,   182,   187,   190,   193,   194,
     195,   196,   199,   200,   203,   204,   205,   208,   211,   212,
     213,   214,   215,   216,   219,   220,   223,   226,   227,   228,
     229,   230,   231,   232,   235,   236,   239,   240,   243,   244,
     247,   248,   249,   250,   251,   252
};
#endif

/** Accessing symbol of state STATE.  */
#define YY_ACCESSING_SYMBOL(State) YY_CAST (yysymbol_kind_t, yystos[State])

#if YYDEBUG || 0
/* The user-facing name of the symbol whose (internal) number is
   YYSYMBOL.  No bounds checking.  */
static const char *yysymbol_name (yysymbol_kind_t yysymbol) YY_ATTRIBUTE_UNUSED;

/* YYTNAME[SYMBOL-NUM] -- String name of the symbol SYMBOL-NUM.
   First, the terminals, then, starting at YYNTOKENS, nonterminals.  */
static const char *const yytname[] =
{
  "\"end of file\"", "error", "\"invalid token\"", "aff", "point", "po",
  "pf", "vg", "idf", "pvg", "mc_then", "mc_if", "mc_else", "mc_program",
  "mc_endif", "mc_character", "mc_real", "mc_enddo", "mc_read", "mc_write",
  "mc_integer", "mc_endr", "mc_routine", "mc_equivalence", "mc_dowhile",
  "mc_end", "mc_call", "mc_dimension", "mc_logical", "cst_char",
  "opar_plus", "opar_moins", "opar_div", "opar_mult", "cst_bool",
  "cst_int", "cst_real", "op_gt", "op_lt", "op_eq", "op_ge", "op_le",
  "op_and", "op_or", "op_ne", "$accept", "PROG", "$@1", "PP", "$@2",
  "CORP_PROGRAM", "ROUTINE", "$@3", "CORP_FONCTION", "RETURN", "OPAR",
  "TYPE", "LIST_PARAMETRE_RT", "DECIDF", "TYPEDEC", "LIST_DEC",
  "DECLARATION", "AFFECT", "EXPRESSION", "CALL", "READ", "WRITE",
  "WRITE_ARGS", "CONDITION", "exp_cnd", "LALR", "INSTRUCTION",
  "LIST_INSTRUCTION", "BOUCLE", "LIST_PARAMETRE_EQ", "EQ", "CST", "OPLOG",
  "OPCOMP", YY_NULLPTR
};

static const char *
yysymbol_name (yysymbol_kind_t yysymbol)
{
  return yytname[yysymbol];
}
#endif

#define YYPACT_NINF (-112)

#define yypact_value_is_default(Yyn) \
  ((Yyn) == YYPACT_NINF)

#define YYTABLE_NINF (-36)

#define yytable_value_is_error(Yyn) \
  0

/* YYPACT[STATE-NUM] -- Index in YYTABLE of the portion describing
   STATE-NUM.  */
static const yytype_int16 yypact[] =
{
      -3,    -2,    22,   136,  -112,  -112,  -112,  -112,  -112,  -112,
    -112,    -3,    36,   136,  -112,    17,  -112,    20,    84,  -112,
    -112,    -7,  -112,   104,   136,   142,    95,   114,   102,    20,
    -112,    45,   149,   153,   158,   175,   176,  -112,   178,   185,
     186,  -112,  -112,  -112,   196,    -5,   173,  -112,  -112,     3,
      26,     7,   201,     6,    74,    52,  -112,  -112,  -112,  -112,
    -112,  -112,  -112,    66,  -112,    78,     3,  -112,   209,  -112,
    -112,   113,  -112,  -112,   172,    52,   212,    64,    49,  -112,
     227,  -112,  -112,   184,  -112,   194,  -112,   110,   136,    99,
    -112,   206,    71,   237,    26,  -112,  -112,    11,  -112,    16,
     241,    26,    59,   123,   235,   199,   129,   236,  -112,  -112,
      51,   240,   112,  -112,  -112,  -112,   243,  -112,   244,  -112,
      -5,   197,     3,  -112,  -112,  -112,  -112,     3,  -112,  -112,
    -112,     3,   245,  -112,  -112,  -112,  -112,  -112,  -112,  -112,
    -112,   248,  -112,  -112,   249,  -112,  -112,  -112,   250,   251,
    -112,   151,   211,    26,  -112,   208,  -112,    26,    93,   100,
     113,   246,   165,     3,   252,   174,    74,    26,  -112,   152,
     233,   217,  -112,   253,  -112,  -112,     3,  -112,   113,    52,
    -112,  -112,   221,   225,     3,  -112,  -112,    26,  -112,   113,
     188,   202,  -112,  -112,    26,   108,   254,  -112,  -112,   255,
    -112,  -112
};

/* YYDEFACT[STATE-NUM] -- Default reduction number in state STATE-NUM.
   Performed when YYTABLE does not specify something else to do.  Zero
   means the default is an error.  */
static const yytype_int8 yydefact[] =
{
       2,     0,     0,     0,     4,     5,     1,    18,    16,    15,
      17,     2,     0,    30,     3,     0,     6,     0,     0,    75,
       8,    31,    28,    26,    30,     0,     0,     0,     0,     0,
      29,     0,     0,     0,     0,     0,     0,     7,     0,     0,
       0,    71,    74,    72,     0,    25,     0,    34,    27,     0,
       0,     0,     0,     0,    83,     0,    68,    70,    69,    73,
      19,    86,    87,     0,    21,     0,     0,    39,     0,    40,
      41,    35,    48,    38,     0,     0,    41,     0,     0,    66,
       0,    59,    58,     0,    77,     0,    79,     0,    30,     0,
      32,     0,     0,     0,     0,    12,    13,     0,    14,     0,
       0,     0,     0,     0,     0,     0,     0,     0,    56,    57,
       0,    85,     0,    75,     9,    75,    20,    22,     0,    47,
      25,     0,     0,    43,    50,    46,    45,     0,    42,    49,
      44,     0,     0,    67,    75,    90,    91,    92,    93,    94,
      95,     0,    88,    89,     0,    75,    61,    60,     0,    78,
      80,     0,     0,     0,    33,     0,    51,     0,     0,     0,
      36,     0,     0,     0,     0,     0,    83,     0,    76,     0,
       0,     0,    55,     0,    54,    53,     0,    75,    64,     0,
      65,    75,     0,     0,     0,    10,    23,     0,    52,    37,
       0,     0,    84,    81,     0,    11,     0,    63,    62,     0,
      24,    82
};

/* YYPGOTO[NTERM-NUM].  */
static const yytype_int16 yypgoto[] =
{
    -112,   247,  -112,  -112,  -112,  -112,  -112,  -112,  -112,  -112,
    -112,   259,   143,   238,  -112,   -17,  -112,  -112,   -48,  -112,
    -112,  -112,  -112,  -112,   -38,   101,  -112,  -111,  -112,    98,
    -112,   -45,  -112,  -112
};

/* YYDEFGOTO[NTERM-NUM].  */
static const yytype_uint8 yydefgoto[] =
{
       0,     2,     3,     4,    13,    16,    11,    26,   114,   170,
      99,    17,    63,    22,    18,    19,    23,    38,    77,    72,
      39,    40,    83,    41,   103,    79,    42,    25,    43,    85,
      44,    73,   144,   141
};

/* YYTABLE[YYPACT[STATE-NUM]] -- What to do in state STATE-NUM.  If
   positive, shift that token.  If negative, reduce the rule whose
   number is the opposite.  If YYTABLE_NINF, syntax error.  */
static const yytype_int16 yytable[] =
{
      64,    71,   151,    60,   152,    74,     5,    30,    66,    86,
       1,    67,    75,    78,    81,    67,   122,    87,    92,   123,
      27,   127,     6,   162,   128,    20,    28,   102,    21,    68,
      61,    62,    69,    68,   165,    82,    69,    70,    61,    62,
     124,    76,    61,    62,   117,   129,   125,   126,    49,   121,
      50,    61,    62,   106,   130,   107,   132,    75,    15,   146,
      67,    61,    62,   105,    94,   119,   190,   150,   105,    94,
     191,   115,    88,    89,   158,    64,    94,   119,    68,   159,
     147,    69,    84,   160,    90,    91,    70,    61,    62,    95,
      96,    97,    98,    24,    95,    96,    97,    98,    94,   174,
      45,    95,    96,    97,    98,    94,   175,   116,   171,    61,
      62,    29,   173,    94,   106,   178,   113,   -35,    94,    46,
     149,    86,   183,    95,    96,    97,    98,   106,   189,   133,
      95,    96,    97,    98,    61,    62,   195,    47,    95,    96,
      97,    98,   196,    95,    96,    97,    98,    61,    62,   199,
      31,     7,     8,    32,    51,   184,     9,    50,    52,    31,
      33,    34,    32,    53,    10,    35,    36,    37,   168,    33,
      34,   142,   143,    31,    35,    36,    32,   177,   100,   101,
      54,    55,    31,    33,    34,    32,   181,    56,    35,    36,
     109,   110,    33,    34,    57,    58,    31,    35,    36,    32,
     111,   112,   197,   156,   157,    59,    33,    34,    65,    80,
      31,    35,    36,    32,   172,    89,   198,    93,   104,   169,
      33,    34,    32,   186,   187,    35,    36,   192,   112,    33,
      34,   193,   194,   108,    35,    36,   135,   136,   137,   138,
     139,   118,   120,   140,   131,   134,   145,   148,   153,   176,
     154,   161,   163,   164,   185,   166,   167,   179,    14,   188,
     200,   201,    12,   155,   182,   180,     0,    48
};

static const yytype_int16 yycheck[] =
{
      45,    49,   113,     8,   115,    50,     8,    24,     5,    54,
      13,     8,     5,    51,     8,     8,     5,    55,    66,     8,
      27,     5,     0,   134,     8,     8,    33,    75,     8,    26,
      35,    36,    29,    26,   145,    29,    29,    34,    35,    36,
      29,    34,    35,    36,    89,    29,    35,    36,     3,    94,
       5,    35,    36,     4,    99,     6,   101,     5,    22,     8,
       8,    35,    36,     4,     5,     6,   177,   112,     4,     5,
     181,    88,     6,     7,   122,   120,     5,     6,    26,   127,
      29,    29,     8,   131,     6,     7,    34,    35,    36,    30,
      31,    32,    33,     9,    30,    31,    32,    33,     5,     6,
       5,    30,    31,    32,    33,     5,     6,     8,   153,    35,
      36,     7,   157,     5,     4,   163,     6,     9,     5,     5,
       8,   166,   167,    30,    31,    32,    33,     4,   176,     6,
      30,    31,    32,    33,    35,    36,   184,    35,    30,    31,
      32,    33,   187,    30,    31,    32,    33,    35,    36,   194,
       8,    15,    16,    11,     5,     3,    20,     5,     5,     8,
      18,    19,    11,     5,    28,    23,    24,    25,    17,    18,
      19,    42,    43,     8,    23,    24,    11,    12,     6,     7,
       5,     5,     8,    18,    19,    11,    12,     9,    23,    24,
       6,     7,    18,    19,     9,     9,     8,    23,    24,    11,
       6,     7,    14,     6,     7,     9,    18,    19,    35,     8,
       8,    23,    24,    11,     6,     7,    14,     8,     6,     8,
      18,    19,    11,     6,     7,    23,    24,     6,     7,    18,
      19,     6,     7,     6,    23,    24,    37,    38,    39,    40,
      41,    35,     5,    44,     3,    10,    10,     7,     5,     3,
       6,     6,     4,     4,    21,     5,     5,     5,    11,     6,
       6,     6,     3,   120,   166,   164,    -1,    29
};

/* YYSTOS[STATE-NUM] -- The symbol kind of the accessing symbol of
   state STATE-NUM.  */
static const yytype_int8 yystos[] =
{
       0,    13,    46,    47,    48,     8,     0,    15,    16,    20,
      28,    51,    56,    49,    46,    22,    50,    56,    59,    60,
       8,     8,    58,    61,     9,    72,    52,    27,    33,     7,
      60,     8,    11,    18,    19,    23,    24,    25,    62,    65,
      66,    68,    71,    73,    75,     5,     5,    35,    58,     3,
       5,     5,     5,     5,     5,     5,     9,     9,     9,     9,
       8,    35,    36,    57,    76,    35,     5,     8,    26,    29,
      34,    63,    64,    76,    76,     5,    34,    63,    69,    70,
       8,     8,    29,    67,     8,    74,    76,    69,     6,     7,
       6,     7,    63,     8,     5,    30,    31,    32,    33,    55,
       6,     7,    63,    69,     6,     4,     4,     6,     6,     6,
       7,     6,     7,     6,    53,    60,     8,    76,    35,     6,
       5,    76,     5,     8,    29,    35,    36,     5,     8,    29,
      76,     3,    76,     6,    10,    37,    38,    39,    40,    41,
      44,    78,    42,    43,    77,    10,     8,    29,     7,     8,
      76,    72,    72,     5,     6,    57,     6,     7,    63,    63,
      63,     6,    72,     4,     4,    72,     5,     5,    17,     8,
      54,    76,     6,    76,     6,     6,     3,    12,    63,     5,
      70,    12,    74,    76,     3,    21,     6,     7,     6,    63,
      72,    72,     6,     6,     7,    63,    76,    14,    14,    76,
       6,     6
};

/* YYR1[RULE-NUM] -- Symbol kind of the left-hand side of rule RULE-NUM.  */
static const yytype_int8 yyr1[] =
{
       0,    45,    47,    46,    46,    49,    48,    50,    52,    51,
      53,    54,    55,    55,    55,    56,    56,    56,    56,    57,
      57,    57,    57,    57,    57,    57,    58,    58,    59,    60,
      60,    61,    61,    61,    61,    62,    62,    62,    63,    63,
      63,    63,    63,    63,    63,    63,    63,    63,    63,    63,
      63,    63,    63,    63,    63,    64,    65,    66,    67,    67,
      67,    67,    68,    68,    69,    69,    69,    70,    71,    71,
      71,    71,    71,    71,    72,    72,    73,    74,    74,    74,
      74,    74,    74,    74,    75,    75,    76,    76,    77,    77,
      78,    78,    78,    78,    78,    78
};

/* YYR2[RULE-NUM] -- Number of symbols on the right-hand side of rule RULE-NUM.  */
static const yytype_int8 yyr2[] =
{
       0,     2,     0,     3,     1,     0,     4,     3,     0,     8,
       4,     3,     1,     1,     1,     1,     1,     1,     1,     1,
       3,     1,     3,     6,     8,     0,     1,     3,     2,     3,
       0,     1,     5,     7,     3,     3,     6,     8,     1,     1,
       1,     1,     3,     3,     3,     3,     3,     3,     1,     3,
       3,     4,     6,     5,     5,     5,     4,     4,     1,     1,
       3,     3,     9,     9,     5,     5,     1,     3,     2,     2,
       2,     1,     1,     2,     2,     0,     6,     1,     3,     1,
       3,     6,     8,     0,     8,     4,     1,     1,     1,     1,
       1,     1,     1,     1,     1,     1
};


enum { YYENOMEM = -2 };

#define yyerrok         (yyerrstatus = 0)
#define yyclearin       (yychar = YYEMPTY)

#define YYACCEPT        goto yyacceptlab
#define YYABORT         goto yyabortlab
#define YYERROR         goto yyerrorlab
#define YYNOMEM         goto yyexhaustedlab


#define YYRECOVERING()  (!!yyerrstatus)

#define YYBACKUP(Token, Value)                                    \
  do                                                              \
    if (yychar == YYEMPTY)                                        \
      {                                                           \
        yychar = (Token);                                         \
        yylval = (Value);                                         \
        YYPOPSTACK (yylen);                                       \
        yystate = *yyssp;                                         \
        goto yybackup;                                            \
      }                                                           \
    else                                                          \
      {                                                           \
        yyerror (YY_("syntax error: cannot back up")); \
        YYERROR;                                                  \
      }                                                           \
  while (0)

/* Backward compatibility with an undocumented macro.
   Use YYerror or YYUNDEF. */
#define YYERRCODE YYUNDEF


/* Enable debugging if requested.  */
#if YYDEBUG

# ifndef YYFPRINTF
#  include <stdio.h> /* INFRINGES ON USER NAME SPACE */
#  define YYFPRINTF fprintf
# endif

# define YYDPRINTF(Args)                        \
do {                                            \
  if (yydebug)                                  \
    YYFPRINTF Args;                             \
} while (0)




# define YY_SYMBOL_PRINT(Title, Kind, Value, Location)                    \
do {                                                                      \
  if (yydebug)                                                            \
    {                                                                     \
      YYFPRINTF (stderr, "%s ", Title);                                   \
      yy_symbol_print (stderr,                                            \
                  Kind, Value); \
      YYFPRINTF (stderr, "\n");                                           \
    }                                                                     \
} while (0)


/*-----------------------------------.
| Print this symbol's value on YYO.  |
`-----------------------------------*/

static void
yy_symbol_value_print (FILE *yyo,
                       yysymbol_kind_t yykind, YYSTYPE const * const yyvaluep)
{
  FILE *yyoutput = yyo;
  YY_USE (yyoutput);
  if (!yyvaluep)
    return;
  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  YY_USE (yykind);
  YY_IGNORE_MAYBE_UNINITIALIZED_END
}


/*---------------------------.
| Print this symbol on YYO.  |
`---------------------------*/

static void
yy_symbol_print (FILE *yyo,
                 yysymbol_kind_t yykind, YYSTYPE const * const yyvaluep)
{
  YYFPRINTF (yyo, "%s %s (",
             yykind < YYNTOKENS ? "token" : "nterm", yysymbol_name (yykind));

  yy_symbol_value_print (yyo, yykind, yyvaluep);
  YYFPRINTF (yyo, ")");
}

/*------------------------------------------------------------------.
| yy_stack_print -- Print the state stack from its BOTTOM up to its |
| TOP (included).                                                   |
`------------------------------------------------------------------*/

static void
yy_stack_print (yy_state_t *yybottom, yy_state_t *yytop)
{
  YYFPRINTF (stderr, "Stack now");
  for (; yybottom <= yytop; yybottom++)
    {
      int yybot = *yybottom;
      YYFPRINTF (stderr, " %d", yybot);
    }
  YYFPRINTF (stderr, "\n");
}

# define YY_STACK_PRINT(Bottom, Top)                            \
do {                                                            \
  if (yydebug)                                                  \
    yy_stack_print ((Bottom), (Top));                           \
} while (0)


/*------------------------------------------------.
| Report that the YYRULE is going to be reduced.  |
`------------------------------------------------*/

static void
yy_reduce_print (yy_state_t *yyssp, YYSTYPE *yyvsp,
                 int yyrule)
{
  int yylno = yyrline[yyrule];
  int yynrhs = yyr2[yyrule];
  int yyi;
  YYFPRINTF (stderr, "Reducing stack by rule %d (line %d):\n",
             yyrule - 1, yylno);
  /* The symbols being reduced.  */
  for (yyi = 0; yyi < yynrhs; yyi++)
    {
      YYFPRINTF (stderr, "   $%d = ", yyi + 1);
      yy_symbol_print (stderr,
                       YY_ACCESSING_SYMBOL (+yyssp[yyi + 1 - yynrhs]),
                       &yyvsp[(yyi + 1) - (yynrhs)]);
      YYFPRINTF (stderr, "\n");
    }
}

# define YY_REDUCE_PRINT(Rule)          \
do {                                    \
  if (yydebug)                          \
    yy_reduce_print (yyssp, yyvsp, Rule); \
} while (0)

/* Nonzero means print parse trace.  It is left uninitialized so that
   multiple parsers can coexist.  */
int yydebug;
#else /* !YYDEBUG */
# define YYDPRINTF(Args) ((void) 0)
# define YY_SYMBOL_PRINT(Title, Kind, Value, Location)
# define YY_STACK_PRINT(Bottom, Top)
# define YY_REDUCE_PRINT(Rule)
#endif /* !YYDEBUG */


/* YYINITDEPTH -- initial size of the parser's stacks.  */
#ifndef YYINITDEPTH
# define YYINITDEPTH 200
#endif

/* YYMAXDEPTH -- maximum size the stacks can grow to (effective only
   if the built-in stack extension method is used).

   Do not make this value too large; the results are undefined if
   YYSTACK_ALLOC_MAXIMUM < YYSTACK_BYTES (YYMAXDEPTH)
   evaluated with infinite-precision integer arithmetic.  */

#ifndef YYMAXDEPTH
# define YYMAXDEPTH 10000
#endif






/*-----------------------------------------------.
| Release the memory associated to this symbol.  |
`-----------------------------------------------*/

static void
yydestruct (const char *yymsg,
            yysymbol_kind_t yykind, YYSTYPE *yyvaluep)
{
  YY_USE (yyvaluep);
  if (!yymsg)
    yymsg = "Deleting";
  YY_SYMBOL_PRINT (yymsg, yykind, yyvaluep, yylocationp);

  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  YY_USE (yykind);
  YY_IGNORE_MAYBE_UNINITIALIZED_END
}


/* Lookahead token kind.  */
int yychar;

/* The semantic value of the lookahead symbol.  */
YYSTYPE yylval;
/* Number of syntax errors so far.  */
int yynerrs;




/*----------.
| yyparse.  |
`----------*/

int
yyparse (void)
{
    yy_state_fast_t yystate = 0;
    /* Number of tokens to shift before error messages enabled.  */
    int yyerrstatus = 0;

    /* Refer to the stacks through separate pointers, to allow yyoverflow
       to reallocate them elsewhere.  */

    /* Their size.  */
    YYPTRDIFF_T yystacksize = YYINITDEPTH;

    /* The state stack: array, bottom, top.  */
    yy_state_t yyssa[YYINITDEPTH];
    yy_state_t *yyss = yyssa;
    yy_state_t *yyssp = yyss;

    /* The semantic value stack: array, bottom, top.  */
    YYSTYPE yyvsa[YYINITDEPTH];
    YYSTYPE *yyvs = yyvsa;
    YYSTYPE *yyvsp = yyvs;

  int yyn;
  /* The return value of yyparse.  */
  int yyresult;
  /* Lookahead symbol kind.  */
  yysymbol_kind_t yytoken = YYSYMBOL_YYEMPTY;
  /* The variables used to return semantic value and location from the
     action routines.  */
  YYSTYPE yyval;



#define YYPOPSTACK(N)   (yyvsp -= (N), yyssp -= (N))

  /* The number of symbols on the RHS of the reduced rule.
     Keep to zero when no symbol should be popped.  */
  int yylen = 0;

  YYDPRINTF ((stderr, "Starting parse\n"));

  yychar = YYEMPTY; /* Cause a token to be read.  */

  goto yysetstate;


/*------------------------------------------------------------.
| yynewstate -- push a new state, which is found in yystate.  |
`------------------------------------------------------------*/
yynewstate:
  /* In all cases, when you get here, the value and location stacks
     have just been pushed.  So pushing a state here evens the stacks.  */
  yyssp++;


/*--------------------------------------------------------------------.
| yysetstate -- set current state (the top of the stack) to yystate.  |
`--------------------------------------------------------------------*/
yysetstate:
  YYDPRINTF ((stderr, "Entering state %d\n", yystate));
  YY_ASSERT (0 <= yystate && yystate < YYNSTATES);
  YY_IGNORE_USELESS_CAST_BEGIN
  *yyssp = YY_CAST (yy_state_t, yystate);
  YY_IGNORE_USELESS_CAST_END
  YY_STACK_PRINT (yyss, yyssp);

  if (yyss + yystacksize - 1 <= yyssp)
#if !defined yyoverflow && !defined YYSTACK_RELOCATE
    YYNOMEM;
#else
    {
      /* Get the current used size of the three stacks, in elements.  */
      YYPTRDIFF_T yysize = yyssp - yyss + 1;

# if defined yyoverflow
      {
        /* Give user a chance to reallocate the stack.  Use copies of
           these so that the &'s don't force the real ones into
           memory.  */
        yy_state_t *yyss1 = yyss;
        YYSTYPE *yyvs1 = yyvs;

        /* Each stack pointer address is followed by the size of the
           data in use in that stack, in bytes.  This used to be a
           conditional around just the two extra args, but that might
           be undefined if yyoverflow is a macro.  */
        yyoverflow (YY_("memory exhausted"),
                    &yyss1, yysize * YYSIZEOF (*yyssp),
                    &yyvs1, yysize * YYSIZEOF (*yyvsp),
                    &yystacksize);
        yyss = yyss1;
        yyvs = yyvs1;
      }
# else /* defined YYSTACK_RELOCATE */
      /* Extend the stack our own way.  */
      if (YYMAXDEPTH <= yystacksize)
        YYNOMEM;
      yystacksize *= 2;
      if (YYMAXDEPTH < yystacksize)
        yystacksize = YYMAXDEPTH;

      {
        yy_state_t *yyss1 = yyss;
        union yyalloc *yyptr =
          YY_CAST (union yyalloc *,
                   YYSTACK_ALLOC (YY_CAST (YYSIZE_T, YYSTACK_BYTES (yystacksize))));
        if (! yyptr)
          YYNOMEM;
        YYSTACK_RELOCATE (yyss_alloc, yyss);
        YYSTACK_RELOCATE (yyvs_alloc, yyvs);
#  undef YYSTACK_RELOCATE
        if (yyss1 != yyssa)
          YYSTACK_FREE (yyss1);
      }
# endif

      yyssp = yyss + yysize - 1;
      yyvsp = yyvs + yysize - 1;

      YY_IGNORE_USELESS_CAST_BEGIN
      YYDPRINTF ((stderr, "Stack size increased to %ld\n",
                  YY_CAST (long, yystacksize)));
      YY_IGNORE_USELESS_CAST_END

      if (yyss + yystacksize - 1 <= yyssp)
        YYABORT;
    }
#endif /* !defined yyoverflow && !defined YYSTACK_RELOCATE */


  if (yystate == YYFINAL)
    YYACCEPT;

  goto yybackup;


/*-----------.
| yybackup.  |
`-----------*/
yybackup:
  /* Do appropriate processing given the current state.  Read a
     lookahead token if we need one and don't already have one.  */

  /* First try to decide what to do without reference to lookahead token.  */
  yyn = yypact[yystate];
  if (yypact_value_is_default (yyn))
    goto yydefault;

  /* Not known => get a lookahead token if don't already have one.  */

  /* YYCHAR is either empty, or end-of-input, or a valid lookahead.  */
  if (yychar == YYEMPTY)
    {
      YYDPRINTF ((stderr, "Reading a token\n"));
      yychar = yylex ();
    }

  if (yychar <= YYEOF)
    {
      yychar = YYEOF;
      yytoken = YYSYMBOL_YYEOF;
      YYDPRINTF ((stderr, "Now at end of input.\n"));
    }
  else if (yychar == YYerror)
    {
      /* The scanner already issued an error message, process directly
         to error recovery.  But do not keep the error token as
         lookahead, it is too special and may lead us to an endless
         loop in error recovery. */
      yychar = YYUNDEF;
      yytoken = YYSYMBOL_YYerror;
      goto yyerrlab1;
    }
  else
    {
      yytoken = YYTRANSLATE (yychar);
      YY_SYMBOL_PRINT ("Next token is", yytoken, &yylval, &yylloc);
    }

  /* If the proper action on seeing token YYTOKEN is to reduce or to
     detect an error, take that action.  */
  yyn += yytoken;
  if (yyn < 0 || YYLAST < yyn || yycheck[yyn] != yytoken)
    goto yydefault;
  yyn = yytable[yyn];
  if (yyn <= 0)
    {
      if (yytable_value_is_error (yyn))
        goto yyerrlab;
      yyn = -yyn;
      goto yyreduce;
    }

  /* Count tokens shifted since error; after three, turn off error
     status.  */
  if (yyerrstatus)
    yyerrstatus--;

  /* Shift the lookahead token.  */
  YY_SYMBOL_PRINT ("Shifting", yytoken, &yylval, &yylloc);
  yystate = yyn;
  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  *++yyvsp = yylval;
  YY_IGNORE_MAYBE_UNINITIALIZED_END

  /* Discard the shifted token.  */
  yychar = YYEMPTY;
  goto yynewstate;


/*-----------------------------------------------------------.
| yydefault -- do the default action for the current state.  |
`-----------------------------------------------------------*/
yydefault:
  yyn = yydefact[yystate];
  if (yyn == 0)
    goto yyerrlab;
  goto yyreduce;


/*-----------------------------.
| yyreduce -- do a reduction.  |
`-----------------------------*/
yyreduce:
  /* yyn is the number of a rule to reduce with.  */
  yylen = yyr2[yyn];

  /* If YYLEN is nonzero, implement the default value of the action:
     '$$ = $1'.

     Otherwise, the following line sets YYVAL to garbage.
     This behavior is undocumented and Bison
     users should not rely upon it.  Assigning to YYVAL
     unconditionally makes the parser a bit smaller, and it avoids a
     GCC warning that YYVAL may be used uninitialized.  */
  yyval = yyvsp[1-yylen];


  YY_REDUCE_PRINT (yyn);
  switch (yyn)
    {
  case 2: /* $@1: %empty  */
#line 39 "syntaxical.y"
      {strcpy(currentScope, "main");}
#line 1301 "syntaxical.tab.c"
    break;

  case 4: /* PROG: PP  */
#line 39 "syntaxical.y"
                                                        {printf("syntaxe correcte\n"); YYACCEPT;}
#line 1307 "syntaxical.tab.c"
    break;

  case 5: /* $@2: %empty  */
#line 43 "syntaxical.y"
                   {strcpy(currentScope, "main");}
#line 1313 "syntaxical.tab.c"
    break;

  case 8: /* $@3: %empty  */
#line 49 "syntaxical.y"
                             {
  strcpy(currentScope, (yyvsp[0].str));
  if (doubleDeclaration((yyvsp[0].str), currentScope)) {      
    printf("double declaration de la routine %s\n", (yyvsp[0].str));  
  } else 
    insererTYPE((yyvsp[0].str), typeidf, currentScope);
  }
#line 1325 "syntaxical.tab.c"
    break;

  case 10: /* CORP_FONCTION: LIST_DEC LIST_INSTRUCTION RETURN mc_endr  */
#line 59 "syntaxical.y"
                                                        {strcpy(currentScope, "main");}
#line 1331 "syntaxical.tab.c"
    break;

  case 15: /* TYPE: mc_integer  */
#line 68 "syntaxical.y"
                 {strcpy(typeidf, "INTEGER");}
#line 1337 "syntaxical.tab.c"
    break;

  case 16: /* TYPE: mc_real  */
#line 69 "syntaxical.y"
              {strcpy(typeidf, "REAL");}
#line 1343 "syntaxical.tab.c"
    break;

  case 17: /* TYPE: mc_logical  */
#line 70 "syntaxical.y"
                 {strcpy(typeidf, "LOGICAL");}
#line 1349 "syntaxical.tab.c"
    break;

  case 18: /* TYPE: mc_character  */
#line 71 "syntaxical.y"
                   {strcpy(typeidf, "CHARACTER");}
#line 1355 "syntaxical.tab.c"
    break;

  case 31: /* DECLARATION: idf  */
#line 93 "syntaxical.y"
                 {
              if (doubleDeclaration((yyvsp[0].str), currentScope)) erreurdd((yyvsp[0].str));
              else insererTYPE((yyvsp[0].str), typeidf, currentScope);
            }
#line 1364 "syntaxical.tab.c"
    break;

  case 32: /* DECLARATION: idf mc_dimension po cst_int pf  */
#line 97 "syntaxical.y"
                                             {
              if(doubleDeclaration((yyvsp[-4].str), currentScope)) erreurdd((yyvsp[-4].str)); 
              else {
                // pour les tableaux a 1 dimension (assignation de la taille au type)
                strcpy(arr, typeidf);
                strcat(arr, "()");
                insererTYPE((yyvsp[-4].str), arr, currentScope);
              }
            }
#line 1378 "syntaxical.tab.c"
    break;

  case 33: /* DECLARATION: idf mc_dimension po cst_int vg cst_int pf  */
#line 106 "syntaxical.y"
                                                        {
              if(doubleDeclaration((yyvsp[-6].str), currentScope)) erreurdd((yyvsp[-6].str)); 
              else {
                // pour les tableaux a 2 dimensions (assignation de la taille au type)
                strcpy(arr, typeidf);
                strcat(arr, "(,)");
                insererTYPE((yyvsp[-6].str), arr, currentScope);
              }
            }
#line 1392 "syntaxical.tab.c"
    break;

  case 34: /* DECLARATION: idf opar_mult cst_int  */
#line 115 "syntaxical.y"
                                    {
              if(doubleDeclaration((yyvsp[-2].str), currentScope)) erreurdd((yyvsp[-2].str));
              else insererTYPE((yyvsp[-2].str), typeidf, currentScope);
            }
#line 1401 "syntaxical.tab.c"
    break;

  case 35: /* AFFECT: idf aff EXPRESSION  */
#line 121 "syntaxical.y"
                           {
          if(!doubleDeclaration((yyvsp[-2].str), currentScope)) erreurnondec((yyvsp[-2].str));
          else incomp_type(type_idf((yyvsp[-2].str), currentScope), (yyvsp[0].exp).type);
        }
#line 1410 "syntaxical.tab.c"
    break;

  case 36: /* AFFECT: idf po CST pf aff EXPRESSION  */
#line 125 "syntaxical.y"
                                     {
          if (!doubleDeclaration((yyvsp[-5].str), currentScope)) erreurnondec((yyvsp[-5].str)); 
          else incomp_type(type_idf((yyvsp[-5].str), currentScope), (yyvsp[0].exp).type);
          if (getDimension((yyvsp[-5].str), currentScope) != 1) erreur_dim((yyvsp[-5].str));      
        }
#line 1420 "syntaxical.tab.c"
    break;

  case 37: /* AFFECT: idf po CST vg CST pf aff EXPRESSION  */
#line 130 "syntaxical.y"
                                            {
          if (!doubleDeclaration((yyvsp[-7].str), currentScope)) erreurnondec((yyvsp[-7].str));
          else incomp_type(type_idf((yyvsp[-7].str), currentScope), (yyvsp[0].exp).type);
          if (getDimension((yyvsp[-7].str), currentScope) != 2) erreur_dim((yyvsp[-7].str));
        }
#line 1430 "syntaxical.tab.c"
    break;

  case 38: /* EXPRESSION: CST  */
#line 137 "syntaxical.y"
                { (yyval.exp) = (yyvsp[0].exp); }
#line 1436 "syntaxical.tab.c"
    break;

  case 39: /* EXPRESSION: idf  */
#line 138 "syntaxical.y"
                { 
            if(!doubleDeclaration((yyvsp[0].str), currentScope)) erreurnondec((yyvsp[0].str));
            (yyval.exp).type = type_idf((yyvsp[0].str), currentScope);
          }
#line 1445 "syntaxical.tab.c"
    break;

  case 40: /* EXPRESSION: cst_char  */
#line 142 "syntaxical.y"
                     {(yyval.exp).type = "CHARACTER";}
#line 1451 "syntaxical.tab.c"
    break;

  case 41: /* EXPRESSION: cst_bool  */
#line 143 "syntaxical.y"
                     {(yyval.exp).type = "LOGICAL";}
#line 1457 "syntaxical.tab.c"
    break;

  case 42: /* EXPRESSION: EXPRESSION OPAR idf  */
#line 144 "syntaxical.y"
                                { 
            if(!doubleDeclaration((yyvsp[0].str), currentScope)) erreurnondec((yyvsp[0].str));
            (yyval.exp).type = incomp_type((yyvsp[-2].exp).type, type_idf((yyvsp[0].str), currentScope));
          }
#line 1466 "syntaxical.tab.c"
    break;

  case 43: /* EXPRESSION: EXPRESSION opar_div idf  */
#line 148 "syntaxical.y"
                                    { 
            if (!doubleDeclaration((yyvsp[0].str), currentScope)) erreurnondec((yyvsp[0].str));
            (yyval.exp).type = incomp_type((yyvsp[-2].exp).type, type_idf((yyvsp[0].str), currentScope));
          }
#line 1475 "syntaxical.tab.c"
    break;

  case 44: /* EXPRESSION: EXPRESSION OPAR CST  */
#line 152 "syntaxical.y"
                                { 
            (yyval.exp).type = incomp_type((yyvsp[-2].exp).type, (yyvsp[0].exp).type);
          }
#line 1483 "syntaxical.tab.c"
    break;

  case 45: /* EXPRESSION: EXPRESSION opar_div cst_real  */
#line 155 "syntaxical.y"
                                         { 
            (yyval.exp).type = incomp_type((yyvsp[-2].exp).type, "REAL");
          }
#line 1491 "syntaxical.tab.c"
    break;

  case 46: /* EXPRESSION: EXPRESSION opar_div cst_int  */
#line 158 "syntaxical.y"
                                         {
            if ((yyvsp[0].entier)==0) printf ("Erreur semantique division par 0 a la ligne %d et a la colonne %d \n",nb_ligne,nb_colonne); 
            (yyval.exp).type = incomp_type((yyvsp[-2].exp).type, "INTEGER");
          }
#line 1500 "syntaxical.tab.c"
    break;

  case 47: /* EXPRESSION: po EXPRESSION pf  */
#line 162 "syntaxical.y"
                             { (yyval.exp) = (yyvsp[-1].exp); }
#line 1506 "syntaxical.tab.c"
    break;

  case 48: /* EXPRESSION: CALL  */
#line 163 "syntaxical.y"
                 { (yyval.exp) = (yyvsp[0].exp); }
#line 1512 "syntaxical.tab.c"
    break;

  case 49: /* EXPRESSION: EXPRESSION OPAR cst_char  */
#line 164 "syntaxical.y"
                                     { 
              (yyval.exp).type = incomp_type((yyvsp[-2].exp).type, "CHARACTER");
            }
#line 1520 "syntaxical.tab.c"
    break;

  case 50: /* EXPRESSION: EXPRESSION opar_div cst_char  */
#line 167 "syntaxical.y"
                                         { 
              (yyval.exp).type = incomp_type((yyvsp[-2].exp).type, "CHARACTER");
            }
#line 1528 "syntaxical.tab.c"
    break;

  case 51: /* EXPRESSION: EXPRESSION po CST pf  */
#line 170 "syntaxical.y"
                                 { 
              (yyval.exp).type = type_idf((yyvsp[-3].exp).type, currentScope);
            }
#line 1536 "syntaxical.tab.c"
    break;

  case 52: /* EXPRESSION: EXPRESSION po CST vg CST pf  */
#line 173 "syntaxical.y"
                                        { 
              (yyval.exp).type = type_idf((yyvsp[-5].exp).type, currentScope);
            }
#line 1544 "syntaxical.tab.c"
    break;

  case 54: /* EXPRESSION: EXPRESSION opar_div po EXPRESSION pf  */
#line 177 "syntaxical.y"
                                                 { 
              (yyval.exp).type = incomp_type((yyvsp[-4].exp).type, (yyvsp[-1].exp).type);
            }
#line 1552 "syntaxical.tab.c"
    break;

  case 55: /* CALL: mc_call idf po LIST_PARAMETRE_RT pf  */
#line 182 "syntaxical.y"
                                          { 
        (yyval.exp).type = type_idf((yyvsp[-3].str), (yyvsp[-3].str));
      }
#line 1560 "syntaxical.tab.c"
    break;

  case 59: /* WRITE_ARGS: idf  */
#line 194 "syntaxical.y"
                { if(!doubleDeclaration((yyvsp[0].str), currentScope)) erreurnondec((yyvsp[0].str));}
#line 1566 "syntaxical.tab.c"
    break;

  case 61: /* WRITE_ARGS: WRITE_ARGS vg idf  */
#line 196 "syntaxical.y"
                              { if(!doubleDeclaration((yyvsp[0].str), currentScope)) erreurnondec((yyvsp[0].str));}
#line 1572 "syntaxical.tab.c"
    break;

  case 77: /* LIST_PARAMETRE_EQ: idf  */
#line 226 "syntaxical.y"
                       { if(!doubleDeclaration((yyvsp[0].str), currentScope)) erreurnondec((yyvsp[0].str));}
#line 1578 "syntaxical.tab.c"
    break;

  case 78: /* LIST_PARAMETRE_EQ: LIST_PARAMETRE_EQ vg idf  */
#line 227 "syntaxical.y"
                                           { if(!doubleDeclaration((yyvsp[0].str), currentScope)) erreurnondec((yyvsp[0].str));}
#line 1584 "syntaxical.tab.c"
    break;

  case 81: /* LIST_PARAMETRE_EQ: LIST_PARAMETRE_EQ vg idf po CST pf  */
#line 230 "syntaxical.y"
                                                     { if(!doubleDeclaration((yyvsp[-3].str), currentScope)) erreurnondec((yyvsp[-3].str));}
#line 1590 "syntaxical.tab.c"
    break;

  case 82: /* LIST_PARAMETRE_EQ: LIST_PARAMETRE_EQ vg idf po CST vg CST pf  */
#line 231 "syntaxical.y"
                                                            { if(!doubleDeclaration((yyvsp[-5].str), currentScope)) erreurnondec((yyvsp[-5].str));}
#line 1596 "syntaxical.tab.c"
    break;

  case 86: /* CST: cst_int  */
#line 239 "syntaxical.y"
             {(yyval.exp).type = "INTEGER";}
#line 1602 "syntaxical.tab.c"
    break;

  case 87: /* CST: cst_real  */
#line 240 "syntaxical.y"
             {(yyval.exp).type = "REAL";}
#line 1608 "syntaxical.tab.c"
    break;


#line 1612 "syntaxical.tab.c"

      default: break;
    }
  /* User semantic actions sometimes alter yychar, and that requires
     that yytoken be updated with the new translation.  We take the
     approach of translating immediately before every use of yytoken.
     One alternative is translating here after every semantic action,
     but that translation would be missed if the semantic action invokes
     YYABORT, YYACCEPT, or YYERROR immediately after altering yychar or
     if it invokes YYBACKUP.  In the case of YYABORT or YYACCEPT, an
     incorrect destructor might then be invoked immediately.  In the
     case of YYERROR or YYBACKUP, subsequent parser actions might lead
     to an incorrect destructor call or verbose syntax error message
     before the lookahead is translated.  */
  YY_SYMBOL_PRINT ("-> $$ =", YY_CAST (yysymbol_kind_t, yyr1[yyn]), &yyval, &yyloc);

  YYPOPSTACK (yylen);
  yylen = 0;

  *++yyvsp = yyval;

  /* Now 'shift' the result of the reduction.  Determine what state
     that goes to, based on the state we popped back to and the rule
     number reduced by.  */
  {
    const int yylhs = yyr1[yyn] - YYNTOKENS;
    const int yyi = yypgoto[yylhs] + *yyssp;
    yystate = (0 <= yyi && yyi <= YYLAST && yycheck[yyi] == *yyssp
               ? yytable[yyi]
               : yydefgoto[yylhs]);
  }

  goto yynewstate;


/*--------------------------------------.
| yyerrlab -- here on detecting error.  |
`--------------------------------------*/
yyerrlab:
  /* Make sure we have latest lookahead translation.  See comments at
     user semantic actions for why this is necessary.  */
  yytoken = yychar == YYEMPTY ? YYSYMBOL_YYEMPTY : YYTRANSLATE (yychar);
  /* If not already recovering from an error, report this error.  */
  if (!yyerrstatus)
    {
      ++yynerrs;
      yyerror (YY_("syntax error"));
    }

  if (yyerrstatus == 3)
    {
      /* If just tried and failed to reuse lookahead token after an
         error, discard it.  */

      if (yychar <= YYEOF)
        {
          /* Return failure if at end of input.  */
          if (yychar == YYEOF)
            YYABORT;
        }
      else
        {
          yydestruct ("Error: discarding",
                      yytoken, &yylval);
          yychar = YYEMPTY;
        }
    }

  /* Else will try to reuse lookahead token after shifting the error
     token.  */
  goto yyerrlab1;


/*---------------------------------------------------.
| yyerrorlab -- error raised explicitly by YYERROR.  |
`---------------------------------------------------*/
yyerrorlab:
  /* Pacify compilers when the user code never invokes YYERROR and the
     label yyerrorlab therefore never appears in user code.  */
  if (0)
    YYERROR;
  ++yynerrs;

  /* Do not reclaim the symbols of the rule whose action triggered
     this YYERROR.  */
  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);
  yystate = *yyssp;
  goto yyerrlab1;


/*-------------------------------------------------------------.
| yyerrlab1 -- common code for both syntax error and YYERROR.  |
`-------------------------------------------------------------*/
yyerrlab1:
  yyerrstatus = 3;      /* Each real token shifted decrements this.  */

  /* Pop stack until we find a state that shifts the error token.  */
  for (;;)
    {
      yyn = yypact[yystate];
      if (!yypact_value_is_default (yyn))
        {
          yyn += YYSYMBOL_YYerror;
          if (0 <= yyn && yyn <= YYLAST && yycheck[yyn] == YYSYMBOL_YYerror)
            {
              yyn = yytable[yyn];
              if (0 < yyn)
                break;
            }
        }

      /* Pop the current state because it cannot handle the error token.  */
      if (yyssp == yyss)
        YYABORT;


      yydestruct ("Error: popping",
                  YY_ACCESSING_SYMBOL (yystate), yyvsp);
      YYPOPSTACK (1);
      yystate = *yyssp;
      YY_STACK_PRINT (yyss, yyssp);
    }

  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  *++yyvsp = yylval;
  YY_IGNORE_MAYBE_UNINITIALIZED_END


  /* Shift the error token.  */
  YY_SYMBOL_PRINT ("Shifting", YY_ACCESSING_SYMBOL (yyn), yyvsp, yylsp);

  yystate = yyn;
  goto yynewstate;


/*-------------------------------------.
| yyacceptlab -- YYACCEPT comes here.  |
`-------------------------------------*/
yyacceptlab:
  yyresult = 0;
  goto yyreturnlab;


/*-----------------------------------.
| yyabortlab -- YYABORT comes here.  |
`-----------------------------------*/
yyabortlab:
  yyresult = 1;
  goto yyreturnlab;


/*-----------------------------------------------------------.
| yyexhaustedlab -- YYNOMEM (memory exhaustion) comes here.  |
`-----------------------------------------------------------*/
yyexhaustedlab:
  yyerror (YY_("memory exhausted"));
  yyresult = 2;
  goto yyreturnlab;


/*----------------------------------------------------------.
| yyreturnlab -- parsing is finished, clean up and return.  |
`----------------------------------------------------------*/
yyreturnlab:
  if (yychar != YYEMPTY)
    {
      /* Make sure we have latest lookahead translation.  See comments at
         user semantic actions for why this is necessary.  */
      yytoken = YYTRANSLATE (yychar);
      yydestruct ("Cleanup: discarding lookahead",
                  yytoken, &yylval);
    }
  /* Do not reclaim the symbols of the rule whose action triggered
     this YYABORT or YYACCEPT.  */
  YYPOPSTACK (yylen);
  YY_STACK_PRINT (yyss, yyssp);
  while (yyssp != yyss)
    {
      yydestruct ("Cleanup: popping",
                  YY_ACCESSING_SYMBOL (+*yyssp), yyvsp);
      YYPOPSTACK (1);
    }
#ifndef yyoverflow
  if (yyss != yyssa)
    YYSTACK_FREE (yyss);
#endif

  return yyresult;
}

#line 253 "syntaxical.y"





void erreurdd(char *idf){
  printf("Erreur semantique: double declaration de la variable %s a la ligne %d et la colonne %d\n", idf, nb_ligne, nb_colonne);
}

void erreurnondec(char *idf){
  printf("Erreur semantique: variable %s non declarer dans %s a la ligne %d et la colonne %d\n", idf, currentScope, nb_ligne, nb_colonne);
}

char *incomp_type(char* type1, char* type2) {
  if (type1[0] == ' ' || type1[0] == '\0') {
    return type2;
  }
  if (type2[0] == ' ' || type2[0] == '\0') {
    return type1;
  }
  if (type1[0] == type2[0]) {
    return type1;
  }
  printf("Erreur semantique: incompatibilite de types a la ligne %d et a la colonne %d\n", nb_ligne, nb_colonne);
  return " ";
}

void erreur_dim(char* idf) {
  printf("Erreur semantique: dimension de la variable %s incorrecte a la ligne %d et a la colonne %d\n", idf, nb_ligne, nb_colonne);
}

/* #include <stdio.h> */
int yyerror(char *msg) {
  printf(" ------------------------------- Erreur Syntaxique à la ligne %d, colonne: %d -------------------------------", nb_ligne, nb_colonne); // changed to the needed error
  return 1;
}

int yywrap() {
  return 1;
}

int main() {
  initialisation();
  yyparse();
  afficher();
  return 0;
}
