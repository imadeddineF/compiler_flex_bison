flex lexique.l
bison -d syntaxique.y
gcc syntaxique.tab.c lex.yy.c -lfl -ly -o output
./output
./tests/test1.txt
./output > ../tests/test1.txt