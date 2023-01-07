echo "--------yacc--------"
bison -d -o parser.tab.c parser.y
gcc -c -g -I.. parser.tab.c
echo "--------lex--------"
flex -o scanner.yy.c scanner.l
gcc -c -g -I.. scanner.yy.c
echo "--------combine--------"
gcc scanner.yy.o parser.tab.o -ll -o smli