module pulse_sync_tb;

  // Inputs
  reg clk_a = 0;
  reg rstn_a = 0;
  reg clk_b = 0;
  reg rstn_b = 0;
  reg pulseA_i = 0;

  // Outputs
  wire pulseB_o;
  wire busy_o;

  // Instantiate the unit under test (UUT)
  pulse_sync uut (
    .clk_a(clk_a),
    .rstn_a(rstn_a),
    .clk_b(clk_b),
    .rstn_b(rstn_b),
    .pulseA_i(pulseA_i),
    .pulseB_o(pulseB_o),
    .busy_o(busy_o)
  );

  initial begin
	  clk_a=0;
	  clk_b=0;
	  rstn_a=0;
	  rstn_b=0;
	  pulseA_i=0;
	 #5 rstn_a=1;
	 #5 rstn_b=1;
	 #20 rstn_a=0;
         #20  rstn_b=0;
	 #5 pulseA_i=1;


  end

  // Clock generation
  always #5 clk_a <= ~clk_a;
  always #10 clk_b <= ~clk_b;
always #20 pulseA_i <= ~pulseA_i;
  // Stimulus
 
  initial begin
	  $dumpfile("con4.vcd");
	  $dumpvars;
  end
initial #100 $finish;
endmodule
