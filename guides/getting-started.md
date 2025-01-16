
# Getting Started

## About CVA6

From the [cva6 README](https://github.com/openhwgroup/cva6/blob/cb5c623e5083656fd6bead45c6a7128e891f121a/README.md):

> CVA6 is a 6-stage, single issue, in-order CPU which implements the 64-bit RISC-V instruction set. It fully implements I, M, A and C extensions as specified in Volume I: User-Level ISA V 2.3 as well as the draft privilege extension 1.10. It implements three privilege levels M, S, U to fully support a Unix-like operating system. Furthermore it is compliant to the draft external debug spec 0.13.

CVA6 is an open-source CPU core, widely used in academia and industry. It is primarily written by [Florian Zaruba](https://github.com/zarubaf), which makes its code style and organization very consistent.

## About "Labs with CVA6"

This repository includes several labs aimed at teaching advanced architecture techniques. To use this repository, you will need to:

1. Ensure you are on a Linux/WSL2 machine.
2. [Create an ssh key for GitHub](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent?platform=linux) and [add it to GitHub](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account?platform=linux).
3. Follow the [GitHub setup guide](./your-own-repo.md)

## Tool Setup

All the instructions are written expecting you to use a local Linux/WSL machine, you will need to install everything yourself.

### Local Tool Setup
1. Clone the labs repo: `git clone TBA`.

2. Clone the cva6 repo inside the [labs-mca](./../) directory:
```sh
cd labs-mca
git clone https://github.com/openhwgroup/cva6.git
```

3. Set `$RISCV` to wherever you want the tools to be installed to. i.e. run `export RISCV=~/riscv-tools`

4. To speedup the building of the tools it is recommended to set the number of threads to use, otherwise it defaults to 1.
```sh
# Use 2/3 of all available threads
export NUM_JOBS=$((($(nproc)/4)*3))
```

5. Follow the cva6 setup instructions from [Quick setup CVA6](./quick-setup-cva6.md).

6. Download and install the [OSS CAD Suite](https://github.com/YosysHQ/oss-cad-suite-build) in the [tools](./../tools/) directory. You can do this by running
```sh
cd tools
bash install_oss_cad.sh
```
or by un-taring the latest release to the [tools](./../tools/) directory.

7. Modify the following parts of the [setup.sh](./../setup.sh) file:

```bash
# Modify with your paths
export RISCV_ROOT=<REPLACE THIS WITH YOUR RISCV ROOT>
#
```

8. Source the setup file from the main [directory](./..) of the labs by running: `source ./setup.sh`.

## Regular Setup

Before starting CVA6 simulations on a new terminal session, ensure proper environment configuration by running `source setup.sh` from the main [labs-mca](./..) directory.

## Running Simulations

After setup is completed, you should be able to run CVA6 simulations. The primary way to run CVA6 simulations is to build and load an [ELF file](https://en.wikipedia.org/wiki/Executable_and_Linkable_Format). An ELF file is the standard file format used for Linux executables, so this means we can write any C/C++/RISC-V assembly program, and gcc/g++ will output a binary readable by CVA6. (You can see how the Verilog processes the ELF file [here](https://github.com/openhwgroup/cva6/blob/b44a696bbead23dafb068037eff00a90689d4faf/corev_apu/tb/ariane_tb.sv#L132-L152) and [here](https://github.com/openhwgroup/cva6/blob/b44a696bbead23dafb068037eff00a90689d4faf/corev_apu/tb/dpi/elfloader.cc)).

### Building an ELF

You can see example programs in [`"./programs/examples"`](./programs/examples). When running a simulation using the default scripts of the CVA6 repo the assembly/C code will automatically build the ELF file in the directory: `./cva6/verif/sim/out_YYYY-MM_DD/directed_tests/` with the `.o` extension.

### Running the Simulation

1. Ensure you've run `source setup.sh`
2. `export TRACE_FAST=1`
3. `bash simulate.sh /the/test/absolute/path`
4. To view the waves, run `gtkwave dump.vcd` (This should probably be done in another terminal to not interfere with running more simulations). The waveforms are dumped in the directory `./cva6/verif/sim/out_YYYY-MM_DD/veri-testharness-sim/`.
5. Navigate to **TOP.ariane_testharness.i_ariane.i_cva6** to see all the logic for the core.
6. Once you've selected all the waves necessary for your lab, be sure to save your workspace using "File->Write Save File", so next time you don't have to reopen all necessary waves again.
