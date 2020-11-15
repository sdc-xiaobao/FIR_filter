`timescale 1ns / 1ps

module MCP4725_init(
 input                clk      ,   //ʱ���ź�
 input                rst_n    ,   //��λ�źţ��͵�ƽ��Ч
 input                i2c_done ,   //I2C�Ĵ�����������ź�
 input [7:0]          send_data,
 output  reg          i2c_exec ,   //I2C����ִ���ź�   
 output  reg  [7:0]  i2c_data1,    //I2CҪ���õĵ�ַ������(��16λ��ַ,��8λ����)
 output  reg  [15:0]  i2c_data2
);




//reg define
reg   [14:0]   start_init_cnt=15'd0;        //�ȴ���ʱ������
//reg [23:0] data;



//scl���ó�250khz,�����clkΪ1Mhz,����Ϊ1us,20000*1us = 20ms
//�ϵ絽��ʼ����IIC���ٵȴ�20ms
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

//���üĴ�����ַ������
always @(posedge clk or negedge rst_n) begin
 if(!rst_n)
     i2c_data1= 8'd0;
  else 
    i2c_data1=8'h60;//��һ���ֽ�Ϊģʽ���ƣ�60:ͬ�����µ�EEPROM;40:ֻ����DAC�Ĵ����������������ֽ�Ϊ�������ݣ�ȡ��8λ
    i2c_data2=send_data<<8;
   end
endmodule