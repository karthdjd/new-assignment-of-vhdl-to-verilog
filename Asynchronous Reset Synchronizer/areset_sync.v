module areset_sync #(parameter STAGES=2)
  (input clk, input async_rst_i, output sync_rst_o);
  
  reg [STAGES-1:0] flipflops;
  
  assign sync_rst_o = flipflops[STAGES-1];
  
  always @(posedge clk) begin
    flipflops <= {flipflops[STAGES-2:0], async_rst_i};
  end
  
endmodule
