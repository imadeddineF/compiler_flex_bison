#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#define MAX_ENTITES 100

// Déclaration de la table des symboles
typedef enum { VAR, CONST } TypeEntite;  // Type de l'entité (variable ou constante)
typedef enum { INT, REAL, TEXT } TypeDonnee;  // Type de données (entier, réel, texte)

typedef struct {
    char NomEntite[20];   // Nom de l'entité
    char CodeEntite[20];  // Code associé à l'entité (ex: TYPE_NUM, TYPE_REAL, etc.)
    TypeEntite type;      // Type (variable ou constante)
    TypeDonnee type_donnee; // Type de donnée (INT, REAL, TEXT)
    int is_declared;      // Indicateur pour vérifier si l'entité est déclarée
    union {
        int entier;
        double reel;
        char* texte;
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
void inserer(char entite[], char code[], TypeEntite type, TypeDonnee type_donnee) {
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

// Affichage de la table des symboles
void afficher() {
    printf("\n/*************** Table des symboles ******************/\n");
    printf("____________________________________\n");
    printf("\t| NomEntite |  CodeEntite  | Type | TypeDonnee | Valeur |\n");
    printf("____________________________________\n");
    int i;
    for ( i = 0; i < CpTS; i++) {
        printf("\t|%10s |%12s  | ", ts[i].NomEntite, ts[i].CodeEntite);
        
        // Affichage du type (variable ou constante)
        if (ts[i].type == VAR) {
            printf("Variable | ");
        } else {
            printf("Constante | ");
        }
        
        // Affichage du type de données
        if (ts[i].type_donnee == INT) {
            printf("Entier    | ");
        } else if (ts[i].type_donnee == REAL) {
            printf("Réel      | ");
        } else {
            printf("Texte     | ");
        }

        // Affichage de la valeur
        if (ts[i].type_donnee == INT) {
            printf("%d |\n", ts[i].valeur.entier);
        } else if (ts[i].type_donnee == REAL) {
            printf("%f |\n", ts[i].valeur.reel);
        } else {
            printf("%s |\n", ts[i].valeur.texte);
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
        if (ts[index].type_donnee == INT) {
            ts[index].valeur.entier = (int)value;
        } else {
            printf("Erreur : tentative d'affectation d'un entier à une entité de type incompatible.\n");
            return;
        }
    } else {
        if (ts[index].type_donnee == REAL) {
            ts[index].valeur.reel = value;
        } else {
            printf("Erreur : tentative d'affectation d'un réel à une entité de type incompatible.\n");
            return;
        }
    }
}

// Affectation d'une chaîne de texte à une entité de type texte
void affecter_texte(char entite[], const char* texte) {
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

    // Affectation de la valeur texte
    if (ts[index].type_donnee == TEXT) {
        ts[index].valeur.texte = strdup(texte);  // Allouer la mémoire pour le texte
    } else {
        printf("Erreur : tentative d'affectation d'un texte à une entité de type incompatible.\n");
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
