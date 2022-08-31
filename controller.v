module CU(
input [1:0] op,
input clk,
input is_done,

output reg halted,
output reg data_mem_write,
output reg mul_or_add
);

always @(posedge clk) begin

    
    if(op != 11) begin
        data_mem_write = 1;
    end 
    
    if(op == 1 || op == 0) begin
        mul_or_add = 1;
    end

    if(op == 2) begin
        mul_or_add = 0;
    end


end



endmodule