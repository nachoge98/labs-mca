
set top ucsbece154b_fifo

yosys read -sv ../../ucsbece154b_fifo.sv
yosys chparam -set DATA_WIDTH 64 -set NR_ENTRIES 1024 ucsbece154b_fifo

yosys synth_ice40 -top $top
#yosys synth_xilinx -top $top
yosys opt
yosys write_json synth.json

#yosys write_verilog -sv synth_fifo.sv