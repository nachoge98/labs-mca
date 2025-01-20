# Introduction to CVA6

This lab will help you become acquainted with the CVA6 core. 

First, you will need to read through and follow along with the [Getting Started Guide](../guides/getting-started.md) to set and install all the required tools.
If you are having difficulties with the tool setup, please contact any of the TA on time to make sure you have it running before the Lab 1.
Note: the total installation time without any issues will take around 1 hour.

As a preparation for Lab 1 you should go through the following questions to make sure you have a basic understanding of System Verilog, CVA6 and RISC-V. Note, we won't ask for the answers of these questions, they are for your self-understanding. 

## SystemVerilog Questions

1. In the keyword `always_comb`, what does "comb" refer to? What is its Verilog equivalent? Find an example of the use of `always_comb` in CVA6.
2. In the keyword `always_ff`, what does "ff" refer to? What is its Verilog equivalent? Find an example of the use of `always_ff` in CVA6.
3. What is a SystemVerilog package, and how do you reference its contents in another file? Find an example of the use of a SV package in CVA6.
4. What is a struct, and how do you access struct members? Find an example of the use of a struct in CVA6.
5. What are block names? Find an example of one in CVA6.

## RISC-V Questions

1. What are the 6 instruction formats of RISC-V?
2. What is a compressed instruction and what are they used for?

## CVA6 Questions

1. Take a look at the block diagram of CVA6 provided in the [core's documentation](https://docs.openhwgroup.org/projects/cva6-user-manual/01_cva6_user/).
2. Skim through the [CVA6 user manual](https://docs.openhwgroup.org/projects/cva6-user-manual/01_cva6_user/) and find each one of the 6 pipeline stages.
3. Which stages are in the "frontend", and which are in the "backend"?
4. Find meaning of the following acronyms: RISC-V, CVA6, IF, ID, EX, I\$, D\$, FIFO, TLB, ITLB, CSR, BHT, RAS, BTB, MMU, EPC, MTVEC, LSU, PTW, DTLB, ALU, FPU, OoO, WB, AXI, APU, DPI.
5. What is AXI and what is it primarily used for in CVA6?

## ELF Questions

Note that you can view the instructions and PCs of an ELF file with the following command: `riscv-none-elf-objdump -d <PATH TO PROGRAM>.o`
How to and where an elf file is generated is explained in [Getting Started](../guides/getting-started.md).

1. What is an ELF file and where are they used? (Not specific to CVA6)
2. What is the difference between segments and sections?

## Simulation Questions

All CVA6 net hierarchical paths should start with `TOP.ariane_testharness.i_ariane.i_cva6.`. Each module/struct should be separated with `.` until you reach the delcaration of the net. To see a net hierarchical path in GTKWave, you can right-click an added signal and click "Alias Highlighted Signal".

Simulate [`"./programs/examples/asm.S"`](./../programs/examples/asm.S). If you have questions about how to, check [Running Simulations](./../guides/getting-started.md/#running-simulations).

1. Find the PC in the instruction decode stage.
2. Find the ALU output and the result of the addition from the assembly code.
3. Find the register file write enable in the commit stage.
