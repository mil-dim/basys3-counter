`timescale 1ns / 1ps
module  decoder (  
output reg [6:0] seg , 
output reg [3:0] an, 
input [3:0] bcd0,
input [3:0] bcd1,
input [3:0] bcd2,
input [3:0] bcd3 , 
input [1:0] clk );
  reg [3:0] bcd;
  reg  [26:0] i;
 
initial i=0;
always @(posedge clk) //multiplexer
    begin  
    i<=i+1;
    case (  i[19:18] )
       0: begin  an<=14;  bcd<=bcd0;     end   
       1: begin  an<=13;  bcd<=bcd1;     end           
       2: begin  an<=11;  bcd<=bcd2;     end           
       3: begin  an<=7;  bcd<=bcd3;     end            
    endcase
    end  
  
  always@(bcd)   //7seg decoder
  begin 
  case (bcd) //case statement
            0 : seg = 7'b1000000;
            1 : seg = 7'b1111001;
            2 : seg = 7'b0100100;
            3 : seg = 7'b0110000;
            4 : seg = 7'b0011001;
            5 : seg = 7'b0010010;
            6 : seg = 7'b0000010;
            7 : seg = 7'b1111000;
            8 : seg = 7'b0000000;
            9 : seg = 7'b0010000;
            10 : seg = 7'b0001000;
            11 : seg = 7'b0000011;
            12 : seg = 7'b1000110;
            13 : seg = 7'b0100001;
            14 : seg = 7'b0000110;
            15 : seg = 7'b0001110;
            default : seg = 7'b1111111; 
  endcase
  end 
endmodule