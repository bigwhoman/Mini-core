module MUL(
 input clk,rst,
 input [7:0] in1,in2,
 output reg [7:0] out,
 output reg is_done
);

reg signed [3:0] a,b,c,d;
reg [1:0] counter;



always @(posedge clk,negedge rst) begin
    if(rst == 0) begin
      counter = 0;
    end
    else begin
    if(counter < 5) begin
        counter = counter + 1;
        is_done = 0;
    end 
    if(counter == 5) begin
        a = in1[7:4];
        b = in1[3:0];
        c = in2[7:4];
        d = in2[3:0];
        out[3:0] = a*d + b*c;
        out[7:4] = a*c - b*d;
        is_done = 1;
        counter = 0;
     end
    end
end

endmodule