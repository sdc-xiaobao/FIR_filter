`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/01 12:27:47
// Design Name: 
// Module Name: Freq_Cal
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


module Freq_Cal
#(parameter Trigger_Mode=1'b1,Measure_Num_Bit=3'd4,Trigger_Limit_T=32'd100_000_000)
(
    input i_clk,
    input i_rst,
    input [7:0]i_adc_data,
    input [7:0]i_trigger_gate,
    output [7:0]o_max_data,
    output [7:0]o_min_data,
    output [31:0]o_period
    );
    
    //State parameter
    localparam ST_IDLE=2'd0;
    localparam ST_START_H=2'd1;
    localparam ST_START_L=2'd2;
    localparam ST_WAIT=2'd3;
    
    //count
    reg [31:0]trigger_hcnt=0;
    reg [31:0]trigger_lcnt=0;
    reg [30+Measure_Num_Bit:0]trigger_cnt=0;
    reg [Measure_Num_Bit:0]measure_cnt=0;
    
    //Best value
    reg [7:0]max_data=0;
    reg [7:0]min_data=8'd255;
    
    //Trigger flag
    reg [1:0]flg_trigger=0;
    
    //status
    reg [1:0]state_current=0;
    reg [1:0]state_next=0;
    
    //Cache
    reg [7:0]adc_data_i=0;
    reg [7:0]trigger_gate_i=0;
    
    //Output
    reg [7:0]max_data_o=0;
    reg [7:0]min_data_o=0;
    reg [31:0]period_o=0;
    
    //Output wiring
    assign o_max_data=max_data_o;
    assign o_min_data=min_data_o;
    assign o_period=period_o;
    
    //Maximum output
    always@(posedge i_clk or negedge i_rst)begin
        if(i_rst==1'b0)begin max_data_o<=8'd0;min_data_o<=8'd0;end
        else if(state_current==ST_WAIT)begin max_data_o<=max_data;min_data_o<=min_data;end
        else begin max_data_o<=max_data_o;min_data_o<=min_data_o;end
    end
    
    //Period output
    always@(posedge i_clk or negedge i_rst)begin
        if(i_rst==1'b0)period_o<=32'd0;
        else if(state_current==ST_IDLE&measure_cnt[Measure_Num_Bit]==1'b1)period_o<=trigger_cnt[(30+Measure_Num_Bit):Measure_Num_Bit]+32'd3;
        else period_o<=period_o;
    end
    
    //Trigger count
    always@(posedge i_clk or negedge i_rst)begin
        if(i_rst==1'b0)trigger_cnt<={(30+Measure_Num_Bit){1'b0}};
        else if(state_current==ST_WAIT)trigger_cnt<=trigger_cnt+trigger_hcnt+trigger_lcnt;
        else if(state_current==ST_IDLE)trigger_cnt<={(30+Measure_Num_Bit){1'b0}};
        else trigger_cnt<=trigger_cnt;
    end
    
    //Maximum value judgment
    always@(posedge i_clk or negedge i_rst)begin
        if(i_rst==1'b0)max_data<=8'd0;
        else if(state_current==ST_START_H&adc_data_i>max_data)max_data<=adc_data_i;
        else if(state_current==ST_IDLE)max_data<=8'd0;
        else max_data<=max_data;
    end
    
    //Minimum value judgment
    always@(posedge i_clk or negedge i_rst)begin
        if(i_rst==1'b0)min_data<=8'd255;
        else if(state_current==ST_START_L&adc_data_i<min_data)min_data<=adc_data_i;
        else if(state_current==ST_IDLE)min_data<=8'd255;
        else min_data<=min_data;
    end
    
    //state machine
    always@(*)begin
        case(state_current)
            ST_IDLE:begin
                if(flg_trigger==2'b11)state_next<=ST_START_H;
                else state_next<=ST_IDLE;
            end
            ST_START_H:begin
                if(flg_trigger==2'b10&trigger_hcnt==Trigger_Limit_T)state_next<=ST_START_H;
                else if(flg_trigger==2'b10)state_next<=ST_START_L;
                else state_next<=ST_START_H;
            end
            ST_START_L:begin
                if(flg_trigger==2'b01&trigger_lcnt==Trigger_Limit_T)state_next<=ST_START_H;
                else if(flg_trigger==2'b01)state_next<=ST_WAIT;
                else state_next<=ST_START_L;
            end
            ST_WAIT:begin
                if(measure_cnt[Measure_Num_Bit]==1'b1)state_next<=ST_IDLE;
                else state_next<=ST_START_H;
            end
        endcase
    end
    
    //State assignment
    always@(posedge i_clk or negedge i_rst)begin
        if(i_rst==1'b0)begin
            state_current<=2'd0;
        end else begin
            state_current<=state_next;
        end
    end
    
    //Measurement count
    always@(posedge i_clk or negedge i_rst)begin
        if(i_rst==1'b0)measure_cnt<={(Measure_Num_Bit+1){1'b0}};
        else if(state_current==ST_IDLE)measure_cnt<={(Measure_Num_Bit+1){1'b0}};
        else if(state_current==ST_START_L&trigger_lcnt<Trigger_Limit_T&flg_trigger==2'b01)measure_cnt<=measure_cnt+1;
        else measure_cnt<=measure_cnt;
    end
    
    //High trigger count
    always@(posedge i_clk or negedge i_rst)begin
        if(i_rst==1'b0)trigger_hcnt<=32'd0;
        else if(state_current==ST_WAIT)trigger_hcnt<=32'd0;
        else if(flg_trigger==2'b10&trigger_hcnt==Trigger_Limit_T)trigger_hcnt<=32'd0;
        else if(flg_trigger==2'b11&trigger_hcnt==Trigger_Limit_T)trigger_hcnt<=trigger_hcnt;
        else if(flg_trigger==2'b11)trigger_hcnt<=trigger_hcnt+32'd1;
        else trigger_hcnt<=trigger_hcnt;
    end
    
    //Low trigger count
    always@(posedge i_clk or negedge i_rst)begin
        if(i_rst==1'b0)trigger_lcnt<=32'd0;
        else if(flg_trigger==2'b00&trigger_lcnt==Trigger_Limit_T)trigger_lcnt<=trigger_lcnt;
        else if(flg_trigger==2'b00)trigger_lcnt<=trigger_lcnt+32'd1;
        else if(flg_trigger==2'b10)trigger_lcnt<=32'd0;
        else trigger_lcnt<=trigger_lcnt;
    end
    
    //Trigger judgment
    always@(posedge i_clk or negedge i_rst)begin
        if(i_rst==1'b0)flg_trigger<=2'd0;
        else if(Trigger_Mode==1'b1&adc_data_i>trigger_gate_i)flg_trigger<={flg_trigger[0],1'b1};
        else if(Trigger_Mode==1'b0&adc_data_i<trigger_gate_i)flg_trigger<={flg_trigger[0],1'b1};
        else flg_trigger<={flg_trigger[0],1'b0};
    end
    
    //Input cache
    always@(posedge i_clk or negedge i_rst)begin
        if(i_rst==1'b0)begin
            adc_data_i<=8'd0;
            trigger_gate_i<=8'd0;
        end else begin
            adc_data_i<=i_adc_data;
            trigger_gate_i<=i_trigger_gate;
        end
    end
    
endmodule
