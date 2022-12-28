bison -d -o M.tab.c M.y
flex -o M.yy.c M.l
g++ -c -g -I.. M.tab.c
g++ -c -g -I.. M.yy.c
g++ M.yy.o M.tab.o -ll