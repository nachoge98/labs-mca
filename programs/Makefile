#
# File: Makefile
# Description: Makefile for compiling for CVA6.
#

AUX = -T aux/link.ld
BARE = -static -nostdlib -nostartfiles -march=rv64gc_zba_zbb_zbs_zbc -mabi=lp64d -O0
#rv64gc_zba_zbb_zbs_zbc -mabi=lp64d

ASM_CC_OPTS="-static -mcmodel=medany -fvisibility=hidden -nostdlib -nostartfiles ../tests/custom/common/syscalls.c ../tests/custom/common/crt.S -I../tests/custom/env -I../tests/custom/common"



#-march=rv64imafdc
all: clean examples/asm.elf bp/loop.elf bp/div.elf bp/spaghetti.elf vm/privilege.elf vm/os.elf rvf/fpu_example.elf

# Create .elf from .S
#riscv64-unknown-elf-gcc ${BARE} $< ${AUX} -o $@
%.o: %.S
	riscv-none-elf-gcc ${BARE} $< ${AUX} -o $@

clean:
	rm -rf *.o **/*.o
