#include <stdio.h>
#include <string.h>
#include <stdlib.h>

// Structure for Symbol Table Entries
typedef struct {
    char NomEntite[20]; // Name of the entity
    char CodeEntite[20]; // Type (NUM, REAL, TEXT)
    char Type[20]; // Variable type (NUM, REAL, TEXT)
    char Constant[5]; // "Oui" for constants, "Non" otherwise
} TypeTS;

#define MAX_TS 100
TypeTS ts[MAX_TS];
int CpTS = 0; // Counter for the symbol table

/* Function to search for an entity in the symbol table */
int recherche(char entite[]) {
    for (int i = 0; i < CpTS; i++) {
        if (strcmp(entite, ts[i].NomEntite) == 0)
            return i; // Found
    }
    return -1; // Not found
}

/* Function to insert an entity into the symbol table */
void inserer(char entite[], char code[], char type[], char constant[]) {
    if (recherche(entite) == -1) {
        strcpy(ts[CpTS].NomEntite, entite);
        strcpy(ts[CpTS].CodeEntite, code);
        strcpy(ts[CpTS].Type, type);
        strcpy(ts[CpTS].Constant, constant); // Store size for arrays
        CpTS++;
    } else {
        printf("Erreur: Double déclaration de l'entité '%s'.\n", entite);
    }
}


/* Function to display the symbol table */
void afficher() {
    printf("\n/*************** Table des Symboles ******************/\n");
    printf("_____________________________________________________________\n");
    printf("| NomEntite      | CodeEntite   | Type       | Constant   |\n");
    printf("_____________________________________________________________\n");
    for (int i = 0; i < CpTS; i++) {
        printf("| %-14s | %-12s | %-10s | %-10s |\n", ts[i].NomEntite, ts[i].CodeEntite, ts[i].Type, ts[i].Constant);
    }
    printf("_____________________________________________________________\n");
}