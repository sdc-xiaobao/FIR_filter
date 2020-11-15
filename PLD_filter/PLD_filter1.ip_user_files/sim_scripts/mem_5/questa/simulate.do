onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib mem_5_opt

do {wave.do}

view wave
view structure
view signals

do {mem_5.udo}

run -all

quit -force
