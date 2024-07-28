`timescale 1ns / 1ps

module tb;

  reg give_clk,give_reset;
  reg [15:0] char;
  wire an3, an2, an1, an0;
  wire [6:0] LED;

  
  FourDigitLEDdriver test (give_reset, give_clk, char, an3, an2, an1, an0, LED); // instatiate decoder test

  initial begin
      $dumpfile("dump.vcd"); $dumpvars;
      give_clk = 0; // our clock is initialy set to 0
      give_reset = 1; // our reset signal is initialy set to 1

      #100; // after 100 timing units, i.e. ns

      give_reset = 0; // set reset signal to 0

      #10000 $finish;	 // after 10000 timing units, i.e. ns, finish our simulation
  end

  always #80 give_clk = ~ give_clk; // create our clock, with a period of 20ns

  always@(posedge give_clk)
  begin
      #20 char = 16'b1011101110111011; // FFFF
      
end

endmodule
