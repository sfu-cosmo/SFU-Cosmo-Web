################################################################
# $Id$
# Makefile for SFU Cosmology website
################################################################

# Files
templates = $(patsubst template/%.tmpl,compiled/%.py,$(shell find template -name '*.tmpl'))
htmls = $(addprefix html/,index.html seminars/arxives.html seminars/webcal.ics) 
htmls += $(shell spyder.py|grep \.html)


################################################################
# Targets
################################################################

all: $(templates) $(htmls)

clean:
	rm -f `find compiled -type f -name '*.py'`
	rm -f `find html -type f -name '*.html' -or -name '*.ics'`
	rm -f `find . -type f -name '*~' -or -name '*.bak' -or -name '*.py[cod]'`


################################################################
# Dependencies
################################################################

html/index.html: seminars.txt parser/seminars.py
html/preprints.html: preprints.txt parser/preprints.py
html/seminars/webcal.ics: seminars.txt parser/seminars.py
html/seminars/arxives.html: seminars.txt parser/seminars.py


################################################################
# Implicit rules
################################################################

# pre-compile Cheetah templates
compiled/%.py: template/%.tmpl layout.tmpl
	cheetah-2.7 compile --idir $(dir $<) --odir $(dir $@) $(notdir $<)

# fill in pre-compiled template (generic rule)
html/%.html html/%.ics: compiled/%.py
	mkdir -p $(dir $@) && PYTHONPATH=.:$(PYTHONPATH) python $< > $@

# fill in pre-compiled template for a specific seminar
html/seminars/%.html: compiled/seminars/entries.py seminars.txt parser/seminars.py
	mkdir -p $(dir $@) && SEMINAR=$(basename $(@F)) PYTHONPATH=.:$(PYTHONPATH) python $< > $@

# HTML and other non-templated files should be just copied over
html/%.html: template/%.html
	mkdir -p $(dir $@) && cp $< $@
