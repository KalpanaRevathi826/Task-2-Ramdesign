// Simple Synchronous RAM Module with Read and Write
module sync_ram #(
    parameter DATA_WIDTH = 8,
    parameter ADDR_WIDTH = 4
) (
    input wire clk,
    input wire rst,
    input wire we,      // Write Enable
    input wire [ADDR_WIDTH-1:0] addr,
    input wire [DATA_WIDTH-1:0] din,
    output reg [DATA_WIDTH-1:0] dout
);

    // RAM storage
    reg [DATA_WIDTH-1:0] mem [0:(1<<ADDR_WIDTH)-1];

    always @(posedge clk) begin
        if (rst) begin
            dout <= 0;
        end else begin
            if (we) begin
                mem[addr] <= din; // Write operation
            end
            dout <= mem[addr]; // Read operation
        end
    end
endmodule
