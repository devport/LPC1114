	.file "enc28j60.pas"
# Begin asmlist al_procedures

.section .text.n_enc28j60_$$_enc28j60_cs_output,"ax"
	.balign 4
.thumb_func 
.globl	ENC28J60_$$_ENC28J60_CS_OUTPUT
ENC28J60_$$_ENC28J60_CS_OUTPUT:
.Lc2:
# [enc28j60.pas]
# [267] begin
	push	{r14}
	sub	r13,r13,#32
# [268] SetOutputs(ENC28J60_CS_PORT, ENC28J60_CS_PIN);
	mov	r1,#4
	mov	r0,#0
	bl	UTILS_$$_SETOUTPUTS$BYTE$WORD
# [269] end;
	add	r13,r13,#32
	pop	{r15}
.Lc1:
.Le0:
	.size	ENC28J60_$$_ENC28J60_CS_OUTPUT, .Le0 - ENC28J60_$$_ENC28J60_CS_OUTPUT

.section .text.n_enc28j60_$$_enc28j60_cs_off,"ax"
	.balign 4
.thumb_func 
.globl	ENC28J60_$$_ENC28J60_CS_OFF
ENC28J60_$$_ENC28J60_CS_OFF:
.Lc4:
# [272] begin
	push	{r14}
	sub	r13,r13,#32
# [273] SetPins(ENC28J60_CS_PORT, ENC28J60_CS_PIN);
	mov	r1,#4
	mov	r0,#0
	bl	UTILS_$$_SETPINS$BYTE$WORD
# [274] end;
	add	r13,r13,#32
	pop	{r15}
.Lc3:
.Le1:
	.size	ENC28J60_$$_ENC28J60_CS_OFF, .Le1 - ENC28J60_$$_ENC28J60_CS_OFF

.section .text.n_enc28j60_$$_enc28j60_cs_on,"ax"
	.balign 4
.thumb_func 
.globl	ENC28J60_$$_ENC28J60_CS_ON
ENC28J60_$$_ENC28J60_CS_ON:
.Lc6:
# [277] begin
	push	{r14}
	sub	r13,r13,#32
# [278] ClrPins(ENC28J60_CS_PORT, ENC28J60_CS_PIN);
	mov	r1,#4
	mov	r0,#0
	bl	UTILS_$$_CLRPINS$BYTE$WORD
# [279] end;
	add	r13,r13,#32
	pop	{r15}
.Lc5:
.Le2:
	.size	ENC28J60_$$_ENC28J60_CS_ON, .Le2 - ENC28J60_$$_ENC28J60_CS_ON

.section .text.n_enc28j60_$$_enc28j60_readop$byte$byte$$byte,"ax"
	.balign 4
.thumb_func 
ENC28J60_$$_ENC28J60_READOP$BYTE$BYTE$$BYTE:
.Lc8:
# [284] begin
	push	{r14}
	sub	r13,r13,#40
# Var op located at r13+0, size=OS_8
# Var address located at r13+4, size=OS_8
# Var $result located at r13+8, size=OS_8
# Var data located at r13+12, size=OS_8
	mov	r2,r13
	strb	r0,[r2]
	add	r0,r13,#4
	strb	r1,[r0]
# [285] ENC28J60_CS_ON;
	bl	ENC28J60_$$_ENC28J60_CS_ON
# [286] SPI_Write(0, op OR (address AND ADDR_MASK));
	add	r0,r13,#4
	ldrb	r0,[r0]
	mov	r1,r0
	mov	r0,#31
	and	r1,r0
	mov	r0,r13
	ldrb	r0,[r0]
	orr	r0,r1
	uxtb	r0,r0
	uxtb	r1,r0
	mov	r0,#0
	bl	SPI_$$_SPI_WRITE$BYTE$BYTE
# [287] data := SPI_Read(0);
	mov	r0,#0
	bl	SPI_$$_SPI_READ$BYTE$$BYTE
	uxtb	r0,r0
	add	r1,r13,#12
	strb	r0,[r1]
# [288] if(address and $80) = $80 then
	add	r0,r13,#4
	ldrb	r0,[r0]
	mov	r1,#128
	and	r0,r1
	cmp	r0,#128
	bne	.Lj13
	bl	.Lj11
.Lj13:
	bl	.Lj12
.Lj11:
# [289] data := SPI_Read(0);
	mov	r0,#0
	bl	SPI_$$_SPI_READ$BYTE$$BYTE
	uxtb	r1,r0
	add	r0,r13,#12
	strb	r1,[r0]
.Lj12:
# [290] ENC28J60_CS_OFF;
	bl	ENC28J60_$$_ENC28J60_CS_OFF
# [291] Result := data;
	add	r0,r13,#12
	ldrb	r1,[r0]
	add	r0,r13,#8
	strb	r1,[r0]
# [292] end;
	add	r1,r13,#8
	ldrb	r0,[r1]
	add	r13,r13,#40
	pop	{r15}
.Lc7:
.Le3:
	.size	ENC28J60_$$_ENC28J60_READOP$BYTE$BYTE$$BYTE, .Le3 - ENC28J60_$$_ENC28J60_READOP$BYTE$BYTE$$BYTE

.section .text.n_enc28j60_$$_enc28j60_writeop$byte$byte$byte,"ax"
	.balign 4
.thumb_func 
ENC28J60_$$_ENC28J60_WRITEOP$BYTE$BYTE$BYTE:
.Lc10:
# [295] begin
	push	{r14}
	sub	r13,r13,#40
# Var op located at r13+0, size=OS_8
# Var address located at r13+4, size=OS_8
# Var data located at r13+8, size=OS_8
	mov	r3,r13
	strb	r0,[r3]
	add	r0,r13,#4
	strb	r1,[r0]
	add	r0,r13,#8
	strb	r2,[r0]
# [296] ENC28J60_CS_ON;
	bl	ENC28J60_$$_ENC28J60_CS_ON
# [298] SPI_Write(0, op OR (address AND ADDR_MASK));
	add	r0,r13,#4
	ldrb	r0,[r0]
	mov	r1,r0
	mov	r0,#31
	and	r1,r0
	mov	r0,r13
	ldrb	r0,[r0]
	orr	r0,r1
	uxtb	r0,r0
	uxtb	r1,r0
	mov	r0,#0
	bl	SPI_$$_SPI_WRITE$BYTE$BYTE
# [299] SPI_Write(0, data);
	add	r0,r13,#8
	ldrb	r1,[r0]
	mov	r0,#0
	bl	SPI_$$_SPI_WRITE$BYTE$BYTE
# [300] ENC28J60_CS_OFF;
	bl	ENC28J60_$$_ENC28J60_CS_OFF
