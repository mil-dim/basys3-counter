`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
 module bcd(
 output reg [3:0] bcd_out,
 output reg carry_up,
 output reg carry_down,
 input cl_up ,
 input cl_down,
 input reset ,
 input enable 
);
 
wire c;
assign cl=cl_up | cl_down ;

always@ (posedge cl or posedge  reset )
begin 
  if ( reset == 1'b1) 
      begin
      bcd_out <=  4'b0000;
      carry_up<=0;
      carry_down<=0;
      end
  else if ( enable == 1'b1 ) 
      begin
         if ( ~cl_down  )   //count up
           begin 
           bcd_out <= bcd_out + 1 ;
           if ( bcd_out == 9  )  // generate carry up
               begin
               carry_up<=1 ;
               carry_down <=0;
               bcd_out<=4'b0000; 
               end
           else 
               begin 
               carry_up <=0;
               carry_down <=0;  
               end
           end 
         if ( ~cl_up & cl_down)    // dount down           
           begin 
           bcd_out <= bcd_out - 1 ;
           if ( bcd_out == 4'b0000  )  //generate carry down
                begin 
                carry_down<=1;
                carry_up <=0;
                bcd_out <= 4'b1001;
                end
           else  
               begin
               carry_down <=0; 
               carry_up <=0;
               end
           end   
  end
end

endmodule
