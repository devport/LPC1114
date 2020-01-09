	.file "spi.pas"
# Begin asmlist al_procedures

.section .text.n_spi_$$_spi_init$byte$byte,"ax"
	.balign 4
.thumb_func 
.globl	SPI_$$_SPI_INIT$BYTE$BYTE
SPI_$$_SPI_INIT$BYTE$BYTE:
.Lc2:
# [spi.pas]
# [39] begin
	push	{r4,r14}
	sub	r13,r13,#48
# Var i located in register r2
# Var v located in register r0
	uxtb	r3,r0
# Var port located in register r3
	uxtb	r2,r1
# Var sckpin located in register r2
# Var v located in register r4
# [40] v := 0;
	mov	r4,#0
# [41] if(port = 0) then
	cmp	r3,#0
	bne	.Lj7
	bl	.Lj5
.Lj7:
	bl	.Lj6
.Lj5:
# [44] SetBit(LPC_SYSCON.PRESETCTRL, 0);
	ldr	r0,.Lj8
	ldr	r1,[r0]
# Peephole LdrMov2Ldr removed superfluous mov
	mov	r0,#1
	orr	r1,r0
	ldr	r0,.Lj8
	str	r1,[r0]
# [46] SetBit(LPC_SYSCON.SYSAHBCLKCTRL, SSP0_SYSAHBCLKCTRL_BIT);
	ldr	r0,.Lj10
	ldr	r1,[r0]
# Peephole LdrMov2Ldr removed superfluous mov
	ldr	r0,.Lj11
	orr	r1,r0
	ldr	r0,.Lj10
	str	r1,[r0]
# [47] LPC_SYSCON.SSP0CLKDIV := $02;
	mov	r1,#2
	ldr	r0,.Lj13
	str	r1,[r0]
# [50] LPC_IOCON.PIO0_8 := LPC_IOCON.PIO0_8 and not $07;
	ldr	r0,.Lj14
	ldr	r1,[r0]
# Peephole LdrMov2Ldr removed superfluous mov
	ldr	r0,.Lj15
	and	r1,r0
	ldr	r0,.Lj14
	str	r1,[r0]
# [51] LPC_IOCON.PIO0_8 := LPC_IOCON.PIO0_8 or $01;
	ldr	r0,.Lj14
	ldr	r1,[r0]
# Peephole LdrMov2Ldr removed superfluous mov
	mov	r0,#1
	orr	r1,r0
	ldr	r0,.Lj14
	str	r1,[r0]
# [53] LPC_IOCON.PIO0_9 := LPC_IOCON.PIO0_9 and not $07;
	ldr	r0,.Lj19
	ldr	r1,[r0]
# Peephole LdrMov2Ldr removed superfluous mov
	ldr	r0,.Lj15
	and	r1,r0
	ldr	r0,.Lj19
	str	r1,[r0]
# [54] LPC_IOCON.PIO0_9 := LPC_IOCON.PIO0_9 or $01;
	ldr	r0,.Lj19
	ldr	r1,[r0]
# Peephole LdrMov2Ldr removed superfluous mov
	mov	r0,#1
	orr	r1,r0
	ldr	r0,.Lj19
	str	r1,[r0]
# [58] LPC_IOCON.SCK0_LOC := sckPin;
	ldr	r0,.Lj24
	str	r2,[r0]
# [59] case sckPin of
	mov	r0,r2
	cmp	r0,#0
	bne	.Lj29
	bl	.Lj26
.Lj29:
	sub	r0,#1
	bne	.Lj30
	bl	.Lj27
.Lj30:
	sub	r0,#1
	bne	.Lj31
	bl	.Lj28
.Lj31:
	bl	.Lj25
.Lj26:
# [60] $00: LPC_IOCON.SWCLK_PIO0_10 := $02;
	mov	r1,#2
	ldr	r0,.Lj32
	str	r1,[r0]
	bl	.Lj25
