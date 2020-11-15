`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/07 02:25:20
// Design Name: 
// Module Name: num_display
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


module num_display(
 input[9:0]                  data,
   input                       rst_n,   
   input                       pclk,
   input                       i_hs,    
   input                       i_vs,    
   input                       i_de,
   input[23:0]                 i_data,
   input[11:0]                 i_pos_y0,        
   output                      o_hs,    
   output                      o_vs,    
   output                      o_de,    
   output[23:0]                o_data
);


wire [15:0]          osd_ram_addr0;
wire [15:0]          osd_ram_addr1;
wire [15:0]          osd_ram_addr2;
wire [15:0]          osd_ram_addr3;
wire [7:0]  q0,q1,q2,q3;
reg  [7:0]  o_q0,o_q1,o_q2;
wire [7:0]  q00,q01,q02, q03,q04,q05,q06,q07,q08,q09;
wire [7:0]  q10,q11,q12,q13,q14,q15,q16,q17,q18,q19;
wire [7:0]  q20,q21,q22,q23,q24,q25,q26,q27,q28,q29;


/*wire[7:0] data_0;
wire[7:0] a0;
wire[3:0] a1;
wire[3:0] a2;*/
reg cs=1'b1;
reg [7:0] data_0;
reg[7:0] a0;
reg[3:0] a1;
reg[3:0] a2;

wire [23:0]osd_rgb_data0;
wire osd_rgb_hsync0;
wire osd_rgb_vsync0;
wire osd_rgb_vde0;

wire [23:0]osd_rgb_data1;
wire osd_rgb_hsync1;
wire osd_rgb_vsync1;
wire osd_rgb_vde1;

wire [23:0]osd_rgb_data2;
wire osd_rgb_hsync2;
wire osd_rgb_vsync2;
wire osd_rgb_vde2;

assign q0=o_q0;
assign q1=o_q1;
assign q2=o_q2;
/*assign data_0=data;
assign a0=data_0%10'd10;
assign a1=data_0/10'd10%10'd10;
assign a2=data_0/10'd100%10'd10;*/

always@(posedge pclk&&cs)
begin
   cs=1'b0;
   data_0=data;
   a0=data_0%8'd10;
   a1=data_0/8'd10%8'd10;
   a2=data_0/8'd100%8'd10;
   cs=1'b1;
end


mem_0 rom_t00(.clka(pclk),.ena(1'b1),.addra(osd_ram_addr0[15:3]),.douta(q00));
mem_1 rom_t01(.clka(pclk),.ena(1'b1),.addra(osd_ram_addr0[15:3]),.douta(q01));
mem_2 rom_t02(.clka(pclk),.ena(1'b1),.addra(osd_ram_addr0[15:3]),.douta(q02));
mem_3 rom_t03(.clka(pclk),.ena(1'b1),.addra(osd_ram_addr0[15:3]),.douta(q03));
mem_4 rom_t04(.clka(pclk),.ena(1'b1),.addra(osd_ram_addr0[15:3]),.douta(q04));
mem_5 rom_t05(.clka(pclk),.ena(1'b1),.addra(osd_ram_addr0[15:3]),.douta(q05));
mem_6 rom_t06(.clka(pclk),.ena(1'b1),.addra(osd_ram_addr0[15:3]),.douta(q06));
mem_7 rom_t07(.clka(pclk),.ena(1'b1),.addra(osd_ram_addr0[15:3]),.douta(q07));
mem_8 rom_t08(.clka(pclk),.ena(1'b1),.addra(osd_ram_addr0[15:3]),.douta(q08));
mem_9 rom_t09(.clka(pclk),.ena(1'b1),.addra(osd_ram_addr0[15:3]),.douta(q09));

mem_0 rom_t10(.clka(pclk),.ena(1'b1),.addra(osd_ram_addr1[15:3]),.douta(q10));
mem_1 rom_t11(.clka(pclk),.ena(1'b1),.addra(osd_ram_addr1[15:3]),.douta(q11));
mem_2 rom_t12(.clka(pclk),.ena(1'b1),.addra(osd_ram_addr1[15:3]),.douta(q12));
mem_3 rom_t13(.clka(pclk),.ena(1'b1),.addra(osd_ram_addr1[15:3]),.douta(q13));
mem_4 rom_t14(.clka(pclk),.ena(1'b1),.addra(osd_ram_addr1[15:3]),.douta(q14));
mem_5 rom_t15(.clka(pclk),.ena(1'b1),.addra(osd_ram_addr1[15:3]),.douta(q15));
mem_6 rom_t16(.clka(pclk),.ena(1'b1),.addra(osd_ram_addr1[15:3]),.douta(q16));
mem_7 rom_t17(.clka(pclk),.ena(1'b1),.addra(osd_ram_addr1[15:3]),.douta(q17));
mem_8 rom_t18(.clka(pclk),.ena(1'b1),.addra(osd_ram_addr1[15:3]),.douta(q18));
mem_9 rom_t19(.clka(pclk),.ena(1'b1),.addra(osd_ram_addr1[15:3]),.douta(q19));

mem_0 rom_t20(.clka(pclk),.ena(1'b1),.addra(osd_ram_addr2[15:3]),.douta(q20));
mem_1 rom_t21(.clka(pclk),.ena(1'b1),.addra(osd_ram_addr2[15:3]),.douta(q21));
mem_2 rom_t22(.clka(pclk),.ena(1'b1),.addra(osd_ram_addr2[15:3]),.douta(q22));
mem_3 rom_t23(.clka(pclk),.ena(1'b1),.addra(osd_ram_addr2[15:3]),.douta(q23));
mem_4 rom_t24(.clka(pclk),.ena(1'b1),.addra(osd_ram_addr2[15:3]),.douta(q24));
mem_5 rom_t25(.clka(pclk),.ena(1'b1),.addra(osd_ram_addr2[15:3]),.douta(q25));
mem_6 rom_t26(.clka(pclk),.ena(1'b1),.addra(osd_ram_addr2[15:3]),.douta(q26));
mem_7 rom_t27(.clka(pclk),.ena(1'b1),.addra(osd_ram_addr2[15:3]),.douta(q27));
mem_8 rom_t28(.clka(pclk),.ena(1'b1),.addra(osd_ram_addr2[15:3]),.douta(q28));
mem_9 rom_t29(.clka(pclk),.ena(1'b1),.addra(osd_ram_addr2[15:3]),.douta(q29));

mem_dot rom_dot(.clka(pclk),.ena(1'b1),.addra(osd_ram_addr3[15:3]),.douta(q3));

always@(*)
begin
  case(a0)
      8'd0:o_q0<=q00;
      8'd1:o_q0<=q01;
      8'd2:o_q0<=q02;
      8'd3:o_q0<=q03;
      8'd4:o_q0<=q04;
      8'd5:o_q0<=q05;
      8'd6:o_q0<=q06;
      8'd7:o_q0<=q07;
      8'd8:o_q0<=q08;
      8'd9:o_q0<=q09;
      default:o_q0<=q00;
   endcase
   case(a1)
       8'd0:o_q1<=q10;
       8'd1:o_q1<=q11;
       8'd2:o_q1<=q12;
       8'd3:o_q1<=q13;
       8'd4:o_q1<=q14;
       8'd5:o_q1<=q15;
       8'd6:o_q1<=q16;
       8'd7:o_q1<=q17;
       8'd8:o_q1<=q18;
       8'd9:o_q1<=q19;
       default:o_q1<=q00;
    endcase
    case(a2)
        8'd0:o_q2<=q20;
        8'd1:o_q2<=q21;
        8'd2:o_q2<=q22;
        8'd3:o_q2<=q23;
        8'd4:o_q2<=q24;
        8'd5:o_q2<=q25;
        8'd6:o_q2<=q26;
        8'd7:o_q2<=q27;
        8'd8:o_q2<=q28;
        8'd9:o_q2<=q29;
        default:o_q2<=q20;
    endcase
end
osd_display  osd_display_0(
       .rst_n                 (rst_n                  ),
       .pclk                  (pclk              ),
       .i_hs                  (i_hs              ),
       .i_vs                  (i_vs              ),
       .i_de                  (i_de                ),
       .i_data                (i_data               ),
       .OSD_WIDTH             (12'd16),
       .OSD_HEGIHT            (12'd32),
       .i_pos_x0              (12'd180),
       .i_pos_y0              (i_pos_y0),
       .i_q                   (q2),
       .osd_ram_addr          (osd_ram_addr2),
       .o_hs                  (osd_rgb_hsync0          ),
       .o_vs                  (osd_rgb_vsync0          ),
       .o_de                  (osd_rgb_vde0            ),
       .o_data                (osd_rgb_data0           )
   ); 
   
osd_display  osd_display_1(
           .rst_n                 (rst_n                  ),
           .pclk                  (pclk              ),
           .i_hs                  (osd_rgb_hsync0              ),
           .i_vs                  (osd_rgb_vsync0              ),
           .i_de                  (osd_rgb_vde0                ),
           .i_data                (osd_rgb_data0               ),
           .OSD_WIDTH             (12'd16),
           .OSD_HEGIHT            (12'd32),
           .i_pos_x0              (12'd220),
           .i_pos_y0              (i_pos_y0),
           .i_q                   (q1),
           .osd_ram_addr          (osd_ram_addr1),
           .o_hs                  (osd_rgb_hsync1          ),
           .o_vs                  (osd_rgb_vsync1          ),
           .o_de                  (osd_rgb_vde1            ),
           .o_data                (osd_rgb_data1           )
       ); 
       
osd_display  osd_display_2(
               .rst_n                 (rst_n                  ),
               .pclk                  (pclk              ),
               .i_hs                  (osd_rgb_hsync1              ),
               .i_vs                  (osd_rgb_vsync1              ),
               .i_de                  (osd_rgb_vde1                ),
               .i_data                (osd_rgb_data1               ),
               .OSD_WIDTH             (12'd16),
               .OSD_HEGIHT            (12'd32),
               .i_pos_x0              (12'd240),
               .i_pos_y0              (i_pos_y0),
               .i_q                   (q0),
               .osd_ram_addr          (osd_ram_addr0),
               .o_hs                  (osd_rgb_hsync2          ),
               .o_vs                  (osd_rgb_vsync2          ),
               .o_de                  (osd_rgb_vde2            ),
               .o_data                (osd_rgb_data2           )
           ); 
osd_display  osd_display_dot(
                           .rst_n                 (rst_n                  ),
                           .pclk                  (pclk              ),
                           .i_hs                  (osd_rgb_hsync2              ),
                           .i_vs                  (osd_rgb_vsync2              ),
                           .i_de                  (osd_rgb_vde2                ),
                           .i_data                (osd_rgb_data2               ),
                           .OSD_WIDTH             (12'd16),
                           .OSD_HEGIHT            (12'd32),
                           .i_pos_x0              (12'd200),
                           .i_pos_y0              (i_pos_y0),
                           .i_q                   (q3),
                           .osd_ram_addr          (osd_ram_addr3),
                           .o_hs                  (o_hs          ),
                           .o_vs                  (o_vs          ),
                           .o_de                  (o_de            ),
                           .o_data                (o_data           )
                       ); 

endmodule
