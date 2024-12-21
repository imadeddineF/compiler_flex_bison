BUILD_DIR = out
SRC_DIR = src
OUTPUT_FILE = $(BUILD_DIR)/output
TEST_DIR = tests

LEXICAL_FILE = $(SRC_DIR)/lexical.l
SYNTAXIQUE_FILE = $(SRC_DIR)/syntaxique.y
SYMBOL_TABLE_FILE = $(SRC_DIR)/ts.h

all: build compile test 

build: 
	mkdir -p $(BUILD_DIR)
	flex -o $(BUILD_DIR)/lex.yy.c $(LEXICAL_FILE)
	bison -d -o $(BUILD_DIR)/syntaxique.tab.c $(SYNTAXIQUE_FILE)

compile: 
	gcc -I$(SRC_DIR) $(BUILD_DIR)/syntaxique.tab.c $(BUILD_DIR)/lex.yy.c -lfl -o $(OUTPUT_FILE)

clean: 
	rm -rf $(BUILD_DIR)

test: compile
	$(OUTPUT_FILE) < $(TEST_DIR)/test1.txt

.PHONY: 
	all build clean test compile
