/* Simple Bare metal program - linker script
*
* Note: This is written for QEMU
* QEMU loads the kernel address at 0x00010000
* The emulator starts at 0x00000000 and peripheral interrupts
* are disabled at startup.
*
* The code must be compiled and linked to be placed at
* 0x00010000
* IRQ handling can be ignored.
*
*/

ENTRY(_Reset)
SECTIONS
{
. = 0x10000;
.startup . : { pi.o(.text) }
.text : { *(.text) }
.data : { *(.data) }
.bss : { *(.bss) }
. = . + 0x4000; /* move by 16kbyte (our stack memory) */
stack_top = .;
}
