bison -d -o Ma.tab.c Ma.y
flex -o Ma.yy.c Ma.l
g++ -c -g -I.. Ma.tab.c
g++ -c -g -I.. Ma.yy.c
g++ Ma.yy.o Ma.tab.o -ll