.Lj27:
# [61] $01: LPC_IOCON.PIO2_11 := $01;
	mov	r1,#1
	ldr	r0,.Lj33
	str	r1,[r0]
	bl	.Lj25
.Lj28:
# [62] $02: LPC_IOCON.PIO0_6 := $02;
	mov	r1,#2
	ldr	r0,.Lj34
	str	r1,[r0]
	bl	.Lj25
.Lj25:
# [66] for i := 0 to FIFOSIZE do
	ldr	r2,.Lj35
.Lj36:
	mov	r0,r2
	add	r0,#1
	mov	r2,r0
# [67] v := LPC_SSP0.DR;
	ldr	r0,.Lj39
	ldr	r4,[r0]
	cmp	r2,#8
	bcc	.Lj40
	bl	.Lj38
.Lj40:
	bl	.Lj36
.Lj38:
# [71] LPC_SSP0.CR0 := $0707;
	ldr	r1,.Lj41
	ldr	r0,.Lj42
	str	r1,[r0]
# [73] LPC_SSP0.CPSR := $10;
	mov	r1,#16
	ldr	r0,.Lj43
	str	r1,[r0]
# [77] LPC_SSP0.CR1 := (1 << 1);
	mov	r1,#2
	ldr	r0,.Lj44
	str	r1,[r0]
	bl	.Lj45
.Lj6:
# [79] end else if (port = 1) then
	cmp	r3,#1
	bne	.Lj48
	bl	.Lj46
.Lj48:
	bl	.Lj47
.Lj46:
# [82] SetBit(LPC_SYSCON.PRESETCTRL, 2);
	ldr	r0,.Lj8
	ldr	r1,[r0]
# Peephole LdrMov2Ldr removed superfluous mov
	mov	r0,#4
	orr	r1,r0
	ldr	r0,.Lj8
	str	r1,[r0]
# [84] SetBit(LPC_SYSCON.SYSAHBCLKCTRL, SSP1_SYSAHBCLKCTRL_BIT);
	ldr	r0,.Lj10
	ldr	r1,[r0]
# Peephole LdrMov2Ldr removed superfluous mov
	ldr	r0,.Lj52
	orr	r1,r0
	ldr	r0,.Lj10
	str	r1,[r0]
# [85] LPC_SYSCON.SSP1CLKDIV := $02;
	mov	r1,#2
	ldr	r0,.Lj54
	str	r1,[r0]
# [88] LPC_IOCON.MISO1_LOC := $00;
	mov	r1,#0
	ldr	r0,.Lj55
	str	r1,[r0]
# [89] LPC_IOCON.PIO2_2 := LPC_IOCON.PIO2_2 AND NOT $07;
	ldr	r0,.Lj56
	ldr	r1,[r0]
# Peephole LdrMov2Ldr removed superfluous mov
	ldr	r0,.Lj15
	and	r1,r0
	ldr	r0,.Lj56
	str	r1,[r0]
# [90] LPC_IOCON.PIO2_2 := LPC_IOCON.PIO2_2 OR $02;
	ldr	r0,.Lj56
	ldr	r1,[r0]
# Peephole LdrMov2Ldr removed superfluous mov
	mov	r0,#2
	orr	r1,r0
	ldr	r0,.Lj56
	str	r1,[r0]
# [92] LPC_IOCON.MOSI1_LOC := $00;
	mov	r1,#0
	ldr	r0,.Lj61
	str	r1,[r0]
# [93] LPC_IOCON.PIO2_3 := LPC_IOCON.PIO2_3 AND NOT $07;
	ldr	r0,.Lj62
	ldr	r1,[r0]
# Peephole LdrMov2Ldr removed superfluous mov
	ldr	r0,.Lj15
	and	r1,r0
	ldr	r0,.Lj62
	str	r1,[r0]
