module pulse_sync_tb;

    
    reg clk_a;
    reg sig_a;
    reg clk_b;
    
    
    wire sig_b;
    wire busy;

    
    pulse_sync dut (
        .clk_a(clk_a), 
        .sig_a(sig_a), 
        .clk_b(clk_b), 
        .sig_b(sig_b),
        .busy(busy)
    );

    
    always #5 clk_a = ~clk_a;
    always #3 clk_b = ~clk_b;

  
    initial begin
       
        clk_a = 0;
        sig_a = 0;
        clk_b = 0;

        #20 sig_a = 1;
        #10 sig_a = 0;

        #100 $finish;
    end

endmodule
