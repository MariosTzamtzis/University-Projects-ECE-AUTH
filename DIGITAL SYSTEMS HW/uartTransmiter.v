`timescale 1ns/1ps

module uart_transmitter(reset, clk, Tx_DATA, baud_select, Tx_WR, TX_EN, TxD, Tx_BUSY);
input clk, reset; 
input [7:0] Tx_DATA; 
input [2:0] baud_select; 
input TX_EN;
input Tx_WR; 
output reg TxD; 
output reg Tx_BUSY;  

reg [3:0] data_counter;
reg flag; //Flag for transmitter to transmit the next bit.
reg parity = 1'b0;

reg [3:0] bit_index;
reg [1:0] state;
parameter START = 2'b00, DATA = 2'b01, PARITY = 2'b10, STOP = 2'b11;

// Instantiate baud controller
baud_controller baud_controller_tx_instance(reset, clk, baud_select, Tx_sample_ENABLE);

always @(reset) 
    begin
        data_counter <= 0;
        TxD <= 1'b1;
        Tx_BUSY <= 1'b0;
        flag <= 1'b0;
    end

always @(posedge Tx_WR)
    begin
        bit_index = 4'b0000;
        Tx_BUSY = 1'b1;
        data_counter = 4'b0000;
    end

always @(posedge Tx_sample_ENABLE && Tx_BUSY)
    begin
      if(data_counter == 4'b1111)
      	begin
         data_counter = 4'b0000;
         flag = 1'b1;	
         bit_index = bit_index + 1'b1;
         if (bit_index == 4'b0001)
            state <= START;
        else if (bit_index >= 4'b0010 && bit_index <=4'b1001)
            state <= DATA;
        else if (bit_index == 4'b1010) 
            state <= PARITY;
        else
            state <= STOP;
        end
    else
      	data_counter = data_counter + 1;
    end

always @(posedge flag)
    begin
        case(state)
        START:
        begin
            TxD = 1'b0; //Start bit
            flag = 1'b0;
        end
        DATA:
        begin
          case (bit_index)
            4'b0010:  TxD = Tx_DATA[0];
            4'b0011:  TxD = Tx_DATA[1];
            4'b0100:  TxD = Tx_DATA[2];
            4'b0101:  TxD = Tx_DATA[3];
            4'b0110:  TxD = Tx_DATA[4];
            4'b0111:  TxD = Tx_DATA[5];
            4'b1000:  TxD = Tx_DATA[6];
            4'b1001:  TxD = Tx_DATA[7];
          endcase         
          flag = 1'b0;
        end
        PARITY:
        begin
          TxD = parity;
          flag = 1'b0;
        end
      STOP:
        begin
          TxD = 1'b1;
          flag = 1'b0;
          Tx_BUSY = 1'b0;
        end
        default:
            TxD = 1'b1;
    endcase      		
end

    always @ (posedge Tx_WR)
    begin
      parity = ^ Tx_DATA; //When we've got even number of 1's-->0, else-->1
    end 


endmodule



