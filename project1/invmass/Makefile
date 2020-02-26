NAME=invmass
ROOTNB_DIR=$(HOME)/.rootnb
OUTPUT_DIR=output

.PHONY: all purge force

all: $(OUTPUT_DIR)/$(NAME).html

$(OUTPUT_DIR)/$(NAME).html: $(NAME).ipynb
	mkdir -p $(OUTPUT_DIR)
	JUPYTER_DATA_DIR="$(ROOTNB_DIR)" JUPYTER_CONFIG_DIR="$(ROOTNB_DIR)" jupyter nbconvert --execute --ExecutePreprocessor.timeout=-1 --to="html" --output-dir=$(OUTPUT_DIR) $<

purge:
	rm -rf $(OUTPUT_DIR)

force: purge all
