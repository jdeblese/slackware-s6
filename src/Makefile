CC=gcc
LIBS=-lskarnet
SOURCES=cgjoin.c
OBJECTS=$(SOURCES:.c=.o)

all: cgjoin

cgjoin: cgjoin.o
	${CC} ${LDFLAGS} cgjoin.o ${LIBS} -o cgjoin

.c.o:
	${CC} -c ${CFLAGS} $< -o $@

clean:
	rm -f ${OBJECTS} cgjoin
