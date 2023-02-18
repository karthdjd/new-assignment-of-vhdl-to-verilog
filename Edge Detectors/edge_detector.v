module edge_detector (
   input clk,     
   input rst,    
   input sig_in, 
   output reg sig_out_r,    
   output  reg sig_out_f,    
   output reg  sig_out_rf, 
   output sig_out_r_imm, 
   output sig_out_f_imm, 
   output sig_out_rf_imm, 
   output sig_out_r_imm_gl, 
   output sig_out_rf_imm_gl 
);

reg sig_in_delayed;

always @(posedge clk or negedge rst) begin
   if (~rst) begin
      sig_out_r <= 1'b0;
      sig_out_f <= 1'b0;
      sig_out_rf <= 1'b0;
      sig_in_delayed <= 1'b0;
   end else begin
      
      sig_out_r <= 1'b0;
      sig_out_f <= 1'b0;
      sig_out_rf <= 1'b0;

      
      sig_in_delayed <= sig_in;

     
      if ((sig_in_delayed == 1'b0) && (sig_in == 1'b1)) begin
         sig_out_r <= 1'b1;
         sig_out_rf <= 1'b1;
      end

      
      if ((sig_in_delayed == 1'b1) && (sig_in == 1'b0)) begin
         sig_out_f <= 1'b1;
         sig_out_rf <= 1'b1;
      end
   end
end


assign sig_out_r_imm = sig_in & (~sig_in_delayed);
assign sig_out_f_imm = (~sig_in) & sig_in_delayed;
assign sig_out_rf_imm = sig_in ^ sig_in_delayed;


assign sig_out_r_imm_gl = (sig_in & (~sig_in_delayed)) & rst;
assign sig_out_rf_imm_gl = ((sig_in ^ sig_in_delayed) & rst);

endmodule
