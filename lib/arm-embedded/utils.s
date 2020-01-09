	.file "utils.pas"
# Begin asmlist al_procedures

.section .text.n_utils_$$_isdigital$char$$boolean,"ax"
	.balign 4
.thumb_func 
.globl	UTILS_$$_ISDIGITAL$CHAR$$BOOLEAN
UTILS_$$_ISDIGITAL$CHAR$$BOOLEAN:
.Lc2:
# [utils.pas]
# [38] begin
	push	{r14}
	sub	r13,r13,#40
# Var c located at r13+0, size=OS_8
# Var $result located at r13+4, size=OS_8
	mov	r1,r13
	strb	r0,[r1]
# [39] Result := False;
	mov	r1,#0
	add	r0,r13,#4
	strb	r1,[r0]
# [40] if (c in ['0'..'9']) then Result := True;
	mov	r0,r13
	ldrb	r0,[r0]
	sub	r0,#48
	cmp	r0,#10
	bcs	.Lj7
	bl	.Lj5
.Lj7:
	bl	.Lj6
.Lj5:
	mov	r1,#1
	add	r0,r13,#4
	strb	r1,[r0]
.Lj6:
# [41] end;
	add	r1,r13,#4
	ldrb	r0,[r1]
	add	r13,r13,#40
	pop	{r15}
.Lc1:
.Le0:
	.size	UTILS_$$_ISDIGITAL$CHAR$$BOOLEAN, .Le0 - UTILS_$$_ISDIGITAL$CHAR$$BOOLEAN

.section .text.n_utils_$$_gettime$$longword,"ax"
	.balign 4
.thumb_func 
.globl	UTILS_$$_GETTIME$$LONGWORD
UTILS_$$_GETTIME$$LONGWORD:
.Lc4:
# [44] begin
	push	{r14}
	sub	r13,r13,#40
# Var $result located at r13+0, size=OS_32
# [45] GetTime := time;
	ldr	r0,.Lj10
	ldr	r0,[r0]
	str	r0,[r13]
# [46] end;
	ldr	r0,[r13]
	add	r13,r13,#40
	pop	{r15}
.Lc3:
	.balign 4
.Lj10:
	.long	TC_$UTILS_$$_TIME
.Le1:
	.size	UTILS_$$_GETTIME$$LONGWORD, .Le1 - UTILS_$$_GETTIME$$LONGWORD

.section .text.n_utils_$$_clearbit$longword$byte,"ax"
	.balign 4
.thumb_func 
.globl	UTILS_$$_CLEARBIT$LONGWORD$BYTE
UTILS_$$_CLEARBIT$LONGWORD$BYTE:
.Lc6:
# [49] begin
	push	{r14}
	sub	r13,r13,#40
# Var Value located at r13+0, size=OS_32
# Var Index located at r13+4, size=OS_8
	str	r0,[r13]
	add	r0,r13,#4
	strb	r1,[r0]
# [50] Value := Value and ((longword(1) shl Index) xor High(longword));
	add	r0,r13,#4
	ldrb	r0,[r0]
	mov	r2,#1
	lsl	r2,r0
	ldr	r0,.Lj13
	eor	r2,r0
	ldr	r0,[r13]
	ldr	r0,[r0]
	mov	r1,r0
	and	r1,r2
	ldr	r0,[r13]
	str	r1,[r0]
# [51] end;
	add	r13,r13,#40
	pop	{r15}
.Lc5:
	.balign 4
.Lj13:
	.long	-1
.Le2:
	.size	UTILS_$$_CLEARBIT$LONGWORD$BYTE, .Le2 - UTILS_$$_CLEARBIT$LONGWORD$BYTE

.section .text.n_utils_$$_setbit$longword$byte,"ax"
	.balign 4
.thumb_func 
.globl	UTILS_$$_SETBIT$LONGWORD$BYTE
UTILS_$$_SETBIT$LONGWORD$BYTE:
.Lc8:
# [54] begin
	push	{r14}
	sub	r13,r13,#40
