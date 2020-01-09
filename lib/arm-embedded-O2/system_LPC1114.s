	.file "system_LPC1114.pas"
# Begin asmlist al_procedures

.section .text.n_system_lpc1114_$$_systeminit,"ax"
	.balign 4
.thumb_func 
.globl	SYSTEM_LPC1114_$$_SYSTEMINIT
SYSTEM_LPC1114_$$_SYSTEMINIT:
.Lc2:
# [system_LPC1114.pas]
# [121] begin
	push	{r14}
	sub	r13,r13,#40
# Var i located in register r0
# Var regVal located in register r0
# [123] LPC_SYSCON.SYSOSCCTRL := $00;
	mov	r1,#0
	ldr	r0,.Lj5
	str	r1,[r0]
# [124] LPC_SYSCON.PDRUNCFG := LPC_SYSCON.PDRUNCFG AND NOT (1 shl 5);
	ldr	r0,.Lj6
	ldr	r1,[r0]
# Peephole LdrMov2Ldr removed superfluous mov
	ldr	r0,.Lj7
	and	r1,r0
	ldr	r0,.Lj6
	str	r1,[r0]
# Var i located in register r0
# [126] for i := 0 to 255 do;
	ldr	r0,.Lj9
.Lj10:
	mov	r1,r0
	add	r1,#1
	mov	r0,r1
	cmp	r0,#255
	bcc	.Lj13
	bl	.Lj12
.Lj13:
	bl	.Lj10
.Lj12:
# [129] ClockSource := OSC_CLK;
	ldr	r1,.Lj14
	ldr	r0,.Lj15
	str	r1,[r0]
# [130] LPC_SYSCON.SYSPLLCLKSEL := MAIN_CLKSRCSEL_Val;
	mov	r1,#1
	ldr	r0,.Lj16
	str	r1,[r0]
# [131] LPC_SYSCON.SYSPLLCLKUEN := $01;
	mov	r1,#1
	ldr	r0,.Lj17
	str	r1,[r0]
# [132] LPC_SYSCON.SYSPLLCLKUEN := $00;
	mov	r1,#0
	ldr	r0,.Lj17
	str	r1,[r0]
# [133] LPC_SYSCON.SYSPLLCLKUEN := $01;
	mov	r1,#1
	ldr	r0,.Lj17
	str	r1,[r0]
# [134] while (LPC_SYSCON.SYSPLLCLKUEN AND $01) = 0 do; // wait until updated
	bl	.Lj21
.Lj20:
.Lj21:
	ldr	r0,.Lj17
	ldr	r0,[r0]
	mov	r1,#1
	and	r0,r1
	cmp	r0,#0
	bne	.Lj24
	bl	.Lj20
.Lj24:
	bl	.Lj22
.Lj22:
# Var regVal located in register r0
# [136] regVal := LPC_SYSCON.SYSPLLCTRL;
	ldr	r0,.Lj25
	ldr	r1,[r0]
# Peephole LdrMov2Ldr removed superfluous mov
# [137] regVal := regVal AND NOT $1FF;
	ldr	r0,.Lj26
	and	r1,r0
# Var regVal located in register r1
# [138] LPC_SYSCON.SYSPLLCTRL := (regVal OR (MAIN_PLL_P_Val shl 5) OR MAIN_PLL_M_Val);
	mov	r0,#35
	orr	r1,r0
	ldr	r0,.Lj25
	str	r1,[r0]
# [140] LPC_SYSCON.PDRUNCFG := LPC_SYSCON.PDRUNCFG AND NOT (1 shl 7);
	ldr	r0,.Lj6
	ldr	r1,[r0]
# Peephole LdrMov2Ldr removed superfluous mov
	ldr	r0,.Lj29
	and	r1,r0
	ldr	r0,.Lj6
	str	r1,[r0]
# [141] while (LPC_SYSCON.SYSPLLSTAT AND $01) = 0 do; // wait until it's locked
	bl	.Lj32
.Lj31:
.Lj32:
	ldr	r0,.Lj34
	ldr	r0,[r0]
	mov	r1,#1
	and	r0,r1
	cmp	r0,#0
	bne	.Lj35
	bl	.Lj31
