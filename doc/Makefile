TEXFILE=image_compression

all:
	@echo "Targets importantes:"
	@echo "      dvi: General el .dvi"
	@echo "      pdf: General el .pdf"
	@echo "       ps: General el .ps"
	@echo "     vpdf: Visualiza el .pdf"
	@echo "     evpdf: Visualiza el .pdf con evince"
	@echo "     vdvi: Visualiza el .dvi"
	@echo "      vps: Visualiza el .ps"
	@echo "      eps: Genera las imágenes .eps"
	@echo " cleanimg: Borra las imágenes .eps"
	@echo "    clean: Borra los derivados del LaTeX" 
	@echo " cleanall: Borra todo"

eps:
	make -C img eps

pdf : $(TEXFILE).pdf
	acroread $(TEXFILE).pdf

evpdf : pdf
	evince $(TEXFILE).pdf &

vpdf: $(TEXFILE).pdf
	xpdf $(TEXFILE).pdf&

vps: $(TEXFILE).ps
	gv $(TEXFILE).ps&

vdvi: $(TEXFILE).dvi
	xdvi $(TEXFILE).dvi&

$(TEXFILE).ps :  $(TEXFILE).dvi
	dvips $(TEXFILE).dvi

$(TEXFILE).pdf :  $(TEXFILE).dvi
	dvipdf  $(TEXFILE).dvi

dvi: $(TEXFILE).dvi
    
$(TEXFILE).dvi :   eps $(TEXFILE).tex
	latex  $(TEXFILE).tex
	makeindex $(TEXFILE).idx
	latex  $(TEXFILE).tex
	latex  $(TEXFILE).tex

aspell: $(TEXFILE).tex
	aspell -t --encoding=iso8859-1 -c $(TEXFILE).tex

force:
	touch $(TEXFILE).tex
	make

clean:
	@-rm -f  $(TEXFILE).dvi $(TEXFILE).pdf $(TEXFILE).log $(TEXFILE).toc 2>/dev/null
	@-rm -f  $(TEXFILE).aux $(TEXFILE).ps $(TEXFILE).bbl $(TEXFILE).blg  2>/dev/null
	@-rm -f $(TEXFILE).lof $(TEXFILE).idx $(TEXFILE).ind $(TEXFILE).ilg $(TEXFILE).bkp Makefile.bkp 2>/dev/null

cleanimg:
	$(MAKE) -C img clean

cleanall: clean cleanimg