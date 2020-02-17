OUTPUT_DIR=output
SCRIPTS_DIR=scripts

.PHONY: melsq dcrsc totcrsc symbolic plots all clean

all: ${OUTPUT_DIR}/visualized/visualize.html

melsq: ${OUTPUT_DIR}/melsq.output

${OUTPUT_DIR}/melsq.output:
	${SCRIPTS_DIR}/generate.sh melsq

dcrsc: ${OUTPUT_DIR}/dcrsc.output

${OUTPUT_DIR}/dcrsc.output: ${OUTPUT_DIR}/melsq.output
	${SCRIPTS_DIR}/generate.sh dcrsc

totcrsc: ${OUTPUT_DIR}/totcrsc.output

${OUTPUT_DIR}/totcrsc.output: ${OUTPUT_DIR}/melsq.output
	${SCRIPTS_DIR}/generate.sh totcrsc

SYMBOLIC_OUTPUTS=${OUTPUT_DIR}/melsq.output ${OUTPUT_DIR}/dcrsc.output ${OUTPUT_DIR}/totcrsc.output
symbolic: ${SYMBOLIC_OUTPUTS}

${OUTPUT_DIR}/visualized/visualize.html: ${SYMBOLIC_OUTPUTS}
	mkdir -p ${OUTPUT_DIR}/visualized
	jupyter nbconvert --to=html --execute visualize.ipynb --output=${OUTPUT_DIR}/visualized/visualize.html

plots: ${OUTPUT_DIR}/visualized/visualize.html

clean:
	rm -rf ${OUTPUT_DIR}
