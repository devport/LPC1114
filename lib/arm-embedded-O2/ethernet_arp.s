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
	push	{r4,r5,r6,r7,r14}
	sub	r13,r13,#64
# Var ARP_Header located in register r0
# Var buffer located in register r0
# Var opcode located in register r0
# Var arp_hdr located in register r0
	mov	r4,r1
# Var ip located in register r4
# Var ARP_Header located in register r0
# [47] ARP_Header := PARP_HDR(arp_hdr);
	mov	r5,r0
# Var arp_hdr located in register r5
	mov	r7,r5
# Peephole MovMov2Mov removed superfluous mov
# Var ARP_Header located in register r7
# [48] opcode := ByteSwap16(ARP_Header^.Opcode);
	ldrb	r1,[r7, #6]
	ldrb	r0,[r7, #7]
	lsl	r0,#8
	orr	r1,r0
	mov	r0,r1
	bl	ETHERNET_$$_BYTESWAP16$WORD$$WORD
	uxth	r1,r0
# Var opcode located in register r1
# Peephole UxthMov2Data removed superfluous mov
	ldrb	r3,[r7, #24]
	ldrb	r0,[r7, #25]
	lsl	r0,#8
	orr	r3,r0
	ldrb	r0,[r7, #26]
	lsl	r0,#16
	orr	r3,r0
	ldrb	r0,[r7, #27]
	lsl	r0,#24
	orr	r3,r0
# [52] if(((ARP_Header^.Target_IP AND $FF) <> ip[0]) OR
	mov	r6,r3
	mov	r0,#255
	and	r6,r0
	mov	r2,r4
# Peephole MovMov2Mov removed superfluous mov
	ldrb	r0,[r2]
	cmp	r6,r0
	beq	.Lj7
	bl	.Lj5
.Lj7:
	bl	.Lj6
.Lj6:
# [53] (((ARP_Header^.Target_IP >> 8) AND $FF) <> ip[1]) OR
	mov	r4,r3
	lsr	r4,r4,#8
	mov	r0,#255
	and	r4,r0
	ldrb	r0,[r2, #1]
	cmp	r4,r0
	beq	.Lj9
	bl	.Lj5
.Lj9:
	bl	.Lj8
.Lj8:
# [54] (((ARP_Header^.Target_IP >> 16) AND $FF)  <> ip[2]) OR
	mov	r4,r3
	lsr	r4,r4,#16
	mov	r0,#255
	and	r4,r0
	ldrb	r0,[r2, #2]
	cmp	r4,r0
	beq	.Lj11
	bl	.Lj5
.Lj11:
	bl	.Lj10
.Lj10:
# [55] (((ARP_Header^.Target_IP >> 24) AND $FF)  <> ip[3])) then exit;
	lsr	r3,r3,#24
	mov	r0,#255
	and	r3,r0
	ldrb	r0,[r2, #3]
	cmp	r3,r0
	beq	.Lj13
	bl	.Lj5
.Lj13:
	bl	.Lj12
.Lj5:
	bl	.Lj3
.Lj12:
# [57] case (opcode) of
	mov	r0,r1
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
	mov	r0,r5
	sub	r0,#14
# [61] ETH_Protocol_ARP_Reply(buffer, ARP_Header^.Sender_IP, ARP_Header^.Sender_MAC);
	mov	r2,r7
	add	r2,#8
	ldrb	r3,[r7, #14]
	ldrb	r1,[r7, #15]
	lsl	r1,#8
	orr	r3,r1
	ldrb	r1,[r7, #16]
	lsl	r1,#16
	orr	r3,r1
	ldrb	r1,[r7, #17]
	lsl	r1,#24
	orr	r3,r1
	mov	r1,r3
	bl	ETHERNET_ARP_$$_ETH_PROTOCOL_ARP_REPLY$PBYTE$LONGWORD$PBYTE
	bl	.Lj14
.Lj14:
.Lj3:
# [73] end;
	add	r13,r13,#64
	pop	{r4,r5,r6,r7,r15}
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
	push	{r4,r5,r6,r14}
	sub	r13,r13,#96
# Var ETH_Header located at r13+0, size=OS_NO
# Var ARP_Header located at r13+16, size=OS_NO
# Var i located in register r0
	mov	r6,r0
# Var snd_buf located in register r6
	mov	r5,r1
# Var dst_ip located in register r5
	mov	r4,r2
# Var dst_mac located in register r4
# [81] ETH_Header.hdrtype := ByteSwap16(ETH_FRAME_TYPE_ARP);
	ldr	r0,.Lj20
	bl	ETHERNET_$$_BYTESWAP16$WORD$$WORD
	uxth	r1,r0
	add	r0,r13,#12
	strh	r1,[r0]
# Var i located in register r2
# [82] for i:=0 to 5 do begin
	mov	r2,#255
.Lj21:
	mov	r0,r2
	add	r0,#1
	uxtb	r2,r0
# Peephole UxtbMov2Data removed superfluous mov
# [83] ETH_Header.dst[i] := dst_mac[i];
	uxtb	r0,r2
	ldrb	r1,[r4, r2]
	add	r0,r13
	strb	r1,[r0]
# [84] ETH_Header.src[i] := MACADDR[i];
	ldr	r0,.Lj24
	ldr	r0,[r0]
	uxtb	r3,r2
	ldrb	r1,[r0, r2]
	mov	r0,r3
	add	r0,r13
	add	r0,#6
	strb	r1,[r0]
# [85] ARP_Header.Sender_MAC[i] := MACADDR[i];
	ldr	r0,.Lj24
	ldr	r0,[r0]
	uxtb	r3,r2
	ldrb	r1,[r0, r2]
	mov	r0,r3
	add	r0,r13
	add	r0,#24
	strb	r1,[r0]
# [86] ARP_Header.Target_MAC[i] := dst_mac[i];
	uxtb	r0,r2
	ldrb	r1,[r4, r2]
	add	r0,r13
	add	r0,#34
	strb	r1,[r0]
	cmp	r2,#5
	bcc	.Lj26
	bl	.Lj23
.Lj26:
	bl	.Lj21
.Lj23:
	ldr	r0,.Lj27
	ldr	r1,[r0]
# [89] ARP_Header.Sender_IP := ByteSwap32((ip[0]<<24) OR (ip[1] << 16) OR (ip[2] << 8) OR ip[3]);
	ldrb	r2,[r1]
# Peephole LdrMov2Ldr removed superfluous mov
	lsl	r2,r2,#24
	ldrb	r3,[r1, #1]
# Peephole LdrMov2Ldr removed superfluous mov
	lsl	r3,r3,#16
	orr	r3,r2
	ldrb	r2,[r1, #2]
# Peephole LdrMov2Ldr removed superfluous mov
	lsl	r2,r2,#8
	orr	r2,r3
	ldrb	r0,[r1, #3]
	orr	r0,r2
	bl	ETHERNET_$$_BYTESWAP32$LONGWORD$$LONGWORD
	mov	r1,r13
	add	r1,#30
	strh	r0,[r1]
	lsr	r0,r0,#16
	strh	r0,[r1, #2]
# [90] ARP_Header.Target_IP := dst_ip;
	mov	r0,r5
# Var dst_ip located in register r0
	str	r0,[r13, #40]
# [91] ARP_Header.hardware_type := ByteSwap16(HARDWARE_TYPE_ETHERNET);
	mov	r0,#1
	bl	ETHERNET_$$_BYTESWAP16$WORD$$WORD
	uxth	r1,r0
	add	r0,r13,#16
	strh	r1,[r0]
# [92] ARP_Header.protocol_type := ByteSwap16(PROTOCOL_TYPE_IPV4);
	ldr	r0,.Lj28
	bl	ETHERNET_$$_BYTESWAP16$WORD$$WORD
	uxth	r1,r0
	mov	r0,r13
	add	r0,#18
	strh	r1,[r0]
# [93] ARP_Header.hardware_Size := HARDWARE_SIZE;
	mov	r0,#6
	add	r1,r13,#20
	strb	r0,[r1]
# [94] ARP_Header.protocol_Size := PROTOCOL_SIZE;
	mov	r1,#4
	mov	r0,r13
	add	r0,#21
	strb	r1,[r0]
# [95] ARP_Header.opcode := ByteSwap16(ARP_OPCODE_REPLY);
	mov	r0,#2
	bl	ETHERNET_$$_BYTESWAP16$WORD$$WORD
	uxth	r1,r0
	mov	r0,r13
	add	r0,#22
	strh	r1,[r0]
# [97] FillByte(snd_buf[0], BUFFER_SIZE, 0);
	ldr	r1,.Lj29
	mov	r2,#0
	mov	r0,r6
	bl	SYSTEM_$$_FILLBYTE$formal$LONGINT$BYTE
# [98] move(ETH_Header, snd_buf[0], sizeof(ETH_Header));
	mov	r0,r13
	mov	r2,#14
	mov	r1,r6
	bl	SYSTEM_$$_MOVE$formal$formal$LONGINT
# [99] move(ARP_Header, snd_buf[sizeof(ETH_Header)], sizeof(ARP_Header));
	add	r0,r13,#16
	mov	r2,#28
	mov	r1,r6
	add	r1,#14
	bl	SYSTEM_$$_MOVE$formal$formal$LONGINT
# [101] enc28j60PacketSend(sizeof(ETH_Header) + sizeof(ARP_Header), snd_buf);
	mov	r1,r6
# Var snd_buf located in register r1
	mov	r0,#42
	bl	ENC28J60_$$_ENC28J60PACKETSEND$WORD$PBYTE
# [102] end;
	add	r13,r13,#96
	pop	{r4,r5,r6,r15}
.Lc3:
	.balign 4
.Lj20:
	.long	2054
.Lj24:
	.long	TC_$ETHERNET_$$_MACADDR
.Lj27:
	.long	TC_$ETHERNET_$$_IP
.Lj28:
	.long	2048
.Lj29:
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

