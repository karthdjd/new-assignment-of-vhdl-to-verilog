module pulse_sync (
    input clk_a,
    input rstn_a,
    input clk_b,
    input rstn_b,
    input pulseA_i,
    output wire pulseB_o,
    output wire busy_o
);

parameter STAGES = 2;

reg [STAGES-1:0] flipflops_a;
reg [STAGES-1:0] flipflops_b;

reg pulseA_regA;
wire busyB;
reg busyB_delayed;
wire busyB_syncA;

// Synchroniser at Domain-A that synchronises the busy signal generated at Domain-B
always @(posedge clk_a) begin
    if (rstn_a == 1'b0) begin
        flipflops_a <= {STAGES{1'b0}};
    end else begin
        flipflops_a <= {flipflops_a[STAGES-2:0], busyB};
    end
end

// Pulse sampler at Domain-A, converts the pulse to level based on the busy status from Domain-B
always @(posedge clk_a) begin
    if (rstn_a == 1'b0) begin
        pulseA_regA <= 1'b0;
    end else begin
        pulseA_regA <= pulseA_i | (pulseA_regA & (~busyB_syncA));
    end
end

// Synchroniser at Domain-B that synchronises the sampled pulse from Domain-A
always @(posedge clk_b) begin
    if (rstn_b == 1'b0) begin
        flipflops_b <= {STAGES{1'b0}};
        busyB_delayed <= 1'b0;
    end else begin
        flipflops_b <= {flipflops_b[STAGES-2:0], pulseA_regA};
        busyB_delayed <= flipflops_b[STAGES-1];
    end
end

// Concurrent assignments
assign busyB = flipflops_b[STAGES-1];
assign busyB_syncA = flipflops_a[STAGES-1];
assign busy_o = busyB_syncA | pulseA_regA;
assign pulseB_o = busyB & (~busyB_delayed);

endmodule
