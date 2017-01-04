.PHONY: src

CC = xelatex
SOURCE_DIR = src
RESUME_DIR = src/resume
CV_DIR = src/cv
RESUME_SRCS = $(shell find $(RESUME_DIR) -name '*.xtex')
CV_SRCS = $(shell find $(CV_DIR) -name '*.xtex')

all:
	make resume
	make cv
	make cover

resume: $(SOURCE_DIR)/resume.xtex $(RESUME_SRCS)
	$(CC) -output-directory=$(SOURCE_DIR) $<
	mv $(SOURCE_DIR)/resume.pdf build/

cv: $(SOURCE_DIR)/cv.xtex $(CV_SRCS)
	$(CC) -output-directory=$(SOURCE_DIR) $<
	mv $(SOURCE_DIR)/cv.pdf build/

cover: $(SOURCE_DIR)/cover.xtex
	$(CC) -output-directory=$(SOURCE_DIR) $<
	mv $(SOURCE_DIR)/cover.pdf build/

clean:
	rm -rf *.pdf
	rm -rf $(SOURCE_DIR)/*.aux
	rm -rf $(SOURCE_DIR)/*.log
	rm -rf $(SOURCE_DIR)/*.out
