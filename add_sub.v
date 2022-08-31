module ADD_SUB(
 input clk,rst,
 input [7:0] in1,in2,
 input [1:0] add_or_sub,
 output reg [7:0] out,
 output reg is_done
);

reg signed [3:0] a,b,c,d;
reg counter;

always @(posedge clk,negedge rst) begin
  if(rst == 0) begin
    counter = 0;
  end
  else begin
    if(counter < 2) begin
    counter = counter + 1;
    is_done = 0;
    end
    if(counter == 2) begin
    a = in1[7:4];
    b = in1[3:0];
    c = in2[7:4];
    d = in2[3:0];
    if(add_or_sub == 1) begin
      out[7:4] = a - c;
      out[3:0] = b - d;
    end else if(add_or_sub == 0) begin
      out[7:4] = a + c;
      out[3:0] = b + d;
    end
    is_done = 1;
    coutner = 0;
  end
  end
end

endmodule 