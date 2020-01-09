	.file "ethernet_arp.pas"
# Begin asmlist al_procedures

.section .text.n_ethernet_arp_$$_eth_protocol_arp$pbyte$pbyte,"ax"
	.balign 4
.thumb_func 
.globl	ETHERNET_ARP_$$_ETH_PROTOCOL_ARP$PBYTE$PBYTE
ETHERNET_ARP_$$_ETH_PROTOCOL_ARP$PBYTE$PBYTE:
.Lc2:
# [ethernet_arp.pas]
# [46] begin
	push	{r14}
	sub	r13,r13,#56
# Var arp_hdr located at r13+0, size=OS_32
# Var ip located at r13+4, size=OS_32
# Var ARP_Header located at r13+8, size=OS_32
# Var buffer located at r13+12, size=OS_32
# Var opcode located at r13+16, size=OS_16
	str	r0,[r13]
	str	r1,[r13, #4]
# [47] ARP_Header := PARP_HDR(arp_hdr);
	ldr	r0,[r13]
	str	r0,[r13, #8]
# [48] opcode := ByteSwap16(ARP_Header^.Opcode);
	ldr	r0,[r13, #8]
	ldrb	r1,[r0, #6]
	ldrb	r0,[r0, #7]
	lsl	r0,#8
	orr	r1,r0
	mov	r0,r1
	bl	ETHERNET_$$_BYTESWAP16$WORD$$WORD
	uxth	r1,r0
	add	r0,r13,#16
	strh	r1,[r0]
# [52] if(((ARP_Header^.Target_IP AND $FF) <> ip[0]) OR
	ldr	r2,[r13, #8]
	ldrb	r1,[r2, #24]
	ldrb	r0,[r2, #25]
	lsl	r0,#8
	orr	r1,r0
	ldrb	r0,[r2, #26]
	lsl	r0,#16
	orr	r1,r0
	ldrb	r0,[r2, #27]
	lsl	r0,#24
	orr	r1,r0
	mov	r0,#255
	and	r1,r0
	ldr	r0,[r13, #4]
	ldrb	r0,[r0]
	cmp	r1,r0
	beq	.Lj7
	bl	.Lj5
.Lj7:
	bl	.Lj6
.Lj6:
# [53] (((ARP_Header^.Target_IP >> 8) AND $FF) <> ip[1]) OR
	ldr	r2,[r13, #8]
	ldrb	r1,[r2, #24]
	ldrb	r0,[r2, #25]
	lsl	r0,#8
	orr	r1,r0
	ldrb	r0,[r2, #26]
	lsl	r0,#16
	orr	r1,r0
	ldrb	r0,[r2, #27]
	lsl	r0,#24
	orr	r1,r0
	lsr	r1,r1,#8
	mov	r0,#255
	and	r1,r0
	ldr	r0,[r13, #4]
	ldrb	r0,[r0, #1]
	cmp	r1,r0
	beq	.Lj9
	bl	.Lj5
.Lj9:
	bl	.Lj8
.Lj8:
# [54] (((ARP_Header^.Target_IP >> 16) AND $FF)  <> ip[2]) OR
	ldr	r1,[r13, #8]
	ldrb	r2,[r1, #24]
	ldrb	r0,[r1, #25]
	lsl	r0,#8
	orr	r2,r0
	ldrb	r0,[r1, #26]
	lsl	r0,#16
	orr	r2,r0
	ldrb	r0,[r1, #27]
	lsl	r0,#24
	orr	r2,r0
	mov	r1,r2
	lsr	r1,r1,#16
	mov	r0,#255
	and	r1,r0
	ldr	r0,[r13, #4]
	ldrb	r0,[r0, #2]
	cmp	r1,r0
	beq	.Lj11
	bl	.Lj5
.Lj11:
	bl	.Lj10
.Lj10:
# [55] (((ARP_Header^.Target_IP >> 24) AND $FF)  <> ip[3])) then exit;
	ldr	r1,[r13, #8]
	ldrb	r2,[r1, #24]
	ldrb	r0,[r1, #25]
	lsl	r0,#8
	orr	r2,r0
	ldrb	r0,[r1, #26]
	lsl	r0,#16
	orr	r2,r0
	ldrb	r0,[r1, #27]
	lsl	r0,#24
	orr	r2,r0
	mov	r1,r2
	lsr	r1,r1,#24
	mov	r0,#255
	and	r1,r0
	ldr	r0,[r13, #4]
	ldrb	r0,[r0, #3]
	cmp	r1,r0
	beq	.Lj13
	bl	.Lj5
.Lj13:
	bl	.Lj12
.Lj5:
	bl	.Lj3
.Lj12:
# [57] case (opcode) of
	add	r0,r13,#16
	ldrh	r0,[r0]
	cmp	r0,#1
	bcs	.Lj16
	bl	.Lj14
.Lj16:
	sub	r0,#1
	bne	.Lj17
	bl	.Lj15
.Lj17:
	bl	.Lj14
.Lj15:
# [60] buffer := arp_hdr - ETH_HEADER_SIZE;
	ldr	r0,[r13]
	sub	r0,#14
	str	r0,[r13, #12]
# [61] ETH_Protocol_ARP_Reply(buffer, ARP_Header^.Sender_IP, ARP_Header^.Sender_MAC);
	ldr	r2,[r13, #8]
	add	r2,#8
	ldr	r1,[r13, #8]
	ldrb	r3,[r1, #14]
	ldrb	r0,[r1, #15]
	lsl	r0,#8
	orr	r3,r0
	ldrb	r0,[r1, #16]
	lsl	r0,#16
	orr	r3,r0
	ldrb	r0,[r1, #17]
	lsl	r0,#24
	orr	r3,r0
	ldr	r0,[r13, #12]
	mov	r1,r3
	bl	ETHERNET_ARP_$$_ETH_PROTOCOL_ARP_REPLY$PBYTE$LONGWORD$PBYTE
	bl	.Lj14
.Lj14:
.Lj3:
# [73] end;
	add	r13,r13,#56
	pop	{r15}
.Lc1:
.Le0:
	.size	ETHERNET_ARP_$$_ETH_PROTOCOL_ARP$PBYTE$PBYTE, .Le0 - ETHERNET_ARP_$$_ETH_PROTOCOL_ARP$PBYTE$PBYTE

.section .text.n_ethernet_arp_$$_eth_protocol_arp_reply$pbyte$longword$pbyte,"ax"
	.balign 4
.thumb_func 
.globl	ETHERNET_ARP_$$_ETH_PROTOCOL_ARP_REPLY$PBYTE$LONGWORD$PBYTE
ETHERNET_ARP_$$_ETH_PROTOCOL_ARP_REPLY$PBYTE$LONGWORD$PBYTE:
.Lc4:
# [80] begin
	push	{r14}
	sub	r13,r13,#88
# Var snd_buf located at r13+0, size=OS_32
# Var dst_ip located at r13+4, size=OS_32
# Var dst_mac located at r13+8, size=OS_32
# Var ETH_Header located at r13+12, size=OS_NO
# Var ARP_Header located at r13+28, size=OS_NO
# Var i located at r13+56, size=OS_8
	str	r0,[r13]
	str	r1,[r13, #4]
	str	r2,[r13, #8]
# [81] ETH_Header.hdrtype := ByteSwap16(ETH_FRAME_TYPE_ARP);
	ldr	r0,.Lj20
	bl	ETHERNET_$$_BYTESWAP16$WORD$$WORD
	uxth	r1,r0
	add	r0,r13,#24
	strh	r1,[r0]
# [82] for i:=0 to 5 do begin
	mov	r1,#255
	add	r0,r13,#56
	strb	r1,[r0]
.Lj21:
	add	r0,r13,#56
	ldrb	r0,[r0]
	add	r0,#1
	uxtb	r0,r0
	add	r1,r13,#56
	strb	r0,[r1]
# [83] ETH_Header.dst[i] := dst_mac[i];
	ldr	r2,[r13, #8]
	add	r0,r13,#56
	ldrb	r1,[r0]
	add	r0,r13,#56
	ldrb	r0,[r0]
	ldrb	r1,[r2, r1]
	add	r0,r13
	add	r0,#12
	strb	r1,[r0]
# [84] ETH_Header.src[i] := MACADDR[i];
	ldr	r0,.Lj24
	ldr	r2,[r0]
	add	r0,r13,#56
	ldrb	r1,[r0]
	add	r0,r13,#56
	ldrb	r0,[r0]
	ldrb	r1,[r2, r1]
	add	r0,r13
	add	r0,#18
	strb	r1,[r0]
# [85] ARP_Header.Sender_MAC[i] := MACADDR[i];
	ldr	r0,.Lj24
	ldr	r2,[r0]
	add	r0,r13,#56
	ldrb	r1,[r0]
	add	r0,r13,#56
	ldrb	r0,[r0]
	ldrb	r1,[r2, r1]
	add	r0,r13
	add	r0,#36
	strb	r1,[r0]
# [86] ARP_Header.Target_MAC[i] := dst_mac[i];
	ldr	r2,[r13, #8]
	add	r0,r13,#56
	ldrb	r1,[r0]
	add	r0,r13,#56
	ldrb	r0,[r0]
	ldrb	r1,[r2, r1]
	add	r0,r13
	add	r0,#46
	strb	r1,[r0]
	add	r0,r13,#56
	ldrb	r0,[r0]
	cmp	r0,#5
	bcc	.Lj26
	bl	.Lj23
.Lj26:
	bl	.Lj21
.Lj23:
# [89] ARP_Header.Sender_IP := ByteSwap32((ip[0]<<24) OR (ip[1] << 16) OR (ip[2] << 8) OR ip[3]);
	ldr	r0,.Lj27
	ldr	r0,[r0]
	ldrb	r0,[r0]
	mov	r2,r0
	lsl	r2,r2,#24
	ldr	r0,.Lj27
	ldr	r0,[r0]
	ldrb	r0,[r0, #1]
	mov	r1,r0
	lsl	r1,r1,#16
	orr	r1,r2
	ldr	r0,.Lj27
	ldr	r0,[r0]
	ldrb	r0,[r0, #2]
	mov	r2,r0
	lsl	r2,r2,#8
	orr	r2,r1
	ldr	r0,.Lj27
	ldr	r0,[r0]
	ldrb	r0,[r0, #3]
	orr	r0,r2
	bl	ETHERNET_$$_BYTESWAP32$LONGWORD$$LONGWORD
	mov	r1,r13
	add	r1,#42
	strh	r0,[r1]
	lsr	r0,r0,#16
	strh	r0,[r1, #2]
# [90] ARP_Header.Target_IP := dst_ip;
	ldr	r0,[r13, #4]
	str	r0,[r13, #52]
# [91] ARP_Header.hardware_type := ByteSwap16(HARDWARE_TYPE_ETHERNET);
	mov	r0,#1
	bl	ETHERNET_$$_BYTESWAP16$WORD$$WORD
	uxth	r0,r0
	add	r1,r13,#28
	strh	r0,[r1]
# [92] ARP_Header.protocol_type := ByteSwap16(PROTOCOL_TYPE_IPV4);
	ldr	r0,.Lj31
	bl	ETHERNET_$$_BYTESWAP16$WORD$$WORD
	uxth	r1,r0
	mov	r0,r13
	add	r0,#30
	strh	r1,[r0]
# [93] ARP_Header.hardware_Size := HARDWARE_SIZE;
	mov	r0,#6
	add	r1,r13,#32
	strb	r0,[r1]
# [94] ARP_Header.protocol_Size := PROTOCOL_SIZE;
	mov	r1,#4
	mov	r0,r13
	add	r0,#33
	strb	r1,[r0]
# [95] ARP_Header.opcode := ByteSwap16(ARP_OPCODE_REPLY);
	mov	r0,#2
	bl	ETHERNET_$$_BYTESWAP16$WORD$$WORD
	uxth	r1,r0
	mov	r0,r13
	add	r0,#34
	strh	r1,[r0]
# [97] FillByte(snd_buf[0], BUFFER_SIZE, 0);
	ldr	r1,.Lj32
	ldr	r0,[r13]
	mov	r2,#0
	bl	SYSTEM_$$_FILLBYTE$formal$LONGINT$BYTE
# [98] move(ETH_Header, snd_buf[0], sizeof(ETH_Header));
	ldr	r1,[r13]
	add	r0,r13,#12
	mov	r2,#14
	bl	SYSTEM_$$_MOVE$formal$formal$LONGINT
# [99] move(ARP_Header, snd_buf[sizeof(ETH_Header)], sizeof(ARP_Header));
	ldr	r1,[r13]
	add	r1,#14
	add	r0,r13,#28
	mov	r2,#28
	bl	SYSTEM_$$_MOVE$formal$formal$LONGINT
# [101] enc28j60PacketSend(sizeof(ETH_Header) + sizeof(ARP_Header), snd_buf);
	ldr	r1,[r13]
	mov	r0,#42
	bl	ENC28J60_$$_ENC28J60PACKETSEND$WORD$PBYTE
# [102] end;
	add	r13,r13,#88
	pop	{r15}
.Lc3:
	.balign 4
.Lj20:
	.long	2054
.Lj24:
	.long	TC_$ETHERNET_$$_MACADDR
.Lj27:
	.long	TC_$ETHERNET_$$_IP
.Lj31:
	.long	2048
.Lj32:
	.long	1460
.Le1:
	.size	ETHERNET_ARP_$$_ETH_PROTOCOL_ARP_REPLY$PBYTE$LONGWORD$PBYTE, .Le1 - ETHERNET_ARP_$$_ETH_PROTOCOL_ARP_REPLY$PBYTE$LONGWORD$PBYTE
# End asmlist al_procedures
# Begin asmlist al_rtti

.section .rodata.n_INIT_$ETHERNET_ARP_$$_TARP_HDR
	.balign 4
.globl	INIT_$ETHERNET_ARP_$$_TARP_HDR
INIT_$ETHERNET_ARP_$$_TARP_HDR:
	.byte	13,8
# [106] 
	.ascii	"TARP_HDR"
	.byte	0,0
	.long	0,0,28,0,0,0
.Le2:
	.size	INIT_$ETHERNET_ARP_$$_TARP_HDR, .Le2 - INIT_$ETHERNET_ARP_$$_TARP_HDR

.section .rodata.n_RTTI_$ETHERNET_ARP_$$_def00000002
	.balign 4
.globl	RTTI_$ETHERNET_ARP_$$_def00000002
RTTI_$ETHERNET_ARP_$$_def00000002:
	.byte	12,0,0,0
	.long	0,6,6
	.long	RTTI_$SYSTEM_$$_BYTE$indirect
	.byte	1,0,0,0
	.long	RTTI_$SYSTEM_$$_SHORTINT$indirect
.Le3:
	.size	RTTI_$ETHERNET_ARP_$$_def00000002, .Le3 - RTTI_$ETHERNET_ARP_$$_def00000002

.section .rodata.n_RTTI_$ETHERNET_ARP_$$_def00000003
	.balign 4
.globl	RTTI_$ETHERNET_ARP_$$_def00000003
RTTI_$ETHERNET_ARP_$$_def00000003:
	.byte	12,0,0,0
	.long	0,6,6
	.long	RTTI_$SYSTEM_$$_BYTE$indirect
	.byte	1,0,0,0
	.long	RTTI_$SYSTEM_$$_SHORTINT$indirect
.Le4:
	.size	RTTI_$ETHERNET_ARP_$$_def00000003, .Le4 - RTTI_$ETHERNET_ARP_$$_def00000003

.section .rodata.n_RTTI_$ETHERNET_ARP_$$_TARP_HDR
	.balign 4
.globl	RTTI_$ETHERNET_ARP_$$_TARP_HDR
RTTI_$ETHERNET_ARP_$$_TARP_HDR:
	.byte	13,8
	.ascii	"TARP_HDR"
	.byte	0,0
	.long	0
	.long	INIT_$ETHERNET_ARP_$$_TARP_HDR
	.long	28,9
	.long	RTTI_$SYSTEM_$$_WORD$indirect
	.long	0
	.long	RTTI_$SYSTEM_$$_WORD$indirect
	.long	2
	.long	RTTI_$SYSTEM_$$_BYTE$indirect
	.long	4
	.long	RTTI_$SYSTEM_$$_BYTE$indirect
	.long	5
	.long	RTTI_$SYSTEM_$$_WORD$indirect
	.long	6
	.long	RTTI_$ETHERNET_ARP_$$_def00000002$indirect
	.long	8
	.long	RTTI_$SYSTEM_$$_LONGWORD$indirect
	.long	14
	.long	RTTI_$ETHERNET_ARP_$$_def00000003$indirect
	.long	18
	.long	RTTI_$SYSTEM_$$_LONGWORD$indirect
	.long	24
.Le5:
	.size	RTTI_$ETHERNET_ARP_$$_TARP_HDR, .Le5 - RTTI_$ETHERNET_ARP_$$_TARP_HDR

.section .rodata.n_RTTI_$ETHERNET_ARP_$$_PARP_HDR
	.balign 4
.globl	RTTI_$ETHERNET_ARP_$$_PARP_HDR
RTTI_$ETHERNET_ARP_$$_PARP_HDR:
	.byte	29,8
	.ascii	"PARP_HDR"
	.byte	0,0
	.long	0
	.long	RTTI_$ETHERNET_ARP_$$_TARP_HDR$indirect
.Le6:
	.size	RTTI_$ETHERNET_ARP_$$_PARP_HDR, .Le6 - RTTI_$ETHERNET_ARP_$$_PARP_HDR
# End asmlist al_rtti
# Begin asmlist al_indirectglobals

.section .rodata.n_INIT_$ETHERNET_ARP_$$_TARP_HDR
	.balign 4
.globl	INIT_$ETHERNET_ARP_$$_TARP_HDR$indirect
INIT_$ETHERNET_ARP_$$_TARP_HDR$indirect:
	.long	INIT_$ETHERNET_ARP_$$_TARP_HDR
.Le7:
	.size	INIT_$ETHERNET_ARP_$$_TARP_HDR$indirect, .Le7 - INIT_$ETHERNET_ARP_$$_TARP_HDR$indirect

.section .rodata.n_RTTI_$ETHERNET_ARP_$$_def00000002
	.balign 4
.globl	RTTI_$ETHERNET_ARP_$$_def00000002$indirect
RTTI_$ETHERNET_ARP_$$_def00000002$indirect:
	.long	RTTI_$ETHERNET_ARP_$$_def00000002
.Le8:
	.size	RTTI_$ETHERNET_ARP_$$_def00000002$indirect, .Le8 - RTTI_$ETHERNET_ARP_$$_def00000002$indirect

.section .rodata.n_RTTI_$ETHERNET_ARP_$$_def00000003
	.balign 4
.globl	RTTI_$ETHERNET_ARP_$$_def00000003$indirect
RTTI_$ETHERNET_ARP_$$_def00000003$indirect:
	.long	RTTI_$ETHERNET_ARP_$$_def00000003
.Le9:
	.size	RTTI_$ETHERNET_ARP_$$_def00000003$indirect, .Le9 - RTTI_$ETHERNET_ARP_$$_def00000003$indirect

.section .rodata.n_RTTI_$ETHERNET_ARP_$$_TARP_HDR
	.balign 4
.globl	RTTI_$ETHERNET_ARP_$$_TARP_HDR$indirect
RTTI_$ETHERNET_ARP_$$_TARP_HDR$indirect:
	.long	RTTI_$ETHERNET_ARP_$$_TARP_HDR
.Le10:
	.size	RTTI_$ETHERNET_ARP_$$_TARP_HDR$indirect, .Le10 - RTTI_$ETHERNET_ARP_$$_TARP_HDR$indirect

.section .rodata.n_RTTI_$ETHERNET_ARP_$$_PARP_HDR
	.balign 4
.globl	RTTI_$ETHERNET_ARP_$$_PARP_HDR$indirect
RTTI_$ETHERNET_ARP_$$_PARP_HDR$indirect:
	.long	RTTI_$ETHERNET_ARP_$$_PARP_HDR
.Le11:
	.size	RTTI_$ETHERNET_ARP_$$_PARP_HDR$indirect, .Le11 - RTTI_$ETHERNET_ARP_$$_PARP_HDR$indirect
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

