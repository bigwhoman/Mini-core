module CU(
input [1:0] op,
input clk,
input is_done,

output reg halted,
output reg data_mem_write
);

always @(posedge clk) begin

if (is_done) begin    
    if(op != 11) begin
        data_mem_write = 1;
    end 
    else begin
        halted = 1;
    end
end
end



endmodule