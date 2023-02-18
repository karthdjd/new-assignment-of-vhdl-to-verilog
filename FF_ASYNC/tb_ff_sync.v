module tb_ff_sync();

    reg clk_a;
    reg sig_a;
    reg clk_b;
    wire [1:0] sig_b;
    
    initial begin
	    $dumpfile("con12.vcd");
	    $dumpvars;
        clk_a = 0;
        sig_a = 0;
        clk_b = 0;
        
    end
    always#5 clk_a=~clk_a;
    always#6 sig_a=~sig_a;
    ff_sync dut (
        .clk_a(clk_a),
        .sig_a(sig_a),
        .clk_b(clk_b),
        .sig_b(sig_b)
    );
    
    always #10 clk_b = ~clk_b;
    initial #100 $finish;
endmodule
