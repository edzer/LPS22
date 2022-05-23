all:
		vi pres.qmd
		quarto render pres.qmd --to beamer
		evince pres.pdf
