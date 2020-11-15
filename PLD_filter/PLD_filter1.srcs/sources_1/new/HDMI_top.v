`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/01 12:27:47
// Design Name: 
// Module Name: HDMI_top
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


module HDMI_top(
    input i_clk,
    input i_rst,
    input [7:0]i_dac_data,
    input [7:0] freq,
    output TMDS_Tx_Clk_N,
    output TMDS_Tx_Clk_P,
    output [2:0]TMDS_Tx_Data_N,
    output [2:0]TMDS_Tx_Data_P
 );

     wire rgb_hsync_src;
     wire rgb_vsync_src;
     wire rgb_vde_src;
     
     wire [23:0]rgb_data;
     wire rgb_hsync;
     wire rgb_vsync;
     wire rgb_vde;
     
     wire [23:0]osd_rgb_data1;
     wire osd_rgb_hsync1;
     wire osd_rgb_vsync1;
     wire osd_rgb_vde1;
     
     wire [23:0]osd_rgb_data2;
     wire osd_rgb_hsync2;
     wire osd_rgb_vsync2;
     wire osd_rgb_vde2;
     
     wire [23:0]osd_rgb_data3;
     wire osd_rgb_hsync3;
     wire osd_rgb_vsync3;
     wire osd_rgb_vde3;
     
     wire [23:0]osd_rgb_data4;
    wire osd_rgb_hsync4;
     wire osd_rgb_vsync4;
     wire osd_rgb_vde4;
     
     wire [23:0]osd_rgb_data5;
     wire osd_rgb_hsync5;
     wire osd_rgb_vsync5;
     wire osd_rgb_vde5;
     
     wire clk_pixel;
     wire oscillo_en;
     wire [7:0]o_max_data;
     wire [15:0]max_data_3v3;
     wire [31:0]o_period;
     wire [9:0]freq_kHz;
     
     //Video signal
     wire [10:0]set_x;
     wire [10:0]set_y;
     //ADC data
     wire [7:0]adc_data;
     wire [7:0]  q0;
     wire [7:0]  q1;
     wire [7:0]  q2;
     wire [15:0]          osd_ram_addr0;
     wire [15:0]          osd_ram_addr1;
     wire [15:0]          osd_ram_addr2;
    
    //ADC data
    wire [7:0]dac_data;
    
    
    assign max_data_3v3=o_max_data*10'd165/10'd128;
    assign freq_kHz=o_period[8:0]/9'd100+(freq-8'd48)*10'd100;
   // assign freq_kHz=(freq-8'd48)*10'd100;
    //System clock
    clk_wiz_0 clk_10(.clk_out1(clk_pixel),.resetn(i_rst),.clk_in1(i_clk));
 
    
    //HDMI driver, video signal generation
    Driver_HDMI HDMI0(
        .i_clk(clk_pixel),                            //Clock
        .i_rst(i_rst),                                //Reset signal, low reset
        .i_video_mode(1'b0),                          //Video format,0 is 1920*1080@60Hz,1 is 1280*720@60Hz
        .o_rgb_hsync(rgb_hsync_src),                  //Line signal
        .o_rgb_vsync(rgb_vsync_src),                  //Field signal
        .o_rgb_vde(rgb_vde_src),                      //Data valid signal
        .o_set_x(set_x),                              //Image coordinate X
        .o_set_y(set_y)                               //Image coordinate Y
    );
    
        //ADC driver
    Driver_ADC Driver_ADC_0(
        .i_clk_100M(i_clk),
        .i_clk(clk_pixel),
        .i_rst(i_rst),
        .i_oscillo_en(oscillo_en),
        .i_oscillo_offset(11'd100),
        .i_oscillo_scale(4'd5),
        .i_adc_data(i_dac_data),
        .i_trigger_gate(8'd128),
        .i_set_x(set_x),
        .o_max_data(o_max_data),
         .o_period(o_period),
        .o_adc_data(dac_data)
        
    );
     video_generator video_adc(
          .i_clk(clk_pixel),
          .i_rst(i_rst),
          .i_rgb_vde(rgb_vde_src),
          .i_rgb_hsync(rgb_hsync_src),
          .i_rgb_vsync(rgb_vsync_src),
          .i_adc_data(dac_data),
          .i_set_x(set_x),
          .i_set_y(set_y),
          .o_oscillo_en(oscillo_en),
          .o_rgb_data(rgb_data),
          .o_rgb_vde(rgb_vde),
          .o_rgb_hsync(rgb_hsync),
          .o_rgb_vsync(rgb_vsync)
      );
    
    osd_rom osd_rom_m0 (
          .clka                       (clk_pixel              ),   
          .ena                        (1'b1                    ),     
          .addra                      (osd_ram_addr0[15:3]      ), 
          .douta                      (q0                       )  
      );
      osd_rom_freq osd_rom_m1 (
          .clka                       (clk_pixel                    ),   
          .ena                        (1'b1                   ),     
          .addra                      (osd_ram_addr1[15:3]      ), 
          .douta                      (q1                       )  
      );
      osd_rom_max osd_rom_m2 (
          .clka                       (clk_pixel                    ),   
          .ena                        (1'b1                  ),     
          .addra                      (osd_ram_addr2[15:3]      ), 
          .douta                      (q2                       )  
      ); 
  osd_display  osd_display_title(
          .rst_n                 (i_rst                  ),
          .pclk                  (clk_pixel              ),
          .i_hs                  (rgb_hsync              ),
          .i_vs                  (rgb_vsync              ),
          .i_de                  (rgb_vde                ),
          .i_data                (rgb_data               ),
          .OSD_WIDTH             (12'd432),
          .OSD_HEGIHT            (12'd66),
          .i_pos_x0              (12'd600),
          .i_pos_y0              (12'd9),
          .i_q                   (q0),
          .osd_ram_addr          (osd_ram_addr0),
          .o_hs                  (osd_rgb_hsync1          ),
          .o_vs                  (osd_rgb_vsync1          ),
          .o_de                  (osd_rgb_vde1            ),
          .o_data                (osd_rgb_data1           )
      );  
  osd_display  osd_display_freq(
              .rst_n                 (i_rst                  ),
              .pclk                  (clk_pixel              ),
              .i_hs                  (osd_rgb_hsync1              ),
              .i_vs                  (osd_rgb_vsync1              ),
              .i_de                  (osd_rgb_vde1                ),
              .i_data                (osd_rgb_data1               ),
              .OSD_WIDTH             (12'd144),
              .OSD_HEGIHT            (12'd32),
              .i_pos_x0              (12'd9),
              .i_pos_y0              (12'd60),
              .i_q                   (q1),
              .osd_ram_addr          (osd_ram_addr1),
              .o_hs                  (osd_rgb_hsync2          ),
              .o_vs                  (osd_rgb_vsync2          ),
              .o_de                  (osd_rgb_vde2            ),
              .o_data                (osd_rgb_data2           )
          );  
  
  osd_display  osd_display_max(
          .rst_n                 (i_rst                  ),
          .pclk                  (clk_pixel              ),
          .i_hs                  (osd_rgb_hsync2              ),
          .i_vs                  (osd_rgb_vsync2              ),
          .i_de                  (osd_rgb_vde2                ),
          .i_data                (osd_rgb_data2               ),
          .OSD_WIDTH             (12'd160),
          .OSD_HEGIHT            (12'd32),
          .i_pos_x0              (12'd9),
          .i_pos_y0              (12'd120),
          .i_q                   (q2),
          .osd_ram_addr          (osd_ram_addr2),
          .o_hs                  (osd_rgb_hsync3          ),
          .o_vs                  (osd_rgb_vsync3          ),
          .o_de                  (osd_rgb_vde3            ),
          .o_data                (osd_rgb_data3           )
      ); 
  num_display max_display(
           .data(max_data_3v3[9:0]),
           .rst_n(i_rst),   
           .pclk(clk_pixel),
           .i_hs(osd_rgb_hsync3),    
           .i_vs(osd_rgb_vsync3),    
           .i_de(osd_rgb_vde3),
           .i_data(osd_rgb_data3),
           .i_pos_y0(12'd120),                  
           .o_hs(osd_rgb_hsync4),    
           .o_vs(osd_rgb_vsync4),    
           .o_de(osd_rgb_vde4),    
           .o_data(osd_rgb_data4)
  ); 
  
  num_display freq_display(
           .data(freq_kHz),
           .rst_n(i_rst),   
           .pclk(clk_pixel),
           .i_hs(osd_rgb_hsync4),    
           .i_vs(osd_rgb_vsync4),    
           .i_de(osd_rgb_vde4),
           .i_data(osd_rgb_data4),
           .i_pos_y0(12'd60),                  
           .o_hs(osd_rgb_hsync5),    
           .o_vs(osd_rgb_vsync5),    
           .o_de(osd_rgb_vde5),    
           .o_data(osd_rgb_data5)
  ); 
      
      //Output signal conversion
  rgb2dvi_0 Mini_HDMI_Driver(
        .TMDS_Clk_p(TMDS_Tx_Clk_P),       // output wire TMDS_Clk_p
        .TMDS_Clk_n(TMDS_Tx_Clk_N),       // output wire TMDS_Clk_n
        .TMDS_Data_p(TMDS_Tx_Data_P),     // output wire [2 : 0] TMDS_Data_p
        .TMDS_Data_n(TMDS_Tx_Data_N),     // output wire [2 : 0] TMDS_Data_n
        .aRst_n(i_rst),                   // input wire aRst_n
        .vid_pData(osd_rgb_data5),         // input wire [23 : 0] vid_pData
        .vid_pVDE(osd_rgb_vde5),               // input wire vid_pVDE
        .vid_pHSync(osd_rgb_hsync5),           // input wire vid_pHSync
        .vid_pVSync(osd_rgb_vsync5),           // input wire vid_pVSync
        .PixelClk(clk_pixel)
      );
  endmodule
