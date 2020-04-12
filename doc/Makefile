SRCDIR=$(wildcard /usr/doc/s6-[0-9]*/html)
SRC=$(wildcard ${SRCDIR}/s6-*.html)
BASE=$(basename $(notdir ${SRC}))
RONN=$(addprefix ronn/,$(addsuffix .8.ronn,${BASE}))
MAN=$(addprefix man/,$(addsuffix .8.gz,${BASE}))

MORE=$(wildcard src/*.ronn)
MOREMAN=$(addprefix man/,$(addsuffix .gz,$(basename $(notdir ${MORE}))))

all: ${MAN} ${MOREMAN}

.PHONY: info clean

info:
	$(info $$SRCDIR is [${SRCDIR}])
	$(info $$BASE is [${BASE}])
	$(info $$RONN is [${RONN}])
	$(info $$MAN is [${MAN}])
	$(info $$MORE is [${MORE}])
	$(info $$MOREMAN is [${MOREMAN}])

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
${MAN}: man/%.gz: ronn/%.ronn
	ronn -r $< --pipe | gzip -c > $@

${MOREMAN}: man
${MOREMAN}: man/%.gz: src/%.ronn
	ronn -r $< --pipe | gzip -c > $@
