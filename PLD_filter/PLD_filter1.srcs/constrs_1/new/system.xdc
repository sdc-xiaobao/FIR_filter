## Clock signal 100 MHz
set_property -dict { PACKAGE_PIN H4  IOSTANDARD LVCMOS33 } [get_ports {clk_100MHz }]; #IO_L13P_T2_MRCC_35 Sch=sysclk
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports {clk_100MHz}];

#DAC
set_property -dict {PACKAGE_PIN L1 IOSTANDARD LVCMOS33} [get_ports DAC_Din];
set_property -dict {PACKAGE_PIN N1 IOSTANDARD LVCMOS33} [get_ports DAC_Sync];
set_property -dict {PACKAGE_PIN M1 IOSTANDARD LVCMOS33} [get_ports clk_DAC];


#ADC
set_property -dict {PACKAGE_PIN J4 IOSTANDARD LVCMOS33} [get_ports ADC_En]
set_property -dict {PACKAGE_PIN C5 IOSTANDARD LVCMOS33} [get_ports clk_ADC]
set_property -dict {PACKAGE_PIN J3 IOSTANDARD LVCMOS33} [get_ports {i_data[0]}]
set_property -dict {PACKAGE_PIN J2 IOSTANDARD LVCMOS33} [get_ports {i_data[1]}]
set_property -dict {PACKAGE_PIN D12 IOSTANDARD LVCMOS33} [get_ports {i_data[2]}]
set_property -dict {PACKAGE_PIN E12 IOSTANDARD LVCMOS33} [get_ports {i_data[3]}]
set_property -dict {PACKAGE_PIN F12 IOSTANDARD LVCMOS33} [get_ports {i_data[4]}]
set_property -dict {PACKAGE_PIN C11 IOSTANDARD LVCMOS33} [get_ports {i_data[5]}]
set_property -dict {PACKAGE_PIN H11 IOSTANDARD LVCMOS33} [get_ports {i_data[6]}]
set_property -dict {PACKAGE_PIN H12 IOSTANDARD LVCMOS33} [get_ports {i_data[7]}]


## Rst
set_property -dict {PACKAGE_PIN D14 IOSTANDARD LVCMOS33} [get_ports i_rst]
#UART0
set_property -dict {PACKAGE_PIN A10 IOSTANDARD LVCMOS33} [get_ports UART0_Rx]
set_property -dict {PACKAGE_PIN B6 IOSTANDARD LVCMOS33} [get_ports UART0_Rx_blue]

#i2c
set_property -dict {PACKAGE_PIN A5 IOSTANDARD LVCMOS33} [get_ports i2c_scl]
set_property -dict {PACKAGE_PIN B5 IOSTANDARD LVCMOS33} [get_ports i2c_sda]


#LED
set_property PACKAGE_PIN J1 [get_ports {LED_IO}]
set_property IOSTANDARD LVCMOS33 [get_ports {LED_IO}]
set_property PULLDOWN true [get_ports {LED_IO}]
set_property PACKAGE_PIN A13 [get_ports {LED_IO2}]
set_property IOSTANDARD LVCMOS33 [get_ports {LED_IO2}]
set_property PULLDOWN true [get_ports {LED_IO2}]

## HDMI Tx
set_property -dict {PACKAGE_PIN F4 IOSTANDARD TMDS_33} [get_ports TMDS_Tx_Clk_N]
set_property -dict {PACKAGE_PIN G4 IOSTANDARD TMDS_33} [get_ports TMDS_Tx_Clk_P]
set_property -dict {PACKAGE_PIN F1 IOSTANDARD TMDS_33} [get_ports {TMDS_Tx_Data_N[0]}]
set_property -dict {PACKAGE_PIN G1 IOSTANDARD TMDS_33} [get_ports {TMDS_Tx_Data_P[0]}]
set_property -dict {PACKAGE_PIN D2 IOSTANDARD TMDS_33} [get_ports {TMDS_Tx_Data_N[1]}]
set_property -dict {PACKAGE_PIN E2 IOSTANDARD TMDS_33} [get_ports {TMDS_Tx_Data_P[1]}]
set_property -dict {PACKAGE_PIN C1 IOSTANDARD TMDS_33} [get_ports {TMDS_Tx_Data_N[2]}]
set_property -dict {PACKAGE_PIN D1 IOSTANDARD TMDS_33} [get_ports {TMDS_Tx_Data_P[2]}]


##Waring Cut If you run implementation and meet the warnings which point to the source not constriant, you can use these cmd to avoid the warnings.
set_property CONFIG_VOLTAGE 3.3 [current_design]
set_property CFGBVS VCCO [current_design]
set_property BITSTREAM.CONFIG.CONFIGRATE 50 [current_design]
