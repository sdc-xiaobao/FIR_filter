set_property SRC_FILE_INFO {cfile:c:/Users/24238/Desktop/PLD/PLD_filter1/PLD_filter/PLD_filter.srcs/sources_1/ip/clk_wiz_1/clk_wiz_1.xdc rfile:../../../PLD_filter.srcs/sources_1/ip/clk_wiz_1/clk_wiz_1.xdc id:1 order:EARLY scoped_inst:inst} [current_design]
set_property src_info {type:SCOPED_XDC file:1 line:57 export:INPUT save:INPUT read:READ} [current_design]
set_input_jitter [get_clocks -of_objects [get_ports clk_in1]] 0.1
