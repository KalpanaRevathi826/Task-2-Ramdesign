// Testbench for Synchronous RAM Module
`timescale 1ns/1ps

module sync_ram_tb;

    parameter DATA_WIDTH = 8;
    parameter ADDR_WIDTH = 4;

    reg clk;
    reg rst;
    reg we;
    reg [ADDR_WIDTH-1:0] addr;
    reg [DATA_WIDTH-1:0] din;
    wire [DATA_WIDTH-1:0] dout;

    sync_ram #(
        .DATA_WIDTH(DATA_WIDTH),
        .ADDR_WIDTH(ADDR_WIDTH)
    ) uut (
        .clk(clk),
        .rst(rst),
        .we(we),
        .addr(addr),
        .din(din),
        .dout(dout)
    );

    // Clock generation
    always #5 clk = ~clk;

    initial begin
        // Initialize signals
        clk = 0;
        rst = 1;
        we = 0;
        addr = 0;
        din = 0;

        // Reset pulse
        #10;
        rst = 0;

        // Write data to locations 0-3
        repeat (4) begin
            @(negedge clk);
            we = 1;
            addr = addr + 1;
            din = din + 8'hA0;
        end

        // Disable write
        @(negedge clk);
        we = 0;

        // Read from locations 0-3
        addr = 1;
        #10;
        $display("Read from Addr 1: Data = %h", dout);

        addr = 2;
        #10;
        $display("Read from Addr 2: Data = %h", dout);

        addr = 3;
        #10;
        $display("Read from Addr 3: Data = %h", dout);

        addr = 4;
        #10;
        $display("Read from Addr 4: Data = %h", dout);

        $finish;
    end

endmodule
