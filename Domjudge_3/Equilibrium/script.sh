bison -d -o E.tab.c E.y
flex -o E.yy.c E.l
g++ -c -g -I.. E.tab.c
g++ -c -g -I.. E.yy.c
g++ E.yy.o E.tab.o -ll