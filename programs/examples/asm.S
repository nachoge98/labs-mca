/*
 * File: asm.S
 * Description: Example of how to format a RISC-V assembly file to be read by CVA6.
 */

  .text
# Text segment

  .globl main;
main:
# entry point
# core of the test
  li      t0, 2022;
  li      t1, 2023;
  add     t2, t0, t1;

#  la    a1, helloworld; # load address of helloworld
#  addi  a2, x0, 12;     # length of our string
#  addi  a7, x0, 64;     # linux write system call
#  ecall;

  li      a0, 0;  # set exit value to 0
  jal exit;

  .data
# Data segment
helloworld: .asciz "Hello World!"