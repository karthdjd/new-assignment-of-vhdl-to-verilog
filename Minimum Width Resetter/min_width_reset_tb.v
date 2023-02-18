module min_width_reset_tb;

reg clk;
reg rst_i;
wire rst_o;

min_width_reset dut (
    .clk(clk),
    .rst_i(rst_i),
    .rst_o(rst_o)
);
initial begin
	$dumpfile("con8.vcd");
	$dumpvars;
end

initial begin
    clk = 0;
    rst_i = 0;

    #5;

    rst_i = 1;
    #2;
    rst_i = 0;

    #10;

    rst_i = 1;
    #20;
    rst_i = 0;

    #10;

    rst_i = 1;
    #2;
    rst_i = 0;
    #10;
    rst_i = 1;
    #2;
    rst_i = 0;

    #10;

    rst_i = 1;
    #4;
    rst_i = 0;

    #10;

    rst_i = 1;
    #8;
    rst_i = 0;

    #10;

    rst_i = 1;
    #16;
    rst_i = 0;

    
end
always #5 clk = ~clk;
initial #100 $finish;
endmodule
