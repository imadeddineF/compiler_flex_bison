flex lexique.l
bison -d syntaxique.y
gcc syntaxique.tab.c lex.yy.c -lfl -o output
./output
./tests/test1.txt