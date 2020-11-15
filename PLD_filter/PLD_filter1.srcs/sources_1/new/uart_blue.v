`timescale 1ns / 1ps


module uart_blue(
   input clk,
 input Rx,
 input [30:0]Baud_Rate,
 output [7:0]Rx_Data

);

wire clk_115200;
wire [30:0]clk_mode;
wire Rx_ACK;
reg cs=1'b1;


assign clk_mode='d100_000_000/Baud_Rate+1;


clk_div clk_div_baud
(
 .clk_100MHz(clk),  // input wire clk_100MHz
 .clk_mode(clk_mode),      // input wire [30 : 0] clk_mode
 .clk_out(clk_115200)        // output wire clk_out
);
uart_rx_blue uart_rx_blue
(
 .clk(clk_115200),
 .rxd(Rx),
 .data_i(Rx_Data),
 .receive_ack(Rx_ACK)
);

endmodule