# Var Value located at r13+0, size=OS_32
# Var Index located at r13+4, size=OS_8
	str	r0,[r13]
	add	r0,r13,#4
	strb	r1,[r0]
# [55] Value := Value or (longword(1) shl Index);
	add	r0,r13,#4
	ldrb	r0,[r0]
	mov	r2,#1
	lsl	r2,r0
	ldr	r0,[r13]
	ldr	r0,[r0]
	mov	r1,r0
	orr	r1,r2
	ldr	r0,[r13]
	str	r1,[r0]
# [56] end;
	add	r13,r13,#40
	pop	{r15}
.Lc7:
.Le3:
	.size	UTILS_$$_SETBIT$LONGWORD$BYTE, .Le3 - UTILS_$$_SETBIT$LONGWORD$BYTE

.section .text.n_utils_$$_inttostr$longint$$ansistring,"ax"
	.balign 4
.thumb_func 
.globl	UTILS_$$_INTTOSTR$LONGINT$$ANSISTRING
UTILS_$$_INTTOSTR$LONGINT$$ANSISTRING:
.Lc10:
# Temps allocated between r13+12 and r13+328
# [62] begin
	push	{r14}
	sub	r13,r13,#384
# Var I located at r13+0, size=OS_S32
# Var $result located at r13+4, size=OS_32
# Var S located at r13+8, size=OS_32
	str	r0,[r13, #4]
	str	r1,[r13]
	mov	r0,#0
	str	r0,[r13, #8]
	add	r2,r13,#12
	add	r1,r13,#24
	mov	r0,#1
	bl	fpc_pushexceptaddr
	bl	fpc_setjmp
	str	r0,[r13, #64]
	cmp	r0,#0
	beq	.Lj20
	bl	.Lj19
.Lj20:
# [63] Str (I, S);
	ldr	r0,.Lj22
	str	r0,[r13, #68]
	mov	r3,#255
	add	r2,r13,#72
	ldr	r1,[r13, #68]
	ldr	r0,[r13]
	bl	fpc_shortstr_sint
	add	r0,r13,#8
	mov	r2,#0
	add	r1,r13,#72
	bl	fpc_shortstr_to_ansistr
	add	r0,r13,#8
	mov	r2,#0
	mov	r1,#0
	bl	SYSTEM_$$_SETCODEPAGE$RAWBYTESTRING$WORD$BOOLEAN
# [64] Result := S;
	ldr	r1,[r13, #8]
	ldr	r0,[r13, #4]
	bl	fpc_ansistr_assign
.Lj19:
	bl	fpc_popaddrstack
# [65] end;
	add	r0,r13,#8
	bl	fpc_ansistr_decr_ref
	ldr	r0,[r13, #64]
	cmp	r0,#0
	bne	.Lj24
	bl	.Lj18
.Lj24:
	bl	fpc_reraise
	mov	r0,#0
	str	r0,[r13, #64]
	bl	.Lj19
.Lj18:
	add	r13,r13,#384
	pop	{r15}
.Lc9:
	.balign 4
.Lj22:
	.long	-1
.Le4:
	.size	UTILS_$$_INTTOSTR$LONGINT$$ANSISTRING, .Le4 - UTILS_$$_INTTOSTR$LONGINT$$ANSISTRING

.section .text.n_utils_$$_setinputs$byte$word,"ax"
	.balign 4
.thumb_func 
.globl	UTILS_$$_SETINPUTS$BYTE$WORD
UTILS_$$_SETINPUTS$BYTE$WORD:
.Lc12:
# [68] begin
	push	{r14}
	sub	r13,r13,#40
# Var Port located at r13+0, size=OS_8
# Var pins located at r13+4, size=OS_16
	mov	r2,r13
	strb	r0,[r2]
	add	r0,r13,#4
	strh	r1,[r0]
# [69] case Port of
	mov	r0,r13
	ldrb	r0,[r0]
	cmp	r0,#0
	bne	.Lj32
	bl	.Lj28
.Lj32:
	sub	r0,#1
	bne	.Lj33
	bl	.Lj29
.Lj33:
	sub	r0,#1
	bne	.Lj34
	bl	.Lj30
.Lj34:
	sub	r0,#1
	bne	.Lj35
	bl	.Lj31
.Lj35:
	bl	.Lj27
.Lj28:
# [71] case pins of
	add	r0,r13,#4
	ldrh	r1,[r0]
	ldr	r0,.Lj38
	cmp	r1,r0
	bcs	.Lj39
	bl	.Lj36
.Lj39:
	ldr	r0,.Lj38
	sub	r1,r0
	bne	.Lj41
	bl	.Lj37
.Lj41:
	bl	.Lj36
.Lj37:
# [72] GPIO_Pin_11 : LPC_IOCON.R_PIO0_11 := LPC_IOCON.R_PIO0_11 OR (1 << 0);
	ldr	r0,.Lj42
	ldr	r0,[r0]
	mov	r1,r0
	mov	r0,#1
	orr	r1,r0
	ldr	r0,.Lj42
	str	r1,[r0]
	bl	.Lj36
.Lj36:
# [74] LPC_GPIO0.DIR := LPC_GPIO0.DIR and not pins;
	add	r0,r13,#4
	ldrh	r0,[r0]
	mvn	r2,r0
	ldr	r0,.Lj44
	ldr	r0,[r0]
	mov	r1,r0
	and	r1,r2
	ldr	r0,.Lj44
	str	r1,[r0]
	bl	.Lj27
.Lj29:
# [76] 1 : LPC_GPIO1.DIR := LPC_GPIO1.DIR and not pins;
	add	r0,r13,#4
	ldrh	r0,[r0]
	mvn	r2,r0
	ldr	r0,.Lj46
	ldr	r0,[r0]
	mov	r1,r0
	and	r1,r2
	ldr	r0,.Lj46
	str	r1,[r0]
	bl	.Lj27
.Lj30:
# [77] 2 : LPC_GPIO2.DIR := LPC_GPIO2.DIR and not pins;
	add	r0,r13,#4
	ldrh	r0,[r0]
	mvn	r2,r0
	ldr	r0,.Lj48
	ldr	r0,[r0]
	mov	r1,r0
	and	r1,r2
	ldr	r0,.Lj48
	str	r1,[r0]
	bl	.Lj27
.Lj31:
# [78] 3 : LPC_GPIO3.DIR := LPC_GPIO3.DIR and not pins;
	add	r0,r13,#4
	ldrh	r0,[r0]
	mvn	r2,r0
	ldr	r0,.Lj50
	ldr	r0,[r0]
	mov	r1,r0
	and	r1,r2
	ldr	r0,.Lj50
	str	r1,[r0]
	bl	.Lj27
.Lj27:
# [80] end;
	add	r13,r13,#40
	pop	{r15}
.Lc11:
	.balign 4
.Lj38:
	.long	2048
.Lj42:
	.long	1074020468
.Lj44:
	.long	1342210048
.Lj46:
	.long	1342275584
.Lj48:
	.long	1342341120
.Lj50:
	.long	1342406656
.Le5:
	.size	UTILS_$$_SETINPUTS$BYTE$WORD, .Le5 - UTILS_$$_SETINPUTS$BYTE$WORD

.section .text.n_utils_$$_setoutputs$byte$word,"ax"
	.balign 4
.thumb_func 
.globl	UTILS_$$_SETOUTPUTS$BYTE$WORD
UTILS_$$_SETOUTPUTS$BYTE$WORD:
.Lc14:
# [83] begin
	push	{r14}
	sub	r13,r13,#40
# Var Port located at r13+0, size=OS_8
# Var pins located at r13+4, size=OS_16
	mov	r2,r13
	strb	r0,[r2]
	add	r0,r13,#4
	strh	r1,[r0]
# [84] case Port of
	mov	r0,r13
	ldrb	r0,[r0]
	cmp	r0,#0
	bne	.Lj59
	bl	.Lj55
.Lj59:
	sub	r0,#1
	bne	.Lj60
	bl	.Lj56
.Lj60:
	sub	r0,#1
	bne	.Lj61
	bl	.Lj57
.Lj61:
	sub	r0,#1
	bne	.Lj62
	bl	.Lj58
.Lj62:
	bl	.Lj54
.Lj55:
# [85] 0 : LPC_GPIO0.DIR := LPC_GPIO0.DIR or pins;
	add	r0,r13,#4
	ldrh	r1,[r0]
	ldr	r0,.Lj63
	ldr	r0,[r0]
	orr	r1,r0
	ldr	r0,.Lj63
	str	r1,[r0]
	bl	.Lj54
.Lj56:
# [87] case pins of
	add	r0,r13,#4
	ldrh	r0,[r0]
	cmp	r0,#2
	bcs	.Lj68
	bl	.Lj65
.Lj68:
	sub	r0,#2
	bne	.Lj69
	bl	.Lj66
.Lj69:
	sub	r0,#2
	bne	.Lj70
	bl	.Lj67
.Lj70:
	bl	.Lj65
.Lj66:
# [88] GPIO_Pin_1 : LPC_IOCON.R_PIO1_1 := LPC_IOCON.R_PIO1_1 OR (1 << 0);
	ldr	r0,.Lj71
	ldr	r0,[r0]
	mov	r1,r0
	mov	r0,#1
	orr	r1,r0
	ldr	r0,.Lj71
	str	r1,[r0]
	bl	.Lj65
.Lj67:
# [89] GPIO_Pin_2 : LPC_IOCON.R_PIO1_2 := LPC_IOCON.R_PIO1_2 OR (1 << 0);
	ldr	r0,.Lj73
	ldr	r0,[r0]
	mov	r1,r0
	mov	r0,#1
	orr	r1,r0
	ldr	r0,.Lj73
	str	r1,[r0]
	bl	.Lj65
.Lj65:
# [91] LPC_GPIO1.DIR := LPC_GPIO1.DIR or pins;
	add	r0,r13,#4
	ldrh	r1,[r0]
	ldr	r0,.Lj75
	ldr	r0,[r0]
	orr	r1,r0
	ldr	r0,.Lj75
	str	r1,[r0]
	bl	.Lj54
.Lj57:
# [94] case pins of
	add	r0,r13,#4
	ldrh	r0,[r0]
	cmp	r0,#8
	bcs	.Lj79
	bl	.Lj77
.Lj79:
	sub	r0,#8
	bne	.Lj80
	bl	.Lj78
.Lj80:
	bl	.Lj77
.Lj78:
# [95] GPIO_Pin_3 : LPC_IOCON.PIO2_3 := LPC_IOCON.PIO2_3 AND NOT $07;
	ldr	r0,.Lj81
	ldr	r0,[r0]
	mov	r1,r0
	ldr	r0,.Lj82
	and	r1,r0
	ldr	r0,.Lj81
	str	r1,[r0]
	bl	.Lj77
.Lj77:
# [97] LPC_GPIO2.DIR := LPC_GPIO2.DIR or pins;
	add	r0,r13,#4
	ldrh	r1,[r0]
	ldr	r0,.Lj84
	ldr	r0,[r0]
	orr	r1,r0
	ldr	r0,.Lj84
	str	r1,[r0]
	bl	.Lj54
.Lj58:
# [100] case pins of
	add	r0,r13,#4
	ldrh	r0,[r0]
	cmp	r0,#2
	bcs	.Lj88
	bl	.Lj86
.Lj88:
	sub	r0,#2
	bne	.Lj89
	bl	.Lj87
.Lj89:
	bl	.Lj86
.Lj87:
# [101] GPIO_Pin_1 : LPC_IOCON.PIO3_1 := LPC_IOCON.PIO3_1 AND NOT $07;
	ldr	r0,.Lj90
	ldr	r0,[r0]
	mov	r1,r0
	ldr	r0,.Lj82
	and	r1,r0
	ldr	r0,.Lj90
	str	r1,[r0]
	bl	.Lj86
.Lj86:
# [104] LPC_GPIO3.DIR := LPC_GPIO3.DIR or pins;
	add	r0,r13,#4
	ldrh	r1,[r0]
	ldr	r0,.Lj93
	ldr	r0,[r0]
	orr	r1,r0
	ldr	r0,.Lj93
	str	r1,[r0]
	bl	.Lj54
.Lj54:
# [107] end;
	add	r13,r13,#40
	pop	{r15}
.Lc13:
	.balign 4
.Lj63:
	.long	1342210048
.Lj71:
	.long	1074020476
.Lj73:
	.long	1074020480
.Lj75:
	.long	1342275584
.Lj81:
	.long	1074020492
.Lj82:
	.long	-8
.Lj84:
	.long	1342341120
.Lj90:
	.long	1074020488
.Lj93:
	.long	1342406656
.Le6:
	.size	UTILS_$$_SETOUTPUTS$BYTE$WORD, .Le6 - UTILS_$$_SETOUTPUTS$BYTE$WORD

.section .text.n_utils_$$_setpins$byte$word,"ax"
	.balign 4
.thumb_func 
.globl	UTILS_$$_SETPINS$BYTE$WORD
UTILS_$$_SETPINS$BYTE$WORD:
.Lc16:
# [110] begin
	push	{r14}
	sub	r13,r13,#40
# Var Port located at r13+0, size=OS_8
# Var pin located at r13+4, size=OS_16
	mov	r2,r13
	strb	r0,[r2]
	add	r0,r13,#4
	strh	r1,[r0]
# [111] case Port of
	mov	r0,r13
	ldrb	r0,[r0]
	cmp	r0,#0
	bne	.Lj102
	bl	.Lj98
.Lj102:
	sub	r0,#1
	bne	.Lj103
	bl	.Lj99
.Lj103:
	sub	r0,#1
	bne	.Lj104
	bl	.Lj100
.Lj104:
	sub	r0,#1
	bne	.Lj105
	bl	.Lj101
.Lj105:
	bl	.Lj97
.Lj98:
# [112] 0 : LPC_GPIO0.MASKED_ACCESS[pin] := pin;
	add	r0,r13,#4
	ldrh	r0,[r0]
	mov	r1,r0
	lsl	r1,r1,#2
	add	r0,r13,#4
	ldrh	r2,[r0]
	mov	r0,r1
	ldr	r1,.Lj106
	add	r0,r1
	str	r2,[r0]
	bl	.Lj97
.Lj99:
# [113] 1 : LPC_GPIO1.MASKED_ACCESS[pin] := pin;
	add	r0,r13,#4
	ldrh	r0,[r0]
	mov	r2,r0
	lsl	r2,r2,#2
	add	r0,r13,#4
	ldrh	r1,[r0]
	ldr	r0,.Lj107
	add	r0,r2
	str	r1,[r0]
	bl	.Lj97
.Lj100:
# [114] 2 : LPC_GPIO2.MASKED_ACCESS[pin] := pin;
	add	r0,r13,#4
	ldrh	r0,[r0]
	mov	r2,r0
	lsl	r2,r2,#2
	add	r0,r13,#4
	ldrh	r1,[r0]
	ldr	r0,.Lj108
	add	r0,r2
	str	r1,[r0]
	bl	.Lj97
.Lj101:
# [115] 3 : LPC_GPIO3.MASKED_ACCESS[pin] := pin;
	add	r0,r13,#4
	ldrh	r0,[r0]
	mov	r2,r0
	lsl	r2,r2,#2
	add	r0,r13,#4
	ldrh	r1,[r0]
	ldr	r0,.Lj109
	add	r0,r2
	str	r1,[r0]
	bl	.Lj97
.Lj97:
# [117] end;
	add	r13,r13,#40
	pop	{r15}
.Lc15:
	.balign 4
.Lj106:
	.long	1342177280
.Lj107:
	.long	1342242816
.Lj108:
	.long	1342308352
.Lj109:
	.long	1342373888
.Le7:
	.size	UTILS_$$_SETPINS$BYTE$WORD, .Le7 - UTILS_$$_SETPINS$BYTE$WORD

.section .text.n_utils_$$_clrpins$byte$word,"ax"
	.balign 4
.thumb_func 
.globl	UTILS_$$_CLRPINS$BYTE$WORD
UTILS_$$_CLRPINS$BYTE$WORD:
.Lc18:
# [120] begin
	push	{r14}
	sub	r13,r13,#40
# Var Port located at r13+0, size=OS_8
# Var pin located at r13+4, size=OS_16
	mov	r2,r13
	strb	r0,[r2]
	add	r0,r13,#4
	strh	r1,[r0]
# [121] case Port of
	mov	r0,r13
	ldrb	r0,[r0]
	cmp	r0,#0
	bne	.Lj117
	bl	.Lj113
.Lj117:
	sub	r0,#1
	bne	.Lj118
	bl	.Lj114
.Lj118:
	sub	r0,#1
	bne	.Lj119
	bl	.Lj115
.Lj119:
	sub	r0,#1
	bne	.Lj120
	bl	.Lj116
.Lj120:
	bl	.Lj112
.Lj113:
# [122] 0 : LPC_GPIO0.MASKED_ACCESS[pin] := 0;
	add	r0,r13,#4
	ldrh	r0,[r0]
	lsl	r0,r0,#2
	mov	r2,#0
	ldr	r1,.Lj121
	add	r0,r1
	str	r2,[r0]
	bl	.Lj112
.Lj114:
# [123] 1 : LPC_GPIO1.MASKED_ACCESS[pin] := 0;
	add	r0,r13,#4
	ldrh	r0,[r0]
	mov	r2,r0
	lsl	r2,r2,#2
	mov	r1,#0
	ldr	r0,.Lj122
	add	r0,r2
	str	r1,[r0]
	bl	.Lj112
.Lj115:
# [124] 2 : LPC_GPIO2.MASKED_ACCESS[pin] := 0;
	add	r0,r13,#4
	ldrh	r0,[r0]
	mov	r2,r0
	lsl	r2,r2,#2
	mov	r1,#0
	ldr	r0,.Lj123
	add	r0,r2
	str	r1,[r0]
	bl	.Lj112
.Lj116:
# [125] 3 : LPC_GPIO3.MASKED_ACCESS[pin] := 0;
	add	r0,r13,#4
	ldrh	r0,[r0]
	mov	r2,r0
	lsl	r2,r2,#2
	mov	r1,#0
	ldr	r0,.Lj124
	add	r0,r2
	str	r1,[r0]
	bl	.Lj112
.Lj112:
# [127] end;
	add	r13,r13,#40
	pop	{r15}
.Lc17:
	.balign 4
.Lj121:
	.long	1342177280
.Lj122:
	.long	1342242816
.Lj123:
	.long	1342308352
.Lj124:
	.long	1342373888
.Le8:
	.size	UTILS_$$_CLRPINS$BYTE$WORD, .Le8 - UTILS_$$_CLRPINS$BYTE$WORD

.section .text.n_utils_$$_pinsense$byte$word$$boolean,"ax"
	.balign 4
.thumb_func 
.globl	UTILS_$$_PINSENSE$BYTE$WORD$$BOOLEAN
UTILS_$$_PINSENSE$BYTE$WORD$$BOOLEAN:
.Lc20:
# [130] begin
	push	{r14}
	sub	r13,r13,#40
# Var Port located at r13+0, size=OS_8
# Var pin located at r13+4, size=OS_16
# Var $result located at r13+8, size=OS_8
	mov	r2,r13
	strb	r0,[r2]
	add	r0,r13,#4
	strh	r1,[r0]
# [131] Result := False;
	mov	r1,#0
	add	r0,r13,#8
	strb	r1,[r0]
# [132] case Port of
	mov	r0,r13
	ldrb	r0,[r0]
	cmp	r0,#0
	bne	.Lj132
	bl	.Lj128
.Lj132:
	sub	r0,#1
	bne	.Lj133
	bl	.Lj129
.Lj133:
	sub	r0,#1
	bne	.Lj134
	bl	.Lj130
.Lj134:
	sub	r0,#1
	bne	.Lj135
	bl	.Lj131
.Lj135:
	bl	.Lj127
.Lj128:
# [133] 0 : Result := (LPC_GPIO0.MASKED_ACCESS[pin] AND pin) = pin;
	add	r0,r13,#4
	ldrh	r0,[r0]
	mov	r1,r0
	lsl	r1,r1,#2
	add	r0,r13,#4
	ldrh	r2,[r0]
	mov	r0,r1
	ldr	r1,.Lj136
	add	r0,r1
	ldr	r0,[r0]
	mov	r1,r2
	and	r1,r0
	add	r0,r13,#4
	ldrh	r0,[r0]
	cmp	r1,r0
	beq	.Lj137
	mov	r0,#0
	b	.Lj138
.Lj137:
	mov	r0,#1
.Lj138:
	add	r1,r13,#8
	strb	r0,[r1]
	bl	.Lj127
.Lj129:
# [134] 1 : Result := (LPC_GPIO1.MASKED_ACCESS[pin] AND pin) = pin;
	add	r0,r13,#4
	ldrh	r0,[r0]
	mov	r2,r0
	lsl	r2,r2,#2
	add	r0,r13,#4
	ldrh	r1,[r0]
	ldr	r0,.Lj139
	add	r0,r2
	ldr	r0,[r0]
	and	r1,r0
	add	r0,r13,#4
	ldrh	r0,[r0]
	cmp	r1,r0
	beq	.Lj140
	mov	r0,#0
	b	.Lj141
.Lj140:
	mov	r0,#1
.Lj141:
	add	r1,r13,#8
	strb	r0,[r1]
	bl	.Lj127
.Lj130:
# [135] 2 : Result := (LPC_GPIO2.MASKED_ACCESS[pin] AND pin) = pin;
	add	r0,r13,#4
	ldrh	r0,[r0]
	mov	r2,r0
	lsl	r2,r2,#2
	add	r0,r13,#4
	ldrh	r1,[r0]
	ldr	r0,.Lj142
	add	r0,r2
	ldr	r0,[r0]
	and	r1,r0
	add	r0,r13,#4
	ldrh	r0,[r0]
	cmp	r1,r0
	beq	.Lj143
	mov	r0,#0
	b	.Lj144
.Lj143:
	mov	r0,#1
.Lj144:
	add	r1,r13,#8
	strb	r0,[r1]
	bl	.Lj127
.Lj131:
# [136] 3 : Result := (LPC_GPIO3.MASKED_ACCESS[pin] AND pin) = pin;
	add	r0,r13,#4
	ldrh	r0,[r0]
	mov	r2,r0
	lsl	r2,r2,#2
	add	r0,r13,#4
	ldrh	r1,[r0]
	ldr	r0,.Lj145
	add	r0,r2
	ldr	r0,[r0]
	and	r1,r0
	add	r0,r13,#4
	ldrh	r0,[r0]
	cmp	r1,r0
	beq	.Lj146
	mov	r0,#0
	b	.Lj147
.Lj146:
	mov	r0,#1
.Lj147:
	add	r1,r13,#8
	strb	r0,[r1]
	bl	.Lj127
.Lj127:
# [138] end;
	add	r1,r13,#8
	ldrb	r0,[r1]
	add	r13,r13,#40
	pop	{r15}
.Lc19:
	.balign 4
.Lj136:
	.long	1342177280
.Lj139:
	.long	1342242816
.Lj142:
	.long	1342308352
.Lj145:
	.long	1342373888
.Le9:
	.size	UTILS_$$_PINSENSE$BYTE$WORD$$BOOLEAN, .Le9 - UTILS_$$_PINSENSE$BYTE$WORD$$BOOLEAN
# End asmlist al_procedures
# Begin asmlist al_typedconsts

.section .data.n_TC_$UTILS_$$_TIME
	.balign 4
.globl	TC_$UTILS_$$_TIME
TC_$UTILS_$$_TIME:
	.long	1
# [32] implementation
.Le10:
	.size	TC_$UTILS_$$_TIME, .Le10 - TC_$UTILS_$$_TIME
# End asmlist al_typedconsts
# Begin asmlist al_rtti

.section .rodata.n_RTTI_$UTILS_$$_ARRAYCHAR
	.balign 4
.globl	RTTI_$UTILS_$$_ARRAYCHAR
RTTI_$UTILS_$$_ARRAYCHAR:
	.byte	21,9
# [151] 
	.ascii	"ArrayChar"
	.byte	0
	.long	0,1
	.long	RTTI_$SYSTEM_$$_CHAR$indirect
	.long	-1,0
	.byte	5
	.ascii	"Utils"
	.byte	0,0
.Le11:
	.size	RTTI_$UTILS_$$_ARRAYCHAR, .Le11 - RTTI_$UTILS_$$_ARRAYCHAR
# End asmlist al_rtti
# Begin asmlist al_indirectglobals

.section .rodata.n_RTTI_$UTILS_$$_ARRAYCHAR
	.balign 4
.globl	RTTI_$UTILS_$$_ARRAYCHAR$indirect
RTTI_$UTILS_$$_ARRAYCHAR$indirect:
	.long	RTTI_$UTILS_$$_ARRAYCHAR
.Le12:
	.size	RTTI_$UTILS_$$_ARRAYCHAR$indirect, .Le12 - RTTI_$UTILS_$$_ARRAYCHAR$indirect
# End asmlist al_indirectglobals
# Begin asmlist al_dwarf_frame

.section .debug_frame
.Lc21:
	.long	.Lc23-.Lc22
.Lc22:
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
.Lc23:
	.long	.Lc25-.Lc24
.Lc24:
	.long	.Lc21
	.long	.Lc2
	.long	.Lc1-.Lc2
	.balign 4,0
.Lc25:
	.long	.Lc28-.Lc27
.Lc27:
	.long	.Lc21
	.long	.Lc4
	.long	.Lc3-.Lc4
	.balign 4,0
.Lc28:
	.long	.Lc31-.Lc30
.Lc30:
	.long	.Lc21
	.long	.Lc6
	.long	.Lc5-.Lc6
	.balign 4,0
.Lc31:
	.long	.Lc34-.Lc33
.Lc33:
	.long	.Lc21
	.long	.Lc8
	.long	.Lc7-.Lc8
	.balign 4,0
.Lc34:
	.long	.Lc37-.Lc36
.Lc36:
	.long	.Lc21
	.long	.Lc10
	.long	.Lc9-.Lc10
	.balign 4,0
.Lc37:
	.long	.Lc40-.Lc39
.Lc39:
	.long	.Lc21
	.long	.Lc12
	.long	.Lc11-.Lc12
	.balign 4,0
.Lc40:
	.long	.Lc43-.Lc42
.Lc42:
	.long	.Lc21
	.long	.Lc14
	.long	.Lc13-.Lc14
	.balign 4,0
.Lc43:
	.long	.Lc46-.Lc45
.Lc45:
	.long	.Lc21
	.long	.Lc16
	.long	.Lc15-.Lc16
	.balign 4,0
.Lc46:
	.long	.Lc49-.Lc48
.Lc48:
	.long	.Lc21
	.long	.Lc18
	.long	.Lc17-.Lc18
	.balign 4,0
.Lc49:
	.long	.Lc52-.Lc51
.Lc51:
	.long	.Lc21
	.long	.Lc20
	.long	.Lc19-.Lc20
	.balign 4,0
.Lc52:
# End asmlist al_dwarf_frame

