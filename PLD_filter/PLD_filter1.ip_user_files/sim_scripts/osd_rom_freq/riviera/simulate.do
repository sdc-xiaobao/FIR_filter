onbreak {quit -force}
onerror {quit -force}

asim -t 1ps +access +r +m+osd_rom_freq -L xil_defaultlib -L xpm -L blk_mem_gen_v8_4_1 -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.osd_rom_freq xil_defaultlib.glbl

do {wave.do}

view wave
view structure

do {osd_rom_freq.udo}

run -all

endsim

quit -force
