NAME=ananyev-project1-report
OUTPUT_DIR=output/

.PHONY: all clean purge view force


all: $(OUTPUT_DIR)/ananyev-project1-report.pdf

force: purge all

$(OUTPUT_DIR)/$(NAME).pdf: $(NAME).tex $(wildcard diags/*.tex) literature.bib $(shell find ../scattering/output -type f)
	mkdir -p $(OUTPUT_DIR)
	latexmk -outdir=$(OUTPUT_DIR) -g -dvi- -ps- -pdf -pdflatex="lualatex --shell-restricted -synctex=1 %O %S" $<

clean:
	rm -rf $(OUTPUT_DIR)

purge: clean
	latexmk -outdir=$(OUTPUT_DIR) -C $(NAME).tex

view: $(OUTPUT_DIR)/$(NAME).pdf
	nohup qpdfview $< 1>/dev/null 2>&1 &

SERVERNAME=VIM$(shell date +%s)
edit: $(OUTPUT_DIR)/$(NAME).pdf
	{ \
	nohup zathura -x 'vim --servername $(SERVERNAME) --remote-silent +%{line} %{input}' $(NAME).pdf 1>/dev/null 2>&1 & \
	zathura_pid=$$!; \
	vim --servername $(SERVERNAME) --cmd "let g:vimtex_zathura_pid=$$zathura_pid" $(NAME).tex; \
	}
