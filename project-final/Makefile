OUTPUT_DIR=output/

.PHONY: all report_clean report_full opendata_playground eda feature_processing modelling clean

all: report_clean report_full

report_clean: $(OUTPUT_DIR)/report_clean.html
report_full: $(OUTPUT_DIR)/report_full.html

$(OUTPUT_DIR)/report_clean.html: $(addsuffix _clean, opendata_playground eda feature_processing modelling)
	cat $(addprefix $(OUTPUT_DIR), $(addsuffix .html, $^)) > $@

$(OUTPUT_DIR)/report_full.html: $(addsuffix _full, opendata_playground eda feature_processing modelling)
	cat $(addprefix $(OUTPUT_DIR), $(addsuffix .html, $^)) > $@

opendata_playground_clean: $(OUTPUT_DIR)/opendata_playground_clean.html
eda_clean: $(OUTPUT_DIR)/eda_clean.html
feature_processing_clean: $(OUTPUT_DIR)/feature_processing_clean.html
modelling_clean: $(OUTPUT_DIR)/modelling_clean.html

opendata_playground_full: $(OUTPUT_DIR)/opendata_playground_full.html
eda_full: $(OUTPUT_DIR)/eda_full.html
feature_processing_full: $(OUTPUT_DIR)/feature_processing_full.html
modelling_full: $(OUTPUT_DIR)/modelling_full.html

$(OUTPUT_DIR)/%_full.html: %.ipynb 
	mkdir -p $(dir $@)
	jupyter nbconvert --to=html --stdout  $< > $@

$(OUTPUT_DIR)/%_clean.html: %.ipynb 
	mkdir -p $(dir $@)
	jupyter nbconvert --to=html --TagRemovePreprocessor.remove_input_tags='{"hide_input"}' --TagRemovePreprocessor.remove_cell_tags='{"hide"}' --TagRemovePreprocessor.remove_single_output_tags='{"hide_output"}' --stdout $< > $@

clean:
	rm -rf $(OUTPUT_DIR)
