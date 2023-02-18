module edge_detector_tb;

  
   reg clk = 0;
   reg rst = 1;
   reg sig_in = 0;
   wire sig_out_r, sig_out_f, sig_out_rf, sig_out_r_imm, sig_out_f_imm, sig_out_rf_imm;
   wire sig_out_r_imm_gl, sig_out_rf_imm_gl;

   // Instantiate of  module
   edge_detector uut (
      .clk(clk),
      .rst(rst),
      .sig_in(sig_in),
      .sig_out_r(sig_out_r),
      .sig_out_f(sig_out_f),
      .sig_out_rf(sig_out_rf),
      .sig_out_r_imm(sig_out_r_imm),
      .sig_out_f_imm(sig_out_f_imm),
      .sig_out_rf_imm(sig_out_rf_imm),
      .sig_out_r_imm_gl(sig_out_r_imm_gl),
      .sig_out_rf_imm_gl(sig_out_rf_imm_gl)
   );

   // Clock generator
   always #5 clk = ~clk;

   // Reset generator and wave input
   initial begin
	   $dumpfile("con6.vcd");
	   $dumpvars;
      rst = 0;
      #10 rst = 1;
      #100 rst = 0;
   end

   
   initial begin
      #50 sig_in = 1;
      #10 sig_in = 0;
      #20 sig_in = 1;
      #5 sig_in = 0;
      #30 sig_in = 1;
      #70 sig_in = 0;
      #100 $finish;
   end

   // to display the results
   always @(posedge clk) begin
      $display("sig_out_r = %d, sig_out_f = %d, sig_out_rf = %d, sig_out_r_imm = %d, sig_out_f_imm = %d, sig_out_rf_imm = %d, sig_out_r_imm_gl = %d, sig_out_rf_imm_gl = %d", sig_out_r, sig_out_f, sig_out_rf, sig_out_r_imm, sig_out_f_imm, sig_out_rf_imm, sig_out_r_imm_gl, sig_out_rf_imm_gl);
   end

endmodule
