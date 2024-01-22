module SR #(
    parameter LEN=8
)(
    input CLK,
    input CFG,
    output reg [LEN-1:0] FF_CHAIN
);

// Shift left whenever a posedge occurs
always @(posedge CLK) begin
    FF_CHAIN    <= FF_CHAIN << 1;
    FF_CHAIN[0] <= CFG;
end

endmodule