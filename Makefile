
bootloader:
	$(CROSS_COMPILE)as -mcpu=arm926ej-s -g pi_$(ARCH).S -o pi.o
	$(CROSS_COMPILE)gcc -c -mcpu=arm926ej-s -g main.c -o main.o 
	$(CROSS_COMPILE)ld  -T pi_$(ARCH)_linker_rules.ld main.o pi.o -lgcc -L$(LD_LIBRARY_PATH) -o output.elf
	$(CROSS_COMPILE)objcopy -O binary output.elf output.bin

run: bootloader
	qemu-system-$(ARCH) -M versatilepb -m 128M -nographic -kernel output.bin

clean:
	rm pi.o main.o output.elf output.bin
