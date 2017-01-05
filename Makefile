.PHONY: src

TEX = xelatex
SOURCE = src

define generate
endef

all: resume cv cover

resume:
	make TYPE=resume generate

cv:
	make TYPE=cv generate

cover:
	make TYPE=cover generate

generate: $(SOURCE)/$(TYPE).tex $(shell find $(SOURCE)/$(TYPE) -name '*.tex')
	$(TEX) -output-directory=$(SOURCE) $<
	mv $(SOURCE)/$(TYPE).pdf build/$(TYPE).pdf
	gs \
		-dCompatibilityLevel=1.4 \
		-dPDFSETTINGS=/prepress \
		-dCompressFonts=true \
		-dSubsetFonts=true \
		-dNOPAUSE \
		-dBATCH \
		-dQUIET \
		-sDEVICE=pdfwrite \
		-sOutputFile=build/$(TYPE).gs.pdf \
		-c ".setpdfwrite <</NeverEmbed [ ]>> setdistillerparams" \
		-f build/$(TYPE).pdf
	rm -rf build/$(TYPE).pdf
	mv build/$(TYPE).gs.pdf build/$(TYPE).pdf
	convert -density 300 -depth 8 -quality 85 build/$(TYPE).pdf[0] build/$(TYPE).jpg

clean:
	rm -rf $(SOURCE)/*.aux
	rm -rf $(SOURCE)/*.log
	rm -rf $(SOURCE)/*.out
