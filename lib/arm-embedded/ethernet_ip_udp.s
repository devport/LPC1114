	.file "ethernet_ip_udp.pas"
# Begin asmlist al_procedures

.section .text.n_ethernet_ip_udp_$$_ucb_add$word$$pudp_ucb,"ax"
	.balign 4
.thumb_func 
ETHERNET_IP_UDP_$$_UCB_ADD$WORD$$PUDP_UCB:
.Lc2:
# [ethernet_ip_udp.pas]
# [48] begin
	push	{r14}
	sub	r13,r13,#40
# Var port located at r13+0, size=OS_16
# Var $result located at r13+4, size=OS_32
# Var i located at r13+8, size=OS_8
	mov	r1,r13
	strh	r0,[r1]
# [49] Result := nil;
	mov	r0,#0
	str	r0,[r13, #4]
# [50] for i:=0 to MAX_UDP_CLIENT_TABLE do begin
	mov	r1,#255
	add	r0,r13,#8
	strb	r1,[r0]
.Lj5:
	add	r0,r13,#8
	ldrb	r0,[r0]
	add	r0,#1
	uxtb	r0,r0
	add	r1,r13,#8
	strb	r0,[r1]
# [51] if(UDP_Client[i].src_ip = 0) then begin
	add	r0,r13,#8
	ldrb	r0,[r0]
	mov	r1,r0
	lsl	r1,r1,#4
	ldr	r0,.Lj8
	add	r0,r1
	ldrh	r1,[r0]
	ldrh	r0,[r0, #2]
	lsl	r0,#16
	orr	r1,r0
	cmp	r1,#0
	bne	.Lj11
	bl	.Lj9
.Lj11:
	bl	.Lj10
.Lj9:
# [52] UDP_Client[i].id := i;
	add	r0,r13,#8
	ldrb	r0,[r0]
	mov	r2,r0
	lsl	r2,r2,#4
	ldr	r0,.Lj12
	mov	r1,r0
	add	r1,r2
	add	r0,r13,#8
	ldrb	r0,[r0]
	strb	r0,[r1]
# [53] UDP_Client[i].src_port := port;
	add	r0,r13,#8
	ldrb	r0,[r0]
	mov	r2,r0
	lsl	r2,r2,#4
	mov	r0,r13
	ldrh	r1,[r0]
	ldr	r0,.Lj13
	strh	r1,[r2, r0]
# [54] Result := @UDP_Client[i];
	add	r0,r13,#8
	ldrb	r0,[r0]
	mov	r1,r0
	lsl	r1,r1,#4
	ldr	r0,.Lj14
	add	r0,r1
	str	r0,[r13, #4]
# [55] exit;
	bl	.Lj3
.Lj10:
	add	r0,r13,#8
	ldrb	r0,[r0]
	cmp	r0,#8
	bcc	.Lj15
	bl	.Lj7
.Lj15:
	bl	.Lj5
.Lj7:
.Lj3:
# [58] end;
	ldr	r0,[r13, #4]
	add	r13,r13,#40
	pop	{r15}
.Lc1:
	.balign 4
.Lj8:
	.long	U_$ETHERNET_IP_UDP_$$_UDP_CLIENT+6
.Lj12:
	.long	U_$ETHERNET_IP_UDP_$$_UDP_CLIENT+14
.Lj13:
	.long	U_$ETHERNET_IP_UDP_$$_UDP_CLIENT+10
.Lj14:
	.long	U_$ETHERNET_IP_UDP_$$_UDP_CLIENT
.Le0:
	.size	ETHERNET_IP_UDP_$$_UCB_ADD$WORD$$PUDP_UCB, .Le0 - ETHERNET_IP_UDP_$$_UCB_ADD$WORD$$PUDP_UCB

.section .text.n_ethernet_ip_udp_$$_ucb_check$longword$word$$pudp_ucb,"ax"
	.balign 4
.thumb_func 
ETHERNET_IP_UDP_$$_UCB_CHECK$LONGWORD$WORD$$PUDP_UCB:
.Lc4:
# [64] begin
	push	{r14}
	sub	r13,r13,#48
# Var ip located at r13+0, size=OS_32
# Var port located at r13+4, size=OS_16
# Var $result located at r13+8, size=OS_32
# Var i located at r13+12, size=OS_8
	str	r0,[r13]
	add	r0,r13,#4
	strh	r1,[r0]
# [65] Result := nil;
	mov	r0,#0
	str	r0,[r13, #8]
# [66] for i:=0 to MAX_UDP_CLIENT_TABLE do begin
	mov	r1,#255
	add	r0,r13,#12
	strb	r1,[r0]
.Lj18:
	add	r0,r13,#12
	ldrb	r0,[r0]
	add	r0,#1
	uxtb	r0,r0
	add	r1,r13,#12
	strb	r0,[r1]
# [67] if((UDP_Client[i].src_ip = ip) AND (UDP_Client[i].src_port = port)) then begin
	add	r0,r13,#12
	ldrb	r0,[r0]
	mov	r1,r0
	lsl	r1,r1,#4
	ldr	r0,.Lj21
	add	r0,r1
	ldrh	r1,[r0]
	ldrh	r0,[r0, #2]
	lsl	r0,#16
	orr	r1,r0
	ldr	r0,[r13]
	cmp	r1,r0
	bne	.Lj24
	bl	.Lj22
.Lj24:
	bl	.Lj23
.Lj22:
	add	r0,r13,#12
	ldrb	r0,[r0]
	lsl	r0,r0,#4
	ldr	r1,.Lj26
	ldrh	r1,[r0, r1]
	add	r0,r13,#4
	ldrh	r0,[r0]
	cmp	r1,r0
	bne	.Lj27
	bl	.Lj25
.Lj27:
	bl	.Lj23
.Lj25:
# [68] Result := @UDP_Client[i];
	add	r0,r13,#12
	ldrb	r0,[r0]
	mov	r1,r0
	lsl	r1,r1,#4
	ldr	r0,.Lj28
	add	r0,r1
	str	r0,[r13, #8]
# [69] exit;
	bl	.Lj16
.Lj23:
	add	r0,r13,#12
	ldrb	r0,[r0]
	cmp	r0,#8
	bcc	.Lj29
	bl	.Lj20
.Lj29:
	bl	.Lj18
.Lj20:
.Lj16:
# [72] end;
	ldr	r0,[r13, #8]
	add	r13,r13,#48
	pop	{r15}
.Lc3:
	.balign 4
.Lj21:
	.long	U_$ETHERNET_IP_UDP_$$_UDP_CLIENT+6
.Lj26:
	.long	U_$ETHERNET_IP_UDP_$$_UDP_CLIENT+10
.Lj28:
	.long	U_$ETHERNET_IP_UDP_$$_UDP_CLIENT
.Le1:
	.size	ETHERNET_IP_UDP_$$_UCB_CHECK$LONGWORD$WORD$$PUDP_UCB, .Le1 - ETHERNET_IP_UDP_$$_UCB_CHECK$LONGWORD$WORD$$PUDP_UCB

.section .text.n_ethernet_ip_udp_$$_eth_protocol_ip_udp$pbyte$pbyte$word$$word,"ax"
	.balign 4
.thumb_func 
.globl	ETHERNET_IP_UDP_$$_ETH_PROTOCOL_IP_UDP$PBYTE$PBYTE$WORD$$WORD
ETHERNET_IP_UDP_$$_ETH_PROTOCOL_IP_UDP$PBYTE$PBYTE$WORD$$WORD:
.Lc6:
# [83] begin
	push	{r4,r14}
	sub	r13,r13,#80
# Var ip_hdr located at r13+0, size=OS_32
# Var udp_hdr located at r13+4, size=OS_32
# Var size located at r13+8, size=OS_16
# Var $result located at r13+12, size=OS_16
# Var UDP_Header located at r13+16, size=OS_32
# Var IP_Header located at r13+20, size=OS_32
# Var udp_data located at r13+24, size=OS_32
# Var udp_total_len located at r13+28, size=OS_16
# Var udp_data_len located at r13+32, size=OS_16
# Var src_port located at r13+36, size=OS_16
# Var dst_port located at r13+40, size=OS_16
# Var len located at r13+44, size=OS_16
# Var checksum located at r13+48, size=OS_16
# Var socket located at r13+52, size=OS_32
# Var ucb located at r13+56, size=OS_32
	str	r0,[r13]
	str	r1,[r13, #4]
	add	r0,r13,#8
	strh	r2,[r0]
# [76] var
	ldr	r0,.Lj32
	ldr	r0,[r0]
	str	r0,[r13, #52]
# [84] Result := 0;
	mov	r1,#0
	add	r0,r13,#12
	strh	r1,[r0]
# [85] UDP_Header := PUDP_HDR(udp_hdr);
	ldr	r0,[r13, #4]
	str	r0,[r13, #16]
# [86] IP_Header := PIP_HDR(ip_hdr);
	ldr	r0,[r13]
	str	r0,[r13, #20]
# [87] len := 0;
	mov	r1,#0
	add	r0,r13,#44
	strh	r1,[r0]
# [89] checksum := Calc_Checksum(PWord(udp_hdr), ByteSwap16(UDP_Header^.total_len) >> 1, 0);
	ldr	r0,[r13, #16]
	ldrb	r1,[r0, #4]
	ldrb	r0,[r0, #5]
	lsl	r0,#8
	orr	r1,r0
	mov	r0,r1
	bl	ETHERNET_$$_BYTESWAP16$WORD$$WORD
	uxth	r0,r0
	lsr	r0,r0,#1
	uxth	r0,r0
	uxth	r1,r0
	mov	r2,#0
	ldr	r0,[r13, #4]
	bl	ETHERNET_IP_$$_CALC_CHECKSUM$PWORD$WORD$WORD$$WORD
	uxth	r1,r0
	add	r0,r13,#48
	strh	r1,[r0]
# [90] if (checksum <> $FFFF) then exit;
	add	r0,r13,#48
	ldrh	r1,[r0]
	ldr	r0,.Lj33
	cmp	r1,r0
	beq	.Lj36
	bl	.Lj34
.Lj36:
	bl	.Lj35
.Lj34:
	bl	.Lj30
.Lj35:
# [92] udp_total_len := ByteSwap16(UDP_Header^.total_len);
	ldr	r0,[r13, #16]
	ldrb	r1,[r0, #4]
	ldrb	r0,[r0, #5]
	lsl	r0,#8
	orr	r1,r0
	mov	r0,r1
	bl	ETHERNET_$$_BYTESWAP16$WORD$$WORD
	uxth	r1,r0
	add	r0,r13,#28
	strh	r1,[r0]
# [93] if(udp_total_len <> size) then exit;
	add	r0,r13,#28
	ldrh	r1,[r0]
	add	r0,r13,#8
	ldrh	r0,[r0]
	cmp	r1,r0
	beq	.Lj39
	bl	.Lj37
.Lj39:
	bl	.Lj38
.Lj37:
	bl	.Lj30
.Lj38:
# [95] udp_data := udp_hdr + UDP_HDR_SIZE;
	ldr	r0,[r13, #4]
	add	r0,#8
	str	r0,[r13, #24]
# [96] udp_data_len := udp_total_len - UDP_HDR_SIZE;
	add	r0,r13,#28
	ldrh	r0,[r0]
	sub	r0,#8
	uxth	r0,r0
	add	r1,r13,#32
	strh	r0,[r1]
# [102] socket := CheckPort(ByteSwap16(UDP_Header^.dst_port), IPV4_TYPE_UDP);
	ldr	r0,[r13, #16]
	ldrb	r1,[r0, #2]
	ldrb	r0,[r0, #3]
	lsl	r0,#8
	orr	r1,r0
	mov	r0,r1
	bl	ETHERNET_$$_BYTESWAP16$WORD$$WORD
	uxth	r0,r0
	uxth	r0,r0
	mov	r1,#17
	bl	ETHERNET_$$_CHECKPORT$WORD$BYTE$$PSOCKET
	str	r0,[r13, #52]
# [103] if socket <> nil then begin
	ldr	r0,[r13, #52]
	cmp	r0,#0
	beq	.Lj42
	bl	.Lj40
.Lj42:
	bl	.Lj41
.Lj40:
# [105] ucb := UCB_Check(ByteSwap32(IP_Header^.src), ByteSwap16(UDP_Header^.src_port));
	ldr	r0,[r13, #16]
	ldrb	r1,[r0]
	ldrb	r0,[r0, #1]
	lsl	r0,#8
	orr	r1,r0
	mov	r0,r1
	bl	ETHERNET_$$_BYTESWAP16$WORD$$WORD
	uxth	r0,r0
	uxth	r4,r0
	ldr	r2,[r13, #20]
	ldrb	r1,[r2, #12]
	ldrb	r0,[r2, #13]
	lsl	r0,#8
	orr	r1,r0
	ldrb	r0,[r2, #14]
	lsl	r0,#16
	orr	r1,r0
	ldrb	r0,[r2, #15]
	lsl	r0,#24
	orr	r1,r0
	mov	r0,r1
	bl	ETHERNET_$$_BYTESWAP32$LONGWORD$$LONGWORD
	mov	r1,r4
	bl	ETHERNET_IP_UDP_$$_UCB_CHECK$LONGWORD$WORD$$PUDP_UCB
	str	r0,[r13, #56]
# [106] if ucb = nil then
	ldr	r0,[r13, #56]
	cmp	r0,#0
	bne	.Lj45
	bl	.Lj43
.Lj45:
	bl	.Lj44
.Lj43:
# [107] ucb := UCB_Add(ByteSwap16(UDP_Header^.src_port));
	ldr	r0,[r13, #16]
	ldrb	r1,[r0]
	ldrb	r0,[r0, #1]
	lsl	r0,#8
	orr	r1,r0
	mov	r0,r1
	bl	ETHERNET_$$_BYTESWAP16$WORD$$WORD
	uxth	r0,r0
	uxth	r0,r0
	bl	ETHERNET_IP_UDP_$$_UCB_ADD$WORD$$PUDP_UCB
	str	r0,[r13, #56]
.Lj44:
# [109] if ucb = nil then exit;
	ldr	r0,[r13, #56]
	cmp	r0,#0
	bne	.Lj48
	bl	.Lj46
.Lj48:
	bl	.Lj47
.Lj46:
	bl	.Lj30
.Lj47:
# [111] ucb^.src_ip := ByteSwap32(IP_Header^.src);
	ldr	r2,[r13, #20]
	ldrb	r1,[r2, #12]
	ldrb	r0,[r2, #13]
	lsl	r0,#8
	orr	r1,r0
	ldrb	r0,[r2, #14]
	lsl	r0,#16
	orr	r1,r0
	ldrb	r0,[r2, #15]
	lsl	r0,#24
	orr	r1,r0
	mov	r0,r1
	bl	ETHERNET_$$_BYTESWAP32$LONGWORD$$LONGWORD
	ldr	r1,[r13, #56]
	strb	r0,[r1, #6]
	lsr	r0,r0,#8
	strb	r0,[r1, #7]
	lsr	r0,r0,#8
	strb	r0,[r1, #8]
	lsr	r0,r0,#8
	strb	r0,[r1, #9]
.Lj41:
# [117] Result := len;
	add	r0,r13,#44
	ldrh	r0,[r0]
	add	r1,r13,#12
	strh	r0,[r1]
.Lj30:
# [118] end;
	add	r1,r13,#12
	ldrh	r0,[r1]
	add	r13,r13,#80
	pop	{r4,r15}
.Lc5:
	.balign 4
.Lj32:
	.long	TC_$ETHERNET_IP_UDP$_$ETH_PROTOCOL_IP_UDP$PBYTE$PBYTE$WORD$$WORD_$$_defaultsocket
.Lj33:
	.long	65535
.Le2:
	.size	ETHERNET_IP_UDP_$$_ETH_PROTOCOL_IP_UDP$PBYTE$PBYTE$WORD$$WORD, .Le2 - ETHERNET_IP_UDP_$$_ETH_PROTOCOL_IP_UDP$PBYTE$PBYTE$WORD$$WORD

.section .text.n_ethernet_ip_udp_$$_init$,"ax"
	.balign 4
.thumb_func 
.globl	ETHERNET_IP_UDP_$$_init$
ETHERNET_IP_UDP_$$_init$:
.thumb_func 
.globl	INIT$_$ETHERNET_IP_UDP
INIT$_$ETHERNET_IP_UDP:
.Lc8:
# [193] initialization
	push	{r14}
	sub	r13,r13,#32
# [194] FillByte(UDP_Client[0], sizeof(UDP_Client)* MAX_UDP_CLIENT_TABLE, 0);
	ldr	r0,.Lj49
	mov	r2,#0
	ldr	r1,.Lj50
	bl	SYSTEM_$$_FILLBYTE$formal$LONGINT$BYTE
# [196] end.
	add	r13,r13,#32
	pop	{r15}
.Lc7:
	.balign 4
.Lj49:
	.long	U_$ETHERNET_IP_UDP_$$_UDP_CLIENT
.Lj50:
	.long	1152
.Le3:
	.size	ETHERNET_IP_UDP_$$_init$, .Le3 - ETHERNET_IP_UDP_$$_init$
# End asmlist al_procedures
# Begin asmlist al_globals

.section .bss.n_u_$ethernet_ip_udp_$$_udp_client,"aw",%nobits
	.balign 2
# [42] UDP_Client : array[0..MAX_UDP_CLIENT_TABLE] of TUDP_UCB;
	.size U_$ETHERNET_IP_UDP_$$_UDP_CLIENT,144
U_$ETHERNET_IP_UDP_$$_UDP_CLIENT:
	.zero 144
# End asmlist al_globals
# Begin asmlist al_typedconsts

.section .rodata.n_TC_$ETHERNET_IP_UDP$_$ETH_PROTOCOL_IP_UDP$PBYTE$PBYTE$WORD$$WORD_$$_defaultsocket
	.balign 4
TC_$ETHERNET_IP_UDP$_$ETH_PROTOCOL_IP_UDP$PBYTE$PBYTE$WORD$$WORD_$$_defaultsocket:
	.long	0
# [82] ucb : PUDP_UCB;
.Le4:
	.size	TC_$ETHERNET_IP_UDP$_$ETH_PROTOCOL_IP_UDP$PBYTE$PBYTE$WORD$$WORD_$$_defaultsocket, .Le4 - TC_$ETHERNET_IP_UDP$_$ETH_PROTOCOL_IP_UDP$PBYTE$PBYTE$WORD$$WORD_$$_defaultsocket
# End asmlist al_typedconsts
# Begin asmlist al_rtti

.section .rodata.n_INIT_$ETHERNET_IP_UDP_$$_TUDP_HDR
	.balign 4
.globl	INIT_$ETHERNET_IP_UDP_$$_TUDP_HDR
INIT_$ETHERNET_IP_UDP_$$_TUDP_HDR:
	.byte	13,8
# [197] 
	.ascii	"Tudp_hdr"
	.byte	0,0
	.long	0,0,8,0,0,0
.Le5:
	.size	INIT_$ETHERNET_IP_UDP_$$_TUDP_HDR, .Le5 - INIT_$ETHERNET_IP_UDP_$$_TUDP_HDR

.section .rodata.n_RTTI_$ETHERNET_IP_UDP_$$_TUDP_HDR
	.balign 4
.globl	RTTI_$ETHERNET_IP_UDP_$$_TUDP_HDR
RTTI_$ETHERNET_IP_UDP_$$_TUDP_HDR:
	.byte	13,8
	.ascii	"Tudp_hdr"
	.byte	0,0
	.long	0
	.long	INIT_$ETHERNET_IP_UDP_$$_TUDP_HDR
	.long	8,4
	.long	RTTI_$SYSTEM_$$_WORD$indirect
	.long	0
	.long	RTTI_$SYSTEM_$$_WORD$indirect
	.long	2
	.long	RTTI_$SYSTEM_$$_WORD$indirect
	.long	4
	.long	RTTI_$SYSTEM_$$_WORD$indirect
	.long	6
.Le6:
	.size	RTTI_$ETHERNET_IP_UDP_$$_TUDP_HDR, .Le6 - RTTI_$ETHERNET_IP_UDP_$$_TUDP_HDR

.section .rodata.n_RTTI_$ETHERNET_IP_UDP_$$_PUDP_HDR
	.balign 4
.globl	RTTI_$ETHERNET_IP_UDP_$$_PUDP_HDR
RTTI_$ETHERNET_IP_UDP_$$_PUDP_HDR:
	.byte	29,8
	.ascii	"Pudp_hdr"
	.byte	0,0
	.long	0
	.long	RTTI_$ETHERNET_IP_UDP_$$_TUDP_HDR$indirect
.Le7:
	.size	RTTI_$ETHERNET_IP_UDP_$$_PUDP_HDR, .Le7 - RTTI_$ETHERNET_IP_UDP_$$_PUDP_HDR

.section .rodata.n_INIT_$ETHERNET_IP_UDP_$$_TUDP_UCB
	.balign 4
.globl	INIT_$ETHERNET_IP_UDP_$$_TUDP_UCB
INIT_$ETHERNET_IP_UDP_$$_TUDP_UCB:
	.byte	13,8
	.ascii	"TUDP_UCB"
	.byte	0,0
	.long	0,0,16,0,0,0
.Le8:
	.size	INIT_$ETHERNET_IP_UDP_$$_TUDP_UCB, .Le8 - INIT_$ETHERNET_IP_UDP_$$_TUDP_UCB

.section .rodata.n_RTTI_$ETHERNET_IP_UDP_$$_def00000004
	.balign 4
.globl	RTTI_$ETHERNET_IP_UDP_$$_def00000004
RTTI_$ETHERNET_IP_UDP_$$_def00000004:
	.byte	12,0,0,0
	.long	0,6,6
	.long	RTTI_$SYSTEM_$$_BYTE$indirect
	.byte	1,0,0,0
	.long	RTTI_$SYSTEM_$$_SHORTINT$indirect
.Le9:
	.size	RTTI_$ETHERNET_IP_UDP_$$_def00000004, .Le9 - RTTI_$ETHERNET_IP_UDP_$$_def00000004

.section .rodata.n_RTTI_$ETHERNET_IP_UDP_$$_TUDP_UCB
	.balign 4
.globl	RTTI_$ETHERNET_IP_UDP_$$_TUDP_UCB
RTTI_$ETHERNET_IP_UDP_$$_TUDP_UCB:
	.byte	13,8
	.ascii	"TUDP_UCB"
	.byte	0,0
	.long	0
	.long	INIT_$ETHERNET_IP_UDP_$$_TUDP_UCB
	.long	16,6
	.long	RTTI_$ETHERNET_IP_UDP_$$_def00000004$indirect
	.long	0
	.long	RTTI_$SYSTEM_$$_LONGWORD$indirect
	.long	6
	.long	RTTI_$SYSTEM_$$_WORD$indirect
	.long	10
	.long	RTTI_$SYSTEM_$$_WORD$indirect
	.long	12
	.long	RTTI_$SYSTEM_$$_BYTE$indirect
	.long	14
	.long	RTTI_$SYSTEM_$$_BYTE$indirect
	.long	15
.Le10:
	.size	RTTI_$ETHERNET_IP_UDP_$$_TUDP_UCB, .Le10 - RTTI_$ETHERNET_IP_UDP_$$_TUDP_UCB

.section .rodata.n_RTTI_$ETHERNET_IP_UDP_$$_PUDP_UCB
	.balign 4
.globl	RTTI_$ETHERNET_IP_UDP_$$_PUDP_UCB
RTTI_$ETHERNET_IP_UDP_$$_PUDP_UCB:
	.byte	29,8
	.ascii	"PUDP_UCB"
	.byte	0,0
	.long	0
	.long	RTTI_$ETHERNET_IP_UDP_$$_TUDP_UCB$indirect
.Le11:
	.size	RTTI_$ETHERNET_IP_UDP_$$_PUDP_UCB, .Le11 - RTTI_$ETHERNET_IP_UDP_$$_PUDP_UCB
# End asmlist al_rtti
# Begin asmlist al_indirectglobals

.section .rodata.n_INIT_$ETHERNET_IP_UDP_$$_TUDP_HDR
	.balign 4
.globl	INIT_$ETHERNET_IP_UDP_$$_TUDP_HDR$indirect
INIT_$ETHERNET_IP_UDP_$$_TUDP_HDR$indirect:
	.long	INIT_$ETHERNET_IP_UDP_$$_TUDP_HDR
.Le12:
	.size	INIT_$ETHERNET_IP_UDP_$$_TUDP_HDR$indirect, .Le12 - INIT_$ETHERNET_IP_UDP_$$_TUDP_HDR$indirect

.section .rodata.n_RTTI_$ETHERNET_IP_UDP_$$_TUDP_HDR
	.balign 4
.globl	RTTI_$ETHERNET_IP_UDP_$$_TUDP_HDR$indirect
RTTI_$ETHERNET_IP_UDP_$$_TUDP_HDR$indirect:
	.long	RTTI_$ETHERNET_IP_UDP_$$_TUDP_HDR
.Le13:
	.size	RTTI_$ETHERNET_IP_UDP_$$_TUDP_HDR$indirect, .Le13 - RTTI_$ETHERNET_IP_UDP_$$_TUDP_HDR$indirect

.section .rodata.n_RTTI_$ETHERNET_IP_UDP_$$_PUDP_HDR
	.balign 4
.globl	RTTI_$ETHERNET_IP_UDP_$$_PUDP_HDR$indirect
RTTI_$ETHERNET_IP_UDP_$$_PUDP_HDR$indirect:
	.long	RTTI_$ETHERNET_IP_UDP_$$_PUDP_HDR
.Le14:
	.size	RTTI_$ETHERNET_IP_UDP_$$_PUDP_HDR$indirect, .Le14 - RTTI_$ETHERNET_IP_UDP_$$_PUDP_HDR$indirect

.section .rodata.n_INIT_$ETHERNET_IP_UDP_$$_TUDP_UCB
	.balign 4
.globl	INIT_$ETHERNET_IP_UDP_$$_TUDP_UCB$indirect
INIT_$ETHERNET_IP_UDP_$$_TUDP_UCB$indirect:
	.long	INIT_$ETHERNET_IP_UDP_$$_TUDP_UCB
.Le15:
	.size	INIT_$ETHERNET_IP_UDP_$$_TUDP_UCB$indirect, .Le15 - INIT_$ETHERNET_IP_UDP_$$_TUDP_UCB$indirect

.section .rodata.n_RTTI_$ETHERNET_IP_UDP_$$_def00000004
	.balign 4
.globl	RTTI_$ETHERNET_IP_UDP_$$_def00000004$indirect
RTTI_$ETHERNET_IP_UDP_$$_def00000004$indirect:
	.long	RTTI_$ETHERNET_IP_UDP_$$_def00000004
.Le16:
	.size	RTTI_$ETHERNET_IP_UDP_$$_def00000004$indirect, .Le16 - RTTI_$ETHERNET_IP_UDP_$$_def00000004$indirect

.section .rodata.n_RTTI_$ETHERNET_IP_UDP_$$_TUDP_UCB
	.balign 4
.globl	RTTI_$ETHERNET_IP_UDP_$$_TUDP_UCB$indirect
RTTI_$ETHERNET_IP_UDP_$$_TUDP_UCB$indirect:
	.long	RTTI_$ETHERNET_IP_UDP_$$_TUDP_UCB
.Le17:
	.size	RTTI_$ETHERNET_IP_UDP_$$_TUDP_UCB$indirect, .Le17 - RTTI_$ETHERNET_IP_UDP_$$_TUDP_UCB$indirect

.section .rodata.n_RTTI_$ETHERNET_IP_UDP_$$_PUDP_UCB
	.balign 4
.globl	RTTI_$ETHERNET_IP_UDP_$$_PUDP_UCB$indirect
RTTI_$ETHERNET_IP_UDP_$$_PUDP_UCB$indirect:
	.long	RTTI_$ETHERNET_IP_UDP_$$_PUDP_UCB
.Le18:
	.size	RTTI_$ETHERNET_IP_UDP_$$_PUDP_UCB$indirect, .Le18 - RTTI_$ETHERNET_IP_UDP_$$_PUDP_UCB$indirect
# End asmlist al_indirectglobals
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

