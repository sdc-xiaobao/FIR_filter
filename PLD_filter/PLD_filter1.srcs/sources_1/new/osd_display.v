`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/07 02:25:20
// Design Name: 
// Module Name: osd_display
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


module osd_display(
	input                       rst_n,   
input                       pclk,
input                       i_hs,    
input                       i_vs,    
input                       i_de,
input[11:0]                 OSD_WIDTH,
input[11:0]                 OSD_HEGIHT,
input[23:0]                 i_data,
input[11:0]                 i_pos_x0,
input[11:0]                 i_pos_y0,
input[7:0]                  i_q,
output reg [15:0]          osd_ram_addr,                    
output                      o_hs,    
output                      o_vs,    
output                      o_de,    
output[23:0]                o_data
);
//parameter OSD_WIDTH   =  12'd432;
//parameter OSD_HEGIHT  =  12'd66;

wire[11:0] pos_x;
wire[11:0] pos_y;
wire       pos_hs;
wire       pos_vs;
wire       pos_de;
wire[23:0] pos_data;
reg[23:0]  v_data;
reg[11:0]  osd_x;
reg[11:0]  osd_y;
//reg[15:0]  osd_ram_addr;
//wire[7:0]  q;
reg        region_active;
reg        region_active_d0;
reg        region_active_d1;
reg        region_active_d2;

reg        pos_vs_d0;
reg        pos_vs_d1;

assign o_data = v_data;
assign o_hs = pos_hs;
assign o_vs = pos_vs;
assign o_de = pos_de;
//delay 1 clock 

//给予区域有效信号
always@(posedge pclk)
begin
if(pos_y >= i_pos_y0 && pos_y <= i_pos_y0 + OSD_HEGIHT - 12'd1 && pos_x >= i_pos_x0 && pos_x  <= i_pos_x0 + OSD_WIDTH - 12'd1)
    region_active <= 1'b1;
else
    region_active <= 1'b0;
end

always@(posedge pclk)
begin
region_active_d0 <= region_active;
region_active_d1 <= region_active_d0;
region_active_d2 <= region_active_d1;
end

always@(posedge pclk)
begin
pos_vs_d0 <= pos_vs;
pos_vs_d1 <= pos_vs_d0;
end

//对x坐标方向在区域有效时进行计数
always@(posedge pclk)
begin
if(region_active_d0 == 1'b1)
    osd_x <= osd_x + 12'd1;
else
    osd_x <= 12'd0;
end

//在场通道下降沿到来时对ROM地址清零
always@(posedge pclk)
begin
if(pos_vs_d1 == 1'b1 && pos_vs_d0 == 1'b0)
    osd_ram_addr <= 16'd0;
else if(region_active == 1'b1)
    osd_ram_addr <= osd_ram_addr + 16'd1;
end

//在显示区域有效情况下，ROM中的数据有等于1的
//就赋值给data，否则赋值波形的
always@(posedge pclk)
begin
if(region_active_d0 == 1'b1)
    if(i_q[osd_x[2:0]] == 1'b1)
        v_data <= 24'h6A5ACD;
    else
        v_data <= pos_data;
else
    v_data <= pos_data;
end



timing_gen_xy timing_gen_xy_m0(
.rst_n    (rst_n    ),
.clk      (pclk     ),
.i_hs     (i_hs     ),
.i_vs     (i_vs     ),
.i_de     (i_de     ),
.i_data   (i_data   ),
.o_hs     (pos_hs   ),
.o_vs     (pos_vs   ),
.o_de     (pos_de   ),
.o_data   (pos_data ),
.x        (pos_x    ),
.y        (pos_y    )
);
endmodule
