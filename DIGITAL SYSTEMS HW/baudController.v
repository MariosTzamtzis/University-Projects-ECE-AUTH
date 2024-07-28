`timescale 1ns/1ps

module baud_controller(
    input         clk,
    input         reset,
    input [2:0]   baud_select,
    output reg    sample_ENABLE
);
  
  
  //Clock_Frequency = 50000000Hz
    reg [16:0] counter;
    reg [16:0] max_value;//We calculate max_value = (CLOCK_FREQUENCY/(16*BAUD_SELECT))
  always @ (baud_select)
    begin
      case(baud_select)
        3'b000: max_value = 17'd104166;
        3'b001: max_value = 17'd2604;
        3'b010: max_value = 17'd651;
        3'b011: max_value = 17'd326;
        3'b100: max_value = 17'd163;
        3'b101: max_value = 17'd81;
        3'b110: max_value = 17'd54;
        3'b111: max_value = 17'd27;
      endcase
    end
  always @ (reset) begin
    counter <= 1'b0;
    sample_ENABLE <= 1'b0;
  end
  
  always @ (posedge clk && !reset) begin
            if (counter == max_value) begin
                counter <= 17'd0;
                sample_ENABLE <= 1'b1;
            end else begin
                counter <= counter + 1'b1;
                sample_ENABLE <= 1'b0;
            end
      
    end
    
  
endmodule