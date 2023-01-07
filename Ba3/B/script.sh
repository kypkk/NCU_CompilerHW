echo "--------yacc--------"
bison -d -o B.tab.c B.y
g++ -c -g -I.. B.tab.c
echo "--------lex--------"
flex -o B.yy.c B.l
g++ -c -g -I.. B.yy.c
echo "--------combine--------"
g++ B.yy.o B.tab.o -ll