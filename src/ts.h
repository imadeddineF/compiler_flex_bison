#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// ====== Data Structures for Symbol Table Management ======

// Structure for identifiers and constants table
typedef struct {
  int state;      // 0: empty case, 1: occupied case
  char name[20];  // Name of the identifier/constant
  char code[20];  // Type of entity ("IDF", "CONST" ...)
  char type[20];  // Data type ("NUM", "REAL", "TEXT" ....)
  float val;      // Value (for constants)
} element;

// Structure for keywords and separators table
typedef struct {
  int state;      // 0: empty case, 1: occupied case
  char name[20];  // Name of keyword/separator
  char code[20];  // Category code
  char type[20];  // Type information
} elt;

// Structure for format specifier and identifier compatibility checking
typedef struct {
  char signFromatage;  // Format specifier (;, %, &, ?)
  char idf[20];        // Associated identifier
} compatibilite;

// ====== Global Tables ======

element tab[1000];  // Main symbol table for identifiers/constants (1000 entries)
elt tabs[40];       // Table for separators (40 entries)
elt tabm[40];       // Table for keywords (40 entries)

// ====== Core Functions ======

// Initialize all tables by setting states to 0 (empty)
// initializeTables()
void initialisation() {
  int i;
  // Initialize main symbol table
  for (i = 0; i < 1000; i++) {
    tab[i].state = 0;
  }
  // Initialize keyword and separator tables
  for (i = 0; i < 40; i++) {
    tabs[i].state = 0;
    tabm[i].state = 0;
  }
}

// Insert an entity into the appropriate table
// Parameters:
// - entite: entity name
// - code: entity code/category
// - type: data type
// - val: value (for constants)
// - i: position to insert
// - y: table selector (0: main table, 1: keywords, 2: separators)

// insertEntity()
void inserer(char entite[], char code[], char type[], float val, int i, int y) {
  switch (y) {
    case 0:  // Insert into identifiers/constants table
      tab[i].state = 1;
      strcpy(tab[i].name, entite);
      strcpy(tab[i].code, code);
      strcpy(tab[i].type, type);
      tab[i].val = val;
      break;
    case 1:  // Insert into keywords table
      tabm[i].state = 1;
      strcpy(tabm[i].name, entite);
      strcpy(tabm[i].code, code);
      strcpy(tabm[i].type, type);
      break;
    case 2:  // Insert into separators table
      tabs[i].state = 1;
      strcpy(tabs[i].name, entite);
      strcpy(tabs[i].code, code);
      break;
  }
}

// Search for an entity and insert if not found
// Parameters similar to inserer() plus:
// - y: table selector (0: main, 1: keywords, 2: separators)

// searchAndInsert()
void rechercher(char entite[], char code[], char type[], float val, int y) {
  int j, i;
  switch (y) {
    case 0: /* verifier si la case dans la tables des IDF et CONST est libre */
      for (i = 0; ((i < 1000) && (tab[i].state == 1)) && (strcmp(entite, tab[i].name) != 0); i++);
      if (tab[i].state == 0) {
        inserer(entite, code, type, val, i, 0);
      } else if (strcmp(entite, tab[i].name) == 0) {
        printf("entite (%s) utilisE existe deja\n", entite);
      } else if (i >= 1000) {
        printf("La table des symboles des idfs est pleine");
      }
      break;

    case 1: /* verifier si la case dans la tables des mots clés est libre */
      for (i = 0; ((i < 40) && (tabm[i].state == 1)) && (strcmp(entite, tabm[i].name) != 0); i++);
      if (tabm[i].state == 0) {
        inserer(entite, code, type, val, i, 1);
      } else if (i >= 40) {
        printf("La table des mots cles est pleine");
      }
      break;

    case 2: /* verifier si la case dans la tables des séparateurs est libre */
      for (i = 0; ((i < 40) && (tabs[i].state == 1)) && (strcmp(entite, tabs[i].name) != 0); i++);
      if (i < 40)
        inserer(entite, code, type, val, i, 2);
      break;
  }
}

// Display contents of all symbol tables
// displayTables
void afficher() {
  int i;

  // Display identifiers table
  printf("/*************** Table des symboles IDF *************/\n");
  printf("____________________________________________________________________\n");
  printf("\t| Nom_Entite |  Code_Entite | Type_Entite | Val_Entite\n");
  printf("____________________________________________________________________\n");

  for (i = 0; i < 50; i++) {
    if (tab[i].state == 1) {
      printf("\t|%10s |%15s | %12s | %12f\n",
             tab[i].name, tab[i].code, tab[i].type, tab[i].val);
    }
  }

  // Display keywords table
  printf("\n/*************** Table des symboles mots cles *************/\n");
  printf("___________________________________________________\n");
  printf("\t| Nom_Entite |  Code_Entite | Type_Entite |\n");
  printf("___________________________________________________\n");

  for (i = 0; i < 40; i++) {
    if (tabm[i].state == 1) {
      printf("\t|%10s |%12s | |%12s | \n",
             tabm[i].name, tabm[i].code, tabm[i].type);
    }
  }

  // Display separators table
  printf("\n/*************** Table des symboles separateurs *************/\n");
  printf("_____________________________________\n");
  printf("\t| NomEntite |  CodeEntite | \n");
  printf("_____________________________________\n");

  for (i = 0; i < 40; i++) {
    if (tabs[i].state == 1) {
      printf("\t|%10s |%12s | \n", tabs[i].name, tabs[i].code);
    }
  }

  printf("\n════════════════════════════════════════════════════════════════════════════════\n");
  printf("Done!\n");
  printf("════════════════════════════════════════════════════════════════════════════════\n");
}

