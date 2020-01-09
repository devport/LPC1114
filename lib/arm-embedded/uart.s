	.file "uart.pas"
# Begin asmlist al_procedures

.section .text.n_uart_$$_uart_init,"ax"
	.balign 4
.thumb_func 
.globl	UART_$$_UART_INIT
UART_$$_UART_INIT:
.Lc2:
# [uart.pas]
# [28] begin
	push	{r14}
	sub	r13,r13,#32
# [29] SetBit(LPC_SYSCON.SYSAHBCLKCTRL, UART_SYSAHBCLKCTRL_BIT);
	ldr	r0,.Lj5
	ldr	r0,[r0]
	mov	r1,r0
	ldr	r0,.Lj6
	orr	r1,r0
	ldr	r0,.Lj5
	str	r1,[r0]
# [30] SetBit(LPC_SYSCON.SYSAHBCLKCTRL, IOCON_SYSAHBCLKCTRL_BIT);
	ldr	r0,.Lj5
	ldr	r0,[r0]
	mov	r1,r0
	ldr	r0,.Lj9
	orr	r1,r0
	ldr	r0,.Lj5
	str	r1,[r0]
# [32] LPC_IOCON.PIO1_6 := LPC_IOCON.PIO1_6 and $07;
	ldr	r0,.Lj11
	ldr	r0,[r0]
	mov	r1,r0
	mov	r0,#7
	and	r1,r0
	ldr	r0,.Lj11
	str	r1,[r0]
# [33] LPC_IOCON.PIO1_6 := LPC_IOCON.PIO1_6 or $01;
	ldr	r0,.Lj11
	ldr	r0,[r0]
	mov	r1,r0
	mov	r0,#1
	orr	r1,r0
	ldr	r0,.Lj11
	str	r1,[r0]
# [35] LPC_IOCON.PIO1_7 := LPC_IOCON.PIO1_7 and $07;
	ldr	r0,.Lj15
	ldr	r0,[r0]
	mov	r1,r0
	mov	r0,#7
	and	r1,r0
	ldr	r0,.Lj15
	str	r1,[r0]
# [36] LPC_IOCON.PIO1_7 := LPC_IOCON.PIO1_7 or $01;
	ldr	r0,.Lj15
	ldr	r0,[r0]
	mov	r1,r0
	mov	r0,#1
	orr	r1,r0
	ldr	r0,.Lj15
	str	r1,[r0]
# [38] LPC_SYSCON.UARTCLKDIV := $01;
	mov	r1,#1
	ldr	r0,.Lj19
	str	r1,[r0]
# [40] LPC_UART.IIR_FCR := $0700;
	ldr	r1,.Lj20
	ldr	r0,.Lj21
	str	r1,[r0]
# [42] LPC_UART.LCR := LPC_UART.LCR or $0080;// DLAB = 1;
	ldr	r0,.Lj22
	ldr	r0,[r0]
	mov	r1,r0
	mov	r0,#128
	orr	r1,r0
	ldr	r0,.Lj22
	str	r1,[r0]
# [43] LPC_UART.RBR_THR_DLL := BAUDRATEDIVISOR;
	mov	r1,#26
	ldr	r0,.Lj24
	str	r1,[r0]
# [44] LPC_UART.DLM_IER := BAUDRATEDIVISOR >> 8;
	mov	r1,#0
	ldr	r0,.Lj25
	str	r1,[r0]
# [45] LPC_UART.LCR := LPC_UART.LCR and $0080; // DLAB = 0;
	ldr	r0,.Lj22
	ldr	r0,[r0]
	mov	r1,r0
	mov	r0,#128
	and	r1,r0
	ldr	r0,.Lj22
	str	r1,[r0]
# [48] LPC_UART.LCR := $03; //8 bit word length, 1 stop bit, No parity
	mov	r1,#3
	ldr	r0,.Lj22
	str	r1,[r0]
# [55] end;
	add	r13,r13,#32
	pop	{r15}
.Lc1:
	.balign 4
.Lj5:
	.long	1074036864
.Lj6:
	.long	4096
.Lj9:
	.long	65536
.Lj11:
	.long	1074020516
