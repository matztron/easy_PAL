#!/usr/bin/env bash

# do 'chmod +x latch_sim.sh' on this script to execute it :)

OUTPUT_PATH="../output"
SRC_PATH=".."
TB_PATH="../testbenches"

# in case there are already old files: delete them to avoid confusion!
rm ${OUTPUT_PATH}/*

iverilog -o ${OUTPUT_PATH}/stride_sim ${TB_PATH}/stride_tb.v ${SRC_PATH}/STRIDE.v
vvp ${OUTPUT_PATH}/stride_sim
gtkwave ${OUTPUT_PATH}/stride_sim.vcd &