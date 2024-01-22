module pal_tb ();

// configure these
parameter NUM_INPUTS = 4;
parameter NUM_OUPUTS = 3;
parameter NUM_INTERM_STAGES = 3;
// ---

reg clk_en_tb;
reg clk_tb;
wire clk_pal_tb;

assign clk_pal_tb = clk_tb ^ clk_en_tb;

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
    forever #10 clk_tb=~clk_tb;
end

/*initial begin
    // hehe...
    forever #10 config_tb = clk_tb;
end*/

initial begin
    // hehe...
   //forever #10 inputs_tb = {~clk_tb,clk_tb,~clk_tb,clk_tb,~clk_tb,clk_tb,~clk_tb,clk_tb};
   inputs_tb = 8'b0000_1111;
   forever #10 inputs_tb = ~inputs_tb;
end

// Testcase
initial begin
    $dumpfile("SIM.vcd");
    $dumpvars(0, pal_tb);

    config_tb = 1'b1;

    clk_en_tb = 1'b1;

    // INPUTS
    //inputs_tb = 8'b1010_1010;

    #1000

    clk_en_tb = 1'b0;

    #4000

    $finish;
end
    
endmodule