`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/01 12:27:47
// Design Name: 
// Module Name: video_generator
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


module video_generator
#(parameter Delay_Num=3'd2)
(
    input i_clk,
    input i_rst,
    input i_rgb_vde,
    input i_rgb_hsync,
    input i_rgb_vsync,
    input [7:0]i_adc_data,
    input [10:0]i_set_x,
    input [10:0]i_set_y,
    output o_oscillo_en,
    output [23:0]o_rgb_data,
    output o_rgb_vde,
    output o_rgb_hsync,
    output o_rgb_vsync
    );
    
    //Video parameters
    localparam Video_H=12'd1920;
    localparam Video_L=12'd1080;
    
    //Cache
    reg [Delay_Num-1:0]rgb_vde_i=0;
    reg [Delay_Num-1:0]rgb_hsync_i=0;
    reg [Delay_Num-1:0]rgb_vsync_i=0;
    reg [7:0]adc_data_i=0;
    reg [10:0]set_x_i=0;
    reg [10:0]set_y_i=0;
    
    //Output
    reg oscillo_en_o=0;
    reg [23:0]rgb_data_o=0;
    
    //Signal connection
    assign o_oscillo_en=oscillo_en_o;
    assign o_rgb_data=rgb_data_o;
    assign o_rgb_vde=rgb_vde_i[Delay_Num-1];
    assign o_rgb_hsync=rgb_hsync_i[Delay_Num-1];
    assign o_rgb_vsync=rgb_vsync_i[Delay_Num-1];
    
    //Enable output
    always@(posedge i_clk or negedge i_rst)begin
        if(i_rst==1'b0)oscillo_en_o<=1'b0;
        else if(set_y_i==(Video_L>>2)+(Video_L>>3)-1)oscillo_en_o<=1'b1;
        else if(set_y_i==(Video_L>>2)+(Video_L>>3)+256)oscillo_en_o<=1'b0;
        else oscillo_en_o<=oscillo_en_o;
    end
    
    //Video output
    always@(posedge i_clk or negedge i_rst)begin
        if(i_rst==1'b0)rgb_data_o<=24'd0;
        else if(set_y_i==adc_data_i+(Video_L>>2)+(Video_L>>3))rgb_data_o<=24'hff00ff;
        else if(set_y_i==adc_data_i+(Video_L>>2)+(Video_L>>3)+1)rgb_data_o<=24'hff00ff;
        else if(set_y_i==adc_data_i+(Video_L>>2)+(Video_L>>3)+2)rgb_data_o<=24'hff00ff;
        else rgb_data_o<=24'd0;
    end
    
    //Input signal buffer
    always@(posedge i_clk or negedge i_rst)begin
        if(i_rst==1'b0)begin
            rgb_vde_i<={Delay_Num{1'b0}};
            rgb_hsync_i<={Delay_Num{1'b0}};
            rgb_vsync_i<={Delay_Num{1'b0}};
            set_x_i<=11'd0;
            set_y_i<=11'd0;
        end else begin
            rgb_vde_i<={rgb_vde_i[Delay_Num-2:0],i_rgb_vde};
            rgb_hsync_i<={rgb_hsync_i[Delay_Num-2:0],i_rgb_hsync};
            rgb_vsync_i<={rgb_vsync_i[Delay_Num-2:0],i_rgb_vsync};
            adc_data_i<=~i_adc_data;
            set_x_i<=i_set_x;
            set_y_i<=i_set_y;
        end
    end
endmodule

