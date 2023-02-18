module clock_divider_tb;

  
  reg clk;
  reg rstn;

  
  wire clk_o;

  
  clock_divider dut (
    .clk(clk),
    .rstn(rstn),
    .clk_o(clk_o)
  );
  initial begin
	  clk=0;
  end

  
  always #5 clk = ~clk;

  
  initial begin
    rstn = 0;
    #10;
    rstn = 1;
  end

  
  initial begin
	  $dumpfile("con9.vcd");
  $dumpvars;
    
    #100;

    
    $display("Test 1: DV = 4");
    #1000000;  
    $display("Clock count: %d", $time);
    $finish;
  end

endmodule
