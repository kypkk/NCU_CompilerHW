echo "--------yacc--------"
bison -d -o A.tab.c A.y
g++ -c -g -I.. A.tab.c
echo "--------lex--------"
flex -o A.yy.c A.l
g++ -c -g -I.. A.yy.c
echo "--------combine--------"
g++ A.yy.o A.tab.o -ll