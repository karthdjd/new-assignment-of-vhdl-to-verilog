module mul_flop_syn (
  clk1,
 clk2, 
   rst,
  din,  
  dout  
  );

input clk1,clk2,rst,din;
output dout;
reg dout, din_flop;
reg mdata;

always@(posedge clk1 or negedge rst)
  if(!rst) din_flop <= 1'b0;
  else din_flop <= din;

always@(posedge clk2 or negedge rst)
begin
  if(!rst) 
  begin
    mdata <= 1'b0;
    dout  <= 1'b0;
  end
  else
  begin 
    mdata <= din_flop;
    dout  <= mdata;
  end
end
endmodule
