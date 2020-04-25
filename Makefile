CC=gcc
LIBS=-L/usr/lib64/skalibs -lskarnet

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

TOCOPY=$(filter-out %~ %.patch,$(wildcard etc/rc.d/*) $(wildcard etc/s6-init/*) $(shell find etc/svc -type f -name "[a-zA-Z]*" ))
DEST=$(addprefix ${DESTDIR}/,${TOCOPY})

install: src/cgjoin install-svscan ${DEST} ${DESTDIR}/etc/rc.d/rc.M install-doc
	install -sD src/cgjoin ${DESTDIR}/bin/cgjoin

install-doc:
	install -Dm 644 -t ${DESTDIR}/usr/share/man/man8 $(wildcard doc/man/*.gz)


${DEST}: ${DESTDIR}/%: %
	install -D $< $@

${DESTDIR}/etc/rc.d/rc.M: etc/rc.d/rc.M.patch
	patch -d ${DESTDIR}/etc/rc.d < etc/rc.d/rc.M.patch

install-svscan: ${DESTDIR}/etc/svc/.s6-svscan ${DESTDIR}/etc/svc/.s6-svscan/finish ${DESTDIR}/etc/svc/.s6-svscan/crash
${DESTDIR}/etc/svc/.s6-svscan:
	mkdir -p ${DESTDIR}/etc/svc/.s6-svscan
${DESTDIR}/etc/svc/.s6-svscan/finish: ${DESTDIR}/etc/s6-init/finish
	ln -fs ${DESTDIR}/etc/s6-init/finish ${DESTDIR}/etc/svc/.s6-svscan/finish
${DESTDIR}/etc/svc/.s6-svscan/crash: ${DESTDIR}/etc/s6-init/crash
	ln -fs ${DESTDIR}/etc/s6-init/crash ${DESTDIR}/etc/svc/.s6-svscan/crash
