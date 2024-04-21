-- This is prepared by Shang En

module counter(
    input clk,
    output reg [31:0] result
);

    reg [31:0] next_count;

    initial begin
        result = 32'd0;
    end

    always @(posedge clk) begin
        result <= result - (-1);
    end

endmodule
