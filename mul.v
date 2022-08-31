module MUL(
 input [7:0] in1,in2,
 output reg [15:0] out,
 output reg is_done
);

reg signed [3:0] a,b,c,d;

always @* begin
    a = in1[7:4];
    b = in1[3:0];
    c = in2[7:4];
    d = in2[3:0];
    out[7:0] = a*d + b*c;
    out[15:8] = a*c - b*d;
end

endmodule