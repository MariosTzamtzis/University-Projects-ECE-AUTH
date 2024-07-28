`timescale 1ns / 1ps

module UART_receiver_tb;
  reg RxD;
  reg give_clk, give_reset, Rx_EN;
  reg[2:0] baud_select;
  wire[7:0] Rx_DATA;
  wire Rx_FERROR, Rx_PERROR, Rx_VALID;
  
  reg[19:0] delay;
  reg[7:0] Tx_DATA;
  integer i;
  

  UART_receiver UART_receiver_TB(.Rx_DATA(Rx_DATA), .Rx_FERROR(Rx_FERROR), .Rx_PERROR(Rx_PERROR), .Rx_VALID(Rx_VALID), .RxD(RxD), .clk(give_clk), .reset(give_reset), .Rx_EN(Rx_EN), .baud_select(baud_select));
  
  initial
    begin
      $dumpfile("dump.vcd"); 
      $dumpvars;
      
      give_clk = 0;
      give_reset = 1;
      RxD = 1'b1;
      
      baud_select = 3'b011;
      Tx_DATA = 8'b11111111;      

      delay = 20'd104167; //Delay for the selected baud rate.		
      
      #50
      give_reset = 0;
      
      #(delay/16) RxD = 1'b0;		
      

      for(i = 0; i <= 7; i=i+1)
        begin
          #(delay) RxD = Tx_DATA[i];
        end
      
      #(delay) RxD = ^ Tx_DATA; //parity error		
      
      #(delay) RxD = 1'b1;	
      #100000	$finish;
    end
  
always
    begin
      #10 give_clk = ~give_clk;
    end


  
endmodule
  