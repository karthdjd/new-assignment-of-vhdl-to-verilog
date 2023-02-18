module pulse_generator (
  input        clk,    // Clock
  input wire       rstn,   // Synchronous Reset
  output  pulse_o // Pulse out
);

  // Internal signals/registers
  reg   pulse_rg;
  reg   [7:0] count;

  // Pulse generator process
  always @(posedge clk) begin
    if (rstn == 1'b0) begin
      pulse_rg <= 1'b0;
      count    <= 8'd0;
    end else begin
      if (count == PERIOD-1) begin
        count    <= 8'd0;
        pulse_rg <= 1'b1;
      end else begin
        pulse_rg <= 1'b0;
        count    <= count + 1;
      end
    end
  end

  // Pulse out
  assign pulse_o = pulse_rg;

endmodule
