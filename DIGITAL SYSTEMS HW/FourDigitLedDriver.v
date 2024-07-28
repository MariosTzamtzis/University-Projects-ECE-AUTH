`timescale 1ns / 1ps
`include "leddriver.sv"

module FourDigitLEDdriver(reset, clk, ch, an3, an2, an1, an0, LEDoutput);

input clk, reset; 
input [15:0] ch;
output an3, an2, an1, an0; // our anodes
output [6:0] LEDoutput;


reg an0,an1,an2,an3;
wire [6:0] LED;
reg [6:0] LEDoutput;

reg [3:0] char; // based on your received message, use this 4bit signal to drive our decoder
reg [3:0] counter; // counter to compute the time that the anodes will be active
  

/////////////////////////////////////////////////////////////////////		
//	Set char values to present them at the correct anode at a time //
/////////////////////////////////////////////////////////////////////	
always@(posedge clk or posedge reset)
begin
	if (reset)
	begin
		char = 4'b1101; // add the required code to set char signal value
	end
  else if (counter == 4'b0000) // add the required code to set char signal value
	//For AN'3
	begin
		char = ch[15:12]; // add the required code to set char signal value
	end
	else if (counter == 4'b1100)
	//For AN'2
	begin
		char = ch[11:8];
	end
	else if (counter == 4'b1000)
	//For AN'1
	begin
		char = ch[7:4];
	end
	else if (counter == 4'b0100)
	//For AN'0
	begin
		char = ch[3:0];
	end
end


//////////////////////////
//		Anodes Set		//
//////////////////////////
always@(posedge clk or posedge reset)
begin
	if (reset)
	begin
		an3 = 1'b1;
		an2 = 1'b1;
		an1 = 1'b1;
		an0 = 1'b1;
	end
	else if (counter == 4'b1110) 
	begin
		an3 = 1'b0;
		an2 = 1'b1;
		an1 = 1'b1;
		an0 = 1'b1;
	
	end
    else if (counter == 4'b1010) 
	begin
		an3 = 1'b1;
		an2 = 1'b0;
		an1 = 1'b1;
		an0 = 1'b1;
	
	end
    else if (counter == 4'b0110) 
	begin
		an3 = 1'b1;
		an2 = 1'b1;
		an1 = 1'b0;
		an0 = 1'b1;
	
	end
    else if (counter == 4'b0010) 
	begin
		an3 = 1'b1;
		an2 = 1'b1;
		an1 = 1'b1;
		an0 = 1'b0;
	
	end
	else
	begin
		an3 = 1'b1;
		an2 = 1'b1;
		an1 = 1'b1;
		an0 = 1'b1;
	end
  
  	if (reset)
		LEDoutput = 7'b1111111;
	else
	begin
		if (an0 == 1'b0 || an1 == 1'b0 || an2 == 1'b0 || an3 == 1'b0)
			LEDoutput = LED;
      	else if (an0 == 1'b1 || an1 == 1'b1 || an2 == 1'b1 || an3 == 1'b1)
			LEDoutput = 7'b1111111;
	end
end


////////////////////////////////
//	Decoder	Instantiation	  //
////////////////////////////////

LEDdecoder LEDdecoderINSTANCE (.char(char),.LED(LED));





//////////////////////////////////////////////////
//		Counter for the 16 states of anodes		//
//////////////////////////////////////////////////
always@(posedge clk or posedge reset)
begin
	if (reset)
	begin
		counter = 4'b1111;
	end	
	else 
	begin
		if (counter == 4'b0000)
		begin
			counter = 4'b1111;
		end
		else
		begin
			counter = counter - 1'b1;
		end
	end
end

endmodule
