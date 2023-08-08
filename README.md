# Lattice ice40 FPGAs

These examples use the yosys, next-pnr, and icestorm open source tool chain.

Yosys 
=====

Detailed setup instructions from [yosys](https://github.com/YosysHQ/yosys)

```
$ brew install bison gawk pkg-config graphviz libftdi0 libffi tcl-tk \
  boost boost-python3 qt5 eigen libusb libusb-compat 
$ brew install yosys
```

NextPNR
=======

Follow setup instructions from [nextpnr](https://github.com/YosysHQ/nextpnr)

Get the sources:
```
$ git clone --recursive https://github.com/YosysHQ/nextpnr.git
```

NextPNR compilation and installation for Ice40 FPGAs
----------------------------------------------------
Compile and install it:
```
$ cd nextpnr
$ cmake -DARCH=ice40 -DCMAKE_INSTALL_PREFIX=/usr/local .
$ make -j 4
$ sudo make install
```

IceStorm 
========

Follow setup instructions from [icestorm](https://github.com/YosysHQ/icestorm)

```
Get the sources:
```
$ git clone https://github.com/YosysHQ/icestorm.git
```
Compile and install it:
```
$ cd icestorm
$ make -j 4
$ sudo make install

