`timescale 1ns / 1ps

module MCP4725_init(
 input                clk      ,   //时钟信号
 input                rst_n    ,   //复位信号，低电平有效
 input                i2c_done ,   //I2C寄存器配置完成信号
 input [7:0]          send_data,
 output  reg          i2c_exec ,   //I2C触发执行信号   
 output  reg  [7:0]  i2c_data1,    //I2C要配置的地址与数据(高16位地址,低8位数据)
 output  reg  [15:0]  i2c_data2
);




//reg define
reg   [14:0]   start_init_cnt=15'd0;        //等待延时计数器
//reg [23:0] data;



//scl配置成250khz,输入的clk为1Mhz,周期为1us,20000*1us = 20ms
//上电到开始配置IIC至少等待20ms
always @(posedge clk or negedge rst_n) begin
 if(!rst_n)
 begin
     start_init_cnt <= 15'd0;
      i2c_exec <= 1'b0;
 end
 else if(start_init_cnt == 15'd19999)
 begin
      i2c_exec <= 1'b1;
      start_init_cnt<=15'd0;
  end
  else
  begin
       start_init_cnt <= start_init_cnt + 1'b1;
        i2c_exec <= 1'b0;
  end               
end

//配置寄存器地址与数据
always @(posedge clk or negedge rst_n) begin
 if(!rst_n)
     i2c_data1= 8'd0;
  else 
    i2c_data1=8'h60;//第一个字节为模式控制（60:同步更新到EEPROM;40:只更新DAC寄存器），后面两个字节为输入数据，取高8位
    i2c_data2=send_data<<8;
   end
endmodule