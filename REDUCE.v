module REDUCE #(
    parameter OPERATION = "and", // either put "and" or "or"
    parameter LEN = 8,
    parameter STRIDE = 2
) (
    input [LEN-1:0] data_in,
    output reduced_out
);

    wire [LEN/STRIDE-1:0] data_stride; 

    //Stride instance
    STRIDE #(
        .LEN(LEN),
        .STRIDE(STRIDE)
    ) stride_I (
        .in(data_in),
        .strided_out(data_stride)
    );

    // Reduce operation
    generate
        if (OPERATION == "and") begin
            assign reduced_out = &data_stride;
        end else if (OPERATION == "or") begin
            assign reduced_out = |data_stride;
        end else begin
            // error! invalid operator specified!
            assign reduced_out = 1'bx;
        end
    endgenerate

endmodule