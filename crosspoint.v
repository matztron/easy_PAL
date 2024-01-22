module CROSSPOINT (
    input data_in,
    input cfg_in,
    output data_out
);

    assign data_out = data_in & cfg_in;
    
endmodule