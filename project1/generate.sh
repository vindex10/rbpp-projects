#!/bin/bash

set -e;
set -x;

function extract_res_name() {
    tee | head -n2 | tail -n+2 | awk -F'=' '{print $1}' | sed 's/[[:space:]]//g';
}

OUTPUT_DIR=output
FORMCMD='form -q -p ../external/form-square/:symbolic/'

mkdir -p "$OUTPUT_DIR"

MELSQ_FILE="$OUTPUT_DIR/melsq.output"
MELSQ_NAME=$($FORMCMD symbolic/melsq.frm | tee "$MELSQ_FILE" | extract_res_name)

$FORMCMD -D INPUTFILE="$MELSQ_FILE" -D FROMNAME="$MELSQ_NAME" symbolic/dcrsc.frm > "$OUTPUT_DIR/dcrsc.output"
$FORMCMD -D INPUTFILE="$MELSQ_FILE" -D FROMNAME="$MELSQ_NAME" symbolic/totcrsc.frm > "$OUTPUT_DIR/totcrsc.output"