.Lj15:
	.long	1074020520
.Lj19:
	.long	1074036888
.Lj20:
	.long	1792
.Lj21:
	.long	1073774600
.Lj22:
	.long	1073774604
.Lj24:
	.long	1073774592
.Lj25:
	.long	1073774596
.Le0:
	.size	UART_$$_UART_INIT, .Le0 - UART_$$_UART_INIT

.section .text.n_uart_$$_uart_send_byte$byte,"ax"
	.balign 4
.thumb_func 
.globl	UART_$$_UART_SEND_BYTE$BYTE
UART_$$_UART_SEND_BYTE$BYTE:
.Lc4:
# [58] begin
	push	{r14}
	sub	r13,r13,#40
# Var data located at r13+0, size=OS_8
	mov	r1,r13
	strb	r0,[r1]
# [59] while (LPC_UART.LSR and $20) = 0 do;
	bl	.Lj32
.Lj31:
.Lj32:
	ldr	r0,.Lj34
	ldr	r0,[r0]
	mov	r1,#32
	and	r0,r1
	cmp	r0,#0
	bne	.Lj35
	bl	.Lj31
.Lj35:
	bl	.Lj33
.Lj33:
# [60] LPC_UART.RBR_THR_DLL := data;
	mov	r0,r13
	ldrb	r1,[r0]
	ldr	r0,.Lj36
	str	r1,[r0]
# [61] end;
	add	r13,r13,#40
	pop	{r15}
.Lc3:
	.balign 4
.Lj34:
	.long	1073774612
.Lj36:
	.long	1073774592
.Le1:
	.size	UART_$$_UART_SEND_BYTE$BYTE, .Le1 - UART_$$_UART_SEND_BYTE$BYTE

.section .text.n_uart_$$_uart_send$pchar$word,"ax"
	.balign 4
.thumb_func 
.globl	UART_$$_UART_SEND$PCHAR$WORD
UART_$$_UART_SEND$PCHAR$WORD:
.Lc6:
# [66] begin
	push	{r14}
	sub	r13,r13,#40
# Var data located at r13+0, size=OS_32
# Var data_size located at r13+4, size=OS_16
# Var i located at r13+8, size=OS_8
	str	r0,[r13]
	add	r0,r13,#4
	strh	r1,[r0]
# [67] i := 1;
	mov	r1,#1
	add	r0,r13,#8
	strb	r1,[r0]
# [68] while i <= data_size do
	bl	.Lj40
.Lj39:
# [70] UART_Send_Byte(byte(data[i]));
	ldr	r1,[r13]
	add	r0,r13,#8
	ldrb	r0,[r0]
	ldrb	r0,[r1, r0]
	bl	UART_$$_UART_SEND_BYTE$BYTE
# [71] inc(i);
	add	r0,r13,#8
	ldrb	r0,[r0]
	add	r0,#1
	uxtb	r0,r0
	add	r1,r13,#8
	strb	r0,[r1]
.Lj40:
	add	r0,r13,#8
	ldrb	r1,[r0]
	add	r0,r13,#4
	ldrh	r0,[r0]
	cmp	r1,r0
	bhi	.Lj42
	bl	.Lj39
.Lj42:
	bl	.Lj41
.Lj41:
# [73] end;
	add	r13,r13,#40
	pop	{r15}
.Lc5:
.Le2:
	.size	UART_$$_UART_SEND$PCHAR$WORD, .Le2 - UART_$$_UART_SEND$PCHAR$WORD

.section .text.n_uart_$$_uart_send$ansistring,"ax"
	.balign 4
.thumb_func 
.globl	UART_$$_UART_SEND$ANSISTRING
UART_$$_UART_SEND$ANSISTRING:
.Lc8:
# [78] begin
	push	{r14}
	sub	r13,r13,#40
# Var data located at r13+0, size=OS_32
# Var i located at r13+4, size=OS_8
	str	r0,[r13]
# [79] i := 1;
	mov	r1,#1
	add	r0,r13,#4
	strb	r1,[r0]
# [80] while i <= length(data) do
	bl	.Lj46
