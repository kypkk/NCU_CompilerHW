echo "--------yacc--------"
bison -d -o P.tab.c P.y
g++ -c -g -I.. P.tab.c
echo "--------lex--------"
flex -o P.yy.c P.l
g++ -c -g -I.. P.yy.c
echo "--------combine--------"
g++ P.yy.o P.tab.o -ll