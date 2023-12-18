module PAL #(
    parameter N = 8, // Number of Inputs
    parameter M = 8, // NUmber of outputs
    parameter P = 8 // Number of intermediate stages
)(
    input CLK,
    input CFG,
    input INPUT_VARS,
    input OUTPUT_VALS
);

    parameter SR_LEN = 2*N+(N+M)*P;

    // Configuration chain
    wire [SR_LEN-1:0] FF_CHAIN;

    // ---
    // FF_CHAIN
    //
    // <MSB> [ OR | ... | OR | OR | AND | ... | AND | AND | AND-INV | ... | AND-INV | AND-INV ] <LSB>
    //
    // When bit at INV is 1 then it is inverted!
    // ---

    // Shift register (stores the configuration)
    SR #(
        .LEN(SR_LEN)
    ) sr (
        .CLK(CLK),
        .CFG(CFG),
        .FF_CHAIN(FF_CHAIN)
    );

    // NOT gates
    // redo this!
    wire [N-1:0] INPUT_VARS_N;

    for (i = 0; i < 2N; i = i + 1) begin
        if (i % 2 == 0) begin
            // even: keep
            assign INPUT_VARS_N[i] = INPUT_VARS[i];
        end else begin
            // odd: invert
            assign INPUT_VARS_N[i] = ~INPUT_VARS[i];
        end
    end
    // ---

    // AND matrix
    for (p = 0; p < P; p = p + 1) begin
        for (n = 0; n < 2*N; n = n + 1 ) begin
            assign INTERM_VARS[p] ^= (CFG[n + P*p] ^ INPUT_VARS[n]);
        end
    end
    // ---

    // OR matrix
    // ---
    
endmodule