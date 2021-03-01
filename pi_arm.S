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
