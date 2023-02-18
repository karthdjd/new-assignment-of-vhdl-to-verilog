module data_sync #(
  parameter STAGES = 2,
  parameter DWIDTH = 8
) (
  input clk,
  input rstn,
  input [DWIDTH-1:0] din,
  input dready_i,
  output [DWIDTH-1:0] dout,
  output dready_o
);

  reg [STAGES-1:0] flipflops;
  wire dready_sync;

  attribute ASYNC_REG : string;
  attribute ASYNC_REG of flipflops : signal is "true";

  always @(posedge clk) begin
    if (!rstn) begin
      flipflops <= {STAGES{1'b0}};
    end else begin
      flipflops <= {flipflops[STAGES-2:0], dready_i};
    end
  end

  always @(posedge clk) begin
    if (!rstn) begin
      dout <= {DWIDTH{1'b0}};
      dready_o <= 1'b0;
    end else begin
      if (dready_sync) begin
        dout <= din;
      end
      dready_o <= dready_sync;
    end
  end

  assign dready_sync = flipflops[STAGES-1];

endmodule
