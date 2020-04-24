SKIPS=index upgrade

S6SRCDIR=$(wildcard /usr/doc/s6-[0-9]*/html)
S6SRC=$(wildcard ${S6SRCDIR}/*.html)
S6BASE=$(filter-out ${SKIPS} overview why ftrig systemd s6-svscan-not-1 s6-svscan-1 socket-activation localservice,$(basename $(notdir ${S6SRC})))
S6RONN=$(addprefix ronn/,$(addsuffix .8.ronn,${S6BASE}))

ELSRCDIR=$(wildcard /usr/doc/execline*/html)
ELSRC=$(wildcard ${ELSRCDIR}/*.html)
ELBASE=$(filter-out ${SKIPS} dieshdiedie exitcodes grammar,$(basename $(notdir ${ELSRC})))
ELRONN=$(addprefix ronn/,$(addsuffix .8.ronn,${ELBASE}))

RONN=${S6RONN} ${ELRONN}
BASE=${S6BASE} ${ELBASE}
MAN=$(addprefix man/,$(addsuffix .8.gz,${BASE}))

MORE=$(wildcard src/*.ronn)
MOREMAN=$(addprefix man/,$(addsuffix .gz,$(basename $(notdir ${MORE}))))

all: ${MAN} ${MOREMAN}

.PHONY: info clean

info:
	$(info $$BASE is [${BASE}])
	$(info $$RONN is [${RONN}])
	$(info $$MAN is [${MAN}])
	$(info $$MORE is [${MORE}])
	$(info $$MOREMAN is [${MOREMAN}])

clean:
	rm -f ${RONN} ${MAN}

${S6RONN}: ronn/%.8.ronn: ${S6SRCDIR}/%.html
	pandoc --from=html --to=markdown -o $@ $<
${ELRONN}: ronn/%.8.ronn: ${ELSRCDIR}/%.html
	pandoc --from=html --to=markdown -o $@ $<

${MAN}: man/%.gz: ronn/%.ronn
	ronn -r $< --pipe | gzip -c > $@

${MOREMAN}: man/%.gz: src/%.ronn
	ronn -r $< --pipe | gzip -c > $@
