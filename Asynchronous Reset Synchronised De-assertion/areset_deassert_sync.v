module areset_deassert_sync (
  input        clk,
  input        async_rst_i,
  output    sync_rst_o
);

  parameter CHAINS  = 2;   
  parameter RST_POL = 1;  

  
  reg [CHAINS-1:0] flipflops;

 
  always @(posedge clk, negedge async_rst_i) begin
    if (async_rst_i == RST_POL) begin
      flipflops <= {CHAINS{RST_POL}};
    end else begin
      flipflops <= {flipflops[CHAINS-2:0], ~RST_POL};
    end
  end

  
  assign sync_rst_o = flipflops[CHAINS-1];

  endmodule
