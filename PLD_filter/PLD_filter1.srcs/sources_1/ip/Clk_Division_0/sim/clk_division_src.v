// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.2 (win64) Build 2258646 Thu Jun 14 20:03:12 MDT 2018
// Date        : Sat Sep 19 17:30:15 2020
// Host        : DESKTOP-I02VR3S running 64-bit major release  (build 9200)
// Command     : write_verilog -mode synth_stub C:/Users/opex9020/Desktop/Test/clk_division_src.v
// Design      : clk_division_src
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7s15ftgb196-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module clk_division_src(i_clk, i_rst, i_clk_mode, o_clk_out)
/* synthesis syn_black_box black_box_pad_pin="i_clk,i_rst,i_clk_mode[30:0],o_clk_out" */;
  input i_clk;
  input i_rst;
  input [30:0]i_clk_mode;
  output o_clk_out;
endmodule
