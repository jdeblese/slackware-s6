CC=gcc
LIBS=-lskarnet

CSOURCES=src/cgjoin.c
OBJECTS=$(SOURCES:.c=.o)

.PHONY: all install uninstall clean doc install-doc

all: src/cgjoin doc

doc:
	make -C doc all

src/cgjoin: src/cgjoin.o
	${CC} ${LDFLAGS} $< ${LIBS} -o $@

.c.o:
	${CC} -c ${CFLAGS} $< -o $@

clean:
	rm -f ${OBJECTS} src/cgjoin

TOCOPY=$(shell find etc/ -type f -name "[a-zA-Z]*" )
DEST=$(addprefix ${DESTDIR}/,${TOCOPY})

install: ${DEST} ${DESTDIR}/etc/rc.d/rc.M install-doc
	install -sD src/cgjoin ${DESTDIR}/bin/cgjoin

install-doc:
	install -Dm 644 -t ${DESTDIR}/usr/share/man/man8 $(wildcard doc/man/*.gz)


${DEST}: ${DESTDIR}/%: %
	install -D $< $@

${DESTDIR}/etc/rc.d/rc.M: ${DESTDIR}/etc/rc.d/rc.M.patch
	patch -d ${DESTDIR}/etc/rc.d < ${DESTDIR}/etc/rc.d/rc.M.patch
