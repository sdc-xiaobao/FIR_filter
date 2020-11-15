`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/01 12:27:47
// Design Name: 
// Module Name: Driver_ADC
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


module Driver_ADC(
    input i_clk_100M, 
    input i_clk,
    input i_rst,
    input i_oscillo_en,
    input [10:0]i_oscillo_offset,
    input [3:0]i_oscillo_scale,
    input [7:0]i_adc_data,
    input [7:0]i_trigger_gate,
    input [10:0]i_set_x,
    output o_clk_adc,
    output o_adc_en,
    output [7:0]o_max_data,
    output [7:0]o_min_data,
    output [7:0]o_adc_data,
    output [31:0]o_period
    );
    
    //parameter
    localparam Default_Factor=31'd100;   //ADC clock division factor
    localparam Sample_Num=15'd19200;     //Sampling points
    
    //data
    wire [7:0]adc_data;

    //clock
    wire clk_adc;
    
    //Enable
    reg en_trigger=0;
    
    //Sign
    reg [23:0]flg_trigger=0;
    
    //Cache
    reg oscillo_en_i=0;
    reg [3:0]oscillo_scale_i=0;
    reg [10:0]oscillo_offset_i=0;
    reg [7:0]trigger_gate_i=0;
    reg [7:0]adc_data_i=0;
    reg [1:0]buff_clk_adc=0;
    reg [10:0]set_x_i=0;
    
    //address
    reg [14:0]addr_wr=0;
    reg [14:0]addr_rd=0;
    
    //Output
    reg adc_en_o=0;
    reg [7:0]adc_data_o=0;
    
    //Output wiring
    assign o_clk_adc=clk_adc;
    assign o_adc_en=adc_en_o;
    assign o_adc_data=adc_data_o;
    
    //Fixed data output
    always@(posedge i_clk or negedge i_rst)begin
        if(i_rst==1'b0)begin
            adc_en_o<=1'b1;
            adc_data_o<=8'd0;
        end else begin
            adc_en_o<=1'b0;
            adc_data_o<=adc_data;
        end
    end
    
    //Write address generation
    always@(posedge i_clk)begin
        if(oscillo_en_i==1'b1)addr_wr<=15'd0;
        else if(en_trigger==1'b0)addr_wr<=15'd0;
        else if(buff_clk_adc==2'b01&addr_wr<Sample_Num-1)addr_wr<=addr_wr+15'd1;
        else addr_wr<=addr_wr;
    end
    
    //Read address generation
    always@(posedge i_clk)begin
        case(oscillo_scale_i)
            4'd2:addr_rd<=(set_x_i<<1)+oscillo_offset_i;
            4'd3:addr_rd<=(set_x_i<<1)+set_x_i+oscillo_offset_i;
            4'd4:addr_rd<=(set_x_i<<2)+oscillo_offset_i;
            4'd5:addr_rd<=(set_x_i<<2)+set_x_i+oscillo_offset_i;
            4'd6:addr_rd<=(set_x_i<<2)+(set_x_i<<1)+oscillo_offset_i;
            4'd7:addr_rd<=(set_x_i<<2)+(set_x_i<<1)+set_x_i+oscillo_offset_i;
            4'd8:addr_rd<=(set_x_i<<3)+oscillo_offset_i;
            4'd9:addr_rd<=(set_x_i<<3)+set_x_i+oscillo_offset_i;
            4'd10:addr_rd<=(set_x_i<<3)+(set_x_i<<1)+oscillo_offset_i;
            default:addr_rd<={4'd0,set_x_i}+oscillo_offset_i;
        endcase
    end
    
    //Trigger enable
    always@(posedge i_clk or negedge i_rst)begin
        if(i_rst==1'b0)en_trigger<=1'b0;
        else if(oscillo_en_i==1'b1)en_trigger<=1'b0;
        else if(flg_trigger==24'h000fff)en_trigger<=1'b1;
        else en_trigger<=en_trigger;
    end
    
    //Trigger judgment
    always@(posedge i_clk or negedge i_rst)begin
        if(i_rst==1'b0)flg_trigger<=24'd0;
        else if(oscillo_en_i==1'b1)flg_trigger<=24'h0f0f0f;
        else if(buff_clk_adc==2'b01&adc_data_i>trigger_gate_i)flg_trigger<={flg_trigger[22:0],1'b1};
        else if(buff_clk_adc==2'b01)flg_trigger<={flg_trigger[22:0],1'b0};
        else flg_trigger<=flg_trigger;
    end
    
    //ADC clock
    Clk_Division_0 Clock_ADC(.clk_100MHz(i_clk),  .clk_mode(Default_Factor), .clk_out(clk_adc) );       
    //Frequency calculation
    Freq_Cal #(.Trigger_Mode(1'b1),.Measure_Num_Bit(3'd4),.Trigger_Limit_T(32'd100_000_000))Freq_Cal_0
    (
        .i_clk(i_clk_100M),
        .i_rst(i_rst),
        .i_adc_data(adc_data_i),
        .i_trigger_gate(8'd160),
        .o_max_data(o_max_data),
        .o_min_data(o_min_data),
        .o_period(o_period)
     );
    
     //Waveform storage
     Wave_Ram Ram_Wave (
        .clka(i_clk),             // input wire clka
        .wea(i_rst),              // input wire [0 : 0] wea
        .addra(addr_wr),          // input wire [14 : 0] addra
        .dina(adc_data_i),        // input wire [7 : 0] dina
        .clkb(i_clk),             // input wire clkb
        .addrb(addr_rd),          // input wire [14 : 0] addrb
        .doutb(adc_data)          // output wire [7 : 0] doutb
    );
    
     //Clock buffer
     always@(posedge i_clk or negedge i_rst)begin
        if(i_rst==1'b0)begin
            oscillo_en_i<=1'b0;
            oscillo_offset_i<=11'd0;
            oscillo_scale_i<=4'd0;
            trigger_gate_i<=8'd0;
            adc_data_i<=8'd0;
            buff_clk_adc<=2'd0;
            set_x_i<=11'd0;
        end else begin
            oscillo_en_i<=i_oscillo_en;
            oscillo_offset_i<=i_oscillo_offset;
            oscillo_scale_i<=i_oscillo_scale;
            trigger_gate_i<=i_trigger_gate;
            adc_data_i<=i_adc_data;
            buff_clk_adc<={buff_clk_adc[0],clk_adc};
            set_x_i<=i_set_x;
        end
     end
endmodule

