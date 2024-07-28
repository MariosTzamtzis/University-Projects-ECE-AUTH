`timescale 1ns/1ps

module test_uart_transmitter;
    reg clk;
    reg reset;
    reg [7:0] tx_data;
    reg [2:0] baud_select;
    reg tx_en;
    reg tx_wr;
    wire tx_busy;
    wire txd;

    uart_transmitter uart_transmitter_instance(
        .clk(clk),
        .reset(reset),
        .Tx_DATA(tx_data),
        .baud_select(baud_select),
        .TX_EN(tx_en),
        .Tx_WR(tx_wr),
        .Tx_BUSY(tx_busy),
        .TxD(txd)
    );

    initial begin
        // Initialize input values
      	$dumpfile("dump.vcd"); $dumpvars;
        clk = 1'b0;
        reset = 1'b1;
        tx_data = 8'b00000000;
        baud_select = 3'b111;
        tx_en = 1'b0;
        tx_wr = 1'b0;

        // Wait for reset to complete
        #10;
        reset = 1'b0;
        #10;


        // Test case 1

        baud_select = 3'b000;
        tx_data = 8'b01010101;
        tx_wr = 1'b1;
        #10;
        tx_wr = 1'b0;

        // Wait for transmission to complete
        #100;

        #10000 $finish;
    end

always
    begin
      #10 clk = ~clk;
    end
endmodule
