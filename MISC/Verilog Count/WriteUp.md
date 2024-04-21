## Verilog Count

### Question:
I want to count from 0

Author: Hackin7

nc challs.nusgreyhats.org 31114

### Challenge Description:
The challenge requires writing a Verilog program for the Icarus Verilog simulator to count from 0. The program should not use conditionals (if, else) and addition (+) or ternary operators (?), but subtraction (-) operator is allowed. The predefined testbench setup includes an input clock (clk) and an output of 32 bits.

### Explanation:
- The Verilog module named `counter` includes an input clock (`clk`) and an output register `result` of 32 bits.
- Inside the module, a register `next_count` is declared.
- Initially, the `result` register is set to 0 (`32'd0`).
- An `always` block is used to handle clocked events. It triggers on the positive edge of the clock (`posedge clk`).
- Inside the `always` block, the `result` register is updated by subtracting `-1` from it. This effectively increments the count by 1.

### Conclusion:
With this Verilog solution, the counter module can count from 0 using only subtraction operations and without using conditionals or addition operators.

### Solution:
```verilog
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
