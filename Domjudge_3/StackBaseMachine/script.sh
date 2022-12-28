bison -d -o S.tab.c S.y
flex -o S.yy.c S.l
g++ -c -g -I.. S.tab.c
g++ -c -g -I.. S.yy.c
g++ S.yy.o S.tab.o -ll