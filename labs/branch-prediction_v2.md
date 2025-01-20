# Branch Prediction

In this lab, you will study and modify the existing branch predictor from CVA6.
## Pre-Lab Questions

1. What is the purpose of a branch predictor? Why does a single-cycle core not need branch prediction?
2. Define and compare and contrast the following:
    * Static branch prediction vs. Dynamic branch prediction
    * One-level branch prediction vs. Two-level predictor
    * Local branch prediction vs. Global branch prediction
3. Define BHT, BTB and RAS. What are they used for?
4. Look at [frontend.sv](https://github.com/openhwgroup/cva6/blob/a12d51143217742fe42058e4dceb4baa33edf5e6/core/frontend/frontend.sv). What are the 4 types of instructions that the [branch predictor](https://github.com/openhwgroup/cva6/blob/a12d51143217742fe42058e4dceb4baa33edf5e6/core/frontend/bht.sv) handles, and how are they handled?
5. How is a branch resolution handled?
6. What kind of dynamic branch predictor does CVA6 use?
8. When can more than 1 instruction be fetched per cycle?

**Show the answers to these questions to the TA to sign off the Pre-lab part.**

## Part 1 - CVA6 Predictor

Add functionality to [frontend.sv](https://github.com/openhwgroup/cva6/blob/a12d51143217742fe42058e4dceb4baa33edf5e6/core/frontend/frontend.sv) that records the branch predictor hit-rate.

To do this, you can create an `always_ff @(posedge clk)` block that counts how many times a branch has been resolved, and how many of those resolutions were mispredicts. ([Branch resolve net](https://github.com/openhwgroup/cva6/blob/a12d51143217742fe42058e4dceb4baa33edf5e6/core/frontend/frontend.sv#L46); [branch resolve type](https://github.com/openhwgroup/cva6/blob/a12d51143217742fe42058e4dceb4baa33edf5e6/core/cva6.sv#L128-L135).) The hit-rate can be calculated with 1-num_mispredicts/num_valid_resolutions. You can then record the hit-rate to a file on every clock cycle; this way, you are certain to get the final hit-rate when the simulation terminates.
Note that the file will be created at `mca-labs/cva6/verif/sim`.

### Example of How to Write to a File in Verilog/SystemVerilog

```systemverilog
integer f;
integer counter;
initial begin
    f = $fopen("bp.txt","w");
end
always @(posedge clk) begin
    $fwrite(f, "%f\n", $itor(counter));
end
```

### Part 1 Questions

1. Highlight your changes to `"frontend.sv"` that records the hit-rate.
2. What are the final hit-rate percentages of each of the [bp benchmarks](./../programs/bp)?
3. Compare the performance of the [bp benchmarks](./../programs/bp) after choosing 3 new values for [`NR_ENTRIES`](https://github.com/openhwgroup/cva6/blob/a12d51143217742fe42058e4dceb4baa33edf5e6/core/frontend/frontend.sv#L517). Display the 4 hit-rates in a table and explain how and why each program changes its hit-rate as BHT size changes. *Note: When changing `NR_ENTRIES`, be sure to change `NR_ENTRIES` in the `bht` instantiation in `"frontend.sv"`, not the `bht` declaration in `"bht.sv"`. Also your `NR_ENTRIES` values should be on the order of 16 to have interesting results.*

**Show the answers to these questions to the TA to sign off Part 1.**

## Part 2 - Global Predictor

In this part, you will modify the [bht.sv](https://github.com/openhwgroup/cva6/blob/a12d51143217742fe42058e4dceb4baa33edf5e6/core/frontend/bht.sv) and turn it into a [global two-level adaptive branch predictor](https://en.wikipedia.org/wiki/Branch_predictor#Global_branch_prediction). First, read through the [Global Branch Predictor Specifications](#global-branch-predictor-specifications) section.

A few notes on your implementation:

* Choose your own values for `n` and `m`
* You can use whatever algorithm you want to calculate the BHT index
    * You can use Gshare or Gselect
    * You may also choose to use [XORShift](https://en.wikipedia.org/wiki/Xorshift), a simple random-number-generation algorithm, to create a hash that will index into your BHT
* Be sure that your BHT size is decided by the parameter `NR_ENTRIES`
* Be sure to remove all unused lines of code leftover from the initial implementation, this includes the fpga targeted implementation.
* Be sure to comment your design clearly

### Part 2 Questions

1. Share your modified `"bht.sv"` that implements the global two-level adaptive branch predictor.
2. What specifications did you decide on for your predictor? What is your BHT index generation algorithm? How wide is your GHR? Which address bits do you use for your address?
3. Briefly explain your reasoning behind the BHT index generation algorithm you chose.
4. Compare the performance of the [bp benchmarks](./../programs/bp) after choosing 3 new values for [`NR_ENTRIES`](https://github.com/openhwgroup/cva6/blob/a12d51143217742fe42058e4dceb4baa33edf5e6/core/frontend/frontend.sv#L514). Display the 4 hit-rates in a table and explain how and why each program changes its hit-rate as BHT size changes.

**Show the answers to these questions to the TA to sign off Part 2.**

## Global Branch Predictor Specifications

*This section describes the specifications required to build a global two-level adaptive branch predictor.*

For global branch predictors, a global history record (GHR) must be kept. A GHR keeps a record of the past `n` branches using a FIFO method. To maintain the GHR, when a branch has been resolved, the branch result must be shifted into the GHR while simultaneously dropping the `n`th result.

Similar to a one-level branch predictor, a two-level branch predictor contains a branch history table (BHT) where its entries are (*often*) two-bit saturation counters. However, one-level and two-level predictors differ in how the BHT index is calculated.

For a global two-level adaptive branch predictor, the BHT index is calculated using the current GHR value and using `m` bits from the resolved branch's program counter. The GHR and PC can either be concatenated together (called Gselect) or xor'ed together (called Gshare). Other BHT index calculation algorithms exist but have little effect on the predictor performance.

### 2-Bit Saturation Counter

![2-Bit Saturation Counter](bp/saturation_counter.svg)

### Global Predictor

![Global Predictor](bp/global_predictor.svg)
