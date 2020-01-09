	.file "delay.pas"
# Begin asmlist al_procedures

.section .text.n_delay_$$_delay_init,"ax"
	.balign 4
.thumb_func 
.globl	DELAY_$$_DELAY_INIT
DELAY_$$_DELAY_INIT:
.Lc2:
# [delay.pas]
# [34] begin
	push	{r14}
	sub	r13,r13,#32
# [35] SetBit(LPC_SYSCON.SYSAHBCLKCTRL, TIMER_SYSAHBCLKCTRL_BIT);
	ldr	r0,.Lj5
	ldr	r0,[r0]
	mov	r1,r0
	mov	r0,#128
	orr	r1,r0
	ldr	r0,.Lj5
	str	r1,[r0]
# [15] {$DEFINE TIMER := LPC_TMR16B0}
	mov	r1,#255
	ldr	r0,.Lj7
	str	r1,[r0]
	mov	r1,#4
	ldr	r0,.Lj8
	str	r1,[r0]
	ldr	r1,.Lj9
	ldr	r0,.Lj10
	str	r1,[r0]
# [39] end;
	add	r13,r13,#32
	pop	{r15}
.Lc1:
	.balign 4
.Lj5:
	.long	1074036864
.Lj7:
	.long	1073790976
.Lj8:
	.long	1073790996
.Lj9:
	.long	48000
.Lj10:
	.long	1073790988
.Le0:
	.size	DELAY_$$_DELAY_INIT, .Le0 - DELAY_$$_DELAY_INIT

.section .text.n_delay_$$_delay_ticks$longword,"ax"
	.balign 4
.thumb_func 
DELAY_$$_DELAY_TICKS$LONGWORD:
.Lc4:
# [42] begin
	push	{r14}
	sub	r13,r13,#40
# Var ticks located at r13+0, size=OS_32
	str	r0,[r13]
	mov	r1,#2
	ldr	r0,.Lj13
	str	r1,[r0]
	ldr	r1,[r13]
	ldr	r0,.Lj14
	str	r1,[r0]
	mov	r1,#1
	ldr	r0,.Lj13
	str	r1,[r0]
# [46] while (TIMER.TCR = 1) do;
	bl	.Lj17
.Lj16:
.Lj17:
	ldr	r0,.Lj13
	ldr	r0,[r0]
	cmp	r0,#1
	bne	.Lj20
	bl	.Lj16
.Lj20:
	bl	.Lj18
.Lj18:
# [47] end;
	add	r13,r13,#40
	pop	{r15}
.Lc3:
	.balign 4
.Lj13:
	.long	1073790980
.Lj14:
	.long	1073791000
.Le1:
	.size	DELAY_$$_DELAY_TICKS$LONGWORD, .Le1 - DELAY_$$_DELAY_TICKS$LONGWORD

.section .text.n_delay_$$_delay_us$longword,"ax"
	.balign 4
.thumb_func 
.globl	DELAY_$$_DELAY_US$LONGWORD
DELAY_$$_DELAY_US$LONGWORD:
.Lc6:
# [50] begin
	push	{r14}
	sub	r13,r13,#40
# Var time located at r13+0, size=OS_32
	str	r0,[r13]
	mov	r1,#48
	ldr	r0,.Lj23
	str	r1,[r0]
# [52] Delay_Ticks(time);
	ldr	r0,[r13]
	bl	DELAY_$$_DELAY_TICKS$LONGWORD
# [53] end;
	add	r13,r13,#40
	pop	{r15}
.Lc5:
	.balign 4
.Lj23:
	.long	1073790988
.Le2:
	.size	DELAY_$$_DELAY_US$LONGWORD, .Le2 - DELAY_$$_DELAY_US$LONGWORD

.section .text.n_delay_$$_delay_ms$longword,"ax"
	.balign 4
.thumb_func 
.globl	DELAY_$$_DELAY_MS$LONGWORD
DELAY_$$_DELAY_MS$LONGWORD:
.Lc8:
# [56] begin
	push	{r14}
	sub	r13,r13,#40
# Var time located at r13+0, size=OS_32
	str	r0,[r13]
	ldr	r1,.Lj26
	ldr	r0,.Lj27
	str	r1,[r0]
# [58] Delay_Ticks(time);
	ldr	r0,[r13]
	bl	DELAY_$$_DELAY_TICKS$LONGWORD
# [59] end;
	add	r13,r13,#40
	pop	{r15}
.Lc7:
	.balign 4
.Lj26:
	.long	48000
.Lj27:
	.long	1073790988
.Le3:
	.size	DELAY_$$_DELAY_MS$LONGWORD, .Le3 - DELAY_$$_DELAY_MS$LONGWORD
# End asmlist al_procedures
# Begin asmlist al_dwarf_frame

.section .debug_frame
.Lc9:
	.long	.Lc11-.Lc10
.Lc10:
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
.Lc11:
	.long	.Lc13-.Lc12
.Lc12:
	.long	.Lc9
	.long	.Lc2
	.long	.Lc1-.Lc2
	.balign 4,0
.Lc13:
	.long	.Lc16-.Lc15
.Lc15:
	.long	.Lc9
	.long	.Lc4
	.long	.Lc3-.Lc4
	.balign 4,0
.Lc16:
	.long	.Lc19-.Lc18
.Lc18:
	.long	.Lc9
	.long	.Lc6
	.long	.Lc5-.Lc6
	.balign 4,0
.Lc19:
	.long	.Lc22-.Lc21
.Lc21:
	.long	.Lc9
	.long	.Lc8
	.long	.Lc7-.Lc8
	.balign 4,0
.Lc22:
# End asmlist al_dwarf_frame

