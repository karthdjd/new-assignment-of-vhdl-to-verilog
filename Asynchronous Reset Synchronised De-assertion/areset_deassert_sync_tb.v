module areset_deassert_sync_tb;
reg clk;
  reg async_rst_i;
  
  // Outputs
  wire sync_rst_o;
  parameter CHAINS  = 2;   
  parameter RST_POL = 1;
  areset_deassert_sync #(CHAINS) dut (
    .clk(clk),
    .async_rst_i(async_rst_i),
    .sync_rst_o(sync_rst_o)
  );
  initial begin
	  clk=0;
  end
  
 always #5 clk = ~clk;

  
  

  
  initial begin
    async_rst_i = 1;
    #10 async_rst_i = 0;
    #100 async_rst_i = 1;
    #10 async_rst_i = 0;
    #100 async_rst_i = 1;
    #10 $finish;
  end
  initial begin
	  $dumpfile("con3.vcd");
	  $dumpvars;

  end 
  always @(posedge clk) begin
    $display("sync_rst_o = %b", sync_rst_o);
  end

endmodule
