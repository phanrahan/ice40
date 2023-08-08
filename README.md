# Lattice ice40 FPGAs

These examples use the yosys, next-pnr, and icestorm open source tool chain.

These examples have been tested on macbooks.
All the tools should run on linux and windows.

### Yosys 

Complete setup instructions at [yosys](https://github.com/YosysHQ/yosys)

Install prerequisites:
```
$ brew install bison gawk pkg-config graphviz libftdi0 libffi tcl-tk \
  boost boost-python3 qt5 eigen libusb libusb-compat 
```

Install yosys:
```
$ brew install yosys
```

### NextPNR

Complete setup instructions at [nextpnr](https://github.com/YosysHQ/nextpnr)

Get the sources:
```
$ git clone --recursive https://github.com/YosysHQ/nextpnr.git
```

Compile and install:
```
$ cd nextpnr
$ cmake -DARCH=ice40 -DCMAKE_INSTALL_PREFIX=/usr/local .
$ make -j 4
$ sudo make install
```

### IceStorm 

Complete setup instructions at [icestorm](https://github.com/YosysHQ/icestorm)

Get the sources:
```
$ git clone https://github.com/YosysHQ/icestorm.git
```
Compile and install:
```
$ cd icestorm
$ make -j 4
$ sudo make install
```

