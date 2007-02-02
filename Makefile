################################################################
# $Id$
# Makefile for SFU Cosmology website
################################################################

FILL = PYTHONPATH=.:$(PYTHONPATH) cheetah fill


################################################################
# Dependencies
################################################################

# Files
htmls = $(addsuffix .html, index people seminars visitors jobs contact links mug)


# Targets
all: $(htmls)

clean:
	rm -f *~ *.bak *.pyc

seminars.html: seminars.txt seminars.py

################################################################
# Implicit rules
################################################################

# Production rules
%.html: %.tmpl layout.tmpl
	$(FILL) $<
