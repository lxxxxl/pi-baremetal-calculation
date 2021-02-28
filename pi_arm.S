/* ===========================================
Start up routines for bare-metal program
===========================================
*/

.global _Reset
_Reset:
B Reset_Handler /* Reset handler */
B Undefined /* Undefined mode handler */
B SWI /* Software interrupt */
B Prfetch_Abort /* Prefetch abort handler */
B Data_Abort /* Data abort handler */
B IRQ_Handler /* IRQ handler */
B FIQ_Handler /* FIQ handler */

Reset_Handler:
LDR sp, =stack_top /*set up env for main function */
BL main
B .
Undefined: /* do nothing */
B .
SWI: /* do nothing */
B .
Prfetch_Abort: /* do nothing */
B .
Data_Abort: /* do nothing */
B .
IRQ_Handler: /* do nothing */
B .
FIQ_Handler: /* do nothing */
B .

/* ------------------------------------------------------------ */

/* Note: QEMU model of PL011 serial port ignores the transmit
FIFO capabilities. When writing on a real SOC, the
"Transmit FIFO Full" flag must be checked in UARTFR register
before writing on the UART register */

UART0: 
    .long 0x101F1000

// writes string to UART
uart_write: // void uart_write(cconst char *str)
    push {r4,r5,lr}
    mov r4, r0      // str
    adr r5, UART0 // address of UART0
    ldr r5,[r5]

    // send bytes one by one from source string to UART while there is no \0 char
uart_write_loop:
        // check if it is \0 char
        ldrb r0,[r4]
        cmp r0, #0
        beq uart_write_exit
        // send data to UART
        str r0,[r5]
        // go to next char
        add r4,#1
        b uart_write_loop

uart_write_exit:
    pop {r4,r5,pc}

main:
    adr r0,str_info
    bl uart_write



str_info:
    .ascii "Press Ctrl+A, X to exit from QEMU\n"
    .byte 0
