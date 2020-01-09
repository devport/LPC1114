	.file "ethernet_ip_icmp.pas"
# Begin asmlist al_procedures

.section .text.n_ethernet_ip_icmp_$$_eth_protocol_ip_icmp$pbyte$pbyte$word$$word,"ax"
	.balign 4
.thumb_func 
.globl	ETHERNET_IP_ICMP_$$_ETH_PROTOCOL_IP_ICMP$PBYTE$PBYTE$WORD$$WORD
ETHERNET_IP_ICMP_$$_ETH_PROTOCOL_IP_ICMP$PBYTE$PBYTE$WORD$$WORD:
.Lc2:
# [ethernet_ip_icmp.pas]
# [41] begin
	push	{r14}
	sub	r13,r13,#64
# Var ip_hdr located at r13+0, size=OS_32
# Var icmp_hdr located at r13+4, size=OS_32
# Var size located at r13+8, size=OS_16
# Var $result located at r13+12, size=OS_16
# Var ETH_Header located at r13+16, size=OS_32
# Var IP_Header located at r13+20, size=OS_32
# Var ICMP_Header located at r13+24, size=OS_32
# Var checksum located at r13+28, size=OS_16
# Var checksum_size located at r13+32, size=OS_16
	str	r0,[r13]
	str	r1,[r13, #4]
	add	r0,r13,#8
	strh	r2,[r0]
# [42] Result := 0;
	mov	r1,#0
	add	r0,r13,#12
	strh	r1,[r0]
# [43] ICMP_Header := PICMP_HDR(icmp_hdr);
	ldr	r0,[r13, #4]
	str	r0,[r13, #24]
# [44] IP_Header := PIP_HDR(ip_hdr);
	ldr	r0,[r13]
	str	r0,[r13, #20]
# [45] ETH_Header := PETH_HDR(ip_hdr)-ETH_HEADER_SIZE;
	ldr	r0,[r13]
	sub	r0,#196
	str	r0,[r13, #16]
# [47] checksum_size := size;
	add	r0,r13,#8
	ldrh	r1,[r0]
	add	r0,r13,#32
	strh	r1,[r0]
# [48] if (checksum_size AND $01) = $01 then begin
	add	r0,r13,#32
	ldrh	r0,[r0]
	mov	r1,#1
	and	r0,r1
	cmp	r0,#1
	bne	.Lj7
	bl	.Lj5
.Lj7:
	bl	.Lj6
.Lj5:
# [49] icmp_hdr[checksum_size] := 0;
	ldr	r2,[r13, #4]
	add	r0,r13,#32
	ldrh	r1,[r0]
	mov	r0,#0
	strb	r0,[r2, r1]
# [50] Inc(checksum_size);
	add	r0,r13,#32
	ldrh	r0,[r0]
	add	r0,#1
	uxth	r0,r0
	add	r1,r13,#32
	strh	r0,[r1]
.Lj6:
# [53] checksum := Calc_Checksum(PWORD(ICMP_Header), checksum_size>>1, 0);
	add	r0,r13,#32
	ldrh	r0,[r0]
	lsr	r0,r0,#1
	uxth	r0,r0
	uxth	r1,r0
	mov	r2,#0
	ldr	r0,[r13, #24]
	bl	ETHERNET_IP_$$_CALC_CHECKSUM$PWORD$WORD$WORD$$WORD
	uxth	r0,r0
	add	r1,r13,#28
	strh	r0,[r1]
# [54] if (checksum <> $FFFF) then exit;
	add	r0,r13,#28
	ldrh	r1,[r0]
	ldr	r0,.Lj8
	cmp	r1,r0
	beq	.Lj11
	bl	.Lj9
.Lj11:
	bl	.Lj10
.Lj9:
	bl	.Lj3
.Lj10:
# [57] if (ICMP_Header^.hdr_type = ICMP_TYPE_REQUEST) then begin
	ldr	r0,[r13, #24]
	ldrb	r0,[r0]
	cmp	r0,#8
	bne	.Lj14
	bl	.Lj12
.Lj14:
	bl	.Lj13
.Lj12:
.Lj13:
.Lj3:
# [60] end;
	add	r1,r13,#12
	ldrh	r0,[r1]
	add	r13,r13,#64
	pop	{r15}
.Lc1:
	.balign 4
.Lj8:
	.long	65535
.Le0:
	.size	ETHERNET_IP_ICMP_$$_ETH_PROTOCOL_IP_ICMP$PBYTE$PBYTE$WORD$$WORD, .Le0 - ETHERNET_IP_ICMP_$$_ETH_PROTOCOL_IP_ICMP$PBYTE$PBYTE$WORD$$WORD

.section .text.n_ethernet_ip_icmp_$$_eth_protocol_ip_icmp_reply$longword$pbyte$word$word$qword$pbyte,"ax"
	.balign 4
.thumb_func 
.globl	ETHERNET_IP_ICMP_$$_ETH_PROTOCOL_IP_ICMP_REPLY$LONGWORD$PBYTE$WORD$WORD$QWORD$PBYTE
ETHERNET_IP_ICMP_$$_ETH_PROTOCOL_IP_ICMP_REPLY$LONGWORD$PBYTE$WORD$WORD$QWORD$PBYTE:
.Lc4:
# [70] begin
	push	{r14}
	sub	r13,r13,#260
# Var dst_ip located at r13+0, size=OS_32
# Var dst_mac located at r13+4, size=OS_32
# Var id located at r13+8, size=OS_16
# Var seq located at r13+12, size=OS_16
# Var data_time located at r13+16, size=OS_64
# Var data located at r13+24, size=OS_32
# Var ETH_Header located at r13+28, size=OS_NO
# Var IP_Header located at r13+44, size=OS_NO
# Var ICMP_Header located at r13+64, size=OS_NO
# Var i located at r13+128, size=OS_8
# Var checksum located at r13+132, size=OS_16
# Var len located at r13+136, size=OS_16
# Var snd_buf located at r13+140, size=OS_NO
	str	r0,[r13]
	str	r1,[r13, #4]
	add	r0,r13,#8
	strh	r2,[r0]
	add	r0,r13,#12
	strh	r3,[r0]
	add	r0,r13,#264
	ldr	r1,[r0]
	ldr	r0,[r0, #4]
	str	r1,[r13, #16]
	str	r0,[r13, #20]
	add	r0,r13,#272
	ldr	r0,[r0]
	str	r0,[r13, #24]
# [71] len := 0;
	mov	r1,#0
	add	r0,r13,#136
	strh	r1,[r0]
# [72] checksum := 0;
	mov	r1,#0
	add	r0,r13,#132
	strh	r1,[r0]
# [74] ETH_Header.hdrtype := ByteSwap16(ETH_FRAME_TYPE_IPV4);
	ldr	r0,.Lj17
	bl	ETHERNET_$$_BYTESWAP16$WORD$$WORD
	uxth	r1,r0
	add	r0,r13,#40
	strh	r1,[r0]
# [75] for i:=0 to 5 do begin
	mov	r1,#255
	add	r0,r13,#128
	strb	r1,[r0]
.Lj18:
	add	r0,r13,#128
	ldrb	r0,[r0]
	add	r0,#1
	uxtb	r0,r0
	add	r1,r13,#128
	strb	r0,[r1]
# [76] ETH_Header.dst[i] := dst_mac[i];
	ldr	r2,[r13, #4]
	add	r0,r13,#128
	ldrb	r1,[r0]
	add	r0,r13,#128
	ldrb	r0,[r0]
	ldrb	r1,[r2, r1]
	add	r0,r13
	add	r0,#28
	strb	r1,[r0]
# [77] ETH_Header.src[i] := MACADDR[i];
	ldr	r0,.Lj21
	ldr	r2,[r0]
	add	r0,r13,#128
	ldrb	r1,[r0]
	add	r0,r13,#128
	ldrb	r0,[r0]
	ldrb	r1,[r2, r1]
	add	r0,r13
	add	r0,#34
	strb	r1,[r0]
	add	r0,r13,#128
	ldrb	r0,[r0]
	cmp	r0,#5
	bcc	.Lj22
	bl	.Lj20
.Lj22:
	bl	.Lj18
.Lj20:
# [80] Inc(package_id);
	ldr	r0,.Lj23
	mov	r1,r0
	ldrh	r0,[r1]
	add	r0,#1
	uxth	r0,r0
	strh	r0,[r1]
# [81] IP_Header.id := ByteSwap16(package_id);
	ldr	r0,.Lj23
	ldrh	r0,[r0]
	bl	ETHERNET_$$_BYTESWAP16$WORD$$WORD
	uxth	r1,r0
	add	r0,r13,#48
	strh	r1,[r0]
# [82] IP_Header.dsfield := 0;
	mov	r1,#0
	mov	r0,r13
	add	r0,#45
	strb	r1,[r0]
# [83] IP_Header.ver_len := $45;
	mov	r0,#69
	add	r1,r13,#44
	strb	r0,[r1]
# [84] IP_Header.flags := $40;
	mov	r1,#64
	mov	r0,r13
	add	r0,#50
	strb	r1,[r0]
# [85] IP_Header.protocol := IPV4_TYPE_ICMP;
	mov	r1,#1
	mov	r0,r13
	add	r0,#53
	strb	r1,[r0]
# [86] IP_Header.ttl := 128;
	mov	r0,#128
	add	r1,r13,#52
	strb	r0,[r1]
# [87] IP_Header.frag_offset := 0;
	mov	r1,#0
	mov	r0,r13
	add	r0,#51
	strb	r1,[r0]
# [89] len := sizeof(ICMP_Header);
	mov	r0,#64
	add	r1,r13,#136
	strh	r0,[r1]
# [90] len := len + sizeof(IP_Header);
	add	r0,r13,#136
	ldrh	r0,[r0]
	add	r0,#20
	uxth	r0,r0
	add	r1,r13,#136
	strh	r0,[r1]
# [92] IP_Header.total_len := ByteSwap16(len);
	add	r0,r13,#136
	ldrh	r0,[r0]
	bl	ETHERNET_$$_BYTESWAP16$WORD$$WORD
	uxth	r1,r0
	mov	r0,r13
	add	r0,#46
	strh	r1,[r0]
# [94] IP_Header.checksum := 0;
	mov	r1,#0
	mov	r0,r13
	add	r0,#54
	strh	r1,[r0]
# [96] IP_Header.dst := dst_ip;
	ldr	r0,[r13]
	str	r0,[r13, #60]
# [97] IP_Header.src := ByteSwap32((ip[0]<<24) OR (ip[1] << 16) OR (ip[2] << 8) OR ip[3]);
	ldr	r0,.Lj25
	ldr	r0,[r0]
	ldrb	r0,[r0]
	mov	r1,r0
	lsl	r1,r1,#24
	ldr	r0,.Lj25
	ldr	r0,[r0]
	ldrb	r0,[r0, #1]
	mov	r2,r0
	lsl	r2,r2,#16
	orr	r2,r1
	ldr	r0,.Lj25
	ldr	r0,[r0]
	ldrb	r0,[r0, #2]
	mov	r1,r0
	lsl	r1,r1,#8
	orr	r1,r2
	ldr	r0,.Lj25
	ldr	r0,[r0]
	ldrb	r0,[r0, #3]
	orr	r0,r1
	bl	ETHERNET_$$_BYTESWAP32$LONGWORD$$LONGWORD
	str	r0,[r13, #56]
# [99] checksum := calc_checksum(@IP_Header, 10, 0);
	add	r0,r13,#44
	mov	r2,#0
	mov	r1,#10
	bl	ETHERNET_IP_$$_CALC_CHECKSUM$PWORD$WORD$WORD$$WORD
	uxth	r0,r0
	add	r1,r13,#132
	strh	r0,[r1]
# [100] checksum := NOT checksum;
	add	r0,r13,#132
	ldrh	r0,[r0]
	mvn	r0,r0
	add	r1,r13,#132
	strh	r0,[r1]
# [101] IP_Header.checksum := checksum;
	add	r0,r13,#132
	ldrh	r1,[r0]
	mov	r0,r13
	add	r0,#54
	strh	r1,[r0]
# [103] ICMP_Header.hdr_type := ICMP_TYPE_REPLY;
	mov	r0,#0
	add	r1,r13,#64
	strb	r0,[r1]
# [104] ICMP_Header.code := 0;
	mov	r1,#0
	mov	r0,r13
	add	r0,#65
	strb	r1,[r0]
# [105] ICMP_Header.checksum := 0;
	mov	r1,#0
	mov	r0,r13
	add	r0,#66
	strh	r1,[r0]
# [106] ICMP_Header.identifier := id;
	add	r0,r13,#8
	ldrh	r1,[r0]
	add	r0,r13,#68
	strh	r1,[r0]
# [107] ICMP_Header.sequence := seq;
	add	r0,r13,#12
	ldrh	r1,[r0]
	mov	r0,r13
	add	r0,#70
	strh	r1,[r0]
# [108] ICMP_Header.data_time := data_time;
	ldr	r2,[r13, #16]
	ldr	r1,[r13, #20]
	add	r0,r13,#72
	str	r2,[r0]
	str	r1,[r0, #4]
# [109] move(data[0], ICMP_Header.data[0], 48);
	add	r1,r13,#80
	ldr	r0,[r13, #24]
	mov	r2,#48
	bl	SYSTEM_$$_MOVE$formal$formal$LONGINT
# [112] checksum := calc_checksum(@ICMP_Header, sizeof(ICMP_Header)>>1, 0);
	add	r0,r13,#64
	mov	r2,#0
	mov	r1,#32
	bl	ETHERNET_IP_$$_CALC_CHECKSUM$PWORD$WORD$WORD$$WORD
	uxth	r1,r0
	add	r0,r13,#132
	strh	r1,[r0]
# [113] checksum := NOT checksum;
	add	r0,r13,#132
	ldrh	r0,[r0]
	mvn	r0,r0
	add	r1,r13,#132
	strh	r0,[r1]
# [114] ICMP_Header.checksum := checksum;
	add	r0,r13,#132
	ldrh	r1,[r0]
	mov	r0,r13
	add	r0,#66
	strh	r1,[r0]
# [116] FillByte(snd_buf[0], 41, 0);
	add	r0,r13,#140
	mov	r2,#0
	mov	r1,#41
	bl	SYSTEM_$$_FILLBYTE$formal$LONGINT$BYTE
# [117] move(ETH_Header, snd_buf[0], sizeof(ETH_Header));
	add	r1,r13,#140
	add	r0,r13,#28
	mov	r2,#14
	bl	SYSTEM_$$_MOVE$formal$formal$LONGINT
# [118] move(IP_Header, snd_buf[sizeof(ETH_Header)], sizeof(IP_Header));
	mov	r1,r13
	add	r1,#154
	add	r0,r13,#44
	mov	r2,#20
	bl	SYSTEM_$$_MOVE$formal$formal$LONGINT
# [119] move(ICMP_Header, snd_buf[sizeof(ETH_Header)+sizeof(IP_Header)], sizeof(ICMP_Header));
	mov	r1,r13
	add	r1,#174
	add	r0,r13,#64
	mov	r2,#64
	bl	SYSTEM_$$_MOVE$formal$formal$LONGINT
# [120] enc28j60PacketSend(sizeof(ETH_Header)+sizeof(IP_Header)+sizeof(ICMP_Header), @snd_buf[0]);
	add	r1,r13,#140
	mov	r0,#98
	bl	ENC28J60_$$_ENC28J60PACKETSEND$WORD$PBYTE
# [121] end;
	add	r13,r13,#260
	pop	{r15}
.Lc3:
	.balign 4
.Lj17:
	.long	2048
.Lj21:
	.long	TC_$ETHERNET_$$_MACADDR
.Lj23:
	.long	TC_$ETHERNET_IP_$$_PACKAGE_ID
.Lj25:
	.long	TC_$ETHERNET_$$_IP
.Le1:
	.size	ETHERNET_IP_ICMP_$$_ETH_PROTOCOL_IP_ICMP_REPLY$LONGWORD$PBYTE$WORD$WORD$QWORD$PBYTE, .Le1 - ETHERNET_IP_ICMP_$$_ETH_PROTOCOL_IP_ICMP_REPLY$LONGWORD$PBYTE$WORD$WORD$QWORD$PBYTE
# End asmlist al_procedures
# Begin asmlist al_rtti

.section .rodata.n_INIT_$ETHERNET_IP_ICMP_$$_TICMP_HDR
	.balign 4
.globl	INIT_$ETHERNET_IP_ICMP_$$_TICMP_HDR
INIT_$ETHERNET_IP_ICMP_$$_TICMP_HDR:
	.byte	13,9
# [124] 
	.ascii	"TICMP_HDR"
	.byte	0
	.long	0,0,64,0,0,0
.Le2:
	.size	INIT_$ETHERNET_IP_ICMP_$$_TICMP_HDR, .Le2 - INIT_$ETHERNET_IP_ICMP_$$_TICMP_HDR

.section .rodata.n_RTTI_$ETHERNET_IP_ICMP_$$_def00000002
	.balign 4
.globl	RTTI_$ETHERNET_IP_ICMP_$$_def00000002
RTTI_$ETHERNET_IP_ICMP_$$_def00000002:
	.byte	12,0,0,0
	.long	0,48,48
	.long	RTTI_$SYSTEM_$$_BYTE$indirect
	.byte	1,0,0,0
	.long	RTTI_$SYSTEM_$$_SHORTINT$indirect
.Le3:
	.size	RTTI_$ETHERNET_IP_ICMP_$$_def00000002, .Le3 - RTTI_$ETHERNET_IP_ICMP_$$_def00000002

.section .rodata.n_RTTI_$ETHERNET_IP_ICMP_$$_TICMP_HDR
	.balign 4
.globl	RTTI_$ETHERNET_IP_ICMP_$$_TICMP_HDR
RTTI_$ETHERNET_IP_ICMP_$$_TICMP_HDR:
	.byte	13,9
	.ascii	"TICMP_HDR"
	.byte	0
	.long	0
	.long	INIT_$ETHERNET_IP_ICMP_$$_TICMP_HDR
	.long	64,7
	.long	RTTI_$SYSTEM_$$_BYTE$indirect
	.long	0
	.long	RTTI_$SYSTEM_$$_BYTE$indirect
	.long	1
	.long	RTTI_$SYSTEM_$$_WORD$indirect
	.long	2
	.long	RTTI_$SYSTEM_$$_WORD$indirect
	.long	4
	.long	RTTI_$SYSTEM_$$_WORD$indirect
	.long	6
	.long	RTTI_$SYSTEM_$$_QWORD$indirect
	.long	8
	.long	RTTI_$ETHERNET_IP_ICMP_$$_def00000002$indirect
	.long	16
.Le4:
	.size	RTTI_$ETHERNET_IP_ICMP_$$_TICMP_HDR, .Le4 - RTTI_$ETHERNET_IP_ICMP_$$_TICMP_HDR

.section .rodata.n_RTTI_$ETHERNET_IP_ICMP_$$_PICMP_HDR
	.balign 4
.globl	RTTI_$ETHERNET_IP_ICMP_$$_PICMP_HDR
RTTI_$ETHERNET_IP_ICMP_$$_PICMP_HDR:
	.byte	29,9
	.ascii	"PICMP_HDR"
	.byte	0
	.long	0
	.long	RTTI_$ETHERNET_IP_ICMP_$$_TICMP_HDR$indirect
.Le5:
	.size	RTTI_$ETHERNET_IP_ICMP_$$_PICMP_HDR, .Le5 - RTTI_$ETHERNET_IP_ICMP_$$_PICMP_HDR
# End asmlist al_rtti
# Begin asmlist al_indirectglobals

.section .rodata.n_INIT_$ETHERNET_IP_ICMP_$$_TICMP_HDR
	.balign 4
.globl	INIT_$ETHERNET_IP_ICMP_$$_TICMP_HDR$indirect
INIT_$ETHERNET_IP_ICMP_$$_TICMP_HDR$indirect:
	.long	INIT_$ETHERNET_IP_ICMP_$$_TICMP_HDR
.Le6:
	.size	INIT_$ETHERNET_IP_ICMP_$$_TICMP_HDR$indirect, .Le6 - INIT_$ETHERNET_IP_ICMP_$$_TICMP_HDR$indirect

.section .rodata.n_RTTI_$ETHERNET_IP_ICMP_$$_def00000002
	.balign 4
.globl	RTTI_$ETHERNET_IP_ICMP_$$_def00000002$indirect
RTTI_$ETHERNET_IP_ICMP_$$_def00000002$indirect:
	.long	RTTI_$ETHERNET_IP_ICMP_$$_def00000002
.Le7:
	.size	RTTI_$ETHERNET_IP_ICMP_$$_def00000002$indirect, .Le7 - RTTI_$ETHERNET_IP_ICMP_$$_def00000002$indirect

.section .rodata.n_RTTI_$ETHERNET_IP_ICMP_$$_TICMP_HDR
	.balign 4
.globl	RTTI_$ETHERNET_IP_ICMP_$$_TICMP_HDR$indirect
RTTI_$ETHERNET_IP_ICMP_$$_TICMP_HDR$indirect:
	.long	RTTI_$ETHERNET_IP_ICMP_$$_TICMP_HDR
.Le8:
	.size	RTTI_$ETHERNET_IP_ICMP_$$_TICMP_HDR$indirect, .Le8 - RTTI_$ETHERNET_IP_ICMP_$$_TICMP_HDR$indirect

.section .rodata.n_RTTI_$ETHERNET_IP_ICMP_$$_PICMP_HDR
	.balign 4
.globl	RTTI_$ETHERNET_IP_ICMP_$$_PICMP_HDR$indirect
RTTI_$ETHERNET_IP_ICMP_$$_PICMP_HDR$indirect:
	.long	RTTI_$ETHERNET_IP_ICMP_$$_PICMP_HDR
.Le9:
	.size	RTTI_$ETHERNET_IP_ICMP_$$_PICMP_HDR$indirect, .Le9 - RTTI_$ETHERNET_IP_ICMP_$$_PICMP_HDR$indirect
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

