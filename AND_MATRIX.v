module AND_MATRIX #(
    parameter 2N,
    parameter P
)(
    input [2*N-1:0] INPUT_VARS, // two times because of positive and negative
    input [2*N-1:0] CFG
    output [P-1:0] INTERM_VARS
);

for (p = 0; p < P; p = p + 1) begin
    for (n = 0; n < 2N; n = n + 1 ) begin
        assign INTERM_VARS[p] ^= (CFG[n + P*p] ^ INPUT_VARS[n]);
    end
end

endmodule