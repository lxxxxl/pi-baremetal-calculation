/* Note: QEMU model of PL011 serial port ignores the transmit
FIFO capabilities. When writing on a real SOC, the
"Transmit FIFO Full" flag must be checked in UARTFR register
before writing on the UART register*/

volatile unsigned int* const UART0 = (unsigned int*)0x0101F1000;

/* Send single char to UART */
static void uart_print_char(char chr)
{
    *UART0 = (unsigned int)(chr); /* send char to UART */
}

/* Send char array to UART */
static void uart_print(const char *str)
{
    while(*str != 0) {
        uart_print_char(*str);
        str++;
    }
}

/* Send decimal interer to UART */
static void uart_print_int(int val)
{

    int div;
    for (div = 1; div <= val; div *= 10)
        ;

    do
    {
        div /= 10;
        uart_print_char((val / div) + 0x30);
        val %= div;
    } while (val);
}

/* Main entry point */
void main()
{
    uart_print("Calculating Pi...\n");

    int r[2800 + 1];    // Array utilizes 11.2Kb in stack! Setup appropriate count of stack memory in linker script
    int i, k;
    int b, d;
    int c = 0;

    for (i = 0; i < 2800; i++) {
        r[i] = 2000;
    }

    for (k = 2800; k > 0; k -= 14) {
        d = 0;
        i = k;
        for (;;) {
            d += r[i] * 10000;
            b = 2 * i - 1;

            r[i] = d % b;
            d /= b;
            i--;
            if (i == 0) break;
            d *= i;
        }
        uart_print_int(c + d / 10000);
        c = d % 10000;
    }   
    uart_print("\nDone\n");
    uart_print("Press Ctrl+A, X to exit from QEMU\n");
}