// ====== Utility Functions ======

// Search for an identifier in the main table
// Returns index if found, -1 if not found

// searchIdentifier
int rechercherIDF(char entite[]) {
  int i = 0;
  for (i; i < 1000; i++) {
    if (strcmp(entite, tab[i].name) == 0) {
      return i;
    }
  }
  return -1;
}

// Check if an identifier is not declared
// Returns 0 if not declared, 1 if declared
// isIdentifierDeclared()
int rechercheNonDeclare(char entite[]) {
  int position = rechercherIDF(entite);
  // Check if identifier exists and has no type (undeclared)
  if (position != -1 && strcmp(tab[position].type, " ") == 0) {
    return 0;  // Not declared
  }
  return 1;  // Declared
}

// Insert/update type for an identifier
// insertOrUpdateType()
void insererType(char entite[], char type[]) {
  int position = rechercherIDF(entite);
  if (position != -1) {
    strcpy(tab[position].type, type);
  }
}

// Mark an identifier as constant
// markAsConstant()
// void CodeCst(char entite[]) {
//   int position = rechercherIDF(entite);
//   if (position != -1) {
//     strcpy(tab[position].code, "FIXE IDF");
//   }
// }

// New version (work for repeated constants)
void CodeCst(char entite[]) {
  int position;
  position = rechercherIDF(entite);
  if (position != -1) {
    // Check if the entity is already a constant
    if (strcmp(tab[position].code, "IDF CONSTANT") == 0) {
      printf("Error: The entity '%s' is already a constant and cannot be modified.\n", entite);
      return;
    }
    // Set the entity as a constant
    strcpy(tab[position].code, "IDF CONSTANT");
  } else {
    printf("Error: Entity '%s' not found in the symbol table.\n", entite);
  }
}

// Save a value for an identifier
// saveIdentifierValue()
void SaveValue(char entite[], float val) {
  int position = rechercherIDF(entite);
  if (position != -1) {
    tab[position].val = val;
  }
}

// Check if an identifier is constant
// Returns 1 if constant, 0 if not
// isIdentifierConstant()
int VerifIdfConst(char entite[]) {
  int position = rechercherIDF(entite);
  if (position != -1) {
    return (strcmp(tab[position].code, "IDF CONSTANT") == 0) ? 1 : 0;
  }
  return 0;
}

// Count format specifiers in a string
// basically used to count the number of variables in a printf statement
// countFormatSpecifiers()
int NbrSgnFormat(char chaine[]) {
  int i = 0;
  int taille = strlen(chaine);  // Get the length of the input string
  int compteur = 0;
  for (i = 0; i < taille; i++) {
    // ';': represent an integer
    // '%': represent a real number
    // '?': represent a string
    if ((chaine[i] == ';') || (chaine[i] == '%') || (chaine[i] == '?')) {
      compteur++;
    }
  }
  return compteur;
}

// Check type compatibility
// Returns 1 if types match, 0 if not
// isTypeCompatible()
int CompType(char entite[], char type[]) {
  int position = rechercherIDF(entite);
  if (position != -1) {
    return (strcmp(tab[position].type, type) == 0) ? 1 : 0;  // Check if types match (comparision)
  }
  return 0;
}

// Extract format specifiers from a string into compatibility array
// extractFormatSpecifiers()
void insererSignFormat(char chaine[], compatibilite tableau[]) {
  int i = 0, j = 0, taille = strlen(chaine);
  for (i = 0; i < taille; i++) {
    switch (chaine[i]) {
      case ';':  // Integer format
      case '?':  // String format
      case '%':  // Real number format
        tableau[j].signFromatage = chaine[i];
        j++;
        break;
    }
  }
}

// Get type of an identifier
// getIdentifierType()
char* retournType(char entite[]) {
  int position = rechercherIDF(entite);
  return (position != -1) ? tab[position].type : NULL;
}

// Verify format specifier compatibility with variables
// Returns 0 if all compatible, index+1 of first incompatible variable otherwise
// verifyFormatCompatibility
int verifierCompatibilite(compatibilite tableau[], int nbr) {
  int i = 0;
  for (i = 0; i < nbr; i++) {
    switch (tableau[i].signFromatage) {
      case ';':  // Check NUM compatibility
        if (strcmp(retournType(tableau[i].idf), "NUM") != 0 || strcmp(retournType(tableau[i].idf), "SIGNEDNUM") != 0)
          return i + 1;
        break;
      case '%':  // Check REAL compatibility
        if (strcmp(retournType(tableau[i].idf), "REAL") != 0 || strcmp(retournType(tableau[i].idf), "SIGNEDREAL") != 0)
          return i + 1;
        break;
      case '?':  // Check TEXT compatibility
        if (strcmp(retournType(tableau[i].idf), "TEXT") != 0)
          return i + 1;
        break;
    }
  }
  return 0;  // All types are compatible
}