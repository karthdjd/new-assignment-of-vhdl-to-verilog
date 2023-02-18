`timescale 1ns/1ns
module data_sync_tb;

  
  reg clk;
  reg rstn;
  reg [7:0] din;
  reg dready_i;

  
  wire [7:0] dout;
  wire dready_o;

  
  data_sync dut(
    .clk(clk),
    .rstn(rstn),
    .din(din),
    .dready_i(dready_i),
    .dout(dout),
    .dready_o(dready_o)
  );

  
  always #5 clk = ~clk;

  
  initial begin
    rstn = 0;
    #10 rstn = 1;
  end
  initial begin
	  $dumpfile("con5.vcd");
	  $dumpvars;
  end

  
  initial begin
    
    @(posedge clk);
    @(posedge clk);

    
    din = 8'b10101010;
    dready_i = 0;
    @(posedge clk);
    assert (dout === 8'b00000000);
    assert (dready_o === 0);

    
    din = 8'b01010101;
    dready_i = 1;
    @(posedge clk);
    assert (dout === 8'b01010101);
    assert (dready_o === 1);

    
    rstn = 0;
    @(posedge clk);
    assert (dout === 8'b00000000);
    assert (dready_o === 0);
    @(posedge clk);
    rstn = 1;
    @(posedge clk);
    @(posedge clk);
    assert (dout === 8'b00000000);
    assert (dready_o === 0);

    $display("Testbench complete.");
    $finish;
  end
endmodule