# [94] LPC_IOCON.PIO2_3 := LPC_IOCON.PIO2_3 OR $02;
	ldr	r0,.Lj62
	ldr	r1,[r0]
# Peephole LdrMov2Ldr removed superfluous mov
	mov	r0,#2
	orr	r1,r0
	ldr	r0,.Lj62
	str	r1,[r0]
# [98] LPC_IOCON.SCK1_LOC := $00;
	mov	r1,#0
	ldr	r0,.Lj67
	str	r1,[r0]
# [99] LPC_IOCON.PIO2_1 := LPC_IOCON.PIO2_1 AND NOT $07;
	ldr	r0,.Lj68
	ldr	r1,[r0]
# Peephole LdrMov2Ldr removed superfluous mov
	ldr	r0,.Lj15
	and	r1,r0
	ldr	r0,.Lj68
	str	r1,[r0]
# [100] LPC_IOCON.PIO2_1 := LPC_IOCON.PIO2_1 OR $02;
	ldr	r0,.Lj68
	ldr	r1,[r0]
# Peephole LdrMov2Ldr removed superfluous mov
	mov	r0,#2
	orr	r1,r0
	ldr	r0,.Lj68
	str	r1,[r0]
# [103] for i := 0 to FIFOSIZE do
	ldr	r2,.Lj35
.Lj74:
	mov	r0,r2
	add	r0,#1
	mov	r2,r0
# [104] v := LPC_SSP1.DR;
	ldr	r0,.Lj77
	ldr	r4,[r0]
	cmp	r2,#8
	bcc	.Lj78
	bl	.Lj76
.Lj78:
	bl	.Lj74
.Lj76:
# [107] LPC_SSP1.CR0 := $0707;
	ldr	r1,.Lj41
	ldr	r0,.Lj80
	str	r1,[r0]
# [109] LPC_SSP1.CPSR := $06;
	mov	r1,#6
	ldr	r0,.Lj81
	str	r1,[r0]
# [113] LPC_SSP1.CR1 := (1 << 1);
	mov	r1,#2
	ldr	r0,.Lj82
	str	r1,[r0]
.Lj47:
.Lj45:
# [116] end;
	add	r13,r13,#48
	pop	{r4,r15}
.Lc1:
	.balign 4
.Lj8:
	.long	1074036740
.Lj10:
	.long	1074036864
.Lj11:
	.long	2048
.Lj13:
	.long	1074036884
.Lj14:
	.long	1074020448
.Lj15:
	.long	-8
.Lj19:
	.long	1074020452
.Lj24:
	.long	1074020528
.Lj32:
	.long	1074020456
.Lj33:
	.long	1074020464
.Lj34:
	.long	1074020428
.Lj35:
	.long	-1
.Lj39:
	.long	1074003976
.Lj41:
	.long	1799
.Lj42:
	.long	1074003968
.Lj43:
	.long	1074003984
.Lj44:
	.long	1074003972
.Lj52:
	.long	262144
.Lj54:
	.long	1074036892
.Lj55:
	.long	1074020552
.Lj56:
	.long	1074020444
.Lj61:
	.long	1074020556
.Lj62:
	.long	1074020492
.Lj67:
	.long	1074020548
.Lj68:
	.long	1074020392
.Lj77:
	.long	1074102280
.Lj80:
	.long	1074102272
.Lj81:
	.long	1074102288
.Lj82:
	.long	1074102276
.Le0:
	.size	SPI_$$_SPI_INIT$BYTE$BYTE, .Le0 - SPI_$$_SPI_INIT$BYTE$BYTE

.section .text.n_spi_$$_spi_write$byte$byte,"ax"
	.balign 4
.thumb_func 
.globl	SPI_$$_SPI_WRITE$BYTE$BYTE
SPI_$$_SPI_WRITE$BYTE$BYTE:
.Lc4:
# [121] begin
	push	{r4,r14}
	sub	r13,r13,#40
# Var Dummy located in register r0
	uxtb	r2,r0
