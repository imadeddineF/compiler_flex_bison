flex lexical.l
bison -d syntaxical.y
gcc syntaxical.tab.c lex.yy.c -lfl -ly -o output
./output
./test1.txt