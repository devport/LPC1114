	.file "ethernet_ip.pas"
# Begin asmlist al_procedures

.section .text.n_ethernet_ip_$$_calc_checksum$pword$word$word$$word,"ax"
	.balign 4
.thumb_func 
.globl	ETHERNET_IP_$$_CALC_CHECKSUM$PWORD$WORD$WORD$$WORD
ETHERNET_IP_$$_CALC_CHECKSUM$PWORD$WORD$WORD$$WORD:
.Lc2:
# [ethernet_ip.pas]
# [41] begin
	push	{r14}
	sub	r13,r13,#48
# Var buf located at r13+0, size=OS_32
# Var num_of_shorts located at r13+4, size=OS_16
# Var start located at r13+8, size=OS_16
# Var $result located at r13+12, size=OS_16
# Var check located at r13+16, size=OS_32
	str	r0,[r13]
	add	r0,r13,#4
	strh	r1,[r0]
	add	r0,r13,#8
	strh	r2,[r0]
# [42] check := start;
	add	r0,r13,#8
	ldrh	r0,[r0]
	str	r0,[r13, #16]
# [43] while(num_of_shorts > 0) do begin
	bl	.Lj6
.Lj5:
# [44] Dec(num_of_shorts);
	add	r0,r13,#4
	ldrh	r0,[r0]
	sub	r0,#1
	uxth	r0,r0
	add	r1,r13,#4
	strh	r0,[r1]
# [45] check := check + buf^;
	ldr	r0,[r13]
	ldrh	r1,[r0]
	ldr	r0,[r13, #16]
	add	r0,r1
	str	r0,[r13, #16]
# [46] Inc(buf);
	ldr	r0,[r13]
	add	r0,#2
	str	r0,[r13]
.Lj6:
	add	r0,r13,#4
	ldrh	r0,[r0]
	cmp	r0,#0
	bls	.Lj8
	bl	.Lj5
.Lj8:
	bl	.Lj7
.Lj7:
# [49] check := (check>>16) + (check AND $FFFF);
	ldr	r0,[r13, #16]
	mov	r2,r0
	lsr	r2,r2,#16
	ldr	r0,[r13, #16]
	mov	r1,r0
	ldr	r0,.Lj9
	and	r1,r0
	mov	r0,r1
	add	r0,r2
	str	r0,[r13, #16]
# [50] check := check + (check>>16);
	ldr	r0,[r13, #16]
	mov	r1,r0
	lsr	r1,r1,#16
	ldr	r0,[r13, #16]
	add	r0,r1
	str	r0,[r13, #16]
# [51] result := check;
	add	r0,r13,#16
	ldrh	r1,[r0]
	add	r0,r13,#12
	strh	r1,[r0]
# [52] end;
	add	r1,r13,#12
	ldrh	r0,[r1]
	add	r13,r13,#48
	pop	{r15}
.Lc1:
	.balign 4
.Lj9:
	.long	65535
.Le0:
	.size	ETHERNET_IP_$$_CALC_CHECKSUM$PWORD$WORD$WORD$$WORD, .Le0 - ETHERNET_IP_$$_CALC_CHECKSUM$PWORD$WORD$WORD$$WORD

.section .text.n_ethernet_ip_$$_eth_protocol_ip$pbyte$pbyte,"ax"
	.balign 4
.thumb_func 
.globl	ETHERNET_IP_$$_ETH_PROTOCOL_IP$PBYTE$PBYTE
ETHERNET_IP_$$_ETH_PROTOCOL_IP$PBYTE$PBYTE:
.Lc4:
# [61] begin
	push	{r14}
	sub	r13,r13,#56
# Var ip_hdr located at r13+0, size=OS_32
# Var ip located at r13+4, size=OS_32
# Var IP_Header located at r13+8, size=OS_32
# Var ip_header_ver located at r13+12, size=OS_8
# Var ip_header_len located at r13+16, size=OS_8
# Var checksum located at r13+20, size=OS_16
# Var ip_total_len located at r13+24, size=OS_16
# Var ip_data_len located at r13+28, size=OS_16
	str	r0,[r13]
	str	r1,[r13, #4]
# [62] IP_Header := PIP_HDR(ip_hdr);
	ldr	r0,[r13]
	str	r0,[r13, #8]
# [64] ip_header_ver := IP_Header^.ver_len >> 4;
	ldr	r0,[r13, #8]
	ldrb	r0,[r0]
	lsr	r0,r0,#4
	uxtb	r1,r0
	add	r0,r13,#12
	strb	r1,[r0]
# [65] if(ip_header_ver <> 4) then exit;
	add	r0,r13,#12
	ldrb	r0,[r0]
	cmp	r0,#4
	beq	.Lj14
	bl	.Lj12
.Lj14:
	bl	.Lj13
.Lj12:
	bl	.Lj10
.Lj13:
# [67] ip_header_len := (IP_Header^.ver_len AND $0F) << 2;
	ldr	r0,[r13, #8]
	ldrb	r0,[r0]
	mov	r1,#15
	and	r0,r1
	lsl	r0,r0,#2
	uxtb	r1,r0
	add	r0,r13,#16
	strb	r1,[r0]
# [68] if (ip_header_len <> 20) then exit;
	add	r0,r13,#16
	ldrb	r0,[r0]
	cmp	r0,#20
	beq	.Lj17
	bl	.Lj15
.Lj17:
	bl	.Lj16
.Lj15:
	bl	.Lj10
.Lj16:
# [71] checksum := Calc_Checksum(PWORD(ip_hdr), ip_header_len >> 1, 0);
	add	r0,r13,#16
	ldrb	r0,[r0]
	lsr	r0,r0,#1
	uxth	r0,r0
	uxth	r1,r0
	mov	r2,#0
	ldr	r0,[r13]
	bl	ETHERNET_IP_$$_CALC_CHECKSUM$PWORD$WORD$WORD$$WORD
	uxth	r1,r0
	add	r0,r13,#20
	strh	r1,[r0]
# [72] if (checksum <> $FFFF) then exit;
	add	r0,r13,#20
	ldrh	r0,[r0]
	ldr	r1,.Lj18
	cmp	r0,r1
	beq	.Lj21
	bl	.Lj19
.Lj21:
	bl	.Lj20
.Lj19:
	bl	.Lj10
.Lj20:
# [74] ip_total_len := ByteSwap16(IP_Header^.total_len);
	ldr	r0,[r13, #8]
	ldrb	r1,[r0, #2]
	ldrb	r0,[r0, #3]
	lsl	r0,#8
	orr	r1,r0
	mov	r0,r1
	bl	ETHERNET_$$_BYTESWAP16$WORD$$WORD
	uxth	r0,r0
	add	r1,r13,#24
	strh	r0,[r1]
# [77] if((((IP_Header^).dst AND $FF) <> ip[0]) OR
	ldr	r2,[r13, #8]
	ldrb	r1,[r2, #16]
	ldrb	r0,[r2, #17]
	lsl	r0,#8
	orr	r1,r0
	ldrb	r0,[r2, #18]
	lsl	r0,#16
	orr	r1,r0
	ldrb	r0,[r2, #19]
	lsl	r0,#24
	orr	r1,r0
	mov	r0,#255
	and	r1,r0
	ldr	r0,[r13, #4]
	ldrb	r0,[r0]
	cmp	r1,r0
	beq	.Lj24
	bl	.Lj22
.Lj24:
	bl	.Lj23
.Lj23:
# [78] ((((IP_Header^).dst >> 8) AND $FF) <> ip[1]) OR
	ldr	r2,[r13, #8]
	ldrb	r1,[r2, #16]
	ldrb	r0,[r2, #17]
	lsl	r0,#8
	orr	r1,r0
	ldrb	r0,[r2, #18]
	lsl	r0,#16
	orr	r1,r0
	ldrb	r0,[r2, #19]
	lsl	r0,#24
	orr	r1,r0
	lsr	r1,r1,#8
	mov	r0,#255
	and	r1,r0
	ldr	r0,[r13, #4]
	ldrb	r0,[r0, #1]
	cmp	r1,r0
	beq	.Lj26
	bl	.Lj22
.Lj26:
	bl	.Lj25
.Lj25:
# [79] ((((IP_Header^).dst >> 16) AND $FF)  <> ip[2]) OR
	ldr	r2,[r13, #8]
	ldrb	r1,[r2, #16]
	ldrb	r0,[r2, #17]
	lsl	r0,#8
	orr	r1,r0
	ldrb	r0,[r2, #18]
	lsl	r0,#16
	orr	r1,r0
	ldrb	r0,[r2, #19]
	lsl	r0,#24
	orr	r1,r0
	lsr	r1,r1,#16
	mov	r0,#255
	and	r1,r0
	ldr	r0,[r13, #4]
	ldrb	r0,[r0, #2]
	cmp	r1,r0
	beq	.Lj28
	bl	.Lj22
.Lj28:
	bl	.Lj27
.Lj27:
# [80] ((((IP_Header^).dst >> 24) AND $FF)  <> ip[3])) then exit;
	ldr	r1,[r13, #8]
	ldrb	r2,[r1, #16]
	ldrb	r0,[r1, #17]
	lsl	r0,#8
	orr	r2,r0
	ldrb	r0,[r1, #18]
	lsl	r0,#16
	orr	r2,r0
	ldrb	r0,[r1, #19]
	lsl	r0,#24
	orr	r2,r0
	mov	r1,r2
	lsr	r1,r1,#24
	mov	r0,#255
	and	r1,r0
	ldr	r0,[r13, #4]
	ldrb	r0,[r0, #3]
	cmp	r1,r0
	beq	.Lj30
	bl	.Lj22
.Lj30:
	bl	.Lj29
.Lj22:
	bl	.Lj10
.Lj29:
# [85] ip_data_len := ip_total_len - ip_header_len;
	add	r0,r13,#24
	ldrh	r1,[r0]
	add	r0,r13,#16
	ldrb	r0,[r0]
	sub	r1,r0
	uxth	r1,r1
	add	r0,r13,#28
	strh	r1,[r0]
# [86] case(IP_Header^.protocol) of
	ldr	r0,[r13, #8]
	ldrb	r0,[r0, #9]
	cmp	r0,#1
	bcs	.Lj35
	bl	.Lj31
.Lj35:
	sub	r0,#1
	bne	.Lj36
	bl	.Lj32
.Lj36:
	sub	r0,#5
	bne	.Lj37
	bl	.Lj33
.Lj37:
	sub	r0,#11
	bne	.Lj38
	bl	.Lj34
.Lj38:
	bl	.Lj31
.Lj32:
# [89] ETH_Protocol_IP_ICMP(ip_hdr, ip_hdr+ETH_IP_HEADER_SIZE, ip_data_len);
	ldr	r1,[r13]
	add	r1,#20
	add	r0,r13,#28
	ldrh	r2,[r0]
	ldr	r0,[r13]
	bl	ETHERNET_IP_ICMP_$$_ETH_PROTOCOL_IP_ICMP$PBYTE$PBYTE$WORD$$WORD
	bl	.Lj31
.Lj33:
# [93] ETH_Protocol_IP_TCP(ip_hdr, ip_hdr+ETH_IP_HEADER_SIZE, ip_data_len);
	ldr	r1,[r13]
	add	r1,#20
	add	r0,r13,#28
	ldrh	r2,[r0]
	ldr	r0,[r13]
	bl	ETHERNET_IP_TCP_$$_ETH_PROTOCOL_IP_TCP$PBYTE$PBYTE$WORD
	bl	.Lj31
.Lj34:
# [98] ETH_Protocol_IP_UDP(ip_hdr, ip_hdr+ETH_IP_HEADER_SIZE, ip_data_len);
	ldr	r1,[r13]
	add	r1,#20
	add	r0,r13,#28
	ldrh	r2,[r0]
	ldr	r0,[r13]
	bl	ETHERNET_IP_UDP_$$_ETH_PROTOCOL_IP_UDP$PBYTE$PBYTE$WORD$$WORD
	bl	.Lj31
.Lj31:
.Lj10:
# [101] end;
	add	r13,r13,#56
	pop	{r15}
.Lc3:
	.balign 4
.Lj18:
	.long	65535
.Le1:
	.size	ETHERNET_IP_$$_ETH_PROTOCOL_IP$PBYTE$PBYTE, .Le1 - ETHERNET_IP_$$_ETH_PROTOCOL_IP$PBYTE$PBYTE
# End asmlist al_procedures
# Begin asmlist al_typedconsts

.section .data.n_TC_$ETHERNET_IP_$$_PACKAGE_ID
	.balign 2
.globl	TC_$ETHERNET_IP_$$_PACKAGE_ID
TC_$ETHERNET_IP_$$_PACKAGE_ID:
	.short	0
# [29] function Calc_Checksum(buf : PWord; num_of_shorts, start : word) : word;
.Le2:
	.size	TC_$ETHERNET_IP_$$_PACKAGE_ID, .Le2 - TC_$ETHERNET_IP_$$_PACKAGE_ID
# End asmlist al_typedconsts
# Begin asmlist al_rtti

.section .rodata.n_INIT_$ETHERNET_IP_$$_TIP_HDR
	.balign 4
.globl	INIT_$ETHERNET_IP_$$_TIP_HDR
INIT_$ETHERNET_IP_$$_TIP_HDR:
	.byte	13,7
# [104] 
	.ascii	"TIP_HDR"
	.byte	0,0,0
	.long	0,0,20,0,0,0
.Le3:
	.size	INIT_$ETHERNET_IP_$$_TIP_HDR, .Le3 - INIT_$ETHERNET_IP_$$_TIP_HDR

.section .rodata.n_RTTI_$ETHERNET_IP_$$_TIP_HDR
	.balign 4
.globl	RTTI_$ETHERNET_IP_$$_TIP_HDR
RTTI_$ETHERNET_IP_$$_TIP_HDR:
	.byte	13,7
	.ascii	"TIP_HDR"
	.byte	0,0,0
	.long	0
	.long	INIT_$ETHERNET_IP_$$_TIP_HDR
	.long	20,11
	.long	RTTI_$SYSTEM_$$_BYTE$indirect
	.long	0
	.long	RTTI_$SYSTEM_$$_BYTE$indirect
	.long	1
	.long	RTTI_$SYSTEM_$$_WORD$indirect
	.long	2
	.long	RTTI_$SYSTEM_$$_WORD$indirect
	.long	4
	.long	RTTI_$SYSTEM_$$_BYTE$indirect
	.long	6
	.long	RTTI_$SYSTEM_$$_BYTE$indirect
	.long	7
	.long	RTTI_$SYSTEM_$$_BYTE$indirect
	.long	8
	.long	RTTI_$SYSTEM_$$_BYTE$indirect
	.long	9
	.long	RTTI_$SYSTEM_$$_WORD$indirect
	.long	10
	.long	RTTI_$SYSTEM_$$_LONGWORD$indirect
	.long	12
	.long	RTTI_$SYSTEM_$$_LONGWORD$indirect
	.long	16
.Le4:
	.size	RTTI_$ETHERNET_IP_$$_TIP_HDR, .Le4 - RTTI_$ETHERNET_IP_$$_TIP_HDR

.section .rodata.n_RTTI_$ETHERNET_IP_$$_PIP_HDR
	.balign 4
.globl	RTTI_$ETHERNET_IP_$$_PIP_HDR
RTTI_$ETHERNET_IP_$$_PIP_HDR:
	.byte	29,7
	.ascii	"PIP_HDR"
	.byte	0,0,0
	.long	0
	.long	RTTI_$ETHERNET_IP_$$_TIP_HDR$indirect
.Le5:
	.size	RTTI_$ETHERNET_IP_$$_PIP_HDR, .Le5 - RTTI_$ETHERNET_IP_$$_PIP_HDR
# End asmlist al_rtti
# Begin asmlist al_indirectglobals

.section .rodata.n_INIT_$ETHERNET_IP_$$_TIP_HDR
	.balign 4
.globl	INIT_$ETHERNET_IP_$$_TIP_HDR$indirect
INIT_$ETHERNET_IP_$$_TIP_HDR$indirect:
	.long	INIT_$ETHERNET_IP_$$_TIP_HDR
.Le6:
	.size	INIT_$ETHERNET_IP_$$_TIP_HDR$indirect, .Le6 - INIT_$ETHERNET_IP_$$_TIP_HDR$indirect

.section .rodata.n_RTTI_$ETHERNET_IP_$$_TIP_HDR
	.balign 4
.globl	RTTI_$ETHERNET_IP_$$_TIP_HDR$indirect
RTTI_$ETHERNET_IP_$$_TIP_HDR$indirect:
	.long	RTTI_$ETHERNET_IP_$$_TIP_HDR
.Le7:
	.size	RTTI_$ETHERNET_IP_$$_TIP_HDR$indirect, .Le7 - RTTI_$ETHERNET_IP_$$_TIP_HDR$indirect

.section .rodata.n_RTTI_$ETHERNET_IP_$$_PIP_HDR
	.balign 4
.globl	RTTI_$ETHERNET_IP_$$_PIP_HDR$indirect
RTTI_$ETHERNET_IP_$$_PIP_HDR$indirect:
	.long	RTTI_$ETHERNET_IP_$$_PIP_HDR
.Le8:
	.size	RTTI_$ETHERNET_IP_$$_PIP_HDR$indirect, .Le8 - RTTI_$ETHERNET_IP_$$_PIP_HDR$indirect
# End asmlist al_indirectglobals
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

