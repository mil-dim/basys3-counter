`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/30/2022 06:48:07 PM
// Design Name: 
// Module Name: blinker
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module blinker ( output blink2, output blink1, input clk) ;
reg blink2=1 ;
reg blink1=1 ;
always @( posedge clk)
begin :COUNTER
 blink2 <=1;
 #100000000;
 blink2 <=0;
 #100000000;
 end  
 endmodule 