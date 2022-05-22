`timescale 1ns/1ps

module counter(
output  [6:0] seg , 
output  [3:0] an,
output reg [13:8] LED,
output reg [7:0] JC,
output reg [7:0] JB,
output  [3:0] counter_out0,
output  [3:0] counter_out1,
output  carry_up, 
output  carry_down, 
input cl_up ,
input cl_down,
input reset ,
input enable,
input sw1,
input sw0,
input sw2,
input sw3, 
input direction,
input  [7:0] JA,
input [11:2] sw,
input clk);  

wire cl;
reg  carry_up_internal,carry_down_internal ;
wire  [3:0] counter_out2;
wire  [3:0] counter_out3;
reg  [26:0] i;

//generating different frequencies on LEDs and JB/JC by dividing
//100MHz by 2 each bit. the lowest frequency on LED13 and JB7 is
// 100MHz/2^27 0.745Hz, 1.34 sec period
initial i=0;
always@(posedge clk) begin
LED<=i[26:21];
JB<=i[24:17];
JC<=i[16:9];
i<=i+1;
end 

//last 2 LEDs indicate CARRY-UP and CARRY_DOWN , selecting which counter output 
// will be routed to the LED by sw0-sw3
assign carry_up= carry_up0&sw0 |carry_up1&sw1 |carry_up2&sw2 |carry_up3&sw3 ;
assign carry_down=carry_down0&sw0|carry_down1&sw1|carry_down2&sw2|carry_down3&sw3  ;
assign cl_up_int=cl_up  | (~JA[1])    |direction&((~JA[0])|JB[7]&sw[2]|

//creating composite input with selector - fron buttons Up and Down, or external 
//  JA[1] for count up ,JA[2] count down, or JA[0] - reversible ,or internal
//connections to JB/JC controlled by sw[2]-sw[11] 
        JB[6]&sw[3]|JB[5]&sw[4]|JB[4]&sw[5]|JB[3]&sw[6]|JB[2]&sw[7]|
        JB[1]&sw[8]|JB[0]&sw[9]|JC[7]&sw[10]|JC[6]&sw[11]);
assign cl_down_int=cl_down|(~JA[2])|(~direction)&((~JA[0])|JB[7]&sw[2]|
        JB[6]&sw[3]|JB[5]&sw[4]|JB[4]&sw[5]|JB[3]&sw[6]|JB[2]&sw[7]|
        JB[1]&sw[8]|JB[0]&sw[9]|JC[7]&sw[10]|JC[6]&sw[11]) ;
 
//4 instances of  BCD counters, cascades by carry-up and carry-down
bcd bcd0 (counter_out0,carry_up0,carry_down0,cl_up_int,cl_down_int,reset,enable);
bcd bcd1 (counter_out1,carry_up1,carry_down1,carry_up0,carry_down0,reset,enable);
bcd bcd2 (counter_out2,carry_up2,carry_down2,carry_up1,carry_down1,reset,enable);
bcd bcd3 (counter_out3,carry_up3,carry_down3,carry_up2,carry_down2,reset,enable);
//decoder and multiplexer for dynamic 7-seg LED 
decoder dec (  seg ,  an, counter_out0,counter_out1,counter_out2,counter_out3 , clk ) ;
endmodule
 

 
  



  
 

 
 