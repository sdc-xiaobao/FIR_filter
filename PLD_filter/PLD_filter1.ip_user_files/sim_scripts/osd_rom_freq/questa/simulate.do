onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib osd_rom_freq_opt

do {wave.do}

view wave
view structure
view signals

do {osd_rom_freq.udo}

run -all

quit -force
