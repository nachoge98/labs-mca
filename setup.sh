#
# File: setup.sh
# Description: Script to set up environment variables for CVA6 simulation and build flow.
# Usage: Using bash, source this file while being in the root folder of "mca-labs".
#

# Modify with your paths
# Purpose: Configure riscv64-unknown-elf-gcc, fesvr, verilator, gtkwave, pip user
export RISCV=<REPLACE THIS WITH YOUR RISCV ROOT>

# No need to modify
# PATHS
export LABS_ROOT=$(pwd)
export CVA6_ROOT=$(cd "$(dirname "${BASH_SOURCE[0]}")/cva6" && pwd)
export OSS_CAD_SUITE=$LABS_ROOT/oss-cad-suite
export VERILATOR_INSTALL_DIR="$( echo "$CVA6_ROOT/tools/verilator-"*)"
export SPIKE_INSTALL_DIR=$CVA6_ROOT/spike
export LIBRARY_PATH=$RISCV/lib
export LD_LIBRARY_PATH=$RISCV/lib
export C_INCLUDE_PATH=$RISCV/include
export CPLUS_INCLUDE_PATH=$RISCV/include
export PATH=$RISCV/bin:$VERILATOR_INSTALL_DIR/bin:$PATH:$OSS_CAD_SUITE/bin:~/.local/bin