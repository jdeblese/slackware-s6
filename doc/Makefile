SRCDIR=$(wildcard /usr/doc/s6-[0-9]*/html)
SRC=$(wildcard ${SRCDIR}/s6-*.html)
BASE=$(basename $(notdir ${SRC}))
RONN=$(addprefix ronn/,$(addsuffix .8.ronn,${BASE}))
MAN=$(addprefix man/,$(addsuffix .8.gz,${BASE}))

all: ${MAN}

.PHONY: info clean

info:
	$(info $$SRCDIR is [${SRCDIR}])
	$(info $$BASE is [${BASE}])

clean:
	rm -f ${RONN} ${MAN}

man:
	mkdir man

ronn:
	mkdir ronn

${RONN}: ronn
${RONN}: ronn/%.8.ronn: ${SRCDIR}/%.html
	pandoc --from=html --to=markdown -o $@ $<

${MAN}: man
${MAN}: man/%.8.gz: ronn/%.8.ronn
	ronn -r $< --pipe | gzip -c > $@
