`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/01 12:27:47
// Design Name: 
// Module Name: Driver_HDMI
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


`define Video_Mode_1600_900 2'd0
`define Video_Mode_1280_720 2'd1
`define Video_Mode_1920_1080 2'd2

module Driver_HDMI(
    input i_clk,                            //Clock
    input i_rst,                            //Reset signal, low reset
    input i_video_mode,                     //Video format,0 is 1920*1080@60Hz,1 is 1280*720@60Hz
    output o_rgb_hsync,                     //Line signal
    output o_rgb_vsync,                     //Field signal
    output o_rgb_vde,                       //Data valid signal
    output [10:0]o_set_x,                   //Image coordinate X
    output [10:0]o_set_y                    //Image coordinate Y
);
    localparam H_ACTIVE_1280_720 = 16'd1280;
    localparam H_FP_1280_720 = 16'd110;
    localparam H_SYNC_1280_720 = 16'd40;
    localparam H_BP_1280_720 = 16'd220; 
    localparam V_ACTIVE_1280_720 = 16'd720;
    localparam V_FP_1280_720     = 16'd5;
    localparam V_SYNC_1280_720  = 16'd5;
    localparam V_BP_1280_720    = 16'd20;
    localparam H_TOTAL_1280_720 = H_ACTIVE_1280_720 + H_FP_1280_720 + H_SYNC_1280_720 + H_BP_1280_720;
    localparam V_TOTAL_1280_720 = V_ACTIVE_1280_720 + V_FP_1280_720 + V_SYNC_1280_720 + V_BP_1280_720;
    
    
    localparam H_ACTIVE_1600_900 = 16'd1600;
        localparam H_FP_1600_900 = 16'd48;
        localparam H_SYNC_1600_900 = 16'd12;
        localparam H_BP_1600_900 = 16'd80; 
        localparam V_ACTIVE_1600_900 = 16'd900;
        localparam V_FP_1600_900     = 16'd3;
        localparam V_SYNC_1600_900  = 16'd5;
        localparam V_BP_1600_900    = 16'd18;
        localparam H_TOTAL_1600_900 = H_ACTIVE_1600_900 + H_FP_1600_900 + H_SYNC_1600_900 + H_BP_1600_900;
        localparam V_TOTAL_1600_900 = V_ACTIVE_1600_900 + V_FP_1600_900 + V_SYNC_1600_900 + V_BP_1600_900;
    
    localparam H_ACTIVE_1920_1080 = 16'd1920;
    localparam H_FP_1920_1080 = 16'd88;
    localparam H_SYNC_1920_1080 = 16'd44;
    localparam H_BP_1920_1080 = 16'd148; 
    localparam V_ACTIVE_1920_1080 = 16'd1080;
    localparam V_FP_1920_1080     = 16'd4;
    localparam V_SYNC_1920_1080  = 16'd5;
    localparam V_BP_1920_1080    = 16'd36;
    localparam H_TOTAL_1920_1080 = H_ACTIVE_1920_1080 + H_FP_1920_1080 + H_SYNC_1920_1080 + H_BP_1920_1080;
    localparam V_TOTAL_1920_1080 = V_ACTIVE_1920_1080 + V_FP_1920_1080 + V_SYNC_1920_1080 + V_BP_1920_1080;
    
    reg [11:0]H_ACTIVE=0;   //Line effective length (number of pixel clock cycles)
    reg [11:0]H_FP=0;       //Line sync front shoulder length
    reg [11:0]H_SYNC=0;     //Line sync length
    reg [11:0]H_BP=0;       //Line sync shoulder length
    reg [11:0]V_ACTIVE=0;   //Field effective length (number of rows)
    reg [11:0]V_FP=0;       //Field sync front shoulder length
    reg [11:0]V_SYNC= 0;    //Field sync length
    reg [11:0]V_BP=0;       //Field sync back shoulder length
    reg [11:0]H_TOTAL=0;    //Total length of line
    reg [11:0]V_TOTAL=0;    //Total length of field
    
    //Line and field signal count
    reg [11:0]hsync_cnt=0;
    reg [11:0]vsync_cnt=0;
    
    //Line and field effective signal
    reg h_de=0;
    reg v_de=0;
    
    //Input cache
    reg video_mode_i=0;
    
    //Output
    reg rgb_hsync_o=0;
    reg rgb_vsync_o=0;
    reg rgb_vde_o=0;
    reg [11:0]set_x_o=0;
    reg [11:0]set_y_o=0;
    
    //Output wiring
    assign o_rgb_hsync=rgb_hsync_o;
    assign o_rgb_vsync=rgb_vsync_o;
    assign o_rgb_vde=rgb_vde_o;
    assign o_set_x=set_x_o[10:0];
    assign o_set_y=set_y_o[10:0];
    
    //Image X coordinate generation
    always@(posedge i_clk or negedge i_rst)begin
        if(i_rst==1'b0)begin
            set_x_o<=12'd0;
        end else if(hsync_cnt>=H_FP + H_SYNC + H_BP - 1)begin
            //When the line signal is valid, start to get the X coordinate value
            set_x_o <= hsync_cnt-(H_FP + H_SYNC + H_BP - 1);
        end else begin
            set_x_o<=12'd0;
        end
    end
    
    //Image Y coordinate generation
    always@(posedge i_clk or negedge i_rst)begin
        if(i_rst==1'b0)begin
            set_y_o<=12'd0;
        end else if(vsync_cnt>=V_FP + V_SYNC + V_BP - 1)begin
            //When the field signal is valid, start to get the current Y coordinate
            set_y_o<=vsync_cnt-(V_FP + V_SYNC + V_BP - 1);
        end else begin
            set_y_o<=12'd0;
        end
    end
    
    //Video format acquisition
    always@(*)begin
        if(video_mode_i==`Video_Mode_1920_1080)begin
            H_ACTIVE<=H_ACTIVE_1920_1080;   //Line effective length (number of pixel clock cycles)
            H_FP<=H_FP_1920_1080;           //Line sync front shoulder length
            H_SYNC<=H_SYNC_1920_1080;       //Line sync length
            H_BP<=H_BP_1920_1080;           //Line sync back shoulder length
            V_ACTIVE<=V_ACTIVE_1920_1080;   //Field effective length (number of rows)
            V_FP<=V_FP_1920_1080;           //Field sync front shoulder length
            V_SYNC<=V_SYNC_1920_1080;       //Field sync length
            V_BP<=V_BP_1920_1080;           //Field sync back shoulder length
            H_TOTAL<=H_TOTAL_1920_1080;     //Total length of line
            V_TOTAL<=V_TOTAL_1920_1080;     //Total length of field
        end 
        else if(video_mode_i==`Video_Mode_1600_900 )
        begin
        H_ACTIVE<=H_ACTIVE_1600_900;   //Line effective length (number of pixel clock cycles)
        H_FP<=H_FP_1600_900;           //Line sync front shoulder length
        H_SYNC<=H_SYNC_1600_900;       //Line sync length
        H_BP<=H_BP_1600_900;           //Line sync back shoulder length
        V_ACTIVE<=V_ACTIVE_1600_900;   //Field effective length (number of rows)
        V_FP<=V_FP_1600_900;           //Field sync front shoulder length
        V_SYNC<=V_SYNC_1600_900;       //Field sync length
        V_BP<=V_BP_1600_900;           //Field sync back shoulder length
        H_TOTAL<=H_TOTAL_1600_900;     //Total length of line
        V_TOTAL<=V_TOTAL_1600_900;     //Total length of field
        end
        else begin
            H_ACTIVE<=H_ACTIVE_1280_720;    //Line effective length (number of pixel clock cycles)
            H_FP<=H_FP_1280_720;            //Line sync front shoulder length
            H_SYNC<=H_SYNC_1280_720;        //Line sync length
            H_BP<=H_BP_1280_720;            //Line sync back shoulder length
            V_ACTIVE<=V_ACTIVE_1280_720;    //Field effective length (number of rows)
            V_FP<=V_FP_1280_720;            //Field sync front shoulder length
            V_SYNC<=V_SYNC_1280_720;        //Field sync length
            V_BP<=V_BP_1280_720;            //Field sync back shoulder length
            H_TOTAL<=H_TOTAL_1280_720;      //Total length of line
            V_TOTAL<=V_TOTAL_1280_720;      //Total length of field
        end
    end

    //Line signal count
    always@(posedge i_clk or negedge i_rst)begin
        if(i_rst==1'b0)begin
            hsync_cnt<=12'd0;
        end else if(hsync_cnt==H_TOTAL-1)begin
            hsync_cnt<=12'd0;
        end else begin
            hsync_cnt<=hsync_cnt+1;
        end
    end
    
    //Field signal count
    always@(posedge i_clk or negedge i_rst)begin
        if(i_rst==1'b0)begin
            vsync_cnt<=12'd0;
        end else if(hsync_cnt==H_FP-1&vsync_cnt==V_TOTAL-1)begin
            vsync_cnt<=12'd0;
        end else if(hsync_cnt==H_FP-1)begin
            vsync_cnt<=vsync_cnt+1;
        end else begin
            vsync_cnt<=vsync_cnt;
        end
    end
    
    //Line signal effective output
    always@(posedge i_clk or negedge i_rst)begin
        if(i_rst==1'b0)begin
            h_de<=1'b0;
        end else if(hsync_cnt==H_FP + H_SYNC + H_BP - 1)begin
            h_de<=1'b1;
        end else if(hsync_cnt==H_TOTAL-1)begin
            h_de<=1'b0;
        end else begin
            h_de<=h_de;
        end
    end
    
    //Field signal effective output
    always@(posedge i_clk or negedge i_rst)begin
        if(i_rst==1'b0)begin
            v_de<=1'b0;
        end else if(hsync_cnt==H_FP-1&vsync_cnt==V_FP + V_SYNC + V_BP - 1)begin
            v_de<=1'b1;
        end else if(hsync_cnt==H_FP-1&vsync_cnt==V_TOTAL-1)begin
            v_de<=1'b0;
        end else begin
            v_de<=v_de;
        end
    end
    
    //Data valid signal output
    always@(posedge i_clk or negedge i_rst)begin
        if(i_rst==1'b0)begin
            rgb_vde_o<=1'b0;
        end else begin
            rgb_vde_o<=h_de&v_de;
        end
    end
    
    //Line signal output
    always@(posedge i_clk or negedge i_rst)begin
        if(i_rst==1'b0)begin
            rgb_hsync_o<=1'b0;
        end else if(hsync_cnt==H_FP-1)begin
            rgb_hsync_o<=1'b1;
        end else if(hsync_cnt==H_FP + H_SYNC - 1)begin
            rgb_hsync_o<=1'b0;
        end else begin
            rgb_hsync_o<=rgb_hsync_o;
        end
    end
    
    //Field signal output
    always@(posedge i_clk or negedge i_rst)begin
        if(i_rst==1'b0)begin
            rgb_vsync_o<=1'b0;
        end else if(hsync_cnt==H_FP-1&vsync_cnt==V_FP-1)begin
            rgb_vsync_o<=1'b1;
        end else if(hsync_cnt==H_FP-1&vsync_cnt==V_FP + V_SYNC - 1)begin
            rgb_vsync_o<=1'b0;
        end else begin
            rgb_vsync_o<=rgb_vsync_o;
        end
    end
    
    //Input signal buffer
    always@(posedge i_clk or negedge i_rst)begin
        if(i_rst==1'b0)begin
            video_mode_i<=1'b0;
        end else begin
            video_mode_i<=i_video_mode;
        end
    end
endmodule
