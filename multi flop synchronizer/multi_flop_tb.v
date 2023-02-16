module mul_flop_syn_tb;

	// Inputs
	reg clk1;
	reg clk2;
	
	reg rst;
	reg din;

	// Outputs
	wire dout;

	// Instantiate the Unit Under Test (UUT)
	mul_flop_syn  dut (
		.clk1(clk1),
	       .clk2(clk2),	
		 
		.rst(rst),		
		.din(din), 
		.dout(dout)
	);

always #10 clk1 = ~clk1;
always #5  clk2= ~clk2;

initial
  $monitor($time," clk1=%b,clk2=%b, din=%b, dout=%b, rst=%b",clk1,clk2,din,dout,rst);

initial
  begin
	  $dumpfile("dfsy.vcd");
	  $dumpvars;
  clk1=1'b0;clk2=1'b0; din=1'b0; rst=1'b0;
  #3 rst=1'b1;
  #17 din=1'b1;
  #60 $finish;
  end
  
endmodule
