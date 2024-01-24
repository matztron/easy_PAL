module reduce_tb ();

// configure these
parameter OPERATION_TB = "bob";
parameter LEN_TB = 8;
parameter STRIDE_TB = 2; 
// ---

reg clk_tb;

reg [LEN_TB-1:0] data_in_tb;
wire reduced_out_tb;

//UUT
REDUCE #(
    .LEN(LEN_TB),
    .STRIDE(STRIDE_TB),
    .OPERATION(OPERATION_TB)
) uut (
    .data_in(data_in_tb),
    .reduced_out(reduced_out_tb)
);

// Clock source
initial begin
    clk_tb=0;
    forever #10 clk_tb=~clk_tb;
end

// Testcase
initial begin
    $dumpfile("../output/reduce_sim.vcd");
    $dumpvars(0, reduce_tb);

    data_in_tb = 8'b1010_0000;

    #10

    data_in_tb = 8'b0101_0101;

    #10

    data_in_tb = 8'b1010_1010;

    #10

    $finish;
end
    
endmodule