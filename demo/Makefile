# Asymptote Makefile
#exclude := $(wildcard _*.tex)
#tex := $(wildcard *.tex)
asy := $(wildcard *.asy)
libs := ../tools.asy globalsetting.asy
asy := $(filter-out $(libs), $(asy))
pdf := $(asy:.asy=.pdf)

ASY=python3 runasy.py

tmp_ext := aux out log pre synctex.gz

all: $(pdf)

%.pdf: %.asy
	$(ASY) $<

$(asy): $(libs) shortcut.tex
	touch $@
	
	
clean:
	rm -fv *.ps

clean-html:
	rm -f *.html
	
clean-target:
	rm -f $(pdf) *.dvi *.ps
	$(MAKE) clean-html
	
clean-all:
	make clean	
	make clean-target

	

