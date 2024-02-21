module pal_tb ();

// configure these
parameter NUM_INPUTS = 4;
parameter NUM_OUPUTS = 1;
parameter NUM_INTERM_STAGES = 3;
// ---

localparam BITSTREAM_LEN = $signed(2*NUM_INPUTS*NUM_INTERM_STAGES + NUM_INTERM_STAGES*NUM_OUPUTS);

//reg clk_en_tb;
reg clk_tb; // this clock is unused...
reg clk_pal_tb;

wire [26:0] bitstream; // TODO: Update width by hand (according to assignment below)
assign bitstream = 27'b000000110000000100000010110; // TODO: Update this by hand

//assign clk_pal_tb = clk_tb ^ clk_en_tb;

reg config_tb;
reg [NUM_INPUTS-1:0] inputs_tb;
wire [NUM_OUPUTS-1:0] outputs_tb;

// UUT
PAL #(
    .N(NUM_INPUTS),
    .M(NUM_OUPUTS),
    .P(NUM_INTERM_STAGES)
) uut (
    .CLK(clk_pal_tb),
    .CFG(config_tb),
    .INPUT_VARS(inputs_tb),
    .OUTPUT_VALS(outputs_tb)
);

// Clock source
initial begin
    clk_tb=0;
    forever #2 clk_tb=~clk_tb;
end

integer i;
// Bitstream programming
initial begin
    clk_pal_tb = 1'b0;

    #10

    for (i = 0; i < BITSTREAM_LEN; i = i + 1) begin
        config_tb = bitstream[i];
        clk_pal_tb = 1'b1;
        #2;
        clk_pal_tb = 1'b0;
	end

    clk_pal_tb = 1'b0;
end

/*initial begin
    // hehe...
   //forever #10 inputs_tb = {~clk_tb,clk_tb,~clk_tb,clk_tb,~clk_tb,clk_tb,~clk_tb,clk_tb};
   inputs_tb = 8'b0000_1111;
   forever #10 inputs_tb = ~inputs_tb;
end*/

// Testcase
initial begin
    $dumpfile("../output/SIM.vcd");
    $dumpvars(0, pal_tb);

    #1000

    inputs_tb = 8'b0000_1111;

    #1000

    inputs_tb = 8'b0000_0000;

    #1000

    inputs_tb = 8'b0000_1010;

    #1000

    $finish;
end
    
endmodule