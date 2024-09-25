OPTS = -g -Wall -ansi -pedantic -std=c++20

OBJS = main.o Token.o lex.yy.o

CC = g++ -c $(OPTS) 
LN = g++

run: $(OBJS)
	$(LN) -o run $(OBJS)

main.o: main.cpp Token.hpp 
	$(CC) main.cpp

Token.o: Token.hpp
	$(CC) Token.cpp

lex.yy.o: lex.yy.cc
	$(CC) lex.yy.cc

lex.yy.cc: lex.l
	flex++ lex.l