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

always @(negedge rst) begin
    for (i = 0; i<20 ; i = i + 1 ) begin
        storage[i] = 0;
    end
    storage[0] = 20'b 00_000000_000001_000010;
    storage[1] = 20'b 00_000011_000100_000101;
    storage[2] = 20'b 00_000110_000111_001000;
    storage[3] = 20'b 01_001001_001010_001011;
    storage[4] = 20'b 01_001100_001101_001110;
    storage[5] = 20'b 10_001111_010000_010001;
    storage[6] = 20'b 10_010010_010011_010100;
    storage[7] = 20'b 11_000000_000000_000000;
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