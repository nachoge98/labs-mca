
set top ucsbece154b_victim_cache

#-noinfo -nonote

yosys read -sv ../../unread.sv
yosys read -sv ../../ucsbece154b_victim_cache.sv
yosys chparam -set PNR_ENTRIES 4 -set PADDR_WIDTH 16 -set PLINE_WIDTH 16 ucsbece154b_victim_cache

yosys synth_ice40 -top $top
yosys opt
yosys write_json synth.json

#yosys write_verilog -sv synth_fifo.sv