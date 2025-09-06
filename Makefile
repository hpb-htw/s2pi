# Asymptote Makefile
#exclude := $(wildcard _*.tex)
#tex := $(wildcard *.tex)
asy := $(wildcard *.asy)
exclude := tools.asy
asy := $(filter-out $(exclude), $(asy))
pdf := $(asy:.asy=.pdf)


tmp_ext := aux out log pre synctex.gz

all: $(pdf)

%.pdf: %.asy
	asy $<

$(asy): $(exclude)
	touch $@
	
	
clean:
	rm -fv *.aux *.out *.bbl *.blg *.pytxcode *.pre *.toc *.loe *.thm *.nav *.bcf *.tdo *.log *.run.xml *.snm *.vrb *.synctex.gz *.fls
	rm -rf *.fdb_latexmk	

clean-html:
	rm -f *.html
	
clean-target:
	rm -f *.pdf *.dvi
	$(MAKE) clean-html
	
clean-all:
	make clean	
	make clean-target

	