.Lj45:
# [82] UART_Send_Byte(byte(data[i]));
	ldr	r0,[r13]
	ldr	r2,[r0]
	add	r0,r13,#4
	ldrb	r1,[r0]
	ldr	r0,.Lj48
	add	r0,r2,r0
	ldrb	r0,[r0, r1]
	bl	UART_$$_UART_SEND_BYTE$BYTE
# [83] inc(i);
	add	r0,r13,#4
	ldrb	r0,[r0]
	add	r0,#1
	uxtb	r0,r0
	add	r1,r13,#4
	strb	r0,[r1]
.Lj46:
	ldr	r0,[r13]
	ldr	r1,[r0]
	cmp	r1,#0
	bne	.Lj50
	bl	.Lj49
.Lj50:
	ldr	r0,.Lj51
	ldr	r1,[r1, r0]
.Lj49:
	add	r0,r13,#4
	ldrb	r0,[r0]
	cmp	r1,r0
	blt	.Lj52
	bl	.Lj45
.Lj52:
	bl	.Lj47
.Lj47:
# [85] end;
	add	r13,r13,#40
	pop	{r15}
.Lc7:
	.balign 4
.Lj48:
	.long	-1
.Lj51:
	.long	-4
.Le3:
	.size	UART_$$_UART_SEND$ANSISTRING, .Le3 - UART_$$_UART_SEND$ANSISTRING

.section .text.n_uart_$$_uart_recv_byte$$byte,"ax"
	.balign 4
.thumb_func 
.globl	UART_$$_UART_RECV_BYTE$$BYTE
UART_$$_UART_RECV_BYTE$$BYTE:
.Lc10:
# [88] begin
	push	{r14}
	sub	r13,r13,#40
# Var $result located at r13+0, size=OS_8
# [89] while not (LPC_UART.LSR and $01) = 0 do;
	bl	.Lj56
.Lj55:
.Lj56:
	ldr	r0,.Lj58
	ldr	r0,[r0]
	mov	r1,#1
	and	r0,r1
	mvn	r0,r0
	cmp	r0,#0
	bne	.Lj59
	bl	.Lj55
.Lj59:
	bl	.Lj57
.Lj57:
# [90] UART_Recv_Byte := LPC_UART.RBR_THR_DLL;
	ldr	r0,.Lj60
	ldrb	r1,[r0]
	mov	r0,r13
	strb	r1,[r0]
# [91] end;
	mov	r1,r13
	ldrb	r0,[r1]
	add	r13,r13,#40
	pop	{r15}
.Lc9:
	.balign 4
.Lj58:
	.long	1073774612
.Lj60:
	.long	1073774592
.Le4:
	.size	UART_$$_UART_RECV_BYTE$$BYTE, .Le4 - UART_$$_UART_RECV_BYTE$$BYTE
# End asmlist al_procedures
# Begin asmlist al_dwarf_frame

.section .debug_frame
.Lc11:
	.long	.Lc13-.Lc12
.Lc12:
	.long	-1
	.byte	1
	.byte	0
	.uleb128	1
	.sleb128	-4
	.byte	0
	.byte	12
	.uleb128	13
	.uleb128	4
	.byte	5
	.uleb128	0
	.uleb128	1
	.balign 4,0
.Lc13:
	.long	.Lc15-.Lc14
.Lc14:
	.long	.Lc11
	.long	.Lc2
	.long	.Lc1-.Lc2
	.balign 4,0
.Lc15:
	.long	.Lc18-.Lc17
.Lc17:
	.long	.Lc11
	.long	.Lc4
	.long	.Lc3-.Lc4
	.balign 4,0
.Lc18:
	.long	.Lc21-.Lc20
.Lc20:
	.long	.Lc11
	.long	.Lc6
	.long	.Lc5-.Lc6
	.balign 4,0
.Lc21:
	.long	.Lc24-.Lc23
.Lc23:
	.long	.Lc11
	.long	.Lc8
	.long	.Lc7-.Lc8
	.balign 4,0
.Lc24:
	.long	.Lc27-.Lc26
.Lc26:
	.long	.Lc11
	.long	.Lc10
	.long	.Lc9-.Lc10
	.balign 4,0
.Lc27:
# End asmlist al_dwarf_frame

