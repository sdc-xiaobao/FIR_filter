`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/10/30 17:07:00
// Design Name: 
// Module Name: top_128
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

module top_128#(parameter  WIDTH = 8)
(
           input                              clk_100MHz,
           input                              i_rst,
           input  signed     [WIDTH -1:0]     i_data,
           output                             ADC_En,
           output                             clk_ADC,
           output                             clk_DAC,  
           output                             DAC_Din, 
           output                             DAC_Sync,
           output                             i2c_scl,
           inout                              i2c_sda,
           output                             LED_IO,
           output                             LED_IO2,
           input                              UART0_Rx,
           input                              UART0_Rx_blue,
           output                             TMDS_Tx_Clk_N,
           output                             TMDS_Tx_Clk_P,
           output         [2:0]               TMDS_Tx_Data_N,
           output         [2:0]               TMDS_Tx_Data_P
     
        );

wire    signed [2*WIDTH+1:0]  o_data;
reg    [7:0]               data_dac;
reg    [7:0]               data;
wire   [7:0]               rx_data;
wire   [7:0]               rx_data2;
wire    [7:0]               blue_data;
wire    [7:0]               dac_data;

assign dac_data=o_data[2*WIDTH+1:2*WIDTH-6];
//wire               [7:0]            Data1=8'h33;
FIR_128 fir_instance
(
.I_clk(clk_100MHz),
.I_rst_p(i_rst),
.I_data(i_data),
.O_data(o_data),
.ADC_En(ADC_En),
.clk_ADC(clk_ADC),
.Data(data)
);
assign LED_IO=(rx_data==8'h02)?1:0;
assign LED_IO2=(rx_data==8'h03)?1:0;

always@(posedge clk_100MHz)
begin
   case(rx_data)
       8'h01:data<=rx_data2;
       8'h02:data<=blue_data;
       8'h03:data_dac<=rx_data2;
 endcase
end


DACtest_128 dac_instance
(
.clk_100MHz(clk_100MHz),
.DAC_Data(o_data), 
.clk_DAC(clk_DAC),  
.DAC_Din(DAC_Din), 
.DAC_Sync(DAC_Sync)
);

uart_top uart_top
(
    .clk(clk_100MHz),
    .Baud_Rate(115200),
    .Rx(UART0_Rx),
    .Rx_Data(rx_data),
    .Rx_Data2(rx_data2) 
);

uart_blue uart_blue(
    .clk(clk_100MHz),
    .Baud_Rate(9600),
    .Rx(UART0_Rx_blue),
    .Rx_Data(blue_data)
        );
i2c_top dacout(
       .clk(clk_100MHz),
       .rst_n(i_rst),
       .scl(i2c_scl),
       .sda(i2c_sda),
       .dac_data(data_dac)
        );
    
HDMI_top HDMI
(
        .i_clk(clk_100MHz),
        .i_rst(i_rst),
        .i_dac_data(dac_data),
        .freq(data),
        .TMDS_Tx_Clk_N(TMDS_Tx_Clk_N),
        .TMDS_Tx_Clk_P(TMDS_Tx_Clk_P),
        .TMDS_Tx_Data_N(TMDS_Tx_Data_N),
        .TMDS_Tx_Data_P(TMDS_Tx_Data_P)
 );

endmodule

