module tb_areset_sync;

  
  parameter STAGES = 2;
  parameter PERIOD = 10;
  
  
  reg clk;
  reg async_rst_i;
  
  
  wire sync_rst_o;
  
  
  areset_sync #(STAGES) dut (
    .clk(clk),
    .async_rst_i(async_rst_i),
    .sync_rst_o(sync_rst_o)
  );
  initial  begin
	  clk=0;
  end
  
  always #5 clk = ~clk;
  
  
  initial begin
	  $dumpfile("con2.vcd");
	  $dumpvars;
    async_rst_i = 0;
    #10;
    async_rst_i = 1;
    #10;
    async_rst_i = 0;
    
  end
  
 always @(posedge clk) begin
    
    if (!async_rst_i?!sync_rst_o:1);
    if (async_rst_i?sync_rst_o:1);
  end
initial#100 $finish;


endmodule