.Lj35:
	bl	.Lj33
.Lj33:
# [143] LPC_SYSCON.MAINCLKSEL := $03;
	mov	r1,#3
	ldr	r0,.Lj36
	str	r1,[r0]
# [144] LPC_SYSCON.MAINCLKUEN := $01;
	mov	r1,#1
	ldr	r0,.Lj37
	str	r1,[r0]
# [145] LPC_SYSCON.MAINCLKUEN := $00;
	mov	r1,#0
	ldr	r0,.Lj37
	str	r1,[r0]
# [146] LPC_SYSCON.MAINCLKUEN := $01;
	mov	r1,#1
	ldr	r0,.Lj37
	str	r1,[r0]
# [147] while (LPC_SYSCON.MAINCLKUEN AND $01) = 0 do;  // wait until updated
	bl	.Lj41
.Lj40:
.Lj41:
	ldr	r0,.Lj37
	ldr	r0,[r0]
	mov	r1,#1
	and	r0,r1
	cmp	r0,#0
	bne	.Lj44
	bl	.Lj40
.Lj44:
	bl	.Lj42
.Lj42:
# [149] LPC_SYSCON.SYSAHBCLKDIV := SYS_AHB_DIV_Val;
	mov	r1,#1
	ldr	r0,.Lj45
	str	r1,[r0]
# [151] SystemFrequency := ClockSource * (MAIN_PLL_M_Val + 1);
	ldr	r0,.Lj15
	ldr	r0,[r0]
	lsl	r0,r0,#2
	ldr	r1,.Lj47
	str	r0,[r1]
# [153] SystemAHBFrequency := SystemFrequency div SYS_AHB_DIV_Val;
	ldr	r0,.Lj47
	ldr	r1,[r0]
	ldr	r0,.Lj49
	str	r1,[r0]
# [157] LPC_SYSCON.SYSAHBCLKCTRL := LPC_SYSCON.SYSAHBCLKCTRL OR (1 shl IOCON_SYSAHBCLKCTRL_BIT);
	ldr	r0,.Lj50
	ldr	r1,[r0]
# Peephole LdrMov2Ldr removed superfluous mov
	ldr	r0,.Lj51
	orr	r1,r0
	ldr	r0,.Lj50
	str	r1,[r0]
# [158] end;
	add	r13,r13,#40
	pop	{r15}
.Lc1:
	.balign 4
.Lj5:
	.long	1074036768
.Lj6:
	.long	1074037304
.Lj7:
	.long	-33
.Lj9:
	.long	-1
.Lj14:
	.long	12000000
.Lj15:
	.long	TC_$SYSTEM_LPC1114_$$_CLOCKSOURCE
.Lj16:
	.long	1074036800
.Lj17:
	.long	1074036804
.Lj25:
	.long	1074036744
.Lj26:
	.long	-512
.Lj29:
	.long	-129
.Lj34:
	.long	1074036748
.Lj36:
	.long	1074036848
.Lj37:
	.long	1074036852
.Lj45:
	.long	1074036856
.Lj47:
	.long	TC_$SYSTEM_LPC1114_$$_SYSTEMFREQUENCY
.Lj49:
	.long	TC_$SYSTEM_LPC1114_$$_SYSTEMAHBFREQUENCY
.Lj50:
	.long	1074036864
.Lj51:
	.long	65536
.Le0:
	.size	SYSTEM_LPC1114_$$_SYSTEMINIT, .Le0 - SYSTEM_LPC1114_$$_SYSTEMINIT

.section .text.n_system_lpc1114_$$_systick_config$longword$$longword,"ax"
	.balign 4
.thumb_func 
.globl	SYSTEM_LPC1114_$$_SYSTICK_CONFIG$LONGWORD$$LONGWORD
SYSTEM_LPC1114_$$_SYSTICK_CONFIG$LONGWORD$$LONGWORD:
.Lc4:
# [167] begin
	push	{r4,r14}
	sub	r13,r13,#40
