#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_SYMBOLS 100

// Type des symboles (variables ou constantes)
typedef enum { VAR,
               CONST } symbol_type;

// Structure représentant un symbole (variable ou constante)
typedef struct {
  char* name;        // Nom de la variable ou de la constante
  symbol_type type;  // Type du symbole (VAR ou CONST)
  int is_declared;   // Indicateur de déclaration
  int is_constant;   // Indicateur de constante (fixe ou variable)
  union {
    int entier;
    double reel;
  } value;  // Valeur de la variable ou constante
} symbol;

// Table des symboles
symbol symbol_table[MAX_SYMBOLS];
int symbol_count = 0;

// Trouver un symbole dans la table
int find_symbol(const char* name) {
  for (int i = 0; i < symbol_count; i++) {
    if (strcmp(symbol_table[i].name, name) == 0) {
      return i;
    }
  }
  return -1;  // Si le symbole n'est pas trouvé
}

// Ajouter un symbole à la table des symboles
void add_symbol(const char* name, symbol_type type, int is_constant) {
  int index = find_symbol(name);
  if (index != -1) {
    fprintf(stderr, "Erreur: variable '%s' déjà déclarée.\n", name);
    exit(1);
  }
  symbol_table[symbol_count].name = strdup(name);
  symbol_table[symbol_count].type = type;
  symbol_table[symbol_count].is_declared = 1;
  symbol_table[symbol_count].is_constant = is_constant;
  symbol_count++;
}

// Définir la valeur d'un symbole
void set_symbol_value(int index, int is_int, double value) {
  if (symbol_table[index].is_constant) {
    fprintf(stderr, "Erreur: tentative de modification d'une constante.\n");
    exit(1);
  }
  if (is_int) {
    symbol_table[index].value.entier = (int)value;
  } else {
    symbol_table[index].value.reel = value;
  }
}

// Vérifier la division par zéro
void check_division_by_zero(double value) {
  if (value == 0) {
    fprintf(stderr, "Erreur: division par zéro.\n");
    exit(1);
  }
}

// Vérifier la compatibilité des types lors des affectations
void check_type_compatibility(int index, int is_int, double value) {
  if (symbol_table[index].type == VAR) {
    if (is_int && symbol_table[index].value.reel != value) {
      fprintf(stderr, "Erreur: incompatibilité de type lors de l'affectation.\n");
      exit(1);
    }
  }
}