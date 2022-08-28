module MUL(
 input [7:0] in1,in2,
 output reg [15:0] out
);

always @* begin
    out[7:0] = in1[7:4]*in2[3:0] + in1[3:0]*in2[7:4];
    out[15:8] = in1[7:4]*in2[7:4] - in1[3:0]*in2[3:0];
end

endmodule