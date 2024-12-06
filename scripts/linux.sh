flex lexique.l
# bison -d syntaxique.y
# gcc lex.yy.c -o output -lfl
gcc syntaxique.tab.c lex.yy.c -lfl -o output
./output < ../tests/test1.txt