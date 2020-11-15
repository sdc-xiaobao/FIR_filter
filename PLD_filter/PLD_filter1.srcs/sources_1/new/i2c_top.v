`timescale 1ns / 1ps

module i2c_top(
input clk,
 input rst_n,
 output scl,
 inout sda,
 input [7:0] dac_data

);
  wire                  clk_50M;
  wire                  i2c_exec        ;  //I2C����ִ���ź�
  wire   [7:0]         i2c_data1        ;  //I2CҪ���õĵ�ַ������(��8λ��ַ,��16λ����)          
  wire   [15:0]         i2c_data2        ;
  wire                  i2c_done        ;  //I2C�Ĵ�����������ź�
  wire                  i2c_dri_clk     ;  //I2C����ʱ��
  parameter  SLAVE_ADDR = 7'h61         ;  //MCP4725��������ַ7'h60
  parameter  BIT_CTRL   = 1'b0          ;  //�ֽڵ�ַΪ8λ  0:8λ 1:16λ
  parameter  CLK_FREQ   = 26'd50_000_000;  //ʱ��Ƶ�� 50MHz
  parameter  I2C_FREQ   = 18'd250_000   ;  //I2C��SCLʱ��Ƶ��,250KHz


clk_wiz_1 instance_name
   (
     .clk_out1(clk_50M),     // output clk_out1
     .clk_in1(clk));  
i2c_drive 
   #(
    .SLAVE_ADDR         (SLAVE_ADDR),       //��������
    .CLK_FREQ           (CLK_FREQ  ),              
    .I2C_FREQ           (I2C_FREQ  )                
    )   

u_i2c_drive(   
    .clk                (clk_50M       ),
    .rst_n              (rst_n     ),   
        
    .i2c_exec           (i2c_exec  ),   
    .bit_ctrl           (BIT_CTRL  ),   
    .i2c_rh_wl          (1'b0),             //�̶�Ϊ0��ֻ�õ���IIC������д����   
    .i2c_addr           (i2c_data1),   
    .i2c_data_w         (i2c_data2),   
    .i2c_data_r         (),   
    .i2c_done           (i2c_done  ),   
    .scl                (scl   ),   
    .sda                (sda   ),   
    .dri_clk            (i2c_dri_clk)       //I2C����ʱ��
); 
  
MCP4725_init u_MCP4725_init( 
 
   .clk     (i2c_dri_clk),   //ʱ���ź�
   .rst_n   (rst_n),   //��λ�źţ��͵�ƽ��Ч
   .send_data(dac_data),
   .i2c_done(i2c_done),   //I2C�Ĵ�����������ź�
   .i2c_exec(i2c_exec),   //I2C����ִ���ź�   
   .i2c_data1(i2c_data1),   //I2CҪ���õĵ�ַ������(��8λ��ַ,��16λ����)
   .i2c_data2(i2c_data2)
);


endmodule
