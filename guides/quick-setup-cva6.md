
# Quick setup

This guide is based on the [Quick Setup](https://github.com/openhwgroup/cva6?tab=readme-ov-file#quick-setup) from [CVA6](https://github.com/openhwgroup/cva6).

## Guide:

1. Initialize all submodules.
```sh
cd ./cva6
git submodule update --init --recursive
```

2. Install the GCC Toolchain [build prerequisites](https://github.com/openhwgroup/cva6/tree/master/util/toolchain-builder#prerequisites) then [the toolchain itself](https://github.com/openhwgroup/cva6/tree/master/util/toolchain-builder#getting-started).

:warning: It is **strongly recommended** to use the toolchain built with the provided scripts.

3. Install `cmake`, version 3.14 or higher.

4. Set the RISCV environment variable.
```sh
export RISCV=~/riscv-tools
```

5. Install `help2man` and `device-tree-compiler` packages.

For Debian-based Linux distributions, run :

```sh
sudo apt-get install help2man device-tree-compiler
```

6. Install the riscv-dv requirements:

```sh
pip3 install -r verif/sim/dv/requirements.txt
```

7. Run these commands to install a custom Spike and Verilator (i.e. these versions must be used to simulate the CVA6) and [these](https://github.com/openhwgroup/cva6/tree/master#running-regression-tests-simulations) tests suites.
```sh
export DV_SIMULATORS=veri-testharness,spike
bash verif/regress/dv-riscv-arch-test.sh
```