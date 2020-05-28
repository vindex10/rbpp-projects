OUTPUT_DIR=output/

.PHONY: all opendata_playground clean

all: report

report: opendata_playground eda feature_processing

opendata_playground: $(OUTPUT_DIR)/opendata_playground.html
eda: $(OUTPUT_DIR)/eda.html
feature_processing: $(OUTPUT_DIR)/feature_processing.html

$(OUTPUT_DIR)/%.html: %.ipynb 
	mkdir -p $(dir $@)
	jupyter nbconvert --to=html --TagRemovePreprocessor.remove_input_tags='{"hide_input"}' --TagRemovePreprocessor.remove_cell_tags='{"hide"}' --TagRemovePreprocessor.remove_single_output_tags='{"hide_output"}' --output-dir=output/  $<

clean:
	rm -rf $(OUTPUT_DIR)
