################################################################
# $Id$
# Makefile for SFU Cosmology website
################################################################

FILL = PYTHONPATH=.:$(PYTHONPATH) cheetah fill


################################################################
# Dependencies
################################################################

# Files
htmls = $(shell spyder.py|grep \.html)


# Targets
all: index.html $(htmls)

clean:
	rm -f *~ *.bak *.pyc

preprints.html: preprints.txt preprints.py


################################################################
# Implicit rules
################################################################

seminars/arxives.html: seminarx.tmpl layout.tmpl seminars.txt seminars.py
	$(FILL) -p $< > $@

seminars/%.html: seminars.tmpl layout.tmpl seminars.txt seminars.py
	SEMINAR=$(basename $(@F)) $(FILL) -p $< > $@

%.html: %.tmpl layout.tmpl
	$(FILL) $<
