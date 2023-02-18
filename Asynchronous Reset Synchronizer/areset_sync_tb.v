module tb_areset_sync;

  // Parameters
  parameter STAGES = 2;
  parameter PERIOD = 10;
  
  // Inputs
  reg clk;
  reg async_rst_i;
  
  // Outputs
  wire sync_rst_o;
  
  // Instantiate the module
  areset_sync #(STAGES) dut (
    .clk(clk),
    .async_rst_i(async_rst_i),
    .sync_rst_o(sync_rst_o)
  );
  initial  begin
	  clk=0;
  end
  // Clock generation
  always #((PERIOD/2)) clk = ~clk;
  
  // Initial stimulus
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
    // Assert sync_rst_o is low when async_rst_i is low
    if (!async_rst_i?!sync_rst_o:1);
    // Assert sync_rst_o is high when async_rst_i is high
    if (async_rst_i?sync_rst_o:1);
  end
initial#100 $finish;


endmodule
