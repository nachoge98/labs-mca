/*
 * File: loop.S
 * Description: Nested for loop to benchmark the branch predictor.
 */

  .text
# Text segment

  .globl main;
main:
# entry point
# core of the test

# loop
#define LOOP_SIZE 5
  li      a0, 0;          # output init

  li      t0, LOOP_SIZE;  # loop0 init
loop0:
  addi    t0, t0, -1;     # loop0 counter
  beqz    t0, loop0_end;  # loop0 exit condition

  li      t1, LOOP_SIZE;  # loop1 init
loop1:
  addi    t1, t1, -1;     # loop1 counter
  beqz    t1, loop1_end;  # loop1 exit condition

  li      t2, LOOP_SIZE;  # loop1 init
loop2:
  addi    t2, t2, -1;     # loop2 counter
  beqz    t2, loop2_end;  # loop2 exit condition

  addi    a0, a0, 1;      # increment output

  j loop2                 # loop loop2
loop2_end:

  j loop1                 # loop loop1
loop1_end:

  j loop0                 # loop loop0
loop0_end:

# exit
  li a0, 0;  # set exit value to 0
  jal exit;

  .data
# Data segment