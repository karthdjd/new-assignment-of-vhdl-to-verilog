module areset_deassert_sync (
  input        clk,
  input        async_rst_i,
  output    sync_rst_o
);

  parameter CHAINS  = 2;   // No. of flip-flops in the synchronization chain; at least
  parameter RST_POL = 1;   // Polarity of Asynchronous Reset

  // Synchronisation Chain of Flip-Flops
  reg [CHAINS-1:0] flipflops;

  // Synchronizer process
  always @(posedge clk, negedge async_rst_i) begin
    if (async_rst_i == RST_POL) begin
      flipflops <= {CHAINS{RST_POL}};
    end else begin
      flipflops <= {flipflops[CHAINS-2:0], ~RST_POL};
    end
  end

  // Reset out with synchronized de-assertion
  assign sync_rst_o = flipflops[CHAINS-1];

  endmodule
