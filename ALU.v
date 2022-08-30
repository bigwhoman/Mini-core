`include "mul.v"
`include "add_sub.v"

module ALU(
    input [7:0] operand1,
    input [7:0] operand2,
    input [1:0] operation,
    
    output [7:0] result
);

wire [7:0] mul_out, add_out;

MUL mul(.in1(operand1), .in2(operand2), .out(mul_out));
ADD_SUB adder(.in1(operand1), .in2(operand2), .out(result), .add_or_sub(add_out));

assign result = operation == 2 ? mul_out : add_out;






endmodule