# Var $result located in register r1
# Var ticks located in register r0
# [169] if ((ticks - 1) > SysTick_LOAD_RELOAD_Msk) then
	mov	r2,r0
	mov	r3,#0
	sub	r2,#1
	mov	r1,#0
	sbc	r3,r1
	ldr	r1,.Lj55
	mov	r4,#0
	cmp	r3,r4
	ble	.Lj58
	bl	.Lj56
.Lj58:
	bge	.Lj59
	bl	.Lj57
.Lj59:
	cmp	r2,r1
	bls	.Lj60
	bl	.Lj56
.Lj60:
	bl	.Lj57
.Lj56:
# [170] Result := 1;
	mov	r1,#1
.Lj57:
# [172] SysTick.Load :=  ticks - 1;
	mov	r1,r0
	sub	r1,#1
	ldr	r0,.Lj61
	str	r1,[r0]
# [173] SysTick.Val := 0;
	mov	r1,#0
	ldr	r0,.Lj62
	str	r1,[r0]
# [174] Systick.Ctrl := SysTick_CTRL_CLKSOURCE_Msk or
	mov	r1,#7
	ldr	r0,.Lj63
	str	r1,[r0]
# Var $result located in register r0
# [177] Result := 0;
	mov	r0,#0
# [178] end;
	add	r13,r13,#40
	pop	{r4,r15}
.Lc3:
	.balign 4
.Lj55:
	.long	16777216
.Lj61:
	.long	-536813548
.Lj62:
	.long	-536813544
.Lj63:
	.long	-536813552
.Le1:
	.size	SYSTEM_LPC1114_$$_SYSTICK_CONFIG$LONGWORD$$LONGWORD, .Le1 - SYSTEM_LPC1114_$$_SYSTICK_CONFIG$LONGWORD$$LONGWORD
# End asmlist al_procedures
# Begin asmlist al_typedconsts

.section .data.n_TC_$SYSTEM_LPC1114_$$_CLOCKSOURCE
	.balign 4
.globl	TC_$SYSTEM_LPC1114_$$_CLOCKSOURCE
TC_$SYSTEM_LPC1114_$$_CLOCKSOURCE:
	.long	4000000
# [110] SystemFrequency : longword = IRC_OSC;
.Le2:
	.size	TC_$SYSTEM_LPC1114_$$_CLOCKSOURCE, .Le2 - TC_$SYSTEM_LPC1114_$$_CLOCKSOURCE

.section .data.n_TC_$SYSTEM_LPC1114_$$_SYSTEMFREQUENCY
	.balign 4
.globl	TC_$SYSTEM_LPC1114_$$_SYSTEMFREQUENCY
TC_$SYSTEM_LPC1114_$$_SYSTEMFREQUENCY:
	.long	4000000
# [111] SystemAHBFrequency : longword = IRC_OSC;
.Le3:
	.size	TC_$SYSTEM_LPC1114_$$_SYSTEMFREQUENCY, .Le3 - TC_$SYSTEM_LPC1114_$$_SYSTEMFREQUENCY

.section .data.n_TC_$SYSTEM_LPC1114_$$_SYSTEMAHBFREQUENCY
	.balign 4
.globl	TC_$SYSTEM_LPC1114_$$_SYSTEMAHBFREQUENCY
TC_$SYSTEM_LPC1114_$$_SYSTEMAHBFREQUENCY:
	.long	4000000
# [113] implementation
.Le4:
	.size	TC_$SYSTEM_LPC1114_$$_SYSTEMAHBFREQUENCY, .Le4 - TC_$SYSTEM_LPC1114_$$_SYSTEMAHBFREQUENCY
# End asmlist al_typedconsts
# Begin asmlist al_dwarf_frame

.section .debug_frame
.Lc5:
	.long	.Lc7-.Lc6
.Lc6:
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
.Lc7:
	.long	.Lc9-.Lc8
.Lc8:
	.long	.Lc5
	.long	.Lc2
	.long	.Lc1-.Lc2
	.balign 4,0
.Lc9:
	.long	.Lc12-.Lc11
.Lc11:
	.long	.Lc5
	.long	.Lc4
	.long	.Lc3-.Lc4
	.balign 4,0
.Lc12:
# End asmlist al_dwarf_frame

