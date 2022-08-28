module inst_mem(
    input clk,
    input rst,
    input enable,
    input read_writenot,
    input [19 : 0] in_data,
    input [4 : 0] read_address,
    input [4 : 0] write_address,

    output reg [19 : 0] out_data

);

reg [19 : 0] storage [31 : 0];
integer i;

always @(posedge rst) begin
    for(i = 0 ; i < 32 ; i = i + 1) begin
        storage[i] = 0;
    end
end

always @(posedge clk) begin

    if(enable) begin
        
        if(read_writenot) begin
            out_data = storage[read_address];
        end
        else begin
            storage[write_address] = in_data;
        end

    end
    
end

endmodule