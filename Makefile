CC=g++ -std=c++11

compilador: parser.tab.o lex.yy.o
	$(CC) -o compilador parser.tab.o lex.yy.o

parser.tab.c parser.tab.h: parser.y
	bison -d parser.y

lex.yy.c: lexico.l
	flex lexico.l

parser.tab.o: parser.tab.c
	$(CC) -c $<

lex.yy.o: lex.yy.c parser.tab.h
	$(CC) -c lex.yy.c

clean:
	rm -f *~ .*~ *.o parser.tab.c parser.tab.h lex.yy.c

prueba:
	./compilador < entrada.txt > salida.s ; cat salida.s ; gcc salida.s ; ./a.out


