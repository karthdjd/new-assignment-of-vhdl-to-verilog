module reset_stretcher
#(
    parameter PERIOD = 4,
    parameter RST_POL = 1
)
(
    input clk,
    input rst_i,
    output wire rst_o
);

reg [PERIOD-1:0] flipflops;

always @(posedge clk) begin
    if (rst_i == RST_POL) begin
        flipflops <= {PERIOD{RST_POL}};
    end else begin
        flipflops <= {flipflops[PERIOD-2:0], ~RST_POL};
    end
end

assign rst_o = flipflops[PERIOD-1];

endmodule
