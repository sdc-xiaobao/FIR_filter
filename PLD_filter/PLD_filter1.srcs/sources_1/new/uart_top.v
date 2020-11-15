`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/01 11:12:34
// Design Name: 
// Module Name: uart_top
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


module uart_top
(
    input clk,
    input Rx,
    input [30:0] Baud_Rate,
    output [7:0]Rx_Data,
    output [7:0]Rx_Data2

);

wire clk_115200;
wire [30:0]clk_mode;
//reg [30:0]Baud_Rate=115200;
wire Rx_ACK;
assign clk_mode='d100_000_000/Baud_Rate+1;


clk_div clk_div_baud
(
    .clk_100MHz(clk),  // input wire clk_100MHz
    .clk_mode(clk_mode),      // input wire [30 : 0] clk_mode
    .clk_out(clk_115200)        // output wire clk_out
  );
uart_rx uart_rx
(
    .clk(clk_115200),
    .rxd(Rx),
    .data_i(Rx_Data),
    .data_i2(Rx_Data2),
    .receive_ack(Rx_ACK)
);

endmodule


