# Compiler with Flex & Bison

## EasyCode language

```
DEBUT
  // Déclaration des variables

  EXECUTION {
    // Partie Instructions

    // Comments:
    -- {Comment} ##
    {-
      Comment
    -}

    // Variables:
    NUM: -32768 ~ 32767.
    REAL: whatever
    TEXT: "String"

    <type> : <nom_variable>;

    // Tables:
    <type> : <nom_tableau>[taille];
    ----> La taille doit être un nombre entier positif.

    // Identifiers:
    1- start with a uppercase letter
    2- can contain letters, numbers or _
    3- max 10 chars

    // constants:
    FIXE <TYPE> : <nom_variable> = <valeur>;
    ex: FIXE NUM : MAX_VALEUR = 100;

    // instructions:
    A <- 2 ;

    // for loop statement:
    SI (<condition>) ALORS {
      <instructions si vrai>
    } SINON {
      <instructions si faux>
    }

    // while loop:
    TANTQUE <condition> FAIRE {
      <instructions>
    }

    // premitive operations:
    ● Arithmétiques :
    ○ + : addition
    ○ - : soustraction
    ○ * : multiplication
    ○ / : division
    ● Logiques :
    ○ ET : ET logique
    ○ OU : OU logique
    ○ NON : Négation
    ● Comparaison :
    ○ = : égalité
    ○ != : inégalité
    ○ <, <= : inférieur, inférieur ou égal
    ○ >, >= : supérieur, supérieur ou égal


    // priorities:
    // --> must be taken in consideration

    // input & output:
    1- affiche(<expression>)
    2- lire(<variable>)

    // syntaxical errors:
    - Variable non déclaré
    - Double déclaration
    - Incompatibilité de type
    - Division sur 0 dans le cas d’une constante.
    - Modification de la valeur d’une constante.
    - Dépassement de la taille d’un tableau.

    // Errors syntax must be showen:
    Erreur <type> à la ligne <numéro_ligne>, colonne <numéro_colonne>
  }

FIN
```
