NAME=ananyev-project1-report

.PHONY: all clean purge view force


all: ananyev-project1-report.pdf

force: purge all

$(NAME).pdf: $(NAME).tex $(wildcard diags/*.tex) literature.bib $(shell find ../scattering/output -type f)
	mkdir -p img/generated
	latexmk -g -dvi- -ps- -pdf -pdflatex="lualatex --shell-restricted -synctex=1 %O %S" $<

clean:
	latexmk -c $(NAME)

purge:
	latexmk -C $(NAME)
	rm -rf img/generated

view: $(NAME).pdf
	nohup qpdfview $< 1>/dev/null 2>&1 &

SERVERNAME=VIM$(shell date +%s)
edit: $(NAME).pdf
	{ \
	nohup zathura -x 'vim --servername $(SERVERNAME) --remote-silent +%{line} %{input}' $< 1>/dev/null 2>&1 & \
	zathura_pid=$$!; \
	vim --servername $(SERVERNAME) --cmd "let g:vimtex_zathura_pid=$$zathura_pid" $(NAME).tex; \
	}