# [301] end;
	add	r13,r13,#40
	pop	{r15}
.Lc9:
.Le4:
	.size	ENC28J60_$$_ENC28J60_WRITEOP$BYTE$BYTE$BYTE, .Le4 - ENC28J60_$$_ENC28J60_WRITEOP$BYTE$BYTE$BYTE

.section .text.n_enc28j60_$$_enc28j60_readbuffer$word$pbyte,"ax"
	.balign 4
.thumb_func 
ENC28J60_$$_ENC28J60_READBUFFER$WORD$PBYTE:
.Lc12:
# [304] begin
	push	{r14}
	sub	r13,r13,#40
# Var len located at r13+0, size=OS_16
# Var data located at r13+4, size=OS_32
	mov	r2,r13
	strh	r0,[r2]
	str	r1,[r13, #4]
# [305] ENC28J60_CS_ON;
	bl	ENC28J60_$$_ENC28J60_CS_ON
# [307] SPI_Write(0, ENC28J60_READ_BUF_MEM);
	mov	r1,#58
	mov	r0,#0
	bl	SPI_$$_SPI_WRITE$BYTE$BYTE
# [308] while(len > 0) do
	bl	.Lj19
.Lj18:
# [310] dec(len);
	mov	r0,r13
	ldrh	r0,[r0]
	sub	r0,#1
	uxth	r0,r0
	mov	r1,r13
	strh	r0,[r1]
# [312] data^ := SPI_Read(0);
	mov	r0,#0
	bl	SPI_$$_SPI_READ$BYTE$$BYTE
	uxtb	r1,r0
	ldr	r0,[r13, #4]
	strb	r1,[r0]
# [313] inc(data);
	ldr	r0,[r13, #4]
	add	r0,#1
	str	r0,[r13, #4]
.Lj19:
	mov	r0,r13
	ldrh	r0,[r0]
	cmp	r0,#0
	bls	.Lj21
	bl	.Lj18
.Lj21:
	bl	.Lj20
.Lj20:
# [315] data^ := $00;
	ldr	r0,[r13, #4]
	mov	r1,#0
	strb	r1,[r0]
# [316] ENC28J60_CS_OFF;
	bl	ENC28J60_$$_ENC28J60_CS_OFF
# [317] end;
	add	r13,r13,#40
	pop	{r15}
.Lc11:
.Le5:
	.size	ENC28J60_$$_ENC28J60_READBUFFER$WORD$PBYTE, .Le5 - ENC28J60_$$_ENC28J60_READBUFFER$WORD$PBYTE

.section .text.n_enc28j60_$$_enc28j60_writebuffer$word$pbyte,"ax"
	.balign 4
.thumb_func 
ENC28J60_$$_ENC28J60_WRITEBUFFER$WORD$PBYTE:
.Lc14:
# [320] begin
	push	{r14}
	sub	r13,r13,#40
# Var len located at r13+0, size=OS_16
# Var data located at r13+4, size=OS_32
	mov	r2,r13
	strh	r0,[r2]
	str	r1,[r13, #4]
# [321] ENC28J60_CS_ON;
	bl	ENC28J60_$$_ENC28J60_CS_ON
# [323] SPI_Write(0, ENC28J60_WRITE_BUF_MEM);
	mov	r1,#122
	mov	r0,#0
	bl	SPI_$$_SPI_WRITE$BYTE$BYTE
# [324] while(len > 0) do
	bl	.Lj25
.Lj24:
# [326] dec(len);
	mov	r0,r13
	ldrh	r0,[r0]
	sub	r0,#1
	uxth	r0,r0
	mov	r1,r13
	strh	r0,[r1]
# [328] SPI_Write(0, data^);
	ldr	r0,[r13, #4]
	ldrb	r1,[r0]
	mov	r0,#0
	bl	SPI_$$_SPI_WRITE$BYTE$BYTE
# [329] inc(data);
	ldr	r0,[r13, #4]
	add	r0,#1
	str	r0,[r13, #4]
.Lj25:
	mov	r0,r13
	ldrh	r0,[r0]
	cmp	r0,#0
	bls	.Lj27
	bl	.Lj24
.Lj27:
	bl	.Lj26
.Lj26:
# [331] ENC28J60_CS_OFF;
	bl	ENC28J60_$$_ENC28J60_CS_OFF
# [332] end;
	add	r13,r13,#40
	pop	{r15}
.Lc13:
.Le6:
	.size	ENC28J60_$$_ENC28J60_WRITEBUFFER$WORD$PBYTE, .Le6 - ENC28J60_$$_ENC28J60_WRITEBUFFER$WORD$PBYTE

.section .text.n_enc28j60_$$_enc28j60_setbank$byte,"ax"
	.balign 4
.thumb_func 
ENC28J60_$$_ENC28J60_SETBANK$BYTE:
.Lc16:
# [335] begin
	push	{r14}
	sub	r13,r13,#40
# Var address located at r13+0, size=OS_8
	mov	r1,r13
	strb	r0,[r1]
# [337] if((address AND BANK_MASK) <> Enc28j60Bank) then
	mov	r0,r13
	ldrb	r0,[r0]
	mov	r1,r0
	mov	r0,#96
	and	r1,r0
	ldr	r0,.Lj30
	ldrb	r0,[r0]
	cmp	r1,r0
	beq	.Lj33
	bl	.Lj31
.Lj33:
	bl	.Lj32
.Lj31:
# [340] ENC28J60_WriteOp(ENC28J60_BIT_FIELD_CLR, ECON1, (ECON1_BSEL1 OR ECON1_BSEL0));
	mov	r2,#3
	mov	r1,#31
	mov	r0,#160
	bl	ENC28J60_$$_ENC28J60_WRITEOP$BYTE$BYTE$BYTE
# [341] ENC28J60_WriteOp(ENC28J60_BIT_FIELD_SET, ECON1, ((address AND BANK_MASK) >> 5));
	mov	r0,r13
	ldrb	r0,[r0]
	mov	r1,#96
	and	r0,r1
	lsr	r0,r0,#5
	uxtb	r0,r0
	uxtb	r2,r0
	mov	r1,#31
	mov	r0,#128
	bl	ENC28J60_$$_ENC28J60_WRITEOP$BYTE$BYTE$BYTE
# [342] Enc28j60Bank := (address AND BANK_MASK);
	mov	r0,r13
	ldrb	r0,[r0]
	mov	r1,#96
	and	r0,r1
	uxtb	r1,r0
	ldr	r0,.Lj30
	strb	r1,[r0]
.Lj32:
# [345] end;
	add	r13,r13,#40
	pop	{r15}
.Lc15:
	.balign 4
.Lj30:
	.long	U_$ENC28J60_$$_ENC28J60BANK
.Le7:
	.size	ENC28J60_$$_ENC28J60_SETBANK$BYTE, .Le7 - ENC28J60_$$_ENC28J60_SETBANK$BYTE

.section .text.n_enc28j60_$$_enc28j60_read$byte$$byte,"ax"
	.balign 4
.thumb_func 
ENC28J60_$$_ENC28J60_READ$BYTE$$BYTE:
.Lc18:
# [348] begin
	push	{r14}
	sub	r13,r13,#40
# Var address located at r13+0, size=OS_8
# Var $result located at r13+4, size=OS_8
	mov	r1,r13
	strb	r0,[r1]
# [350] ENC28J60_SetBank(address);
	mov	r0,r13
	ldrb	r0,[r0]
	bl	ENC28J60_$$_ENC28J60_SETBANK$BYTE
# [352] Result := ENC28J60_ReadOp(ENC28J60_READ_CTRL_REG, address);
	mov	r0,r13
	ldrb	r1,[r0]
	mov	r0,#0
	bl	ENC28J60_$$_ENC28J60_READOP$BYTE$BYTE$$BYTE
	uxtb	r1,r0
	add	r0,r13,#4
	strb	r1,[r0]
# [353] end;
	add	r1,r13,#4
	ldrb	r0,[r1]
	add	r13,r13,#40
	pop	{r15}
.Lc17:
.Le8:
	.size	ENC28J60_$$_ENC28J60_READ$BYTE$$BYTE, .Le8 - ENC28J60_$$_ENC28J60_READ$BYTE$$BYTE

.section .text.n_enc28j60_$$_enc28j60_write$byte$byte,"ax"
	.balign 4
.thumb_func 
ENC28J60_$$_ENC28J60_WRITE$BYTE$BYTE:
.Lc20:
# [356] begin
	push	{r14}
	sub	r13,r13,#40
# Var address located at r13+0, size=OS_8
# Var data located at r13+4, size=OS_8
	mov	r2,r13
	strb	r0,[r2]
	add	r0,r13,#4
	strb	r1,[r0]
# [358] ENC28J60_SetBank(address);
	mov	r0,r13
	ldrb	r0,[r0]
	bl	ENC28J60_$$_ENC28J60_SETBANK$BYTE
# [360] ENC28J60_WriteOp(ENC28J60_WRITE_CTRL_REG, address, data);
	add	r0,r13,#4
	ldrb	r2,[r0]
	mov	r0,r13
	ldrb	r1,[r0]
	mov	r0,#64
	bl	ENC28J60_$$_ENC28J60_WRITEOP$BYTE$BYTE$BYTE
# [361] end;
	add	r13,r13,#40
	pop	{r15}
.Lc19:
.Le9:
	.size	ENC28J60_$$_ENC28J60_WRITE$BYTE$BYTE, .Le9 - ENC28J60_$$_ENC28J60_WRITE$BYTE$BYTE

.section .text.n_enc28j60_$$_enc28j60_phyread$byte$$word,"ax"
	.balign 4
.thumb_func 
ENC28J60_$$_ENC28J60_PHYREAD$BYTE$$WORD:
.Lc22:
# [366] begin
	push	{r4,r14}
	sub	r13,r13,#40
# Var address located at r13+0, size=OS_8
# Var $result located at r13+4, size=OS_16
	mov	r1,r13
	strb	r0,[r1]
# [368] ENC28J60_Write(MIREGADR, address);
	mov	r0,r13
	ldrb	r1,[r0]
	mov	r0,#212
	bl	ENC28J60_$$_ENC28J60_WRITE$BYTE$BYTE
# [369] ENC28J60_Write(MICMD, MICMD_MIIRD);
	mov	r1,#1
	mov	r0,#210
	bl	ENC28J60_$$_ENC28J60_WRITE$BYTE$BYTE
# [371] while(ENC28J60_Read(MISTAT) AND MISTAT_BUSY) = MISTAT_BUSY do;
	bl	.Lj42
.Lj41:
.Lj42:
	mov	r0,#234
	bl	ENC28J60_$$_ENC28J60_READ$BYTE$$BYTE
	uxtb	r0,r0
	mov	r1,#1
	and	r0,r1
	cmp	r0,#1
	bne	.Lj44
	bl	.Lj41
.Lj44:
	bl	.Lj43
.Lj43:
# [373] ENC28J60_Write(MICMD, $00);
	mov	r1,#0
	mov	r0,#210
	bl	ENC28J60_$$_ENC28J60_WRITE$BYTE$BYTE
# [375] Result := ((ENC28J60_Read(MIRDH)<<8) OR ENC28J60_Read(MIRDL));
	mov	r0,#217
	bl	ENC28J60_$$_ENC28J60_READ$BYTE$$BYTE
	uxtb	r4,r0
	lsl	r4,r4,#8
	mov	r0,#216
	bl	ENC28J60_$$_ENC28J60_READ$BYTE$$BYTE
	uxtb	r0,r0
	orr	r0,r4
	uxth	r1,r0
	add	r0,r13,#4
	strh	r1,[r0]
# [376] end;
	add	r1,r13,#4
	ldrh	r0,[r1]
	add	r13,r13,#40
	pop	{r4,r15}
.Lc21:
.Le10:
	.size	ENC28J60_$$_ENC28J60_PHYREAD$BYTE$$WORD, .Le10 - ENC28J60_$$_ENC28J60_PHYREAD$BYTE$$WORD

.section .text.n_enc28j60_$$_enc28j60_writeword$byte$word,"ax"
	.balign 4
.thumb_func 
ENC28J60_$$_ENC28J60_WRITEWORD$BYTE$WORD:
.Lc24:
# [379] begin
	push	{r14}
	sub	r13,r13,#40
# Var address located at r13+0, size=OS_8
# Var data located at r13+4, size=OS_16
	mov	r2,r13
	strb	r0,[r2]
	add	r0,r13,#4
	strh	r1,[r0]
# [380] ENC28J60_Write(address, data AND $ff);
	add	r0,r13,#4
	ldrh	r0,[r0]
	mov	r1,#255
	and	r0,r1
	uxtb	r0,r0
	uxtb	r1,r0
	mov	r0,r13
	ldrb	r0,[r0]
	bl	ENC28J60_$$_ENC28J60_WRITE$BYTE$BYTE
# [381] ENC28J60_Write(address + 1, data >> 8);
	add	r0,r13,#4
	ldrh	r0,[r0]
	lsr	r0,r0,#8
	uxtb	r0,r0
	uxtb	r1,r0
	mov	r0,r13
	ldrb	r0,[r0]
	add	r0,#1
	uxtb	r0,r0
	uxtb	r0,r0
	bl	ENC28J60_$$_ENC28J60_WRITE$BYTE$BYTE
# [382] end;
	add	r13,r13,#40
	pop	{r15}
.Lc23:
.Le11:
	.size	ENC28J60_$$_ENC28J60_WRITEWORD$BYTE$WORD, .Le11 - ENC28J60_$$_ENC28J60_WRITEWORD$BYTE$WORD

.section .text.n_enc28j60_$$_enc28j60_phywrite$byte$word,"ax"
	.balign 4
.thumb_func 
.globl	ENC28J60_$$_ENC28J60_PHYWRITE$BYTE$WORD
ENC28J60_$$_ENC28J60_PHYWRITE$BYTE$WORD:
.Lc26:
# [385] begin
	push	{r14}
	sub	r13,r13,#40
# Var address located at r13+0, size=OS_8
# Var data located at r13+4, size=OS_16
	mov	r2,r13
	strb	r0,[r2]
	add	r0,r13,#4
	strh	r1,[r0]
# [387] ENC28J60_Write(MIREGADR, address);
	mov	r0,r13
	ldrb	r1,[r0]
	mov	r0,#212
	bl	ENC28J60_$$_ENC28J60_WRITE$BYTE$BYTE
# [389] ENC28J60_Write(MIWRL, data);
	add	r0,r13,#4
	ldrb	r1,[r0]
	mov	r0,#214
	bl	ENC28J60_$$_ENC28J60_WRITE$BYTE$BYTE
# [390] ENC28J60_Write(MIWRH, data>>8);
	add	r0,r13,#4
	ldrh	r0,[r0]
	lsr	r0,r0,#8
	uxtb	r0,r0
	uxtb	r1,r0
	mov	r0,#215
	bl	ENC28J60_$$_ENC28J60_WRITE$BYTE$BYTE
# [392] while(ENC28J60_Read(MISTAT) AND MISTAT_BUSY) = MISTAT_BUSY do
	bl	.Lj50
.Lj49:
# [393] Delay_US(10); // 10us
	mov	r0,#10
	bl	DELAY_$$_DELAY_US$LONGWORD
.Lj50:
	mov	r0,#234
	bl	ENC28J60_$$_ENC28J60_READ$BYTE$$BYTE
	uxtb	r0,r0
	mov	r1,#1
	and	r0,r1
	cmp	r0,#1
	bne	.Lj52
	bl	.Lj49
.Lj52:
	bl	.Lj51
.Lj51:
# [394] end;
	add	r13,r13,#40
	pop	{r15}
.Lc25:
.Le12:
	.size	ENC28J60_$$_ENC28J60_PHYWRITE$BYTE$WORD, .Le12 - ENC28J60_$$_ENC28J60_PHYWRITE$BYTE$WORD

.section .text.n_enc28j60_$$_enc28j60_getrev$$byte,"ax"
	.balign 4
.thumb_func 
.globl	ENC28J60_$$_ENC28J60_GETREV$$BYTE
ENC28J60_$$_ENC28J60_GETREV$$BYTE:
.Lc28:
# [401] begin
	push	{r14}
	sub	r13,r13,#40
# Var $result located at r13+0, size=OS_8
# Var rev located at r13+4, size=OS_8
# [402] rev := ENC28J60_Read(EREVID);
	mov	r0,#114
	bl	ENC28J60_$$_ENC28J60_READ$BYTE$$BYTE
	uxtb	r1,r0
	add	r0,r13,#4
	strb	r1,[r0]
# [407] if (rev>5) then inc(rev);
	add	r0,r13,#4
	ldrb	r0,[r0]
	cmp	r0,#5
	bls	.Lj57
	bl	.Lj55
.Lj57:
	bl	.Lj56
.Lj55:
	add	r0,r13,#4
	ldrb	r0,[r0]
	add	r0,#1
	uxtb	r0,r0
	add	r1,r13,#4
	strb	r0,[r1]
.Lj56:
# [408] Result := rev;
	add	r0,r13,#4
	ldrb	r0,[r0]
	mov	r1,r13
	strb	r0,[r1]
# [409] end;
	mov	r1,r13
	ldrb	r0,[r1]
	add	r13,r13,#40
	pop	{r15}
.Lc27:
.Le13:
	.size	ENC28J60_$$_ENC28J60_GETREV$$BYTE, .Le13 - ENC28J60_$$_ENC28J60_GETREV$$BYTE

.section .text.n_enc28j60_$$_enc28j60linkup$$word,"ax"
	.balign 4
.thumb_func 
.globl	ENC28J60_$$_ENC28J60LINKUP$$WORD
ENC28J60_$$_ENC28J60LINKUP$$WORD:
.Lc30:
# [412] begin
	push	{r14}
	sub	r13,r13,#40
# Var $result located at r13+0, size=OS_16
# [414] Result := ((ENC28J60_PhyRead(PHSTAT2) AND $0400) >> 10);
	mov	r0,#17
	bl	ENC28J60_$$_ENC28J60_PHYREAD$BYTE$$WORD
	uxth	r1,r0
	ldr	r0,.Lj60
	and	r1,r0
	lsr	r1,r1,#10
	uxth	r0,r1
	mov	r1,r13
	strh	r0,[r1]
# [415] end;
	mov	r1,r13
	ldrh	r0,[r1]
	add	r13,r13,#40
	pop	{r15}
.Lc29:
	.balign 4
.Lj60:
	.long	1024
.Le14:
	.size	ENC28J60_$$_ENC28J60LINKUP$$WORD, .Le14 - ENC28J60_$$_ENC28J60LINKUP$$WORD

.section .text.n_enc28j60_$$_enc28j60_init$pbyte,"ax"
	.balign 4
.thumb_func 
.globl	ENC28J60_$$_ENC28J60_INIT$PBYTE
ENC28J60_$$_ENC28J60_INIT$PBYTE:
.Lc32:
# [418] begin
	push	{r14}
	sub	r13,r13,#40
# Var macaddr located at r13+0, size=OS_32
	str	r0,[r13]
# [421] ENC28J60_CS_OUTPUT;
	bl	ENC28J60_$$_ENC28J60_CS_OUTPUT
# [422] ENC28J60_CS_ON; // ss=0
	bl	ENC28J60_$$_ENC28J60_CS_ON
# [425] ENC28J60_WriteOp(ENC28J60_SOFT_RESET, 0, ENC28J60_SOFT_RESET);
	mov	r2,#255
	mov	r1,#0
	mov	r0,#255
	bl	ENC28J60_$$_ENC28J60_WRITEOP$BYTE$BYTE$BYTE
# [426] Delay_MS(1); // 1ms
	mov	r0,#1
	bl	DELAY_$$_DELAY_MS$LONGWORD
# [434] gNextPacketPtr := RXSTART_INIT;
	mov	r1,#0
	ldr	r0,.Lj63
	strh	r1,[r0]
# [436] ENC28J60_Write(ERXSTL, RXSTART_INIT AND $FF);
	mov	r1,#0
	mov	r0,#8
	bl	ENC28J60_$$_ENC28J60_WRITE$BYTE$BYTE
# [437] ENC28J60_Write(ERXSTH, RXSTART_INIT>>8);
	mov	r1,#0
	mov	r0,#9
	bl	ENC28J60_$$_ENC28J60_WRITE$BYTE$BYTE
# [439] ENC28J60_Write(ERXRDPTL, RXSTART_INIT AND $FF);
	mov	r1,#0
	mov	r0,#12
	bl	ENC28J60_$$_ENC28J60_WRITE$BYTE$BYTE
# [440] ENC28J60_Write(ERXRDPTH, RXSTART_INIT>>8);
	mov	r1,#0
	mov	r0,#13
	bl	ENC28J60_$$_ENC28J60_WRITE$BYTE$BYTE
# [442] ENC28J60_Write(ERXNDL, RXSTOP_INIT AND $FF);
	mov	r1,#254
	mov	r0,#10
	bl	ENC28J60_$$_ENC28J60_WRITE$BYTE$BYTE
# [443] ENC28J60_Write(ERXNDH, RXSTOP_INIT>>8);
	mov	r1,#25
	mov	r0,#11
	bl	ENC28J60_$$_ENC28J60_WRITE$BYTE$BYTE
# [445] ENC28J60_Write(ETXSTL, TXSTART_INIT AND $FF);
	mov	r1,#255
	mov	r0,#4
	bl	ENC28J60_$$_ENC28J60_WRITE$BYTE$BYTE
# [446] ENC28J60_Write(ETXSTH, TXSTART_INIT>>8);
	mov	r1,#25
	mov	r0,#5
	bl	ENC28J60_$$_ENC28J60_WRITE$BYTE$BYTE
# [448] ENC28J60_Write(ETXNDL, TXSTOP_INIT AND $FF);
	mov	r1,#255
	mov	r0,#6
	bl	ENC28J60_$$_ENC28J60_WRITE$BYTE$BYTE
# [449] ENC28J60_Write(ETXNDH, TXSTOP_INIT>>8);
	mov	r1,#31
	mov	r0,#7
	bl	ENC28J60_$$_ENC28J60_WRITE$BYTE$BYTE
# [460] ENC28J60_Write(ERXFCON, ERXFCON_UCEN OR ERXFCON_CRCEN OR ERXFCON_PMEN);
	mov	r1,#176
	mov	r0,#56
	bl	ENC28J60_$$_ENC28J60_WRITE$BYTE$BYTE
# [461] ENC28J60_Write(EPMM0, $3f);
	mov	r1,#63
	mov	r0,#40
	bl	ENC28J60_$$_ENC28J60_WRITE$BYTE$BYTE
# [462] ENC28J60_Write(EPMM1, $30);
	mov	r1,#48
	mov	r0,#41
	bl	ENC28J60_$$_ENC28J60_WRITE$BYTE$BYTE
# [463] ENC28J60_Write(EPMCSL, $f9);
	mov	r1,#249
	mov	r0,#48
	bl	ENC28J60_$$_ENC28J60_WRITE$BYTE$BYTE
# [464] ENC28J60_Write(EPMCSH, $f7);
	mov	r1,#247
	mov	r0,#49
	bl	ENC28J60_$$_ENC28J60_WRITE$BYTE$BYTE
# [469] ENC28J60_Write(MACON1, MACON1_MARXEN OR MACON1_TXPAUS OR MACON1_RXPAUS);
	mov	r1,#13
	mov	r0,#192
	bl	ENC28J60_$$_ENC28J60_WRITE$BYTE$BYTE
# [471] ENC28J60_Write(MACON2, $00);
	mov	r1,#0
	mov	r0,#193
	bl	ENC28J60_$$_ENC28J60_WRITE$BYTE$BYTE
# [473] ENC28J60_WriteOp(ENC28J60_BIT_FIELD_SET, MACON3, MACON3_PADCFG0 OR MACON3_TXCRCEN OR MACON3_FRMLNEN);// MACON3_PADCFG0
	mov	r2,#50
	mov	r1,#194
	mov	r0,#128
	bl	ENC28J60_$$_ENC28J60_WRITEOP$BYTE$BYTE$BYTE
# [475] ENC28J60_Write(MAIPGL, $12);
	mov	r1,#18
	mov	r0,#198
	bl	ENC28J60_$$_ENC28J60_WRITE$BYTE$BYTE
# [476] ENC28J60_Write(MAIPGH, $0C);
	mov	r1,#12
	mov	r0,#199
	bl	ENC28J60_$$_ENC28J60_WRITE$BYTE$BYTE
# [478] ENC28J60_Write(MABBIPG, $12);
	mov	r1,#18
	mov	r0,#196
	bl	ENC28J60_$$_ENC28J60_WRITE$BYTE$BYTE
# [481] ENC28J60_Write(MAMXFLL, MAX_FRAMELEN AND $FF);
	mov	r1,#220
	mov	r0,#202
	bl	ENC28J60_$$_ENC28J60_WRITE$BYTE$BYTE
# [482] ENC28J60_Write(MAMXFLH, MAX_FRAMELEN>>8);
	mov	r1,#5
	mov	r0,#203
	bl	ENC28J60_$$_ENC28J60_WRITE$BYTE$BYTE
# [486] ENC28J60_Write(MAADR5, macaddr^);
	ldr	r0,[r13]
	ldrb	r1,[r0]
	mov	r0,#228
	bl	ENC28J60_$$_ENC28J60_WRITE$BYTE$BYTE
# [487] ENC28J60_Write(MAADR4, (macaddr+1)^);
	ldr	r0,[r13]
	ldrb	r1,[r0, #1]
	mov	r0,#229
	bl	ENC28J60_$$_ENC28J60_WRITE$BYTE$BYTE
# [488] ENC28J60_Write(MAADR3, (macaddr+2)^);
	ldr	r0,[r13]
	ldrb	r1,[r0, #2]
	mov	r0,#226
	bl	ENC28J60_$$_ENC28J60_WRITE$BYTE$BYTE
# [489] ENC28J60_Write(MAADR2, (macaddr+3)^);
	ldr	r0,[r13]
	ldrb	r1,[r0, #3]
	mov	r0,#227
	bl	ENC28J60_$$_ENC28J60_WRITE$BYTE$BYTE
# [490] ENC28J60_Write(MAADR1, (macaddr+4)^);
	ldr	r0,[r13]
	ldrb	r1,[r0, #4]
	mov	r0,#224
	bl	ENC28J60_$$_ENC28J60_WRITE$BYTE$BYTE
# [491] ENC28J60_Write(MAADR0, (macaddr+5)^);
	ldr	r0,[r13]
	ldrb	r1,[r0, #5]
	mov	r0,#225
	bl	ENC28J60_$$_ENC28J60_WRITE$BYTE$BYTE
# [493] ENC28J60_PhyWrite(PHCON2, PHCON2_HDLDIS);
	ldr	r1,.Lj64
	mov	r0,#16
	bl	ENC28J60_$$_ENC28J60_PHYWRITE$BYTE$WORD
# [495] ENC28J60_SetBank(ECON1);
	mov	r0,#31
	bl	ENC28J60_$$_ENC28J60_SETBANK$BYTE
# [497] ENC28J60_WriteOp(ENC28J60_BIT_FIELD_SET, EIE, EIE_INTIE OR EIE_PKTIE);
	mov	r2,#192
	mov	r1,#27
	mov	r0,#128
	bl	ENC28J60_$$_ENC28J60_WRITEOP$BYTE$BYTE$BYTE
# [499] ENC28J60_WriteOp(ENC28J60_BIT_FIELD_SET, ECON1, ECON1_RXEN);
	mov	r2,#4
	mov	r1,#31
	mov	r0,#128
	bl	ENC28J60_$$_ENC28J60_WRITEOP$BYTE$BYTE$BYTE
# [500] end;
	add	r13,r13,#40
	pop	{r15}
.Lc31:
	.balign 4
.Lj63:
	.long	U_$ENC28J60_$$_GNEXTPACKETPTR
.Lj64:
	.long	256
.Le15:
	.size	ENC28J60_$$_ENC28J60_INIT$PBYTE, .Le15 - ENC28J60_$$_ENC28J60_INIT$PBYTE

.section .text.n_enc28j60_$$_enc28j60packetreceive$word$pbyte$$word,"ax"
	.balign 4
.thumb_func 
.globl	ENC28J60_$$_ENC28J60PACKETRECEIVE$WORD$PBYTE$$WORD
ENC28J60_$$_ENC28J60PACKETRECEIVE$WORD$PBYTE$$WORD:
.Lc34:
# [505] begin
	push	{r4,r14}
	sub	r13,r13,#48
# Var maxlen located at r13+0, size=OS_16
# Var packet located at r13+4, size=OS_32
# Var $result located at r13+8, size=OS_16
# Var len located at r13+12, size=OS_16
# Var rxstat located at r13+16, size=OS_16
	mov	r2,r13
	strh	r0,[r2]
	str	r1,[r13, #4]
# [506] if(UnreleasedPacket = 1) then
	ldr	r0,.Lj67
	ldrb	r0,[r0]
	cmp	r0,#1
	bne	.Lj70
	bl	.Lj68
.Lj70:
	bl	.Lj69
.Lj68:
# [508] if (gNextPacketPtr = 0) then
	ldr	r0,.Lj71
	ldrh	r0,[r0]
	cmp	r0,#0
	bne	.Lj74
	bl	.Lj72
.Lj74:
	bl	.Lj73
.Lj72:
# [510] ENC28J60_Write(ERXRDPTL, (RXSTOP_INIT AND $FF));
	mov	r1,#254
	mov	r0,#12
	bl	ENC28J60_$$_ENC28J60_WRITE$BYTE$BYTE
# [511] ENC28J60_Write(ERXRDPTH, (RXSTOP_INIT) >> 8);
	mov	r1,#25
	mov	r0,#13
	bl	ENC28J60_$$_ENC28J60_WRITE$BYTE$BYTE
	bl	.Lj75
.Lj73:
# [514] ENC28J60_Write(ERXRDPTL, (gNextPacketPtr-1) AND $FF);
	ldr	r0,.Lj71
	ldrh	r0,[r0]
	sub	r0,#1
	mov	r1,#255
	and	r0,r1
	uxtb	r0,r0
	uxtb	r1,r0
	mov	r0,#12
	bl	ENC28J60_$$_ENC28J60_WRITE$BYTE$BYTE
# [515] ENC28J60_Write(ERXRDPTH, (gNextPacketPtr-1) >> 8);
	ldr	r0,.Lj71
	ldrh	r0,[r0]
	sub	r0,#1
	lsr	r0,r0,#8
	uxtb	r0,r0
	uxtb	r1,r0
	mov	r0,#13
	bl	ENC28J60_$$_ENC28J60_WRITE$BYTE$BYTE
.Lj75:
# [518] UnreleasedPacket := 0;
	mov	r1,#0
	ldr	r0,.Lj67
	strb	r1,[r0]
.Lj69:
# [521] if( ENC28J60_Read(EPKTCNT) > 0 ) then
	mov	r0,#57
	bl	ENC28J60_$$_ENC28J60_READ$BYTE$$BYTE
	uxtb	r0,r0
	cmp	r0,#0
	bls	.Lj81
	bl	.Lj79
.Lj81:
	bl	.Lj80
.Lj79:
# [525] ENC28J60_Write(ERDPTL, (gNextPacketPtr AND $FF));
	ldr	r0,.Lj71
	ldrh	r0,[r0]
	mov	r1,#255
	and	r0,r1
	uxtb	r0,r0
	uxtb	r1,r0
	mov	r0,#0
	bl	ENC28J60_$$_ENC28J60_WRITE$BYTE$BYTE
# [526] ENC28J60_Write(ERDPTH, (gNextPacketPtr) >> 8);
	ldr	r0,.Lj71
	ldrh	r0,[r0]
	lsr	r0,r0,#8
	uxtb	r0,r0
	uxtb	r1,r0
	mov	r0,#1
	bl	ENC28J60_$$_ENC28J60_WRITE$BYTE$BYTE
# [529] gNextPacketPtr := ENC28J60_ReadOp(ENC28J60_READ_BUF_MEM, 0);
	mov	r1,#0
	mov	r0,#58
	bl	ENC28J60_$$_ENC28J60_READOP$BYTE$BYTE$$BYTE
	uxtb	r1,r0
	ldr	r0,.Lj71
	strh	r1,[r0]
# [530] gNextPacketPtr := gNextPacketPtr OR ENC28J60_ReadOp(ENC28J60_READ_BUF_MEM, 0)<<8;
	ldr	r0,.Lj71
	ldrh	r4,[r0]
	mov	r1,#0
	mov	r0,#58
	bl	ENC28J60_$$_ENC28J60_READOP$BYTE$BYTE$$BYTE
	uxtb	r0,r0
	lsl	r0,r0,#8
	orr	r0,r4
	uxth	r1,r0
	ldr	r0,.Lj71
	strh	r1,[r0]
# [532] len := ENC28J60_ReadOp(ENC28J60_READ_BUF_MEM, 0);
	mov	r1,#0
	mov	r0,#58
	bl	ENC28J60_$$_ENC28J60_READOP$BYTE$BYTE$$BYTE
	uxtb	r1,r0
	add	r0,r13,#12
	strh	r1,[r0]
# [533] len := len OR (ENC28J60_ReadOp(ENC28J60_READ_BUF_MEM, 0)<<8);
	add	r0,r13,#12
	ldrh	r4,[r0]
	mov	r1,#0
	mov	r0,#58
	bl	ENC28J60_$$_ENC28J60_READOP$BYTE$BYTE$$BYTE
	uxtb	r0,r0
	lsl	r0,r0,#8
	orr	r0,r4
	uxth	r1,r0
	add	r0,r13,#12
	strh	r1,[r0]
# [534] len := len - 4; //remove the CRC count
	add	r0,r13,#12
	ldrh	r0,[r0]
	sub	r0,#4
	uxth	r0,r0
	add	r1,r13,#12
	strh	r0,[r1]
# [536] rxstat := ENC28J60_ReadOp(ENC28J60_READ_BUF_MEM, 0);
	mov	r1,#0
	mov	r0,#58
	bl	ENC28J60_$$_ENC28J60_READOP$BYTE$BYTE$$BYTE
	uxtb	r0,r0
	add	r1,r13,#16
	strh	r0,[r1]
# [537] rxstat := rxstat OR ENC28J60_ReadOp(ENC28J60_READ_BUF_MEM, 0)<<8;
	add	r0,r13,#16
	ldrh	r4,[r0]
	mov	r1,#0
	mov	r0,#58
	bl	ENC28J60_$$_ENC28J60_READOP$BYTE$BYTE$$BYTE
	uxtb	r0,r0
	lsl	r0,r0,#8
	orr	r0,r4
	uxth	r0,r0
	add	r1,r13,#16
	strh	r0,[r1]
# [540] if (len > maxlen - 1) then
	mov	r0,r13
	ldrh	r0,[r0]
	mov	r1,r0
	sub	r1,#1
	add	r0,r13,#12
	ldrh	r0,[r0]
	cmp	r1,r0
	bge	.Lj89
	bl	.Lj87
.Lj89:
	bl	.Lj88
.Lj87:
# [541] len := maxlen - 1;
	mov	r0,r13
	ldrh	r0,[r0]
	sub	r0,#1
	uxth	r1,r0
	add	r0,r13,#12
	strh	r1,[r0]
.Lj88:
# [546] if ((rxstat AND $80) = 0)then
	add	r0,r13,#16
	ldrh	r0,[r0]
	mov	r1,#128
	and	r0,r1
	cmp	r0,#0
	bne	.Lj92
	bl	.Lj90
.Lj92:
	bl	.Lj91
.Lj90:
# [548] len := 0
	mov	r1,#0
	add	r0,r13,#12
	strh	r1,[r0]
	bl	.Lj93
.Lj91:
# [551] ENC28J60_ReadBuffer(len, packet);
	ldr	r1,[r13, #4]
	add	r0,r13,#12
	ldrh	r0,[r0]
	bl	ENC28J60_$$_ENC28J60_READBUFFER$WORD$PBYTE
.Lj93:
# [553] ENC28J60_WriteOp(ENC28J60_BIT_FIELD_SET, ECON2, ECON2_PKTDEC);
	mov	r2,#64
	mov	r1,#30
	mov	r0,#128
	bl	ENC28J60_$$_ENC28J60_WRITEOP$BYTE$BYTE$BYTE
# [554] UnreleasedPacket := 1;
	mov	r1,#1
	ldr	r0,.Lj67
	strb	r1,[r0]
.Lj80:
# [557] Result := len;
	add	r0,r13,#12
	ldrh	r0,[r0]
	add	r1,r13,#8
	strh	r0,[r1]
# [558] end;
	add	r1,r13,#8
	ldrh	r0,[r1]
	add	r13,r13,#48
	pop	{r4,r15}
.Lc33:
	.balign 4
.Lj67:
	.long	U_$ENC28J60_$$_UNRELEASEDPACKET
.Lj71:
	.long	U_$ENC28J60_$$_GNEXTPACKETPTR
.Le16:
	.size	ENC28J60_$$_ENC28J60PACKETRECEIVE$WORD$PBYTE$$WORD, .Le16 - ENC28J60_$$_ENC28J60PACKETRECEIVE$WORD$PBYTE$$WORD

.section .text.n_enc28j60_$$_enc28j60packetsend$word$pbyte,"ax"
	.balign 4
.thumb_func 
.globl	ENC28J60_$$_ENC28J60PACKETSEND$WORD$PBYTE
ENC28J60_$$_ENC28J60PACKETSEND$WORD$PBYTE:
.Lc36:
# [561] begin
	push	{r14}
	sub	r13,r13,#40
# Var len located at r13+0, size=OS_16
# Var packet located at r13+4, size=OS_32
	mov	r2,r13
	strh	r0,[r2]
	str	r1,[r13, #4]
# [564] while (ENC28J60_ReadOp(ENC28J60_READ_CTRL_REG, ECON1) AND ECON1_TXRTS) = ECON1_TXRTS do
	bl	.Lj98
.Lj97:
# [567] if( (ENC28J60_Read(EIR) AND EIR_TXERIF) = EIR_TXERIF ) then
	mov	r0,#28
	bl	ENC28J60_$$_ENC28J60_READ$BYTE$$BYTE
	uxtb	r0,r0
	mov	r1,#2
	and	r0,r1
	cmp	r0,#2
	bne	.Lj102
	bl	.Lj100
.Lj102:
	bl	.Lj101
.Lj100:
# [569] ENC28J60_WriteOp(ENC28J60_BIT_FIELD_SET, ECON1, ECON1_TXRST);
	mov	r2,#128
	mov	r1,#31
	mov	r0,#128
	bl	ENC28J60_$$_ENC28J60_WRITEOP$BYTE$BYTE$BYTE
# [570] ENC28J60_WriteOp(ENC28J60_BIT_FIELD_CLR, ECON1, ECON1_TXRST);
	mov	r2,#128
	mov	r1,#31
	mov	r0,#160
	bl	ENC28J60_$$_ENC28J60_WRITEOP$BYTE$BYTE$BYTE
.Lj101:
.Lj98:
	mov	r1,#31
	mov	r0,#0
	bl	ENC28J60_$$_ENC28J60_READOP$BYTE$BYTE$$BYTE
	uxtb	r0,r0
	mov	r1,#8
	and	r0,r1
	cmp	r0,#8
	bne	.Lj103
	bl	.Lj97
.Lj103:
	bl	.Lj99
.Lj99:
# [574] ENC28J60_WriteWord(EWRPTL, TXSTART_INIT);
	ldr	r1,.Lj104
	mov	r0,#2
	bl	ENC28J60_$$_ENC28J60_WRITEWORD$BYTE$WORD
# [577] ENC28J60_WriteWord(ETXNDL, TXSTART_INIT+len);
	mov	r0,r13
	ldrh	r0,[r0]
	mov	r1,r0
	ldr	r0,.Lj104
	add	r1,r0
	uxth	r0,r1
	uxth	r1,r0
	mov	r0,#6
	bl	ENC28J60_$$_ENC28J60_WRITEWORD$BYTE$WORD
# [580] ENC28J60_WriteOp(ENC28J60_WRITE_BUF_MEM, 0, $00);
	mov	r2,#0
	mov	r1,#0
	mov	r0,#122
	bl	ENC28J60_$$_ENC28J60_WRITEOP$BYTE$BYTE$BYTE
# [582] ENC28J60_WriteBuffer(len, packet);
	ldr	r1,[r13, #4]
	mov	r0,r13
	ldrh	r0,[r0]
	bl	ENC28J60_$$_ENC28J60_WRITEBUFFER$WORD$PBYTE
# [584] ENC28J60_WriteOp(ENC28J60_BIT_FIELD_SET, ECON1, ECON1_TXRTS);
	mov	r2,#8
	mov	r1,#31
	mov	r0,#128
	bl	ENC28J60_$$_ENC28J60_WRITEOP$BYTE$BYTE$BYTE
# [590] end;
	add	r13,r13,#40
	pop	{r15}
.Lc35:
	.balign 4
.Lj104:
	.long	6655
.Le17:
	.size	ENC28J60_$$_ENC28J60PACKETSEND$WORD$PBYTE, .Le17 - ENC28J60_$$_ENC28J60PACKETSEND$WORD$PBYTE
# End asmlist al_procedures
# Begin asmlist al_globals

.section .bss.n_u_$enc28j60_$$_enc28j60bank,"aw",%nobits
# [262] Enc28j60Bank : byte;
	.size U_$ENC28J60_$$_ENC28J60BANK,1
U_$ENC28J60_$$_ENC28J60BANK:
	.zero 1

.section .bss.n_u_$enc28j60_$$_unreleasedpacket,"aw",%nobits
# [263] UnreleasedPacket : byte;
	.size U_$ENC28J60_$$_UNRELEASEDPACKET,1
U_$ENC28J60_$$_UNRELEASEDPACKET:
	.zero 1

.section .bss.n_u_$enc28j60_$$_gnextpacketptr,"aw",%nobits
	.balign 2
# [264] gNextPacketPtr : word;
	.size U_$ENC28J60_$$_GNEXTPACKETPTR,2
U_$ENC28J60_$$_GNEXTPACKETPTR:
	.zero 2
# End asmlist al_globals
# Begin asmlist al_dwarf_frame

.section .debug_frame
.Lc37:
	.long	.Lc39-.Lc38
.Lc38:
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
.Lc39:
	.long	.Lc41-.Lc40
.Lc40:
	.long	.Lc37
	.long	.Lc2
	.long	.Lc1-.Lc2
	.balign 4,0
.Lc41:
	.long	.Lc44-.Lc43
.Lc43:
	.long	.Lc37
	.long	.Lc4
	.long	.Lc3-.Lc4
	.balign 4,0
.Lc44:
	.long	.Lc47-.Lc46
.Lc46:
	.long	.Lc37
	.long	.Lc6
	.long	.Lc5-.Lc6
	.balign 4,0
.Lc47:
	.long	.Lc50-.Lc49
.Lc49:
	.long	.Lc37
	.long	.Lc8
	.long	.Lc7-.Lc8
	.balign 4,0
.Lc50:
	.long	.Lc53-.Lc52
.Lc52:
	.long	.Lc37
	.long	.Lc10
	.long	.Lc9-.Lc10
	.balign 4,0
.Lc53:
	.long	.Lc56-.Lc55
.Lc55:
	.long	.Lc37
	.long	.Lc12
	.long	.Lc11-.Lc12
	.balign 4,0
.Lc56:
	.long	.Lc59-.Lc58
.Lc58:
	.long	.Lc37
	.long	.Lc14
	.long	.Lc13-.Lc14
	.balign 4,0
.Lc59:
	.long	.Lc62-.Lc61
.Lc61:
	.long	.Lc37
	.long	.Lc16
	.long	.Lc15-.Lc16
	.balign 4,0
.Lc62:
	.long	.Lc65-.Lc64
.Lc64:
	.long	.Lc37
	.long	.Lc18
	.long	.Lc17-.Lc18
	.balign 4,0
.Lc65:
	.long	.Lc68-.Lc67
.Lc67:
	.long	.Lc37
	.long	.Lc20
	.long	.Lc19-.Lc20
	.balign 4,0
.Lc68:
	.long	.Lc71-.Lc70
.Lc70:
	.long	.Lc37
	.long	.Lc22
	.long	.Lc21-.Lc22
	.balign 4,0
.Lc71:
	.long	.Lc74-.Lc73
.Lc73:
	.long	.Lc37
	.long	.Lc24
	.long	.Lc23-.Lc24
	.balign 4,0
.Lc74:
	.long	.Lc77-.Lc76
.Lc76:
	.long	.Lc37
	.long	.Lc26
	.long	.Lc25-.Lc26
	.balign 4,0
.Lc77:
	.long	.Lc80-.Lc79
.Lc79:
	.long	.Lc37
	.long	.Lc28
	.long	.Lc27-.Lc28
	.balign 4,0
.Lc80:
	.long	.Lc83-.Lc82
.Lc82:
	.long	.Lc37
	.long	.Lc30
	.long	.Lc29-.Lc30
	.balign 4,0
.Lc83:
	.long	.Lc86-.Lc85
.Lc85:
	.long	.Lc37
	.long	.Lc32
	.long	.Lc31-.Lc32
	.balign 4,0
.Lc86:
	.long	.Lc89-.Lc88
.Lc88:
	.long	.Lc37
	.long	.Lc34
	.long	.Lc33-.Lc34
	.balign 4,0
.Lc89:
	.long	.Lc92-.Lc91
.Lc91:
	.long	.Lc37
	.long	.Lc36
	.long	.Lc35-.Lc36
	.balign 4,0
.Lc92:
# End asmlist al_dwarf_frame

