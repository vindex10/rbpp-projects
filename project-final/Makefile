OUTPUT_DIR=output/

.PHONY: all opendata_playground clean

all: report

report: $(OUTPUT_DIR)/report.html

$(OUTPUT_DIR)/report.html: opendata_playground eda feature_processing modelling
	cat $(addprefix $(OUTPUT_DIR), $(addsuffix .html, $^)) > $@

opendata_playground: $(OUTPUT_DIR)/opendata_playground.html
eda: $(OUTPUT_DIR)/eda.html
feature_processing: $(OUTPUT_DIR)/feature_processing.html
modelling: $(OUTPUT_DIR)/modelling.html

$(OUTPUT_DIR)/%.html: %.ipynb 
	mkdir -p $(dir $@)
	jupyter nbconvert --to=html --TagRemovePreprocessor.remove_input_tags='{"hide_input"}' --TagRemovePreprocessor.remove_cell_tags='{"hide"}' --TagRemovePreprocessor.remove_single_output_tags='{"hide_output"}' --output-dir=output/  $<

clean:
	rm -rf $(OUTPUT_DIR)
