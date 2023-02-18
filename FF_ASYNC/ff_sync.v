module ff_sync (
    input clk_a,
    input sig_a,
    input clk_b,
    output  [1:0] sig_b
);

parameter pre_reg = 0;
parameter re_edge = 1;
parameter sync_size = 2;

reg sig_a_int;
reg [sync_size-1:0] sig_b_int;

always @ (posedge clk_a or negedge clk_a)
begin
    if (re_edge) begin
        if ( clk_a) begin
            sig_a_int <= sig_a;
        end
    end else begin
        if ( !clk_a) begin
            sig_a_int <= sig_a;
        end
    end
end

always @ (posedge clk_b or negedge clk_b)
begin
    if (re_edge) begin
        if ( clk_b) begin
            sig_b_int <= {sig_b_int[0], sig_a_int};
        end
    end else begin
        if (! clk_b) begin
            sig_b_int <= {sig_b_int[0], sig_a_int};
        end
    end
end

assign sig_b = sig_b_int[sync_size-1];

endmodule
