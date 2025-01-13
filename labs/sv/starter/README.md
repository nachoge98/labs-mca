
# FIFO Starter Code

## Guide to Run Simulations with verilator


1. Edit [`"ucsbece154b_fifo.sv"`](./ucsbece154b_fifo.sv) and [`"tb/fifo_tb.sv"`](./fifo_tb.sv)
2. Run `make tb TOOL=verilator` to run the simulation
3. To open the waveforms: `cd ./build/ucsbece154b_sv_fifo_1.0.0/tb-verilator` and then `gtkwave dump.fst`.
