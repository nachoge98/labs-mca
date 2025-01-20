
# Quick setup

This guide is based on the [Quick Setup](https://github.com/openhwgroup/cva6?tab=readme-ov-file#quick-setup) from [CVA6](https://github.com/openhwgroup/cva6).
This has been tested for a fresh Ubuntu 24.04 on WSL 2.

## Guide:

1. Initialize all submodules.
```sh
cd cva6
git submodule update --init --recursive
```
2. Prerequisites, run: `sudo apt update` before you continue with the next steps.
```sh
sudo apt update
sudo apt install python3-pip
sudo apt-get install autoconf automake autotools-dev curl git libmpc-dev libmpfr-dev libgmp-dev gawk build-essential bison flex texinfo gperf libtool bc zlib1g-dev
sudo apt-get install cmake
sudo apt-get install help2man device-tree-compiler
```

3. Make sure to have set the RISCV environment variable to your installation directory, i.e:
```sh
export RISCV=~/riscv-tools
```

4. Install the GCC Toolchain with the scripts included in the cva6 directory `cva6/util/toolchain-builder/`.
Run:
```sh
cd util/toolchain-builder
bash get-toolchain.sh
# The next step might take a while (~20m):
bash build-toolchain.sh $RISCV
```

7. Go back to the cva6 main directory at `labs-mca/cva6` and install the riscv-dv requirements:
```sh
cd ../..
pip3 install -r verif/sim/dv/requirements.txt
```

8. Run these commands to install a custom Spike and Verilator (i.e. these versions must be used to simulate the CVA6) and [these](https://github.com/openhwgroup/cva6/tree/master#running-regression-tests-simulations) tests suites.
```sh
export DV_SIMULATORS=veri-testharness,spike
#The first time you run a simulation Spike and Verilator will get installed, this might take a while (~15m)
bash verif/regress/dv-riscv-arch-test.sh
```