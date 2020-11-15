`timescale 1ns / 1ps

module i2c_top(
input clk,
 input rst_n,
 output scl,
 inout sda,
 input [7:0] dac_data

);
  wire                  clk_50M;
  wire                  i2c_exec        ;  //I2C触发执行信号
  wire   [7:0]         i2c_data1        ;  //I2C要配置的地址与数据(高8位地址,低16位数据)          
  wire   [15:0]         i2c_data2        ;
  wire                  i2c_done        ;  //I2C寄存器配置完成信号
  wire                  i2c_dri_clk     ;  //I2C操作时钟
  parameter  SLAVE_ADDR = 7'h61         ;  //MCP4725的器件地址7'h60
  parameter  BIT_CTRL   = 1'b0          ;  //字节地址为8位  0:8位 1:16位
  parameter  CLK_FREQ   = 26'd50_000_000;  //时钟频率 50MHz
  parameter  I2C_FREQ   = 18'd250_000   ;  //I2C的SCL时钟频率,250KHz


clk_wiz_1 instance_name
   (
     .clk_out1(clk_50M),     // output clk_out1
     .clk_in1(clk));  
i2c_drive 
   #(
    .SLAVE_ADDR         (SLAVE_ADDR),       //参数传递
    .CLK_FREQ           (CLK_FREQ  ),              
    .I2C_FREQ           (I2C_FREQ  )                
    )   

u_i2c_drive(   
    .clk                (clk_50M       ),
    .rst_n              (rst_n     ),   
        
    .i2c_exec           (i2c_exec  ),   
    .bit_ctrl           (BIT_CTRL  ),   
    .i2c_rh_wl          (1'b0),             //固定为0，只用到了IIC驱动的写操作   
    .i2c_addr           (i2c_data1),   
    .i2c_data_w         (i2c_data2),   
    .i2c_data_r         (),   
    .i2c_done           (i2c_done  ),   
    .scl                (scl   ),   
    .sda                (sda   ),   
    .dri_clk            (i2c_dri_clk)       //I2C操作时钟
); 
  
MCP4725_init u_MCP4725_init( 
 
   .clk     (i2c_dri_clk),   //时钟信号
   .rst_n   (rst_n),   //复位信号，低电平有效
   .send_data(dac_data),
   .i2c_done(i2c_done),   //I2C寄存器配置完成信号
   .i2c_exec(i2c_exec),   //I2C触发执行信号   
   .i2c_data1(i2c_data1),   //I2C要配置的地址与数据(高8位地址,低16位数据)
   .i2c_data2(i2c_data2)
);


endmodule