# Var port located in register r2
	uxtb	r1,r1
# Var data located in register r1
# Var Dummy located in register r0
# [119] var
	ldr	r0,.Lj85
	ldr	r3,[r0]
# Var Dummy located in register r3
# Peephole LdrMov2Ldr removed superfluous mov
# [123] if(port = 0) then
	cmp	r2,#0
	bne	.Lj88
	bl	.Lj86
.Lj88:
	bl	.Lj87
.Lj86:
# [125] while (LPC_SSP0.SR AND (SSPSR_TNF OR SSPSR_BSY)) <> SSPSR_TNF do;
	bl	.Lj90
.Lj89:
.Lj90:
	ldr	r0,.Lj92
	ldr	r0,[r0]
	mov	r4,#18
	and	r0,r4
	cmp	r0,#2
	beq	.Lj93
	bl	.Lj89
.Lj93:
	bl	.Lj91
.Lj91:
# [126] LPC_SSP0.DR := data;
	ldr	r0,.Lj94
	str	r1,[r0]
# [128] while ( (LPC_SSP0.SR AND (SSPSR_BSY OR SSPSR_RNE)) <> SSPSR_RNE ) do;
	bl	.Lj96
.Lj95:
.Lj96:
	ldr	r0,.Lj92
	ldr	r0,[r0]
	mov	r4,#20
	and	r0,r4
	cmp	r0,#4
	beq	.Lj99
	bl	.Lj95
.Lj99:
	bl	.Lj97
.Lj97:
# [129] Dummy := LPC_SSP0.DR;
	ldr	r0,.Lj94
	ldr	r3,[r0]
	bl	.Lj101
.Lj87:
# [133] end else if (port = 1) then
	cmp	r2,#1
	bne	.Lj104
	bl	.Lj102
.Lj104:
	bl	.Lj103
.Lj102:
# [135] while (LPC_SSP1.SR AND (SSPSR_TNF OR SSPSR_BSY)) <> SSPSR_TNF do;
	bl	.Lj106
.Lj105:
.Lj106:
	ldr	r0,.Lj108
	ldr	r0,[r0]
	mov	r2,#18
	and	r0,r2
	cmp	r0,#2
	beq	.Lj109
	bl	.Lj105
.Lj109:
	bl	.Lj107
.Lj107:
# [136] LPC_SSP1.DR := data;
	ldr	r0,.Lj110
	str	r1,[r0]
# [138] while ( (LPC_SSP1.SR AND (SSPSR_BSY OR SSPSR_RNE)) <> SSPSR_RNE ) do;
	bl	.Lj112
.Lj111:
.Lj112:
	ldr	r0,.Lj108
	ldr	r0,[r0]
	mov	r1,#20
	and	r0,r1
	cmp	r0,#4
	beq	.Lj115
	bl	.Lj111
.Lj115:
	bl	.Lj113
.Lj113:
# [139] Dummy := LPC_SSP1.DR;
	ldr	r0,.Lj110
	ldr	r3,[r0]
.Lj103:
.Lj101:
# [145] end;
	add	r13,r13,#40
	pop	{r4,r15}
.Lc3:
	.balign 4
.Lj85:
	.long	TC_$SPI$_$SPI_WRITE$BYTE$BYTE_$$_defaultDummy
.Lj92:
	.long	1074003980
.Lj94:
	.long	1074003976
.Lj108:
	.long	1074102284
.Lj110:
	.long	1074102280
.Le1:
	.size	SPI_$$_SPI_WRITE$BYTE$BYTE, .Le1 - SPI_$$_SPI_WRITE$BYTE$BYTE

.section .text.n_spi_$$_spi_read$byte$$byte,"ax"
	.balign 4
.thumb_func 
.globl	SPI_$$_SPI_READ$BYTE$$BYTE
SPI_$$_SPI_READ$BYTE$$BYTE:
.Lc6:
# [148] begin
	push	{r14}
	sub	r13,r13,#40
