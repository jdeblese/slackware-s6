CC=gcc
CFLAGS=-I/include
LDFLAGS=-L/library.so -lstddjb
SOURCES=cgjoin.c
OBJECTS=$(SOURCES:.c=.o)

all: cgjoin

cgjoin: cgjoin.o
	${CC} ${LDFLAGS} cgjoin.o -o cgjoin

.c.o:
	${CC} -c ${CFLAGS} $< -o $@
