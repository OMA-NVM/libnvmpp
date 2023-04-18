# LibNVM++ NVM Library Support for Unikraft on MSP430FR5994

This repository contains all required sources to run a modified instance of Unikraft on the MSP430FR5994 hardware platform. The kernel is further equipped with LibNVM++. a C++ integration for easy persistent object allocation. Please refer to the demo application for the usage of the allocation library.

## Building
First, initialize all submodules by
```
```
If you want to configure, ccompile and flash the software on your own computer, several dependencies are required. To ease this setup, a Dockerfile is provided to setup the dependencies. Just run
```
./run_in_docker.sh
```
and wait for the environment to start. Afterwards switch inside the docker container to your application, e.g.
```
cd apps/app-casestudy
```
You need to configure unikraft properly by typing
```
make menuconfig
```
Select as Architecture MSP430 compatible, as Platform MSP430FR5994 and as Library allocnv. In the configuration of ukboot, select allocnv as the memory allocator to be initialized. Build the kernel subsequently with
```
make
```

## Flashing and Running

You can directly flash the compiled kernel from the docker container by typing

```
MSP430Flasher -n msp430fr5994 -w build/app-casestudy_msp430fr5994-msp430.hex -z [VCC, RESET]
```

The output will be done through the serial console. Open minicom, either from the docker container or from a seperate terminal in your host system by typing

```
minicom -D /dev/ttyACM1 -b 9600
```
For better readability, add automatic carriage returns by typing
```
Ctrl+A Z U
```