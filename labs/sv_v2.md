# Requirements

Make sure to have finished [Lab 0](./intro.md) prior to this lab.

# Synthesizable SystemVerilog

SystemVerilog is the most common hardware-description-language today. It is powerful for its good object-oriented design support that can be used both in simulation and synthesis. Writing synthesizable SystemVerilog has difficulties, so this lab will help you develop your skills.

Resources

* [Writing Synthesizable SystemVerilog](../guides/synthesis.md)
* [DigitalJS Online](https://digitaljs.tilk.eu/)
* ["Busting the Myth that SystemVerilog is only for Verification"](https://sutherland-hdl.com/papers/2013-SNUG-SV_Synthesizable-SystemVerilog_paper.pdf)

## Part 1:

1. For the following questions, please provide a screenshot from [DigitalJS Online](https://digitaljs.tilk.eu/), a Verilog synthesis visualizer, to support your answers.
    1. How is a Verilog/SystemVerilog `for` loop synthesized?
    2. How is a Verilog/SystemVerilog `if` statement synthesized?
2. CVA6 uses a common design practice of appending `_d` and `_q` to the end of net names. What does each mean? How should each net type be assigned? Why can this practice be more useful than using a single net?
3. When synthesizing Verilog/SystemVerilog into a netlist, the synthesis tool will often "infer" where you have created a block-RAM and try to optimize the design accordingly. This is extremely helpful if your target FPGA or ASIC already has built-in block-RAMs, because using the built-in block-RAMs will be much more power and area efficient than creating an equivalent design using flip-flops. For example, you can see that [DigitalJS Online](https://digitaljs.tilk.eu/) converts the Verilog array into a "RAM" logic cell.

    ```systemverilog
    module ram (
        input clk,
        input rst,
        // read port
        input [1:0] raddr_i,
        output [7:0] rdata_o,
        // write port
        input [1:0] waddr_i,
        input [7:0] wdata_i,
        input we_i
    );

    logic [7:0] RAM [0:3];

    assign rdata_o = RAM[raddr_i];

    always_ff @(posedge clk) begin
        if (we_i) RAM[waddr_i] <= wdata_i;
    end

    endmodule
    ```

    1. Add a `for` loop to this design so that when `rst` goes high, all the RAM cells' values are set to `'0` on the next clock cycle. Provide your modified code and a screenshot of what [DigitalJS Online](https://digitaljs.tilk.eu/) synthesized.
    2. Why is this reset strategy not scalable to larger RAM sizes? Theorize a better strategy to reset the RAM over multiple cycles. What are the pros and cons of this new reset strategy versus the first strategy?

**Show the answers to questions 1.1, 1.2, 2, 3.1 and 3.2 to a TA to sign off Part 1 of this lab.**

## Part 2:

In this part, you will implement a synchronous FIFO.

FIFOs (first-in-first-out queues) are incredibly popular in pipelined architecture designs. Usually, if two hardware units with different clock frequencies/latencies need to communicate, the faster unit must stall and wait for the slower unit to be ready to prevent data loss. Fortunetly, a FIFO can be added between the two units to buffer the requests so that the faster unit will stall only when the FIFO is full, and the slower unit can grab available data as soon as it is ready. This strategy can provide incredible speedup when a lot of different types of hardware units need to communicate. (CVA6 uses several FIFOs in its design.)

You should implement your FIFO with a cyclical buffer. You should have one block ram of size `DATA_WIDTH` and `NR_ENTRIES`, with pointers to your FIFO `head` and `tail`. Here are some specifics:

* When you pop an element, you should increment the `head` pointer.
* When you push an element, you should write `data_i` to the tail of the buffer, and increment the `tail` pointer.
* If the `head` or `tail` pointer reach `NR_ENTRIES`, they should reset to `0`.
* You can push and pop on the same cycle, but if the FIFO is empty, you should only push.
* If the FIFO is empty, `valid_o` should output `0`, and any pop requests should fail.
* If the FIFO is full, `full_o` should output `1`, and any push request should fail unless a pop request is also active.
* As long as the FIFO is not empty, `data_o` should give the data at the head of the buffer.
* Both pushing and popping should occur on `posedge clk_i`, and reset should occur synchronously.

The module you need to finish is [`"ucsbece154b_fifo.sv"`](./sv/starter/ucsbece154b_fifo.sv), found in [`"labs/sv/starter"`](./sv/starter/). You can simulate your changes with Verilator 5 using `make tb TOOL=verilator`. A [sample testbench](./sv/starter/tb/fifo_tb.sv) is provided that you may edit as desired. Note, the waveforms will be dumped under `labs/sv/started/build/ucsbece154b_sv_fifo_1.0.0/tb-verilator/dump.fst`.

Now that you have seen a lot of CVA6's code, **you must mimic the coding practices/styles of CVA6**. This means using `_d` and `_q` nets for all your flip-flops, and using `always_comb` to set your `_d` nets, and using `always_ff` to set your `_q` nets. See ["Writing Synthesizable SystemVerilog" - Flip-Flops](../guides/synthesis.md#flip-flops).

Note that for your buffer to infer a block ram, you cannot separate it into `_d` and `_q` nets. This is because if your `always_ff` block has `<ARRAY>_q <= <ARRAY>_d;`, your array will be inferred as an array of registers. To be inferred as a block ram, you must do `if (<WE>) <ARRAY>[<ADDR>] <= <DATA>;` instead. See ["Writing Synthesizable SystemVerilog" - Memory](../guides/synthesis.md#memory).

Your design needs to be synthesizable. You can run `make synth` to verify that it synthesizes with Yosys+Surelog correctly. Note that the makefile script command will snthesize the FIFO for the following parameter values: `DATA_WIDTH=64` and `NR_ENTRIES=1024`. Note you can find the utilization summary under: `3.49. Printing statistics.`

<strong>

To sign off Part 2 show the following to a TA:

1. waveform of the FIFO working as intended.
2. Your .sv implementation.
3. your synthesis results, how many rams are being being used and why?

Make sure you understand what you are seeing and explain it clearly to the TA.
 
</strong>