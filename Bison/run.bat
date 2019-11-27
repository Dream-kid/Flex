flex prac.l
bison -d prac.y
gcc lex.yy.c prac.tab.c -o app
app