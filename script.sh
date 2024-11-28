flex lexical.l
bison -d syntaxical.y
gcc syntaxical.tab.c lex.yy.c -lfl -o output
./output
./test1.txt