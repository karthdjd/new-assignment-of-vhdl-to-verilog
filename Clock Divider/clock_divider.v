module clock_divider (
  input        clk,      
  input        rstn,     
  output       clk_o     
);

 parameter DV = 4;
  reg    clk_rg;         
  reg    [31:0] count;   

  always @(posedge clk) begin
    if (rstn == 1'b0) begin
      clk_rg <= 1'b0;
      count <= 32'd0;
    end
    else begin
      if (count == DV/2 - 1) begin
        count <= 32'd0;
        clk_rg <= ~clk_rg;
      end
      else begin
        count <= count + 1;
      end
    end
  end

  assign clk_o = clk_rg;

endmodule
