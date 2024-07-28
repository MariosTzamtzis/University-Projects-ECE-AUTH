module UART_communication;
  reg give_clk,give_reset, Tx_EN, Tx_WR;
  wire Tx_BUSY; 
  wire channel;			
  reg[2:0] baud_select;
  reg[7:0] Tx_DATA;
  wire[7:0] Rx_DATA;
  wire Rx_VALID;
  
   UART_transmitter Transmitter_TB(.Tx_BUSY(Tx_BUSY), .TxD(channel), .clk(give_clk), .reset(give_reset), .Tx_EN(Tx_EN), .Tx_WR(Tx_WR), .baud_select(baud_select), .Tx_DATA(Tx_DATA));
  UART_receiver Receiver_TB(.Rx_DATA(Rx_DATA), .Rx_VALID(Rx_VALID), .RxD(channel), .clk(give_clk), .reset(give_reset), .Rx_EN(Rx_EN), .baud_select(baud_select));

  initial
    begin
      $dumpfile("dump.vcd"); 
      $dumpvars;
      
      give_clk = 0;
      give_reset = 1;
      Tx_WR = 1'b0;
      
      baud_select = 3'b011;
      
      #10;					
      
      give_reset = 0;		
      
      #10;					
      

      Tx_WR = 1'b1;
      Tx_DATA = 8'b11111111;
      
      #10
      Tx_WR = 1'b0;	
      
      #1000000 $finish;
    end  
  
  
  always
    begin
      #10 give_clk = ~ give_clk;
    end 
endmodule