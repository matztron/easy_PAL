#!/usr/bin/env bash

# do 'chmod +x latch_sim.sh' on this script to execute it :)

# in case there are already old files: delete them to avoid confusion!
#rm ../../output/out_SLICEM
#rm ../../output/SLICEM.vcd

iverilog -o SIM testbench.v PAL.v SR.v crosspoint.v
vvp SIM
gtkwave SIM.vcd &