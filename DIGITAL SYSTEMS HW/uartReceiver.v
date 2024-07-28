module uart_receiver(
    input clk, reset,
    input [2:0] baud_select,
    input RX_EN, RxD,
    output reg [7:0] Rx_DATA,
    output reg Rx_VALID
);

    // Instantiate the baud rate controller
    baud_controller baud_controller_rx_instance(.sample_ENABLE(Rx_sample_ENABLE), .clk(clk), .reset(reset), .baud_select(baud_select));

    // State machine for the receiver
    reg [1:0] state;
    parameter IDLE = 2'b00, START = 2'b01, DATA = 2'b10, STOP = 2'b11;

    // Data counter
    reg [3:0] data_counter;

    // Register to store received data
    reg [7:0] rx_reg;

    // Error signals
    reg Rx_FERROR, Rx_PERROR;
    reg [3:0] bit_counter;

    reg flag;
    reg parity_test;


    always @(reset) begin
        state <= IDLE;
        data_counter <= 4'b0000;
        rx_reg <= 8'b0;
        Rx_FERROR <= 1'b0;
        Rx_PERROR <= 1'b0;
    end


    always @(negedge RxD && state == IDLE) begin
        state <= START;
        bit_counter = 4'b0001;
        flag = 1'b0;
        Rx_DATA = 8'b0;
        data_counter = 4'b0;
    end

    always @(negedge Rx_sample_ENABLE) begin
      if(data_counter == 4'b1111)
        begin
          flag = 1'b1;			
          data_counter = 4'b0000;		
        end
      else
        begin
          data_counter = data_counter + 1'b1;
          flag = 1'b0;			
        end
    end
    
    always @(posedge flag) begin
        case (state)
            START: begin
                    state <= DATA;
                end            
            DATA: begin
                case(bit_counter)
                    4'b0010:  Rx_DATA[0] = RxD;
                    4'b0011:  Rx_DATA[1] = RxD;
                    4'b0100:  Rx_DATA[2] = RxD;
                    4'b0101:  Rx_DATA[3] = RxD;
                    4'b0110:  Rx_DATA[4] = RxD;
                    4'b0111:  Rx_DATA[5] = RxD;
                    4'b1000:  Rx_DATA[6] = RxD;
                    4'b1001:  Rx_DATA[7] = RxD;
                endcase
                if (bit_counter == 4'b1010) begin                            
                parity_test = ^ Rx_DATA;
                state <= STOP;		
                end
            end
            STOP: begin
                state <= IDLE;
                bit_counter <= 4'b0000;
                if(start_bit == 1'b1 || stop_bit == 1'b0)
                    Rx_FERROR = 1'b1;
                if(parity_bit == parity_test)		
                    Rx_PERROR = 1'b0;
                else
                    Rx_PERROR = 1'b1;
                if(Rx_FERROR == 0 && Rx_PERROR == 0)
                    Rx_VALID = 1'b1;
                else
                    Rx_VALID = 1'b0;
            end
        endcase
    bit_counter = bit_counter + bit_counter + 1'b1;
    end
endmodule