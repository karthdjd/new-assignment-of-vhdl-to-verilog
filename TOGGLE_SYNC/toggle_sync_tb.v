module toggle_sync_tb;

   
    localparam CLK_PERIOD = 10;

    
    reg clk_a;
    reg sig_a;
    reg clk_b;

   
    wire sig_b;

   
    toggle_sync dut (
        .clk_a(clk_a),
        .sig_a(sig_a),
        .clk_b(clk_b),
        .sig_b(sig_b)
    );

   
    always #5 clk_a = ~clk_a;
    always #10 clk_b = ~clk_b;

   initial begin
     $dumpfile("con14.vcd");
     $dumpvars;
   end
    initial begin
        clk_a = 0;
        sig_a = 0;
        clk_b = 0;
        
    end
  always#10 sig_a=~sig_a;
  initial #100 $finish;

endmodule