# Var $result located in register r3
	uxtb	r2,r0
# Var port located in register r2
# [149] if(port = 0) then
	cmp	r2,#0
	bne	.Lj121
	bl	.Lj119
.Lj121:
	bl	.Lj120
.Lj119:
# [152] LPC_SSP0.DR := $FF;
	mov	r1,#255
	ldr	r0,.Lj122
	str	r1,[r0]
# [153] while ( (LPC_SSP0.SR AND (SSPSR_BSY OR SSPSR_RNE)) <> SSPSR_RNE ) do;
	bl	.Lj124
.Lj123:
.Lj124:
	ldr	r0,.Lj126
	ldr	r0,[r0]
	mov	r1,#20
	and	r0,r1
	cmp	r0,#4
	beq	.Lj127
	bl	.Lj123
.Lj127:
	bl	.Lj125
.Lj125:
# [157] Result := LPC_SSP0.DR;
	ldr	r0,.Lj122
	ldrb	r3,[r0]
	bl	.Lj129
.Lj120:
# [158] end else if (port = 1) then
	cmp	r2,#1
	bne	.Lj132
	bl	.Lj130
.Lj132:
	bl	.Lj131
.Lj130:
# [161] LPC_SSP1.DR := $FF;
	mov	r1,#255
	ldr	r0,.Lj133
	str	r1,[r0]
# [162] while ( (LPC_SSP1.SR AND (SSPSR_BSY OR SSPSR_RNE)) <> SSPSR_RNE ) do;
	bl	.Lj135
.Lj134:
.Lj135:
	ldr	r0,.Lj137
	ldr	r0,[r0]
	mov	r1,#20
	and	r0,r1
	cmp	r0,#4
	beq	.Lj138
	bl	.Lj134
.Lj138:
	bl	.Lj136
.Lj136:
# [166] Result := LPC_SSP1.DR;
	ldr	r0,.Lj133
	ldrb	r3,[r0]
.Lj131:
.Lj129:
# [168] end;
	uxtb	r0,r3
	add	r13,r13,#40
	pop	{r15}
.Lc5:
	.balign 4
.Lj122:
	.long	1074003976
.Lj126:
	.long	1074003980
.Lj133:
	.long	1074102280
.Lj137:
	.long	1074102284
.Le2:
	.size	SPI_$$_SPI_READ$BYTE$$BYTE, .Le2 - SPI_$$_SPI_READ$BYTE$$BYTE
# End asmlist al_procedures
# Begin asmlist al_typedconsts

.section .rodata.n_TC_$SPI$_$SPI_WRITE$BYTE$BYTE_$$_defaultDummy
	.balign 4
TC_$SPI$_$SPI_WRITE$BYTE$BYTE_$$_defaultDummy:
	.long	0
.Le3:
	.size	TC_$SPI$_$SPI_WRITE$BYTE$BYTE_$$_defaultDummy, .Le3 - TC_$SPI$_$SPI_WRITE$BYTE$BYTE_$$_defaultDummy
# End asmlist al_typedconsts
# Begin asmlist al_dwarf_frame

.section .debug_frame
.Lc7:
	.long	.Lc9-.Lc8
.Lc8:
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
.Lc9:
	.long	.Lc11-.Lc10
.Lc10:
	.long	.Lc7
	.long	.Lc2
	.long	.Lc1-.Lc2
	.balign 4,0
.Lc11:
	.long	.Lc14-.Lc13
.Lc13:
	.long	.Lc7
	.long	.Lc4
	.long	.Lc3-.Lc4
	.balign 4,0
.Lc14:
	.long	.Lc17-.Lc16
.Lc16:
	.long	.Lc7
	.long	.Lc6
	.long	.Lc5-.Lc6
	.balign 4,0
.Lc17:
# End asmlist al_dwarf_frame

