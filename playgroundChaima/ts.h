#include <stdio.h>

#include <string.h>
#include <stdlib.h>

#define MAX_ENTITES 100

// Déclaration de la table des symboles
typedef enum { VAR, CONST } TypeEntite;  // Type de l'entité (variable ou constante)
typedef enum {
    TS_INT,
    TS_REAL,  // Renommé
    TS_TEXT,  // Renommé
    // autres énumérateurs
} type_donnee;

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
=======
    char NomEntite[20];   // Nom de l'entité
    char CodeEntite[20];  // Code associé à l'entité (ex: TYPE_NUM, TYPE_TS_TS_REAL, etc.)
    TypeEntite type;      // Type (variable ou constante)
    type_donnee type_donnee; // Type de donnée (TS_INT, TS_REAL, TS_TEXT)
    int is_declared;      // Indicateur pour vérifier si l'entité est déclarée
    union {
        int entier;
        double reel;
        char* TS_TEXTe;
    } valeur;              // Valeur de l'entité (selon son type)
} TypeTS;

TypeTS ts[MAX_ENTITES];  // Table des symboles
int CpTS = 0;            // Compteur des entités dans la table

// Recherche d'une entité dans la table des symboles
int recherche(char entite[]) {
  int i;
    for (i = 0; i < CpTS; i++) {
        if (strcmp(entite, ts[i].NomEntite) == 0) {
            return i;  // Entité trouvée, retourne son index
        }
    }
    return -1;  // Entité non trouvée
}

// Insertion d'une entité dans la table des symboles
void inserer(char entite[], char code[], TypeEntite type, type_donnee type_donnee) {
    if (recherche(entite) != -1) {
        printf("Erreur : l'entité '%s' est déjà déclarée.\n", entite);
        return;  // L'entité existe déjà, on ne l'ajoute pas
    }

    if (CpTS >= MAX_ENTITES) {
        printf("Erreur : la table des symboles est pleine.\n");
        return;  // La table des symboles est pleine, on ne peut pas ajouter d'autres entités
    }

    // Ajouter l'entité dans la table des symboles
    strcpy(ts[CpTS].NomEntite, entite);
    strcpy(ts[CpTS].CodeEntite, code);
    ts[CpTS].type = type;
    ts[CpTS].type_donnee = type_donnee;
    ts[CpTS].is_declared = 1;  // Marque l'entité comme déclarée

    CpTS++;
}
// Affecter une chaîne de TS_TEXTe à une entité de type TS_TEXTe
void _affecter_texte(char entite[], const char* TS_TEXTe) {
    int index = recherche(entite);
    if (index == -1) {
        printf("Erreur : l'entité '%s' n'est pas déclarée.\n", entite);
        return;
    }

    // Vérification du type de l'entité
    if (ts[index].type == CONST) {
        printf("Erreur : l'entité '%s' est une constante et ne peut pas être modifiée.\n", entite);
        return;
    }

    // Affectation de la valeur TS_TEXTe
    if (ts[index].type_donnee == TS_TEXT) {
        ts[index].valeur.TS_TEXTe = strdup(TS_TEXTe);  // Allouer la mémoire pour le TS_TEXTe
    } else {
        printf("Erreur : tentative d'affectation d'un TS_TEXTe à une entité de type incompatible.\n");
        return;
    }
}

// Implémentation manuelle de strdup si elle n'est pas définie
char* strdup(const char* str) {
    size_t len = strlen(str) + 1;  // Taille de la chaîne + 1 pour le caractère nul
    char* copy = (char*)malloc(len);  // Allocation de la mémoire
    if (copy == NULL) {
        fprintf(stderr, "Erreur d'allocation mémoire\n");
        exit(1);  // Sortie en cas d'erreur d'allocation
    }
    memcpy(copy, str, len);  // Copie de la chaîne
    return copy;
}

// Affichage de la table des symboles
void afficher() {
    printf("\n/*************** Table des symboles ******************/\n");
    printf("____________________________________\n");
    printf("\t| NomEntite |  CodeEntite  | Type | TypeDonnee | Valeur |\n");
    printf("____________________________________\n");
    int i;
    for (i = 0; i < CpTS; i++) {
        printf("\t|%10s |%12s  | ", ts[i].NomEntite, ts[i].CodeEntite);
        
        // Affichage du type (variable ou constante)
        if (ts[i].type == VAR) {
            printf("Variable | ");
        } else {
            printf("Constante | ");
        }
        
        // Affichage du type de données
        if (ts[i].type_donnee == TS_INT) {
            printf("Entier    | ");
        } else if (ts[i].type_donnee == TS_REAL) {
            printf("Réel      | ");
        } else {
            printf("TS_TEXTe  | ");
        }

        // Affichage de la valeur
        if (ts[i].type_donnee == TS_INT) {
            printf("%d |\n", ts[i].valeur.entier);
        } else if (ts[i].type_donnee == TS_REAL) {
            printf("%f |\n", ts[i].valeur.reel);
        } else {
            printf("%s |\n", ts[i].valeur.TS_TEXTe);
        }
    }
}

// Affecter une valeur à une entité de type variable
void affecter(char entite[], int is_int, double value) {
    int index = recherche(entite);
    if (index == -1) {
        printf("Erreur : l'entité '%s' n'est pas déclarée.\n", entite);
        return;
    }

    // Vérification du type de l'entité
    if (ts[index].type == CONST) {
        printf("Erreur : l'entité '%s' est une constante et ne peut pas être modifiée.\n", entite);
        return;
    }

    // Affectation de la valeur selon le type de l'entité
    if (is_int) {
        if (ts[index].type_donnee == TS_INT) {
            ts[index].valeur.entier = (int)value;
        } else {
            printf("Erreur : tentative d'affectation d'un entier à une entité de type incompatible.\n");
            return;
        }
    } else {
        if (ts[index].type_donnee == TS_REAL) {
            ts[index].valeur.reel = value;
        } else {
            printf("Erreur : tentative d'affectation d'un réel à une entité de type incompatible.\n");
            return;
        }
    }
}

// Récupérer la valeur d'une entité
double get_value(int idx) {
    if (ts[idx].type_donnee == TS_INT) {
        return (double)ts[idx].valeur.entier;  // Retourner la valeur entière en tant que double
    } else if (ts[idx].type_donnee == TS_REAL) {
        return ts[idx].valeur.reel;  // Retourner la valeur réelle
    } else {
        printf("Erreur: Tentative d'accès à une valeur non numérique.\n");
        return 0.0;  // Retourner une valeur par défaut en cas d'erreur
    }
}
