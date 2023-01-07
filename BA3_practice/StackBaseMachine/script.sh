echo "--------yacc--------"
bison -d -o S.tab.c S.y
g++ -c -g -I.. S.tab.c
echo "--------lex--------"
flex -o S.yy.c S.l
g++ -c -g -I.. S.yy.c
echo "--------combine--------"
g++ S.yy.o S.tab.o -ll