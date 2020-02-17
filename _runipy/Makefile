SummaryReport.pdf: SummaryReport.tex \
	00-intro.tex 01-chapter1.tex 02-chapter2.tex \
	03-chapter3.tex 04-chapter4.tex \
	05-chapter5.tex  06-chapter6.tex \
	07-chapter7.tex 08-chapter8.tex 09-chapter9.tex \
	10-chapter10.tex 11-chapter11.tex latex_chapter.tex
	pdflatex $<
	pdflatex $<

%.pdf: %.tex %.ipynb
	pdflatex $<
	pdflatex $<

%.tex: %.ipynb chapter-base.tplx
	jupyter nbconvert --to latex --template=chapter-ipython.tplx $<
