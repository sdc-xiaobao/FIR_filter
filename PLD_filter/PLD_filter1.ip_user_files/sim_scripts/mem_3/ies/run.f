-makelib ies_lib/xil_defaultlib -sv \
  "F:/Vivado_2018/Vivado/2018.2/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
  "F:/Vivado_2018/Vivado/2018.2/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \
-endlib
-makelib ies_lib/xpm \
  "F:/Vivado_2018/Vivado/2018.2/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib ies_lib/blk_mem_gen_v8_4_1 \
  "../../../ipstatic/simulation/blk_mem_gen_v8_4.v" \
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../../PLD_filter.srcs/sources_1/ip/mem_3/sim/mem_3.v" \
-endlib
-makelib ies_lib/xil_defaultlib \
  glbl.v
-endlib

