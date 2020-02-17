runipy_pdf:
	cp *.tplx nbconvert_book.sty _runipy/
	cp -r images _runipy/
	cp Jupyt-Nb.tex SummaryReport.tex _runipy/
	python run_notebooks.py
	make -C _runipy SummaryReport.pdf

SummaryReport.pdf: SummaryReport.tex \
	00-intro.tex 01-chapter1.tex 02-chapter2.tex \
	03-chapter3.tex 04-chapter4.tex \
	05-chapter5.tex  06-chapter6.tex \
	07-chapter7.tex 08-chapter8.tex 09-chapter9.tex \
	10-chapter10.tex 11-chapter11.tex
	pdflatex $<
	pdflatex $<

SummaryReport_xelatex.pdf: SummaryReport.tex \
	00-intro.tex 01-chapter1.tex 02-chapter2.tex \
	03-chapter3.tex 04-chapter4.tex \
	05-chapter5.tex  06-chapter6.tex \
	07-chapter7.tex 08-chapter8.tex 09-chapter9.tex \
	10-chapter10.tex 11-chapter11.tex
	xelatex $<
	xelatex $<

all_html: index.html \
		00-intro.html 01-chapter1.html 02-chapter2.html \
	  03-chapter3.html 04-chapter4.html \
	  05-chapter5.html  06-chapter6.html \
	  07-chapter7.html 08-chapter8.html 09-chapter9.html \
	  10-chapter10.html 11-chapter11.html

web_html: website-index.html \
		00-intro.html 01-chapter1.html 02-chapter2.html \
	  03-chapter3.html 04-chapter4.html \
	  05-chapter5.html  06-chapter6.html \
	  07-chapter7.html 08-chapter8.html 09-chapter9.html \
	  10-chapter10.html 11-chapter11.html

%.pdf: %.tex %.ipynb
	pdflatex $<
	pdflatex $<

%.tex: %.ipynb chapter-base.tplx
	jupyter nbconvert --to latex --template=chapter-ipython.tplx $<

%.html: %.ipynb full-title.tpl
		jupyter nbconvert --to html --template=full-title.tpl $<

test.tex: test.ipynb
	jupyter nbconvert --to latex $<
slide-example.tex: slide-example.ipynb
	jupyter nbconvert --to latex $<

webpages: web_html
	mkdir -p webpages
	cp [01]*html slide-example.html webpages/
	cp website-index.html webpages/index.html
	cp -r images webpages/
	ghp-import -m "Generate website" -b gh-pages webpages
	git push origin gh-pages

# Makefile for Sphinx documentation
#

# You can set these variables from the command line.
SPHINXOPTS    =
SPHINXBUILD   = sphinx-build
PAPER         =
BUILDDIR      = _build

# User-friendly check for sphinx-build
ifeq ($(shell which $(SPHINXBUILD) >/dev/null 2>&1; echo $$?), 1)
$(error The '$(SPHINXBUILD)' command was not found. Make sure you have Sphinx installed, then set the SPHINXBUILD environment variable to point to the full path of the '$(SPHINXBUILD)' executable. Alternatively you can add the directory with the executable to your PATH. If you don't have Sphinx installed, grab it from http://sphinx-doc.org/)
endif

# Internal variables.
PAPEROPT_a4     = -D latex_paper_size=a4
PAPEROPT_letter = -D latex_paper_size=letter
ALLSPHINXOPTS   = -d $(BUILDDIR)/doctrees $(PAPEROPT_$(PAPER)) $(SPHINXOPTS) .
# the i18n builder cannot share the environment and doctrees with the others
I18NSPHINXOPTS  = $(PAPEROPT_$(PAPER)) $(SPHINXOPTS) .

html:
	$(SPHINXBUILD) -b html $(ALLSPHINXOPTS) $(BUILDDIR)/html
	@echo
	@echo "Build finished. The HTML pages are in $(BUILDDIR)/html."

epub:
	$(SPHINXBUILD) -b epub $(ALLSPHINXOPTS) $(BUILDDIR)/epub
	@echo
	@echo "Build finished. The epub file is in $(BUILDDIR)/epub."


clean:
	rm -f *.{out,log,aux,toc}
	rm -rf auto
	rm -f [01]*tex
	rm -rf [01]*files
	rm -f Exercises*tex
	rm -rf Exercises*files
	rm -rf __pycache__
	rm -f *.html
	rm -rf webpages
	rm -rf $(BUILDDIR)/*
	rm -f _runipy/*.{ipynb,tex,out,log,aux,toc}
	rm -rf _runipy/*_files _runipy/images _runipy/.ipynb_checkpoints
	rm -f _runipy/*.{tplx,sty}
