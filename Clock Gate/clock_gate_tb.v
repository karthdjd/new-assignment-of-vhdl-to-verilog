module clock_gate_tb();

reg clk_i;
reg en_i;
wire clk_o;

clock_gate dut(
  .clk_i(clk_i),
  .en_i(en_i),
  .clk_o(clk_o)
);

initial begin
  $dumpfile("con11.vcd");
  $dumpvars;
  
  
  clk_i = 0;
  en_i = 0;
  #10;
  #5 en_i=1;
  #10 en_i=0;
  end

  always#5 clk_i=~clk_i;

initial #100  $finish;


endmodule
