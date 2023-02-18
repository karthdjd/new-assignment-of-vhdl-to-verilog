module reset_stretcher_tb;
    reg clk;
    reg rst_i;

    wire rst_o;

    reset_stretcher uut (
        .clk(clk),
        .rst_i(rst_i),
        .rst_o(rst_o)
    );

    initial begin
	    $dumpfile("con7.vcd");
	    $dumpvars;
        clk = 0;
        rst_i = 1;

        #10;

        rst_i = 0;
        #5;
        if (rst_o !== 1'b0) begin
            $display("Error: Synchronous Reset was not stretched");
        end

        #5;
        if (rst_o !== 1'b1) begin
            $display("Error: Stretched Synchronous Reset was not released");
        end

        $display("Testbench completed");
        $finish;
    end

    always #5 clk = ~clk;
endmodule

