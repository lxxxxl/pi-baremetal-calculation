# pi-baremetal-calculation
Program that calculates first 800 digits of Pi in bare metal  
It contains C come from [Dik T. Winter](https://crypto.stanford.edu/pbc/notes/pi/code.html) to compute the first 800 digits of Pi.  

Thanks to UNIXMANLINUXBOY for a [good bare-metal manual](https://rechtzeit.wordpress.com/2012/06/16/a-simple-bare-metal-program-arm/).  
## Prerequesties
### ARM
* ARM cross compilation toolchain with apropriate libgcc. ARM926ej-s V6 Assembly doesn't contain division functionality, so compiler will utilize functions from libgcc.  
* QEMU ARM core    
```bash
sudo apt install gcc-arm-none-eabi libgcc1-armel-cross qemu-system-arm
```
## Compilation
```bash
make CROSS_COMPILE=arm-none-eabi- 
     ARCH=arm 
     LD_LIBRARY_PATH=/usr/lib/gcc/arm-none-eabi/7.3.1/hard
```

## Run
```bash
make run
```
