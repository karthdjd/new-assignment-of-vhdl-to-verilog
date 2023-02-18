module clock_gate(
  input clk_i,     
  input en_i,     
  output reg clk_o 
);

reg en_latched;

always @ (posedge clk_i) begin
  en_latched <= en_i;
end

always @ (*) begin
  clk_o = clk_i & en_latched;
end

endmodule
