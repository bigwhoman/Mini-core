module data_mem(
    input clk,
    input rst,
    input enable,
    input read_writenot,
    input [7 : 0] in_data,
    input [5 : 0] read_address1,
    input [5 : 0] read_address2,
    input [5 : 0] write_address,

    output [7 : 0] out_data1;
    output [7 : 0] out_data2;

);

reg [7 : 0] storage [63 : 0];
integer i;

always @(posedge rst) begin
    for(i = 0 ; i < 64 ; i = i + 1) begin
        storage[i] = 0;
    end
end

always @(posedge clk) begin

    if(enable) begin
        
        if(read_writenot) begin
            out_data1 = storage[read_address1];
            out_data2 = storage[read_address2];
        end
        else begin
            storage[write_address] = in_data;
        end

    end
    
end

endmodule