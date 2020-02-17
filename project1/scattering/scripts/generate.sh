#/bin/bash

set -e;
set -x;

CMD="$1"

function extract_res_name() {
    tee | head -n2 | tail -n+2 | awk -F'=' '{print $1}' | sed 's/[[:space:]]//g';
}

OUTPUT_DIR=output
FORMCMD='form -q -p ../../external/form-square/:symbolic/'

mkdir -p "$OUTPUT_DIR"
MELSQ_FILE="$OUTPUT_DIR/melsq.output"

function generate_melsq() {
    $FORMCMD symbolic/melsq.frm > "$MELSQ_FILE"
}

function generate_dcrsc() {
    if [ ! -f "$MELSQ_FILE" ]; then
        echo "Run melsq first";
        exit 1;
    fi

    MELSQ_NAME=$(cat "$MELSQ_FILE" | extract_res_name)
    $FORMCMD -D INPUTFILE="$MELSQ_FILE" -D FROMNAME="$MELSQ_NAME" symbolic/dcrsc.frm > "$OUTPUT_DIR/dcrsc.output"
}

function generate_totcrsc() {
    if [ ! -f "$MELSQ_FILE" ]; then
        echo "Run melsq first";
        exit 1;
    fi

    MELSQ_NAME=$(cat "$MELSQ_FILE" | extract_res_name)
    $FORMCMD -D INPUTFILE="$MELSQ_FILE" -D FROMNAME="$MELSQ_NAME" symbolic/totcrsc.frm > "$OUTPUT_DIR/totcrsc.output"
}

case "$CMD" in
    melsq)
        generate_melsq
        ;;
    dcrsc)
        generate_dcrsc
        ;;
    totcrsc)
        generate_totcrsc
        ;;
    *)
        generate_melsq;
        generate_dcrsc;
        generate_totcrsc;
    ;;
esac;
