module ADD_SUB(
 input [7:0] in1,in2,
 input add_or_sub,
 output reg [7:0] out
);

reg signed [3:0] a,b,c,d;


always @* begin
    a = in1[7:4];
    b = in1[3:0];
    c = in2[7:4];
    d = in2[3:0];
    if(add_or_sub) begin
      out[7:4] = a - c;
      out[3:0] = b - d;
    end else begin
      out[7:4] = a + c;
      out[3:0] = b + d;
    end
end

endmodule 