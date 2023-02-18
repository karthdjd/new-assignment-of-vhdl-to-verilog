`timescale 1ns/1ps

module pulse_generator_tb;
  reg clk;
  reg rstn;
  wire  pulse_o;
  pulse_generator dut (
    .clk(clk),
    .rstn(rstn),
    .pulse_o(pulse_o)
  );

  
  initial clk = 1'b0;
  always #5 clk = ~clk;

  
  initial rstn = 1'b0;
  always #10 rstn = 1'b1;

  
  initial begin
	  $dumpfile("con10.vcd");
	  $dumpvars;
  end
	  always@(posedge clk)begin
if (pulse_o?1'b0:"error");
   end

 


endmodule
