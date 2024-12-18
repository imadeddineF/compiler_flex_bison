#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#ifndef SYMBOL_TABLE_H
#define SYMBOL_TABLE_H

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// Rename enum to avoid conflicts
typedef enum {
  ST_TYPE_INTEGER,
  ST_TYPE_REAL,
  ST_TYPE_STRING,
  ST_TYPE_INTEGER_ARRAY,
  ST_TYPE_REAL_ARRAY,
  ST_TYPE_STRING_ARRAY,
  ST_TYPE_CONSTANT
} SymbolTableType;

// Structure to represent a symbol table entry
typedef struct {
  char name[11];         // Identifier name (max 10 chars + null terminator)
  SymbolTableType type;  // Updated type reference
  int is_initialized;    // Whether the variable has been initialized
  int is_constant;       // Whether the symbol is a constant

  union {
    int int_value;       // For integer and constant integer
    double real_value;   // For real and constant real
    char* string_value;  // For string and constant string

    // For array types
    struct {
      int size;      // Size of the array
      void* values;  // Pointer to array values
    } array_info;
  } value;
} SymbolTableEntry;

// Hash table structure for symbol table
#define TABLE_SIZE 100

typedef struct {
  SymbolTableEntry* entries[TABLE_SIZE];
  int count;
} SymbolTable;

// Function prototypes (update type references)
SymbolTable* create_symbol_table();
void free_symbol_table(SymbolTable* table);
unsigned int hash(const char* key);
int insert_symbol(SymbolTable* table, const char* name, SymbolTableType type, int is_constant);
SymbolTableEntry* lookup_symbol(SymbolTable* table, const char* name);
int update_symbol_value(SymbolTable* table, const char* name, void* value);
int check_symbol_exists(SymbolTable* table, const char* name);
void print_symbol_table(SymbolTable* table);

// Implementations below remain the same, just replace SymbolTableType with SymbolTableType
SymbolTable* create_symbol_table() {
  SymbolTable* table = (SymbolTable*)malloc(sizeof(SymbolTable));
  if (table == NULL) {
    fprintf(stderr, "Memory allocation error for symbol table\n");
    exit(1);
  }

  // Initialize all entries to NULL
  int i;
  for ( i = 0; i < TABLE_SIZE; i++) {
    table->entries[i] = NULL;
  }
  table->count = 0;

  return table;
}

void free_symbol_table(SymbolTable* table) {
  int i;
  for ( i = 0; i < TABLE_SIZE; i++) {
    if (table->entries[i] != NULL) {
      // Free any dynamically allocated memory
      if (table->entries[i]->type == ST_TYPE_STRING ||
          table->entries[i]->type == ST_TYPE_STRING_ARRAY) {
        free(table->entries[i]->value.string_value);
      }

      // Free array values if applicable
      if (table->entries[i]->type == ST_TYPE_INTEGER_ARRAY ||
          table->entries[i]->type == ST_TYPE_REAL_ARRAY ||
          table->entries[i]->type == ST_TYPE_STRING_ARRAY) {
        free(table->entries[i]->value.array_info.values);
      }

      free(table->entries[i]);
    }
  }
  free(table);
}

unsigned int hash(const char* key) {
  unsigned int hash = 0;
  int i;
  for (i = 0; key[i] != '\0'; i++) {
    hash = 31 * hash + key[i];
  }
  return hash % TABLE_SIZE;
}

int insert_symbol(SymbolTable* table, const char* name, SymbolTableType type, int is_constant) {
  // Check for existing symbol
  if (lookup_symbol(table, name) != NULL) {
    fprintf(stderr, "Error: Symbol '%s' already exists\n", name);
    return 0;
  }

  // Create new symbol table entry
  SymbolTableEntry* entry = (SymbolTableEntry*)malloc(sizeof(SymbolTableEntry));
  if (entry == NULL) {
    fprintf(stderr, "Memory allocation error for symbol\n");
    return 0;
  }

  // Copy name, ensuring it doesn't exceed 10 characters
  strncpy(entry->name, name, 10);
  entry->name[10] = '\0';

  entry->type = type;
  entry->is_constant = is_constant;
  entry->is_initialized = 0;

  // Initialize value based on type
  switch (type) {
    case ST_TYPE_INTEGER:
    case ST_TYPE_CONSTANT:
      entry->value.int_value = 0;
      break;
    case ST_TYPE_REAL:
      entry->value.real_value = 0.0;
      break;
    case ST_TYPE_STRING:
      entry->value.string_value = NULL;
      break;
    case ST_TYPE_INTEGER_ARRAY:
    case ST_TYPE_REAL_ARRAY:
    case ST_TYPE_STRING_ARRAY:
      entry->value.array_info.size = 0;
      entry->value.array_info.values = NULL;
      break;
  }

  // Insert into hash table
  unsigned int index = hash(name);
  while (table->entries[index] != NULL) {
    index = (index + 1) % TABLE_SIZE;
  }

  table->entries[index] = entry;
  table->count++;

  return 1;
}

SymbolTableEntry* lookup_symbol(SymbolTable* table, const char* name) {
  unsigned int index = hash(name);
  int original_index = index;

  do {
    if (table->entries[index] != NULL &&
        strcmp(table->entries[index]->name, name) == 0) {
      return table->entries[index];
    }

    index = (index + 1) % TABLE_SIZE;
  } while (index != original_index && table->entries[index] != NULL);

  return NULL;
}

int update_symbol_value(SymbolTable* table, const char* name, void* value) {
  SymbolTableEntry* entry = lookup_symbol(table, name);

  if (entry == NULL) {
    fprintf(stderr, "Error: Symbol '%s' not found\n", name);
    return 0;
  }

  if (entry->is_constant) {
    fprintf(stderr, "Error: Cannot modify constant '%s'\n", name);
    return 0;
  }

  switch (entry->type) {
    case ST_TYPE_INTEGER:
      entry->value.int_value = *(int*)value;
      break;
    case ST_TYPE_REAL:
      entry->value.real_value = *(double*)value;
      break;
    case ST_TYPE_STRING:
      if (entry->value.string_value != NULL) {
        free(entry->value.string_value);
      }
      entry->value.string_value = strdup((char*)value);
      break;
    default:
      fprintf(stderr, "Error: Unsupported type for update\n");
      return 0;
  }

  entry->is_initialized = 1;
  return 1;
}

int check_symbol_exists(SymbolTable* table, const char* name) {
  return lookup_symbol(table, name) != NULL;
}

void print_symbol_table(SymbolTable* table) {
  printf("\n===== Symbol Table =====\n");
  int i;
  for (i = 0; i < TABLE_SIZE; i++) {
    if (table->entries[i] != NULL) {
      SymbolTableEntry* entry = table->entries[i];
      printf("Name: %s, Type: %d, Constant: %d, Initialized: %d\n", entry->name, entry->type, entry->is_constant, entry->is_initialized);
    }
  }
  printf("=======================\n");
}

#endif
