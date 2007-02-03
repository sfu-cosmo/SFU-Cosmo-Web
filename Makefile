################################################################
# $Id$
# Makefile for SFU Cosmology website
################################################################

FILL = PYTHONPATH=.:$(PYTHONPATH) cheetah fill


################################################################
# Dependencies
################################################################

# Files
htmls = $(shell spyder.py)


# Targets
all: index.html $(htmls)

clean:
	rm -f *~ *.bak *.pyc


################################################################
# Implicit rules
################################################################

seminars/%.html: seminars.tmpl layout.tmpl seminars.txt seminars.py
	SEMINAR=$(basename $(@F)) $(FILL) -p $< > $@

%.html: %.tmpl layout.tmpl
	$(FILL) $<
