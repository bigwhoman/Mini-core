module ADD_SUB(
 input [7:0] in1,in2,
 input add_or_sub,
 output reg [7:0] out
);

always @* begin
    if(add_or_sub) begin
      out[7:4] = in1[7:4] - in2[7:4];
      out[3:0] = in1[3:0] - in2[3:0];
    end else begin
      out[7:4] = in1[7:4] + in2[7:4];
      out[3:0] = in1[3:0] + in2[3:0];
    end
end

endmodule 