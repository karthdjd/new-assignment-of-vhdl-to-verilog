module min_width_reset (
    input clk,      // Clock
    input rst_i,    // Synchronous Reset in
    output rst_o    // Synchronous Reset out with min. pulse width assured
);

parameter MIN_WIDTH = 4;   // Minimum pulse width of reset to be recognized, [2-16]
parameter RST_POL = 0;     // Polarity of Synchronous Reset

// Pulse Width Validator Chain : Synchronous Chain of Flip-Flops
reg [MIN_WIDTH-1:0] sync_chain_rg = ~RST_POL;
wire [MIN_WIDTH-1:0] temp_level0;
wire [MIN_WIDTH-1:0] temp_level1;
wire muxed_sync_rst;
reg muxed_sync_rst_rg = RST_POL;

// Clocked process
always @(posedge clk) begin
    sync_chain_rg <= {sync_chain_rg[MIN_WIDTH-2:0], rst_i};
    muxed_sync_rst_rg <= muxed_sync_rst;
end

// Generate statement to self-OR and self-AND all bits of Synchronizer chain
assign temp_level0[0] = sync_chain_rg[0];
assign temp_level1[0] = sync_chain_rg[0];

genvar i;
generate
    for (i = 1; i < MIN_WIDTH; i = i+1) begin
        assign temp_level1[i] = temp_level1[i-1] & sync_chain_rg[i];
        assign temp_level0[i] = temp_level0[i-1] | sync_chain_rg[i];
    end
endgenerate

// Muxed reset
assign muxed_sync_rst = muxed_sync_rst_rg ? temp_level0[MIN_WIDTH-1] : temp_level1[MIN_WIDTH-1];

// Reset out
assign rst_o = muxed_sync_rst_rg;

endmodule
