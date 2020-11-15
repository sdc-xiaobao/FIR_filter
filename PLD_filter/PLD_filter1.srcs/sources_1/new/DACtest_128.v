`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/10/30 17:08:11
// Design Name: 
// Module Name: DACtest_128
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


module DACtest_128(
   input clk_100MHz, 
   input [17:0] DAC_Data,
   output clk_DAC,  
   output reg DAC_Din, 
   output reg DAC_Sync 
    );
    reg [30:0] clk_divided_20MHz=5/2;
      Clk_Division_0 inst (
      .clk_100MHz(clk_100MHz),
      .clk_mode(clk_divided_20MHz),
      .clk_out(clk_DAC)
    );
     //DAC data 
     //  reg [15:0]DAC_Data=16'h8000; 
       //DAC cycle state machine count 
       reg [4:0] DAC_Cnt = 5'd0;
       
       always@(posedge clk_DAC) 
               begin 
                   if(DAC_Cnt == 24) 
                       DAC_Cnt <= 5'd0; 
                   else 
                       DAC_Cnt <= DAC_Cnt + 5'd1; 
                   case(DAC_Cnt) 
                       5'd0: DAC_Din <= 1'b0; 
                       5'd1: DAC_Din <= DAC_Data[17];
                       5'd2: DAC_Din <= DAC_Data[16];
                       5'd3: DAC_Din <= DAC_Data[15];
                       5'd4: DAC_Din <= DAC_Data[14];
                       5'd5: DAC_Din <= DAC_Data[13];
                       5'd6: DAC_Din <= DAC_Data[12];
                       5'd7: DAC_Din <= DAC_Data[11]; 
                       5'd8: DAC_Din <= DAC_Data[10]; 
                       5'd9: DAC_Din <= DAC_Data[9]; 
                       5'd10: DAC_Din <= DAC_Data[8]; 
                       5'd11: DAC_Din <= DAC_Data[7]; 
                       5'd12: DAC_Din <= DAC_Data[6]; 
                       5'd13: DAC_Din <= DAC_Data[5]; 
                       5'd14: DAC_Din <= DAC_Data[4]; 
                       5'd15: DAC_Din <= DAC_Data[3]; 
                       5'd16: DAC_Din <= DAC_Data[2]; 
                       5'd17: DAC_Din <= DAC_Data[1]; 
                       5'd18: DAC_Din <= DAC_Data[0];                                                                                                                  
                       5'd19: DAC_Din <= 1'b0; 
                       5'd20: DAC_Din <= 1'b0; 
                       5'd21: DAC_Din <= 1'b0;
                       5'd22: DAC_Din <= 1'b0;                                            
                       5'd23: begin 
                               DAC_Din <= 1'b0; 
                               DAC_Sync <= 1'b1; 
                              end 
                       5'd24: begin  
                               DAC_Din <= 1'b0; 
                               DAC_Sync <= 1'b0;  
                               end 
                               endcase     
                               end
    
    
    
endmodule
