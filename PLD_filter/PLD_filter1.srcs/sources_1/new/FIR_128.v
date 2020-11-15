`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/10/30 17:07:41
// Design Name: 
// Module Name: FIR_128
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



module FIR_128#(parameter  WIDTH = 8)
(

           input                              I_clk,
           input                              I_rst_p,
           input  signed     [WIDTH -1:0]     I_data,
           output signed     [2*WIDTH+1:0]    O_data,
           output ADC_En,
           output clk_ADC,
           input             [7:0]            Data
 );



//ADC分频
reg [30:0] Clk_Divide1=2500/2;
reg [30:0] Clk_Divide2=800/2;

wire clk_ADC1;
wire clk_ADC2;

reg clk_ADC_o;

//分频系数计算
always@(posedge I_clk)
begin
if (Data==8'h31)  Clk_Divide1<=2500/2;
if (Data==8'h32 || Data==8'h33 || Data==8'h34)  Clk_Divide1<=1250/2;
if (Data==8'h35 || Data==8'h36)  Clk_Divide2<=800/2;
if (Data==8'h37 || Data==8'h38||Data==8'h39)  Clk_Divide2<=571/2;
end

//分频
Clk_Division_0 your_instance_name1 (
  .clk_100MHz(I_clk),  // input wire clk_100MHz
  .clk_mode(Clk_Divide1),      // input wire [30 : 0] clk_mode
  .clk_out(clk_ADC1)        // output wire clk_out
);
Clk_Division_0 your_instance_name2 (
  .clk_100MHz(I_clk),  // input wire clk_100MHz
  .clk_mode(Clk_Divide2),      // input wire [30 : 0] clk_mode
  .clk_out(clk_ADC2)        // output wire clk_out
);

always@(posedge I_clk)
begin
if (Data==8'h31||Data==8'h32 || Data==8'h33 || Data==8'h34)  clk_ADC_o=clk_ADC1;
if (Data==8'h35 || Data==8'h36||Data==8'h37 || Data==8'h38||Data==8'h39)  clk_ADC_o=clk_ADC2;

end

assign clk_ADC=clk_ADC_o;

/*reg [30:0] Clk_Divide;

always@(*)
begin
if (Data==8'h31)   Clk_Divide<=2500/2;
if (Data==8'h32 || Data==8'h33 || Data==8'h34)  Clk_Divide<=1250/2;
if (Data==8'h35 || Data==8'h36)  Clk_Divide<=800/2;
if (Data==8'h37 || Data==8'h39 || Data==8'h38)  Clk_Divide<=571/2;
end

Clk_Division_0 your_instance_name_2 (
  .clk_100MHz(I_clk),  // input wire clk_100MHz
  .clk_mode(Clk_Divide),      // input wire [30 : 0] clk_mode
  .clk_out(clk_ADC)        // output wire clk_out
);*/


/*always@(*)
begin
Data=Data1;
end*/
//ADC使能
assign ADC_En=~I_rst_p;

//定义抽头系数
reg signed [8:0] coeff1;//matlab fir生成系数 * 256
reg signed [8:0] coeff2;
reg signed [8:0] coeff3;
reg signed [8:0] coeff4;
reg signed [8:0] coeff5;
reg signed [8:0] coeff6;
reg signed [8:0] coeff7;
reg signed [8:0] coeff8;
reg signed [8:0] coeff9;
reg signed [8:0] coeff10;
reg signed [8:0] coeff11;
reg signed [8:0] coeff12;
reg signed [8:0] coeff13;
reg signed [8:0] coeff14;
reg signed [8:0] coeff15;
reg signed [8:0] coeff16;
reg signed [8:0] coeff17;
reg signed [8:0] coeff18;
reg signed [8:0] coeff19;
reg signed [8:0] coeff20;
reg signed [8:0] coeff21;
reg signed [8:0] coeff22;
reg signed [8:0] coeff23;
reg signed [8:0] coeff24;
reg signed [8:0] coeff25;
reg signed [8:0] coeff26;
reg signed [8:0] coeff27;
reg signed [8:0] coeff28;
reg signed [8:0] coeff29;
reg signed [8:0] coeff30;
reg signed [8:0] coeff31;
reg signed [8:0] coeff32;
reg signed [8:0] coeff33;
reg signed [8:0] coeff34;
reg signed [8:0] coeff35;
reg signed [8:0] coeff36;
reg signed [8:0] coeff37;
reg signed [8:0] coeff38;
reg signed [8:0] coeff39;
reg signed [8:0] coeff40;
reg signed [8:0] coeff41;
reg signed [8:0] coeff42;
reg signed [8:0] coeff43;
reg signed [8:0] coeff44;
reg signed [8:0] coeff45;
reg signed [8:0] coeff46;
reg signed [8:0] coeff47;
reg signed [8:0] coeff48;
reg signed [8:0] coeff49;
reg signed [8:0] coeff50;
reg signed [8:0] coeff51;
reg signed [8:0] coeff52;
reg signed [8:0] coeff53;
reg signed [8:0] coeff54;
reg signed [8:0] coeff55;
reg signed [8:0] coeff56;
reg signed [8:0] coeff57;
reg signed [8:0] coeff58;
reg signed [8:0] coeff59;
reg signed [8:0] coeff60;
reg signed [8:0] coeff61;
reg signed [8:0] coeff62;
reg signed [8:0] coeff63;
reg signed [8:0] coeff64;
reg signed [8:0] coeff65;


//抽头系数由Data的值决定
//抽头系数
always@(posedge I_clk)
begin
        if(Data==8'h31)  //第一种状态：31H，此时取样频率为40kHz，中心频率1kHz（已成功）
        begin
        coeff1 <= 143;
        coeff2 <= -36;
        coeff3 <= -34;
        coeff4 <= -32;
        coeff5 <= -31;
        coeff6 <= -31;
        coeff7 <= -32;
        coeff8 <= -33;
        coeff9 <= -34;
        coeff10 <= -36;
        coeff11 <= -38;
        coeff12 <= -40;
        coeff13 <= -43;
        coeff14 <= -45;
        coeff15 <= -47;
        coeff16 <= -49;
        coeff17 <= -51;
        coeff18 <= -53;
        coeff19 <= -55;
        coeff20 <= -57;
        coeff21 <= -58;
        coeff22 <= -59;
        coeff23 <= -60;
        coeff24 <= -60;
        coeff25 <= -60;
        coeff26 <= -60;
        coeff27 <= -59;
        coeff28 <= -58;
        coeff29 <= -57;
        coeff30 <= -55;
        coeff31 <= -52;
        coeff32 <= -50;
        coeff33 <= -47;
        coeff34 <= -43;
        coeff35 <= -39;
        coeff36 <= -35;
        coeff37 <= -30;
        coeff38 <= -25;
        coeff39 <= -20;
        coeff40 <= -15;
        coeff41 <= -9;
        coeff42 <= -3;
        coeff43 <= 3;
        coeff44 <= 10;
        coeff45 <= 16;
        coeff46 <= 23;
        coeff47 <= 29;
        coeff48 <= 36;
        coeff49 <= 42;
        coeff50 <= 48;
        coeff51 <= 54;
        coeff52 <= 60;
        coeff53 <= 66;
        coeff54 <= 71;
        coeff55 <= 76;
        coeff56 <= 81;
        coeff57 <= 85;
        coeff58 <= 89;
        coeff59 <= 92;
        coeff60 <= 95;
        coeff61 <= 98;
        coeff62 <= 100;
        coeff63 <= 101;
        coeff64 <= 102;
        coeff65 <= 102;
        end
        
        
        
        if(Data==8'h32)  //第二种状态：32H，此时取样频率80kHz，中心频率2kHz（已成功）
        begin
        coeff1 <= 228;
        coeff2 <= -14;
        coeff3 <= -13;
        coeff4 <= -13;
        coeff5 <= -14;
        coeff6 <= -14;
        coeff7 <= -14;
        coeff8 <= -15;
        coeff9 <= -16;
        coeff10 <= -16;
        coeff11 <= -17;
        coeff12 <= -18;
        coeff13 <= -19;
        coeff14 <= -20;
        coeff15 <= -21;
        coeff16 <= -22;
        coeff17 <= -23;
        coeff18 <= -24;
        coeff19 <= -24;
        coeff20 <= -25;
        coeff21 <= -26;
        coeff22 <= -26;
        coeff23 <= -27;
        coeff24 <= -27;
        coeff25 <= -27;
        coeff26 <= -27;
        coeff27 <= -27;
        coeff28 <= -27;
        coeff29 <= -27;
        coeff30 <= -26;
        coeff31 <= -26;
        coeff32 <= -25;
        coeff33 <= -24;
        coeff34 <= -23;
        coeff35 <= -21;
        coeff36 <= -20;
        coeff37 <= -18;
        coeff38 <= -16;
        coeff39 <= -15;
        coeff40 <= -13;
        coeff41 <= -11;
        coeff42 <= -8;
        coeff43 <= -6;
        coeff44 <= -4;
        coeff45 <= -1;
        coeff46 <= 1;
        coeff47 <= 3;
        coeff48 <= 6;
        coeff49 <= 8;
        coeff50 <= 10;
        coeff51 <= 13;
        coeff52 <= 15;
        coeff53 <= 17;
        coeff54 <= 19;
        coeff55 <= 21;
        coeff56 <= 23;
        coeff57 <= 24;
        coeff58 <= 26;
        coeff59 <= 27;
        coeff60 <= 28;
        coeff61 <= 29;
        coeff62 <= 30;
        coeff63 <= 30;
        coeff64 <= 31;
        coeff65 <= 31;
        end
        
        
        
        if(Data==8'h33)  //第三种状态：33H，此时取样频率为80kHz，中心频率3kHz（已成功）
        begin
        coeff1 <= -216;
        coeff2 <= 67;
        coeff3 <= 59;
        coeff4 <= 52;
        coeff5 <= 47;
        coeff6 <= 43;
        coeff7 <= 41;
        coeff8 <= 38;
        coeff9 <= 36;
        coeff10 <= 35;
        coeff11 <= 34;
        coeff12 <= 33;
        coeff13 <= 31;
        coeff14 <= 30;
        coeff15 <= 28;
        coeff16 <= 27;
        coeff17 <= 25;
        coeff18 <= 23;
        coeff19 <= 20;
        coeff20 <= 17;
        coeff21 <= 14;
        coeff22 <= 11;
        coeff23 <= 8;
        coeff24 <= 4;
        coeff25 <= 1;
        coeff26 <= -3;
        coeff27 <= -7;
        coeff28 <= -10;
        coeff29 <= -14;
        coeff30 <= -18;
        coeff31 <= -21;
        coeff32 <= -24;
        coeff33 <= -27;
        coeff34 <= -29;
        coeff35 <= -31;
        coeff36 <= -33;
        coeff37 <= -34;
        coeff38 <= -35;
        coeff39 <= -35;
        coeff40 <= -35;
        coeff41 <= -34;
        coeff42 <= -33;
        coeff43 <= -31;
        coeff44 <= -29;
        coeff45 <= -26;
        coeff46 <= -23;
        coeff47 <= -20;
        coeff48 <= -16;
        coeff49 <= -12;
        coeff50 <= -8;
        coeff51 <= -3;
        coeff52 <= 1;
        coeff53 <= 6;
        coeff54 <= 11;
        coeff55 <= 15;
        coeff56 <= 19;
        coeff57 <= 23;
        coeff58 <= 27;
        coeff59 <= 30;
        coeff60 <= 33;
        coeff61 <= 35;
        coeff62 <= 37;
        coeff63 <= 38;
        coeff64 <= 39;
        coeff65 <= 40;
        end
        
        
          if(Data==8'h34)  //第四种状态：34H，此时取样频率80kHz，中心频率4kHz（已成功）
          begin
          coeff1 <= 107;
          coeff2 <= -177;
          coeff3 <= -97;
          coeff4 <= -62;
          coeff5 <= -47;
          coeff6 <= -40;
          coeff7 <= -36;
          coeff8 <= -34;
          coeff9 <= -31;
          coeff10 <= -27;
          coeff11 <= -23;
          coeff12 <= -18;
          coeff13 <= -13;
          coeff14 <= -7;
          coeff15 <= 0;
          coeff16 <= 7;
          coeff17 <= 14;
          coeff18 <= 22;
          coeff19 <= 29;
          coeff20 <= 35;
          coeff21 <= 41;
          coeff22 <= 46;
          coeff23 <= 50;
          coeff24 <= 53;
          coeff25 <= 55;
          coeff26 <= 55;
          coeff27 <= 54;
          coeff28 <= 51;
          coeff29 <= 47;
          coeff30 <= 42;
          coeff31 <= 36;
          coeff32 <= 28;
          coeff33 <= 19;
          coeff34 <= 10;
          coeff35 <= 0;
          coeff36 <= -10;
          coeff37 <= -20;
          coeff38 <= -30;
          coeff39 <= -40;
          coeff40 <= -48;
          coeff41 <= -56;
          coeff42 <= -62;
          coeff43 <= -67;
          coeff44 <= -70;
          coeff45 <= -72;
          coeff46 <= -71;
          coeff47 <= -69;
          coeff48 <= -65;
          coeff49 <= -60;
          coeff50 <= -53;
          coeff51 <= -44;
          coeff52 <= -34;
          coeff53 <= -23;
          coeff54 <= -12;
          coeff55 <= 0;
          coeff56 <= 12;
          coeff57 <= 24;
          coeff58 <= 35;
          coeff59 <= 46;
          coeff60 <= 55;
          coeff61 <= 63;
          coeff62 <= 69;
          coeff63 <= 74;
          coeff64 <= 77;
          coeff65 <= 78;
         end
         
         
         if(Data==8'h35)  //第五种状态：35H，此时采样频率为125kHz，中心频率为5k（部分成功，但有毛刺）
         begin
         coeff1 <= -227;
         coeff2 <= 38;
         coeff3 <= 35;
         coeff4 <= 34;
         coeff5 <= 32;
         coeff6 <= 31;
         coeff7 <= 30;
         coeff8 <= 30;
         coeff9 <= 30;
         coeff10 <= 29;
         coeff11 <= 29;
         coeff12 <= 29;
         coeff13 <= 29;
         coeff14 <= 28;
         coeff15 <= 28;
         coeff16 <= 27;
         coeff17 <= 26;
         coeff18 <= 25;
         coeff19 <= 23;
         coeff20 <= 21;
         coeff21 <= 20;
         coeff22 <= 17;
         coeff23 <= 15;
         coeff24 <= 12;
         coeff25 <= 10;
         coeff26 <= 7;
         coeff27 <= 4;
         coeff28 <= 1;
         coeff29 <= -2;
         coeff30 <= -6;
         coeff31 <= -8;
         coeff32 <= -11;
         coeff33 <= -14;
         coeff34 <= -16;
         coeff35 <= -19;
         coeff36 <= -21;
         coeff37 <= -22;
         coeff38 <= -23;
         coeff39 <= -24;
         coeff40 <= -25;
         coeff41 <= -25;
         coeff42 <= -24;
         coeff43 <= -24;
         coeff44 <= -22;
         coeff45 <= -21;
         coeff46 <= -19;
         coeff47 <= -17;
         coeff48 <= -14;
         coeff49 <= -11;
         coeff50 <= -8;
         coeff51 <= -5;
         coeff52 <= -2;
         coeff53 <= 2;
         coeff54 <= 5;
         coeff55 <= 8;
         coeff56 <= 12;
         coeff57 <= 15;
         coeff58 <= 17;
         coeff59 <= 20;
         coeff60 <= 22;
         coeff61 <= 24;
         coeff62 <= 25;
         coeff63 <= 26;
         coeff64 <= 27;
         coeff65 <= 27;
         end
         
         
         
         if(Data==8'h36)  //第六种状态：36H，此时采样频率为125kHz，中心频率为6k（部分成功，但有毛刺）
         begin
         coeff1 <= 180;
         coeff2 <= -209;
         coeff3 <= -125;
         coeff4 <= -77;
         coeff5 <= -51;
         coeff6 <= -35;
         coeff7 <= -26;
         coeff8 <= -21;
         coeff9 <= -17;
         coeff10 <= -14;
         coeff11 <= -11;
         coeff12 <= -8;
         coeff13 <= -6;
         coeff14 <= -3;
         coeff15 <= 0;
         coeff16 <= 3;
         coeff17 <= 5;
         coeff18 <= 8;
         coeff19 <= 10;
         coeff20 <= 13;
         coeff21 <= 15;
         coeff22 <= 16;
         coeff23 <= 17;
         coeff24 <= 18;
         coeff25 <= 19;
         coeff26 <= 19;
         coeff27 <= 18;
         coeff28 <= 17;
         coeff29 <= 15;
         coeff30 <= 14;
         coeff31 <= 11;
         coeff32 <= 9;
         coeff33 <= 6;
         coeff34 <= 3;
         coeff35 <= 0;
         coeff36 <= -3;
         coeff37 <= -6;
         coeff38 <= -9;
         coeff39 <= -12;
         coeff40 <= -14;
         coeff41 <= -17;
         coeff42 <= -18;
         coeff43 <= -20;
         coeff44 <= -20;
         coeff45 <= -21;
         coeff46 <= -20;
         coeff47 <= -20;
         coeff48 <= -19;
         coeff49 <= -17;
         coeff50 <= -15;
         coeff51 <= -12;
         coeff52 <= -10;
         coeff53 <= -6;
         coeff54 <= -3;
         coeff55 <= 0;
         coeff56 <= 3;
         coeff57 <= 7;
         coeff58 <= 10;
         coeff59 <= 13;
         coeff60 <= 15;
         coeff61 <= 17;
         coeff62 <= 19;
         coeff63 <= 21;
         coeff64 <= 21;
         coeff65 <= 21;
         end
         
         if(Data==8'h37)  //第七种状态：37H，此时采样频率为175khz，中心频率为7kHz
         begin
          coeff1 <= -234;
          coeff2 <= 39;
          coeff3 <= 36;
          coeff4 <= 34;
          coeff5 <= 33;
          coeff6 <= 32;
          coeff7 <= 31;
          coeff8 <= 31;
          coeff9 <= 31;
          coeff10 <= 31;
          coeff11 <= 31;
          coeff12 <= 30;
          coeff13 <= 30;
          coeff14 <= 30;
          coeff15 <= 29;
          coeff16 <= 28;
          coeff17 <= 27;
          coeff18 <= 26;
          coeff19 <= 25;
          coeff20 <= 23;
          coeff21 <= 21;
          coeff22 <= 19;
          coeff23 <= 16;
          coeff24 <= 13;
          coeff25 <= 10;
          coeff26 <= 7;
          coeff27 <= 4;
          coeff28 <= 1;
          coeff29 <= -3;
          coeff30 <= -6;
          coeff31 <= -9;
          coeff32 <= -12;
          coeff33 <= -15;
          coeff34 <= -18;
          coeff35 <= -20;
          coeff36 <= -22;
          coeff37 <= -24;
          coeff38 <= -25;
          coeff39 <= -26;
          coeff40 <= -27;
          coeff41 <= -27;
          coeff42 <= -27;
          coeff43 <= -26;
          coeff44 <= -24;
          coeff45 <= -23;
          coeff46 <= -21;
          coeff47 <= -18;
          coeff48 <= -15;
          coeff49 <= -12;
          coeff50 <= -9;
          coeff51 <= -6;
          coeff52 <= -2;
          coeff53 <= 2;
          coeff54 <= 6;
          coeff55 <= 9;
          coeff56 <= 13;
          coeff57 <= 16;
          coeff58 <= 19;
          coeff59 <= 22;
          coeff60 <= 24;
          coeff61 <= 26;
          coeff62 <= 28;
          coeff63 <= 29;
          coeff64 <= 30;
          coeff65 <= 30;
         end
         
         if(Data==8'h38)  //第八种状态：38H，此时采样频率为200khz，中心频率为8kHz
         begin
          coeff1 <= -226;
          coeff2 <= -6;
          coeff3 <= -5;
          coeff4 <= -4;
          coeff5 <= -3;
          coeff6 <= -2;
          coeff7 <= 0;
          coeff8 <= 2;
          coeff9 <= 5;
          coeff10 <= 7;
          coeff11 <= 10;
          coeff12 <= 13;
          coeff13 <= 16;
          coeff14 <= 19;
          coeff15 <= 21;
          coeff16 <= 24;
          coeff17 <= 28;
          coeff19 <= 29;
          coeff20 <= 30;
          coeff21 <= 31;
          coeff22 <= 31;
          coeff23 <= 30;
          coeff24 <= 29;
          coeff25 <= 28;
          coeff26 <= 26;
          coeff27 <= 23;
          coeff28 <= 21;
          coeff29 <= 17;
          coeff30 <= 14;
          coeff31 <= 10;
          coeff32 <= 6;
          coeff33 <= 2;
          coeff34 <= -2;
          coeff35 <= -6;
          coeff36 <= -9;
          coeff37 <= -13;
          coeff38 <= -16;
          coeff39 <= -19;
          coeff40 <= -21;
          coeff41 <= -23;
          coeff42 <= -24;
          coeff43 <= -25;
          coeff44 <= -25;
          coeff45 <= -24;
          coeff46 <= -23;
          coeff47 <= -21;
          coeff48 <= -19;
          coeff49 <= -16;
          coeff50 <= -13;
          coeff51 <= -9;
          coeff52 <= -5;
          coeff53 <= -1;
          coeff54 <= 4;
          coeff55 <= 8;
          coeff56 <= 13;
          coeff57 <= 17;
          coeff58 <= 21;
          coeff59 <= 24;
          coeff60 <= 28;
          coeff61 <= 30;
          coeff62 <= 32;
          coeff63 <= 34;
          coeff64 <= 35;
          coeff65 <= 35;
         end
         
         
         if(Data==8'h39)  //第九种状态：39H，此时采样频率为175khz，中心频率为9kHz
         begin
         coeff1 <= 164;
         coeff2 <= -118;
         coeff3 <= -86;
         coeff4 <= -65;
         coeff5 <= -50;
         coeff6 <= -41;
         coeff7 <= -34;
         coeff8 <= -29;
         coeff9 <= -25;
         coeff10 <= -22;
         coeff11 <= -19;
         coeff12 <= -15;
         coeff13 <= -12;
         coeff14 <= -9;
         coeff15 <= -5;
         coeff16 <= -2;
         coeff17 <= 2;
         coeff18 <= 6;
         coeff19 <= 9;
         coeff20 <= 13;
         coeff21 <= 16;
         coeff22 <= 19;
         coeff23 <= 21;
         coeff24 <= 23;
         coeff25 <= 24;
         coeff26 <= 25;
         coeff27 <= 25;
         coeff28 <= 24;
         coeff29 <= 23;
         coeff30 <= 21;
         coeff31 <= 18;
         coeff32 <= 15;
         coeff33 <= 12;
         coeff34 <= 8;
         coeff35 <= 4;
         coeff36 <= -1;
         coeff37 <= -5;
         coeff38 <= -9;
         coeff39 <= -14;
         coeff40 <= -17;
         coeff41 <= -21;
         coeff42 <= -24;
         coeff43 <= -26;
         coeff44 <= -28;
         coeff45 <= -29;
         coeff46 <= -29;
         coeff47 <= -29;
         coeff48 <= -27;
         coeff49 <= -25;
         coeff50 <= -22;
         coeff51 <= -19;
         coeff52 <= -15;
         coeff53 <= -11;
         coeff54 <= -6;
         coeff55 <= -1;
         coeff56 <= 3;
         coeff57 <= 8;
         coeff58 <= 13;
         coeff59 <= 17;
         coeff60 <= 21;
         coeff61 <= 24;
         coeff62 <= 27;
         coeff63 <= 29;
         coeff64 <= 30;
         coeff65 <= 31;
         end
         

end


//锁存的数据
reg  signed [WIDTH -1:0]  sample_0;
reg  signed [WIDTH -1:0]  sample_1;
reg  signed [WIDTH -1:0]  sample_2;
reg  signed [WIDTH -1:0]  sample_3;
reg  signed [WIDTH -1:0]  sample_4;
reg  signed [WIDTH -1:0]  sample_5;
reg  signed [WIDTH -1:0]  sample_6;
reg  signed [WIDTH -1:0]  sample_7;
reg  signed [WIDTH -1:0]  sample_8;
reg  signed [WIDTH -1:0]  sample_9;
reg  signed [WIDTH -1:0]  sample_10;
reg  signed [WIDTH -1:0]  sample_11;
reg  signed [WIDTH -1:0]  sample_12;
reg  signed [WIDTH -1:0]  sample_13;
reg  signed [WIDTH -1:0]  sample_14;
reg  signed [WIDTH -1:0]  sample_15;
reg  signed [WIDTH -1:0]  sample_16;
reg  signed [WIDTH -1:0]  sample_17;
reg  signed [WIDTH -1:0]  sample_18;
reg  signed [WIDTH -1:0]  sample_19;
reg  signed [WIDTH -1:0]  sample_20;
reg  signed [WIDTH -1:0]  sample_21;
reg  signed [WIDTH -1:0]  sample_22;
reg  signed [WIDTH -1:0]  sample_23;
reg  signed [WIDTH -1:0]  sample_24;
reg  signed [WIDTH -1:0]  sample_25;
reg  signed [WIDTH -1:0]  sample_26;
reg  signed [WIDTH -1:0]  sample_27;
reg  signed [WIDTH -1:0]  sample_28;
reg  signed [WIDTH -1:0]  sample_29;
reg  signed [WIDTH -1:0]  sample_30;
reg  signed [WIDTH -1:0]  sample_31;
reg  signed [WIDTH -1:0]  sample_32;
reg  signed [WIDTH -1:0]  sample_33;
reg  signed [WIDTH -1:0]  sample_34;
reg  signed [WIDTH -1:0]  sample_35;
reg  signed [WIDTH -1:0]  sample_36;
reg  signed [WIDTH -1:0]  sample_37;
reg  signed [WIDTH -1:0]  sample_38;
reg  signed [WIDTH -1:0]  sample_39;
reg  signed [WIDTH -1:0]  sample_40;
reg  signed [WIDTH -1:0]  sample_41;
reg  signed [WIDTH -1:0]  sample_42;
reg  signed [WIDTH -1:0]  sample_43;
reg  signed [WIDTH -1:0]  sample_44;
reg  signed [WIDTH -1:0]  sample_45;
reg  signed [WIDTH -1:0]  sample_46;
reg  signed [WIDTH -1:0]  sample_47;
reg  signed [WIDTH -1:0]  sample_48;
reg  signed [WIDTH -1:0]  sample_49;
reg  signed [WIDTH -1:0]  sample_50;
reg  signed [WIDTH -1:0]  sample_51;
reg  signed [WIDTH -1:0]  sample_52;
reg  signed [WIDTH -1:0]  sample_53;
reg  signed [WIDTH -1:0]  sample_54;
reg  signed [WIDTH -1:0]  sample_55;
reg  signed [WIDTH -1:0]  sample_56;
reg  signed [WIDTH -1:0]  sample_57;
reg  signed [WIDTH -1:0]  sample_58;
reg  signed [WIDTH -1:0]  sample_59;
reg  signed [WIDTH -1:0]  sample_60;
reg  signed [WIDTH -1:0]  sample_61;
reg  signed [WIDTH -1:0]  sample_62;
reg  signed [WIDTH -1:0]  sample_63;
reg  signed [WIDTH -1:0]  sample_64;
reg  signed [WIDTH -1:0]  sample_65;
reg  signed [WIDTH -1:0]  sample_66;
reg  signed [WIDTH -1:0]  sample_67;
reg  signed [WIDTH -1:0]  sample_68;
reg  signed [WIDTH -1:0]  sample_69;
reg  signed [WIDTH -1:0]  sample_70;
reg  signed [WIDTH -1:0]  sample_71;
reg  signed [WIDTH -1:0]  sample_72;
reg  signed [WIDTH -1:0]  sample_73;
reg  signed [WIDTH -1:0]  sample_74;
reg  signed [WIDTH -1:0]  sample_75;
reg  signed [WIDTH -1:0]  sample_76;
reg  signed [WIDTH -1:0]  sample_77;
reg  signed [WIDTH -1:0]  sample_78;
reg  signed [WIDTH -1:0]  sample_79;
reg  signed [WIDTH -1:0]  sample_80;
reg  signed [WIDTH -1:0]  sample_81;
reg  signed [WIDTH -1:0]  sample_82;
reg  signed [WIDTH -1:0]  sample_83;
reg  signed [WIDTH -1:0]  sample_84;
reg  signed [WIDTH -1:0]  sample_85;
reg  signed [WIDTH -1:0]  sample_86;
reg  signed [WIDTH -1:0]  sample_87;
reg  signed [WIDTH -1:0]  sample_88;
reg  signed [WIDTH -1:0]  sample_89;
reg  signed [WIDTH -1:0]  sample_90;
reg  signed [WIDTH -1:0]  sample_91;
reg  signed [WIDTH -1:0]  sample_92;
reg  signed [WIDTH -1:0]  sample_93;
reg  signed [WIDTH -1:0]  sample_94;
reg  signed [WIDTH -1:0]  sample_95;
reg  signed [WIDTH -1:0]  sample_96;
reg  signed [WIDTH -1:0]  sample_97;
reg  signed [WIDTH -1:0]  sample_98;
reg  signed [WIDTH -1:0]  sample_99;
reg  signed [WIDTH -1:0]  sample_100;
reg  signed [WIDTH -1:0]  sample_101;
reg  signed [WIDTH -1:0]  sample_102;
reg  signed [WIDTH -1:0]  sample_103;
reg  signed [WIDTH -1:0]  sample_104;
reg  signed [WIDTH -1:0]  sample_105;
reg  signed [WIDTH -1:0]  sample_106;
reg  signed [WIDTH -1:0]  sample_107;
reg  signed [WIDTH -1:0]  sample_108;
reg  signed [WIDTH -1:0]  sample_109;
reg  signed [WIDTH -1:0]  sample_110;
reg  signed [WIDTH -1:0]  sample_111;
reg  signed [WIDTH -1:0]  sample_112;
reg  signed [WIDTH -1:0]  sample_113;
reg  signed [WIDTH -1:0]  sample_114;
reg  signed [WIDTH -1:0]  sample_115;
reg  signed [WIDTH -1:0]  sample_116;
reg  signed [WIDTH -1:0]  sample_117;
reg  signed [WIDTH -1:0]  sample_118;
reg  signed [WIDTH -1:0]  sample_119;
reg  signed [WIDTH -1:0]  sample_120;
reg  signed [WIDTH -1:0]  sample_121;
reg  signed [WIDTH -1:0]  sample_122;
reg  signed [WIDTH -1:0]  sample_123;
reg  signed [WIDTH -1:0]  sample_124;
reg  signed [WIDTH -1:0]  sample_125;
reg  signed [WIDTH -1:0]  sample_126;
reg  signed [WIDTH -1:0]  sample_127;
reg  signed [WIDTH -1:0]  sample_128;




//第一次加法
reg  signed [WIDTH:0]  add_data_0;//9 bit
reg  signed [WIDTH:0]  add_data_1;
reg  signed [WIDTH:0]  add_data_2;
reg  signed [WIDTH:0]  add_data_3;
reg  signed [WIDTH:0]  add_data_4;
reg  signed [WIDTH:0]  add_data_5;
reg  signed [WIDTH:0]  add_data_6;
reg  signed [WIDTH:0]  add_data_7;
reg  signed [WIDTH:0]  add_data_8;
reg  signed [WIDTH:0]  add_data_9;
reg  signed [WIDTH:0]  add_data_10;
reg  signed [WIDTH:0]  add_data_11;
reg  signed [WIDTH:0]  add_data_12;
reg  signed [WIDTH:0]  add_data_13;
reg  signed [WIDTH:0]  add_data_14;
reg  signed [WIDTH:0]  add_data_15;
reg  signed [WIDTH:0]  add_data_16;
reg  signed [WIDTH:0]  add_data_17;
reg  signed [WIDTH:0]  add_data_18;
reg  signed [WIDTH:0]  add_data_19;
reg  signed [WIDTH:0]  add_data_20;
reg  signed [WIDTH:0]  add_data_21;
reg  signed [WIDTH:0]  add_data_22;
reg  signed [WIDTH:0]  add_data_23;
reg  signed [WIDTH:0]  add_data_24;
reg  signed [WIDTH:0]  add_data_25;
reg  signed [WIDTH:0]  add_data_26;
reg  signed [WIDTH:0]  add_data_27;
reg  signed [WIDTH:0]  add_data_28;
reg  signed [WIDTH:0]  add_data_29;
reg  signed [WIDTH:0]  add_data_30;
reg  signed [WIDTH:0]  add_data_31;
reg  signed [WIDTH:0]  add_data_32;
reg  signed [WIDTH:0]  add_data_33;
reg  signed [WIDTH:0]  add_data_34;
reg  signed [WIDTH:0]  add_data_35;
reg  signed [WIDTH:0]  add_data_36;
reg  signed [WIDTH:0]  add_data_37;
reg  signed [WIDTH:0]  add_data_38;
reg  signed [WIDTH:0]  add_data_39;
reg  signed [WIDTH:0]  add_data_40;
reg  signed [WIDTH:0]  add_data_41;
reg  signed [WIDTH:0]  add_data_42;
reg  signed [WIDTH:0]  add_data_43;
reg  signed [WIDTH:0]  add_data_44;
reg  signed [WIDTH:0]  add_data_45;
reg  signed [WIDTH:0]  add_data_46;
reg  signed [WIDTH:0]  add_data_47;
reg  signed [WIDTH:0]  add_data_48;
reg  signed [WIDTH:0]  add_data_49;
reg  signed [WIDTH:0]  add_data_50;
reg  signed [WIDTH:0]  add_data_51;
reg  signed [WIDTH:0]  add_data_52;
reg  signed [WIDTH:0]  add_data_53;
reg  signed [WIDTH:0]  add_data_54;
reg  signed [WIDTH:0]  add_data_55;
reg  signed [WIDTH:0]  add_data_56;
reg  signed [WIDTH:0]  add_data_57;
reg  signed [WIDTH:0]  add_data_58;
reg  signed [WIDTH:0]  add_data_59;
reg  signed [WIDTH:0]  add_data_60;
reg  signed [WIDTH:0]  add_data_61;
reg  signed [WIDTH:0]  add_data_62;
reg  signed [WIDTH:0]  add_data_63;
reg  signed [WIDTH:0]  add_data_64;



//第一次乘法
reg  signed [2*WIDTH+1:0]  mult_1;//18 bit
reg  signed [2*WIDTH+1:0]  mult_2;
reg  signed [2*WIDTH+1:0]  mult_3;
reg  signed [2*WIDTH+1:0]  mult_4;
reg  signed [2*WIDTH+1:0]  mult_5;
reg  signed [2*WIDTH+1:0]  mult_6;
reg  signed [2*WIDTH+1:0]  mult_7;
reg  signed [2*WIDTH+1:0]  mult_8;
reg  signed [2*WIDTH+1:0]  mult_9;
reg  signed [2*WIDTH+1:0]  mult_10;
reg  signed [2*WIDTH+1:0]  mult_11;
reg  signed [2*WIDTH+1:0]  mult_12;
reg  signed [2*WIDTH+1:0]  mult_13;
reg  signed [2*WIDTH+1:0]  mult_14;
reg  signed [2*WIDTH+1:0]  mult_15;
reg  signed [2*WIDTH+1:0]  mult_16;
reg  signed [2*WIDTH+1:0]  mult_17;
reg  signed [2*WIDTH+1:0]  mult_18;
reg  signed [2*WIDTH+1:0]  mult_19;
reg  signed [2*WIDTH+1:0]  mult_20;
reg  signed [2*WIDTH+1:0]  mult_21;
reg  signed [2*WIDTH+1:0]  mult_22;
reg  signed [2*WIDTH+1:0]  mult_23;
reg  signed [2*WIDTH+1:0]  mult_24;
reg  signed [2*WIDTH+1:0]  mult_25;
reg  signed [2*WIDTH+1:0]  mult_26;
reg  signed [2*WIDTH+1:0]  mult_27;
reg  signed [2*WIDTH+1:0]  mult_28;
reg  signed [2*WIDTH+1:0]  mult_29;
reg  signed [2*WIDTH+1:0]  mult_30;
reg  signed [2*WIDTH+1:0]  mult_31;
reg  signed [2*WIDTH+1:0]  mult_32;
reg  signed [2*WIDTH+1:0]  mult_33;
reg  signed [2*WIDTH+1:0]  mult_34;
reg  signed [2*WIDTH+1:0]  mult_35;
reg  signed [2*WIDTH+1:0]  mult_36;
reg  signed [2*WIDTH+1:0]  mult_37;
reg  signed [2*WIDTH+1:0]  mult_38;
reg  signed [2*WIDTH+1:0]  mult_39;
reg  signed [2*WIDTH+1:0]  mult_40;
reg  signed [2*WIDTH+1:0]  mult_41;
reg  signed [2*WIDTH+1:0]  mult_42;
reg  signed [2*WIDTH+1:0]  mult_43;
reg  signed [2*WIDTH+1:0]  mult_44;
reg  signed [2*WIDTH+1:0]  mult_45;
reg  signed [2*WIDTH+1:0]  mult_46;
reg  signed [2*WIDTH+1:0]  mult_47;
reg  signed [2*WIDTH+1:0]  mult_48;
reg  signed [2*WIDTH+1:0]  mult_49;
reg  signed [2*WIDTH+1:0]  mult_50;
reg  signed [2*WIDTH+1:0]  mult_51;
reg  signed [2*WIDTH+1:0]  mult_52;
reg  signed [2*WIDTH+1:0]  mult_53;
reg  signed [2*WIDTH+1:0]  mult_54;
reg  signed [2*WIDTH+1:0]  mult_55;
reg  signed [2*WIDTH+1:0]  mult_56;
reg  signed [2*WIDTH+1:0]  mult_57;
reg  signed [2*WIDTH+1:0]  mult_58;
reg  signed [2*WIDTH+1:0]  mult_59;
reg  signed [2*WIDTH+1:0]  mult_60;
reg  signed [2*WIDTH+1:0]  mult_61;
reg  signed [2*WIDTH+1:0]  mult_62;
reg  signed [2*WIDTH+1:0]  mult_63;
reg  signed [2*WIDTH+1:0]  mult_64;
reg  signed [2*WIDTH+1:0]  mult_65;



//第一次加法数据
reg signed  [2*WIDTH+2:0]   add_level_1;// 19 bit
reg signed  [2*WIDTH+2:0]   add_level_2;
reg signed  [2*WIDTH+2:0]   add_level_3;
reg signed  [2*WIDTH+2:0]   add_level_4;
reg signed  [2*WIDTH+2:0]   add_level_5;
reg signed  [2*WIDTH+2:0]   add_level_6;
reg signed  [2*WIDTH+2:0]   add_level_7;
reg signed  [2*WIDTH+2:0]   add_level_8;
reg signed  [2*WIDTH+2:0]   add_level_9;
reg signed  [2*WIDTH+2:0]   add_level_10;
reg signed  [2*WIDTH+2:0]   add_level_11;
reg signed  [2*WIDTH+2:0]   add_level_12;
reg signed  [2*WIDTH+2:0]   add_level_13;
reg signed  [2*WIDTH+2:0]   add_level_14;
reg signed  [2*WIDTH+2:0]   add_level_15;
reg signed  [2*WIDTH+2:0]   add_level_16;
reg signed  [2*WIDTH+2:0]   add_level_17;
reg signed  [2*WIDTH+2:0]   add_level_18;
reg signed  [2*WIDTH+2:0]   add_level_19;
reg signed  [2*WIDTH+2:0]   add_level_20;
reg signed  [2*WIDTH+2:0]   add_level_21;
reg signed  [2*WIDTH+2:0]   add_level_22;
reg signed  [2*WIDTH+2:0]   add_level_23;
reg signed  [2*WIDTH+2:0]   add_level_24;
reg signed  [2*WIDTH+2:0]   add_level_25;
reg signed  [2*WIDTH+2:0]   add_level_26;
reg signed  [2*WIDTH+2:0]   add_level_27;
reg signed  [2*WIDTH+2:0]   add_level_28;
reg signed  [2*WIDTH+2:0]   add_level_29;
reg signed  [2*WIDTH+2:0]   add_level_30;
reg signed  [2*WIDTH+2:0]   add_level_31;
reg signed  [2*WIDTH+2:0]   add_level_32;
reg signed  [2*WIDTH+2:0]   add_level_33;

//第二次加法数据
reg signed  [2*WIDTH+3:0]   add_level2_1;// 20 bit
reg signed  [2*WIDTH+3:0]   add_level2_2;
reg signed  [2*WIDTH+3:0]   add_level2_3;
reg signed  [2*WIDTH+3:0]   add_level2_4;
reg signed  [2*WIDTH+3:0]   add_level2_5;
reg signed  [2*WIDTH+3:0]   add_level2_6;
reg signed  [2*WIDTH+3:0]   add_level2_7;
reg signed  [2*WIDTH+3:0]   add_level2_8;
reg signed  [2*WIDTH+3:0]   add_level2_9;
reg signed  [2*WIDTH+3:0]   add_level2_10;
reg signed  [2*WIDTH+3:0]   add_level2_11;
reg signed  [2*WIDTH+3:0]   add_level2_12;
reg signed  [2*WIDTH+3:0]   add_level2_13;
reg signed  [2*WIDTH+3:0]   add_level2_14;
reg signed  [2*WIDTH+3:0]   add_level2_15;
reg signed  [2*WIDTH+3:0]   add_level2_16;
reg signed  [2*WIDTH+3:0]   add_level2_17;


//第三次加法数据
reg signed  [2*WIDTH+4:0]   add_level3_1;// 21 bit
reg signed  [2*WIDTH+4:0]   add_level3_2;
reg signed  [2*WIDTH+4:0]   add_level3_3;
reg signed  [2*WIDTH+4:0]   add_level3_4;
reg signed  [2*WIDTH+4:0]   add_level3_5;
reg signed  [2*WIDTH+4:0]   add_level3_6;
reg signed  [2*WIDTH+4:0]   add_level3_7;
reg signed  [2*WIDTH+4:0]   add_level3_8;
reg signed  [2*WIDTH+4:0]   add_level3_9;




wire signed [2*WIDTH+8:0] data_out;//25 bit




//输入数据，移位寄存器
always@(posedge clk_ADC or posedge I_rst_p)
   begin
      if(~I_rst_p)
         begin
            sample_1 <= 'h0;
            sample_2 <= 'h0;
            sample_3 <= 'h0;
            sample_4 <= 'h0;
            sample_5 <= 'h0;
            sample_6 <= 'h0;
            sample_7 <= 'h0;
            sample_8 <= 'h0;
            sample_9 <= 'h0;
            sample_10 <= 'h0;
            sample_11 <= 'h0;           
            sample_12 <= 'h0;
            sample_13 <= 'h0;
            sample_14 <= 'h0;
            sample_15 <= 'h0;
            sample_16 <= 'h0;
            sample_17 <= 'h0;           
            sample_18 <= 'h0;
            sample_19 <= 'h0;
            sample_20 <= 'h0;
            sample_21 <= 'h0;
            sample_22 <= 'h0;
            sample_23 <= 'h0;           
            sample_24 <= 'h0;
            sample_25 <= 'h0;
            sample_26 <= 'h0;
            sample_27 <= 'h0;
            sample_28 <= 'h0;
            sample_29 <= 'h0;           
            sample_30 <= 'h0;
            sample_31 <= 'h0;
            sample_32 <= 'h0;
            sample_33 <= 'h0;
            sample_34 <= 'h0;
            sample_35 <= 'h0;           
            sample_36 <= 'h0;
            sample_37 <= 'h0;
            sample_38 <= 'h0;
            sample_39 <= 'h0;
            sample_40 <= 'h0;
            sample_41 <= 'h0;           
            sample_42 <= 'h0;
            sample_43 <= 'h0;
            sample_44 <= 'h0;
            sample_45 <= 'h0;
            sample_46 <= 'h0;
            sample_47 <= 'h0;           
            sample_48 <= 'h0;
            sample_49 <= 'h0;
            sample_50 <= 'h0;
            sample_51 <= 'h0;
            sample_52 <= 'h0;
            sample_53 <= 'h0;           
            sample_54 <= 'h0;
            sample_55 <= 'h0;
            sample_56 <= 'h0;
            sample_57 <= 'h0;
            sample_58 <= 'h0;
            sample_59 <= 'h0;           
            sample_60 <= 'h0;
            sample_61 <= 'h0;
            sample_62 <= 'h0;
            sample_63 <= 'h0;
            sample_64 <= 'h0;           
            sample_65 <= 'h0;
            sample_66 <= 'h0;
            sample_67 <= 'h0;
            sample_68 <= 'h0;
            sample_69 <= 'h0;
            sample_70 <= 'h0;           
            sample_71 <= 'h0;
            sample_72 <= 'h0;
            sample_73 <= 'h0;
            sample_74 <= 'h0;
            sample_75 <= 'h0;
            sample_76 <= 'h0;           
            sample_77 <= 'h0;
            sample_78 <= 'h0;
            sample_79 <= 'h0;
            sample_80 <= 'h0;
            sample_81 <= 'h0;
            sample_82 <= 'h0;           
            sample_83 <= 'h0;
            sample_84 <= 'h0;
            sample_85 <= 'h0;
            sample_86 <= 'h0;
            sample_87 <= 'h0;
            sample_88 <= 'h0;           
            sample_89 <= 'h0;
            sample_90 <= 'h0;
            sample_91 <= 'h0;
            sample_92 <= 'h0;
            sample_93 <= 'h0;
            sample_94 <= 'h0;           
            sample_95 <= 'h0;
            sample_96 <= 'h0;
            sample_97 <= 'h0;
            sample_98 <= 'h0;
            sample_99 <= 'h0;
            sample_100<= 'h0;           
            sample_101<= 'h0;
            sample_102<= 'h0;
            sample_103<= 'h0;
            sample_104<= 'h0;
            sample_105<= 'h0;
            sample_106<= 'h0;           
            sample_107<= 'h0;
            sample_108<= 'h0;
            sample_109<= 'h0;
            sample_110<= 'h0;
            sample_111<= 'h0;
            sample_112<= 'h0;           
            sample_113<= 'h0;
            sample_114<= 'h0;
            sample_115<= 'h0;
            sample_116<= 'h0;
            sample_117<= 'h0;
            sample_118<= 'h0;           
            sample_119<= 'h0;
            sample_120<= 'h0;
            sample_121<= 'h0;
            sample_122<= 'h0;
            sample_123<= 'h0;
            sample_124<= 'h0;           
            sample_125<= 'h0;
            sample_126<= 'h0;
            sample_127<= 'h0;
            sample_128<= 'h0;
         end
      else
         begin
         sample_0 <= I_data;
         sample_1 <= sample_0;
         sample_2 <= sample_1;
         sample_3 <= sample_2;
         sample_4 <= sample_3;
         sample_5 <= sample_4;
         sample_6 <= sample_5;
         sample_7 <= sample_6;
         sample_8 <= sample_7;
         sample_9 <= sample_8;
         sample_10 <= sample_9;
         sample_11 <= sample_10;           
         sample_12 <= sample_11;
         sample_13 <= sample_12;
         sample_14 <= sample_13;
         sample_15 <= sample_14;
         sample_16 <= sample_15;
         sample_17 <= sample_16;           
         sample_18 <= sample_17;
         sample_19 <= sample_18;
         sample_20 <= sample_19;
         sample_21 <= sample_20;
         sample_22 <= sample_21;
         sample_23 <= sample_22;           
         sample_24 <= sample_23;
         sample_25 <= sample_24;
         sample_26 <= sample_25;
         sample_27 <= sample_26;
         sample_28 <= sample_27;
         sample_29 <= sample_28;           
         sample_30 <= sample_29;
         sample_31 <= sample_30;
         sample_32 <= sample_31;
         sample_33 <= sample_32;
         sample_34 <= sample_33;
         sample_35 <= sample_34;           
         sample_36 <= sample_35;
         sample_37 <= sample_36;
         sample_38 <= sample_37;
         sample_39 <= sample_38;
         sample_40 <= sample_39;
         sample_41 <= sample_40;           
         sample_42 <= sample_41;
         sample_43 <= sample_42;
         sample_44 <= sample_43;
         sample_45 <= sample_44;
         sample_46 <= sample_45;
         sample_47 <= sample_46;           
         sample_48 <= sample_47;
         sample_49 <= sample_48;
         sample_50 <= sample_49;
         sample_51 <= sample_50;
         sample_52 <= sample_51;
         sample_53 <= sample_52;           
         sample_54 <= sample_53;
         sample_55 <= sample_54;
         sample_56 <= sample_55;
         sample_57 <= sample_56;
         sample_58 <= sample_57;
         sample_59 <= sample_58;           
         sample_60 <= sample_59;
         sample_61 <= sample_60;
         sample_62 <= sample_61;
         sample_63 <= sample_62;
         sample_64 <= sample_63;           
         sample_65 <= sample_64;
         sample_66 <= sample_65;
         sample_67 <= sample_66;
         sample_68 <= sample_67;
         sample_69 <= sample_68;
         sample_70 <= sample_69;           
         sample_71 <= sample_70;
         sample_72 <= sample_71;
         sample_73 <= sample_72;
         sample_74 <= sample_73;
         sample_75 <= sample_74;
         sample_76 <= sample_75;           
         sample_77 <= sample_76;
         sample_78 <= sample_77;
         sample_79 <= sample_78;
         sample_80 <= sample_79;
         sample_81 <= sample_80;
         sample_82 <= sample_81;           
         sample_83 <= sample_82;
         sample_84 <= sample_83;
         sample_85 <= sample_84;
         sample_86 <= sample_85;
         sample_87 <= sample_86;
         sample_88 <= sample_87;           
         sample_89 <= sample_88;
         sample_90 <= sample_89;
         sample_91 <= sample_90;
         sample_92 <= sample_91;
         sample_93 <= sample_92;
         sample_94 <= sample_93;           
         sample_95 <= sample_94;
         sample_96 <= sample_95;
         sample_97 <= sample_96;
         sample_98 <= sample_97;
         sample_99 <= sample_98;
         sample_100<= sample_99;           
         sample_101<= sample_100;
         sample_102<= sample_101;
         sample_103<= sample_102;
         sample_104<= sample_103;
         sample_105<= sample_104;
         sample_106<= sample_105;           
         sample_107<= sample_106;
         sample_108<= sample_107;
         sample_109<= sample_108;
         sample_110<= sample_109;
         sample_111<= sample_110;
         sample_112<= sample_111;           
         sample_113<= sample_112;
         sample_114<= sample_113;
         sample_115<= sample_114;
         sample_116<= sample_115;
         sample_117<= sample_116;
         sample_118<= sample_117;           
         sample_119<= sample_118;
         sample_120<= sample_119;
         sample_121<= sample_120;
         sample_122<= sample_121;
         sample_123<= sample_122;
         sample_124<= sample_123;           
         sample_125<= sample_124;
         sample_126<= sample_125;
         sample_127<= sample_126;
         sample_128<= sample_127;

         end
   end
//fir系数对称 add data 将对称的data相加共用抽头系数
always@(posedge clk_ADC or posedge I_rst_p)
   begin
      if(~I_rst_p)
         begin
            add_data_0 <= 'h0;
            add_data_1 <= 'h0;
            add_data_2 <= 'h0;
            add_data_3 <= 'h0;
            add_data_4 <= 'h0;
            add_data_5 <= 'h0;
            add_data_6 <= 'h0;
            add_data_7 <= 'h0;
            add_data_8 <= 'h0;
            add_data_9 <= 'h0;
            add_data_10 <= 'h0;
            add_data_11 <= 'h0;
            add_data_12 <= 'h0;
            add_data_13 <= 'h0;
            add_data_14 <= 'h0;
            add_data_15 <= 'h0;
            add_data_16 <= 'h0;
            add_data_17 <= 'h0;
            add_data_18 <= 'h0;
            add_data_19 <= 'h0;
            add_data_20 <= 'h0;
            add_data_21 <= 'h0;
            add_data_22 <= 'h0;
            add_data_23 <= 'h0;
            add_data_24 <= 'h0;
            add_data_25 <= 'h0;
            add_data_26 <= 'h0;
            add_data_27 <= 'h0;
            add_data_28 <= 'h0;
            add_data_29 <= 'h0;
            add_data_30 <= 'h0;
            add_data_31 <= 'h0;
            add_data_32 <= 'h0;
            add_data_33 <= 'h0;
            add_data_34 <= 'h0;
            add_data_35 <= 'h0;
            add_data_36 <= 'h0;
            add_data_37 <= 'h0;
            add_data_38 <= 'h0;
            add_data_39 <= 'h0;
            add_data_40 <= 'h0;
            add_data_41 <= 'h0;
            add_data_42 <= 'h0;
            add_data_43 <= 'h0;
            add_data_44 <= 'h0;
            add_data_45 <= 'h0;
            add_data_46 <= 'h0;
            add_data_47 <= 'h0;
            add_data_48 <= 'h0;
            add_data_49 <= 'h0;
            add_data_50 <= 'h0;
            add_data_51 <= 'h0;
            add_data_52 <= 'h0;
            add_data_53 <= 'h0;
            add_data_54 <= 'h0;
            add_data_55 <= 'h0;
            add_data_56 <= 'h0;
            add_data_57 <= 'h0;
            add_data_58 <= 'h0;
            add_data_59 <= 'h0;
            add_data_60 <= 'h0;
            add_data_61 <= 'h0;
            add_data_62 <= 'h0;
            add_data_63 <= 'h0;
            add_data_64 <= 'h0;

         end
      else
         begin
            add_data_0 <= sample_0 + sample_128;
            add_data_1 <= sample_1 + sample_127;
            add_data_2 <= sample_2 + sample_126;
            add_data_3 <= sample_3 + sample_125;
            add_data_4 <= sample_4 + sample_124;
            add_data_5 <= sample_5 + sample_123;
            add_data_6 <= sample_6 + sample_122;
            add_data_7 <= sample_7 + sample_121;
            add_data_8 <= sample_8 + sample_120;
            add_data_9 <= sample_9 + sample_119;
            add_data_10 <= sample_10 + sample_118;
            add_data_11 <= sample_11 + sample_117;
            add_data_12 <= sample_12 + sample_116;
            add_data_13 <= sample_13 + sample_115;
            add_data_14 <= sample_14 + sample_114;
            add_data_15 <= sample_15 + sample_113;
            add_data_16 <= sample_16 + sample_112;
            add_data_17 <= sample_17 + sample_111;
            add_data_18 <= sample_18 + sample_110;
            add_data_19 <= sample_19 + sample_109;
            add_data_20 <= sample_20 + sample_108;
            add_data_21 <= sample_21 + sample_107;
            add_data_22 <= sample_22 + sample_106;
            add_data_23 <= sample_23 + sample_105;
            add_data_24 <= sample_24 + sample_104;
            add_data_25 <= sample_25 + sample_103;
            add_data_26 <= sample_26 + sample_102;
            add_data_27 <= sample_27 + sample_101;
            add_data_28 <= sample_28 + sample_100;
            add_data_29 <= sample_29 + sample_99;
            add_data_30 <= sample_30 + sample_98;
            add_data_31 <= sample_31 + sample_97;
            add_data_32 <= sample_32 + sample_96;
            add_data_33 <= sample_33 + sample_95;
            add_data_34 <= sample_34 + sample_94;
            add_data_35 <= sample_35 + sample_93;
            add_data_36 <= sample_36 + sample_92;
            add_data_37 <= sample_37 + sample_91;
            add_data_38 <= sample_38 + sample_90;
            add_data_39 <= sample_39 + sample_89;
            add_data_40 <= sample_40 + sample_88;
            add_data_41 <= sample_41 + sample_87;
            add_data_42 <= sample_42 + sample_86;
            add_data_43 <= sample_43 + sample_85;
            add_data_44 <= sample_44 + sample_84;
            add_data_45 <= sample_45 + sample_83;
            add_data_46 <= sample_46 + sample_82;
            add_data_47 <= sample_47 + sample_81;
            add_data_48 <= sample_48 + sample_80;
            add_data_49 <= sample_49 + sample_79;
            add_data_50 <= sample_50 + sample_78;
            add_data_51 <= sample_51 + sample_77;
            add_data_52 <= sample_52 + sample_76;
            add_data_53 <= sample_53 + sample_75;
            add_data_54 <= sample_54 + sample_74;
            add_data_55 <= sample_55 + sample_73;
            add_data_56 <= sample_56 + sample_72;
            add_data_57 <= sample_57 + sample_71;
            add_data_58 <= sample_58 + sample_70;
            add_data_59 <= sample_59 + sample_69;
            add_data_60 <= sample_60 + sample_68;
            add_data_61 <= sample_61 + sample_67;
            add_data_62 <= sample_62 + sample_66;
            add_data_63 <= sample_63 + sample_65;
            add_data_64 <= {sample_64[WIDTH -1],sample_64};

         end
   end

//第一次乘法：所有add_data乘抽头系数  
always@(posedge clk_ADC or posedge I_rst_p)
   begin
      if(~I_rst_p)
         begin
            mult_1 <= 'h0;
            mult_2 <= 'h0;
            mult_3 <= 'h0;
            mult_4 <= 'h0;
            mult_5 <= 'h0;
            mult_6 <= 'h0;
            mult_7 <= 'h0;
            mult_8 <= 'h0;
            mult_9 <= 'h0;
            mult_10 <= 'h0;
            mult_11 <= 'h0;
            mult_12 <= 'h0;
            mult_13 <= 'h0;
            mult_14 <= 'h0;
            mult_15 <= 'h0;
            mult_16 <= 'h0;
            mult_17 <= 'h0;
            mult_18 <= 'h0;
            mult_19 <= 'h0;
            mult_20 <= 'h0;
            mult_21 <= 'h0;
            mult_22 <= 'h0;
            mult_23 <= 'h0;
            mult_24 <= 'h0;
            mult_25 <= 'h0;
            mult_26 <= 'h0;
            mult_27 <= 'h0;
            mult_28 <= 'h0;
            mult_29 <= 'h0;
            mult_30 <= 'h0;
            mult_31 <= 'h0;
            mult_32 <= 'h0;
            mult_33 <= 'h0;
            mult_34 <= 'h0;
            mult_35 <= 'h0;
            mult_36 <= 'h0;
            mult_37 <= 'h0;
            mult_38 <= 'h0;
            mult_39 <= 'h0;
            mult_40 <= 'h0;
            mult_41 <= 'h0;
            mult_42 <= 'h0;
            mult_43 <= 'h0;
            mult_44 <= 'h0;
            mult_45 <= 'h0;
            mult_46 <= 'h0;
            mult_47 <= 'h0;
            mult_48 <= 'h0;
            mult_49 <= 'h0;
            mult_50 <= 'h0;
            mult_51 <= 'h0;
            mult_52 <= 'h0;
            mult_53 <= 'h0;
            mult_54 <= 'h0;
            mult_55 <= 'h0;
            mult_56 <= 'h0;
            mult_57 <= 'h0;
            mult_58 <= 'h0;
            mult_59 <= 'h0;
            mult_60 <= 'h0;
            mult_61 <= 'h0;
            mult_62 <= 'h0;
            mult_63 <= 'h0;
            mult_64 <= 'h0;
            mult_65 <= 'h0;
        end
     else
        begin
           mult_1 <= add_data_0 * coeff1;
           mult_2 <= add_data_1 * coeff2;
           mult_3 <= add_data_2 * coeff3;
           mult_4 <= add_data_3 * coeff4;
           mult_5 <= add_data_4 * coeff5;
           mult_6 <= add_data_5 * coeff6;
           mult_7 <= add_data_6 * coeff7;
           mult_8 <= add_data_7 * coeff8;
           mult_9 <= add_data_8 * coeff9;
           mult_10 <= add_data_9 * coeff10;
           mult_11 <= add_data_10 * coeff11;
           mult_12 <= add_data_11 * coeff12;
           mult_13 <= add_data_12 * coeff13;
           mult_14 <= add_data_13 * coeff14;
           mult_15 <= add_data_14 * coeff15;
           mult_16 <= add_data_15 * coeff16;
           mult_17 <= add_data_16* coeff17;
           mult_18 <= add_data_17* coeff18;
           mult_19 <= add_data_18* coeff19;
           mult_20 <= add_data_19* coeff20;
           mult_21 <= add_data_20* coeff21;
           mult_22 <= add_data_21* coeff22;
           mult_23 <= add_data_22* coeff23;
           mult_24 <= add_data_23* coeff24;
           mult_25 <= add_data_24* coeff25;
           mult_26 <= add_data_25* coeff26;
           mult_27 <= add_data_26* coeff27;
           mult_28 <= add_data_27* coeff28;
           mult_29 <= add_data_28* coeff29;
           mult_30 <= add_data_29* coeff30;
           mult_31 <= add_data_30* coeff31;
           mult_32 <= add_data_31* coeff32;
           mult_33 <= add_data_32* coeff33;
           mult_34 <= add_data_33* coeff34;
           mult_35 <= add_data_34* coeff35;
           mult_36 <= add_data_35* coeff36;
           mult_37 <= add_data_36* coeff37;
           mult_38 <= add_data_37* coeff38;
           mult_39 <= add_data_38* coeff39;
           mult_40 <= add_data_39* coeff40;
           mult_41 <= add_data_40* coeff41;
           mult_42 <= add_data_41* coeff42;
           mult_43 <= add_data_42* coeff43;
           mult_44 <= add_data_43* coeff44;
           mult_45 <= add_data_44* coeff45;
           mult_46 <= add_data_45* coeff46;
           mult_47 <= add_data_46* coeff47;
           mult_48 <= add_data_47* coeff48;
           mult_49 <= add_data_48* coeff49;
           mult_50 <= add_data_49* coeff50;
           mult_51 <= add_data_50* coeff51;
           mult_52 <= add_data_51* coeff52;
           mult_53 <= add_data_52* coeff53;
           mult_54 <= add_data_53* coeff54;
           mult_55 <= add_data_54* coeff55;
           mult_56 <= add_data_55* coeff56;
           mult_57 <= add_data_56* coeff57;
           mult_58 <= add_data_57* coeff58;
           mult_59 <= add_data_58* coeff59;
           mult_60 <= add_data_59* coeff60;
           mult_61 <= add_data_60* coeff61;
           mult_62 <= add_data_61* coeff62;
           mult_63 <= add_data_62* coeff63;
           mult_64 <= add_data_63* coeff64;
           mult_65 <= add_data_64* coeff65;

        end
   end

//第一次将乘法结果累加  
always@(posedge clk_ADC or posedge I_rst_p)
   begin
      if(~I_rst_p)
         begin
            add_level_1 <= 'h0;
            add_level_2 <= 'h0;
            add_level_3 <= 'h0;
            add_level_4 <= 'h0;
            add_level_5 <= 'h0;
            add_level_6 <= 'h0;
            add_level_7 <= 'h0;
            add_level_8 <= 'h0;
            add_level_9 <= 'h0;
            add_level_10 <= 'h0;
            add_level_11<= 'h0;
            add_level_12<= 'h0;
            add_level_13 <= 'h0;
            add_level_14 <= 'h0;
            add_level_15 <= 'h0;
            add_level_16 <= 'h0;
            add_level_17 <= 'h0;
            add_level_18 <= 'h0;
            add_level_19 <= 'h0;
            add_level_20 <= 'h0;
            add_level_21 <= 'h0;
            add_level_22 <= 'h0;
            add_level_23 <= 'h0;
            add_level_24 <= 'h0;
            add_level_25 <= 'h0;
            add_level_26 <= 'h0;
            add_level_27 <= 'h0;
            add_level_28 <= 'h0;
            add_level_29 <= 'h0;
            add_level_30 <= 'h0;
            add_level_31 <= 'h0;
            add_level_32 <= 'h0;
            add_level_33 <= 'h0;
            
         end
      else
         begin
            add_level_1 <= mult_1 + mult_2;
            add_level_2 <= mult_3 + mult_4;
            add_level_3 <= mult_5 + mult_6;
            add_level_4 <= mult_7 + mult_8;
            add_level_5 <= mult_9 + mult_10;
            add_level_6 <= mult_11 + mult_12;
            add_level_7 <= mult_13 + mult_14;
            add_level_8 <= mult_15 + mult_16;
            add_level_9 <= mult_17 + mult_18;
            add_level_10<= mult_19 + mult_20;
            add_level_11<= mult_21 + mult_22;
            add_level_12<= mult_23 + mult_24;
            add_level_13<= mult_25 + mult_26;
            add_level_14<= mult_27 + mult_28;
            add_level_15<= mult_29 + mult_30;
            add_level_16<= mult_31 + mult_32;
            add_level_17<= mult_33 + mult_34;
            add_level_18<= mult_35 + mult_36;
            add_level_19<= mult_37 + mult_38;
            add_level_20<= mult_39 + mult_40;
            add_level_21<= mult_41 + mult_42;
            add_level_22<= mult_43 + mult_44;
            add_level_23<= mult_45 + mult_46;
            add_level_24<= mult_47 + mult_48;
            add_level_25<= mult_49 + mult_50;
            add_level_26<= mult_51 + mult_52;
            add_level_27<= mult_53 + mult_54;
            add_level_28<= mult_55 + mult_56;
            add_level_29<= mult_57 + mult_58;
            add_level_30<= mult_59 + mult_60;
            add_level_31<= mult_61 + mult_62;
            add_level_32<= mult_63 + mult_64;
            add_level_33 <={mult_65[2*WIDTH+1],mult_65};
         end         
   end


//第二次将相加结果累加
always@(posedge clk_ADC or posedge I_rst_p)
   begin
      if(~I_rst_p)
         begin
            add_level2_1 <= 'h0;
            add_level2_2 <= 'h0;
            add_level2_3 <= 'h0;
            add_level2_4 <= 'h0;
            add_level2_5 <= 'h0;
            add_level2_6 <= 'h0;
            add_level2_7 <= 'h0;
            add_level2_8 <= 'h0;
            add_level2_9 <= 'h0;
            add_level2_10 <= 'h0;
            add_level2_11 <= 'h0;
            add_level2_12 <= 'h0;
            add_level2_13 <= 'h0;            
         end
      else
         begin
            add_level2_1 <= add_level_1 + add_level_2;
            add_level2_2 <= add_level_3 + add_level_4;
            add_level2_3 <= add_level_5 + add_level_6;
            add_level2_4 <= add_level_7 + add_level_8;
            add_level2_5 <= add_level_9 + add_level_10;
            add_level2_6 <= add_level_11 + add_level_12;
            add_level2_7 <= add_level_13 + add_level_14;
            add_level2_8 <= add_level_15 + add_level_16;
            add_level2_9 <= add_level_17 + add_level_18;
            add_level2_10 <= add_level_19 + add_level_20;
            add_level2_11 <= add_level_21 + add_level_22;
            add_level2_12 <= add_level_23 + add_level_24;
            add_level2_13 <= add_level_25 + add_level_26;
            add_level2_14 <= add_level_27 + add_level_28;
            add_level2_15 <= add_level_29 + add_level_30;
            add_level2_16 <= add_level_31 + add_level_32;
            add_level2_17 <={add_level_33[2*WIDTH+2],add_level_33};
         end         
   end

//第三次将相加结果累加
always@(posedge clk_ADC or posedge I_rst_p)
   begin
      if(~I_rst_p)
         begin
            add_level3_1 <= 'h0;
            add_level3_2 <= 'h0;
            add_level3_3 <= 'h0;
            add_level3_4 <= 'h0;
            add_level3_5 <= 'h0;
            add_level3_6 <= 'h0;
            add_level3_7 <= 'h0;
            add_level3_8 <= 'h0;
            add_level3_9 <= 'h0;          
         end
      else
         begin
            add_level3_1 <= add_level2_1 + add_level2_2;
            add_level3_2 <= add_level2_3 + add_level2_4;
            add_level3_3 <= add_level2_5 + add_level2_6;
            add_level3_4 <= add_level2_7 + add_level2_8;
            add_level3_5 <= add_level2_9 + add_level2_10;
            add_level3_6 <= add_level2_11 + add_level2_12;
            add_level3_7 <= add_level2_13 + add_level2_14;
            add_level3_8 <= add_level2_15 + add_level2_16;
            add_level3_9 <= {add_level2_17[2*WIDTH+3],add_level2_17};
         end         
   end


assign data_out = add_level3_1 
                + add_level3_2 
                + add_level3_3 
                + add_level3_4 
                + add_level3_5
                + add_level3_6
                + add_level3_7
                + add_level3_8
                + add_level3_9;
                
assign O_data = data_out[17:0]+18'h1FFFF;


endmodule

