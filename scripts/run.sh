flex lexical.l
bison -d syntaxique.y
gcc syntaxique.tab.c lex.yy.c -lfl -o output # for linux
gcc syntaxique.tab.c lex.yy.c -lfl -ly -o output # for windows
./output < ../tests/test1.txt # for linux
./output > ../tests/test1.txt # for windows
