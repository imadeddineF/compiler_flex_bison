# Compiler with Flex & Bison

## EasyCode Language

EasyCode is a simple academic language designed to demonstrate the use of Flex and Bison for creating a compiler. Below is the syntax and structure of the EasyCode language.

### Program Structure

```
DEBUT
  // Variable Declarations

  EXECUTION {
    // Instructions

    // Comments:
    -- {Single line comment} ##
    {-
      Multi-line
      comment
    -}

    // Variables:
    NUM: -32768 ~ 32767
    REAL: floating point numbers
    TEXT: "String"

    <type> : <variable_name>;

    // Arrays:
    <type> : <array_name>[size];
    ----> Size must be a positive integer.

    // Identifiers:
    1. Start with an uppercase letter
    2. Can contain letters, numbers, or _
    3. Maximum 10 characters

    // Constants:
    FIXE <TYPE> : <variable_name> = <value>;
    Example: FIXE NUM : MAX_VALUE = 100;

    // Instructions:
    A <- 2;

    // Conditional statement:
    SI (<condition>) ALORS {
      <instructions if true>
    } SINON {
      <instructions if false>
    }

    // While loop:
    TANTQUE <condition> FAIRE {
      <instructions>
    }

    // Primitive operations:
    ● Arithmetic:
      ○ + : addition
      ○ - : subtraction
      ○ * : multiplication
      ○ / : division
    ● Logical:
      ○ ET : logical AND
      ○ OU : logical OR
      ○ NON : negation
    ● Comparison:
      ○ = : equality
      ○ != : inequality
      ○ <, <= : less than, less than or equal to
      ○ >, >= : greater than, greater than or equal to

    // Priorities:
    // --> Must be taken into consideration

    // Input & Output:
    1. affiche(<expression>)
    2. lire(<variable>)

    // Syntax errors:
    - Undeclared variable
    - Double declaration
    - Type incompatibility
    - Division by 0 in the case of a constant
    - Modification of a constant value
    - Array size overflow

    // Error messages:
    Erreur <type> à la ligne <line_number>, colonne <column_number>
  }

FIN
```

### Example Program

```easycode
DEBUT
  NUM: a;
  REAL: b;
  TEXT: c;

  EXECUTION {
    a <- 10;
    b <- 20.5;
    c <- "Hello";

    SI (a < b) ALORS {
      affiche(c);
    } SINON {
      affiche("a is not less than b");
    }

    TANTQUE (a < 100) FAIRE {
      a <- a + 1;
    }

    affiche(a);
  }
FIN
```

### Compilation Instructions

1. Use Bison to generate the parser:

   ```sh
   bison -d bisonCode.y
   ```

2. Use Flex to generate the lexer:

   ```sh
   flex flexCode.l
   ```

3. Compile the generated C files with GCC:

   ```sh
   gcc bisonCode.tab.c lex.yy.c -lfl -o output
   ```

4. Run the compiled program:
   ```sh
   ./output
   ```

### Error Handling

The compiler will report syntax errors with the following format:

```
Erreur <type> à la ligne <line_number>, colonne <column_number>
```
