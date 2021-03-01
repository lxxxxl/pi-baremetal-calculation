
arm:
	arm-none-eabi-as -mcpu=arm926ej-s -g pi_arm.S -o pi_arm.o
	arm-none-eabi-gcc -c -mcpu=arm926ej-s -g main.c -o main.o 
	arm-none-eabi-ld  -T pi_arm_linker_rules.ld main.o pi_arm.o /usr/lib/gcc/arm-none-eabi/7.3.1/hard/libgcc.a -o output.elf
	arm-none-eabi-objcopy -O binary output.elf output.bin

run_arm: arm
	qemu-system-arm -M versatilepb -m 128M -nographic -kernel output.bin

clean:
	rm pi_arm.o main.o output.elf output.bin
