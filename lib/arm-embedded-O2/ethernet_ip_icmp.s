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
	push	{r4,r5,r14}
	sub	r13,r13,#64
# Var $result located in register r0
# Var ETH_Header located in register r0
# Var IP_Header located in register r0
# Var ICMP_Header located in register r0
# Var checksum located in register r0
# Var checksum_size located in register r0
# Var ip_hdr located in register r0
# Var icmp_hdr located in register r1
	uxth	r4,r2
# Var size located in register r4
# Var $result located in register r5
# [42] Result := 0;
	mov	r5,#0
# Var ICMP_Header located in register r3
# [43] ICMP_Header := PICMP_HDR(icmp_hdr);
	mov	r2,r1
# Var icmp_hdr located in register r2
	mov	r3,r2
# Var IP_Header located in register r1
# Var ip_hdr located in register r0
# [44] IP_Header := PIP_HDR(ip_hdr);
	mov	r1,r0
# [45] ETH_Header := PETH_HDR(ip_hdr)-ETH_HEADER_SIZE;
	sub	r0,#196
# Var ETH_Header located in register r0
# Var checksum_size located in register r1
# Var size located in register r4
# [47] checksum_size := size;
	mov	r1,r4
# [48] if (checksum_size AND $01) = $01 then begin
	mov	r0,r1
	mov	r4,#1
	and	r0,r4
	cmp	r0,#1
	bne	.Lj7
	bl	.Lj5
.Lj7:
	bl	.Lj6
.Lj5:
# [49] icmp_hdr[checksum_size] := 0;
	mov	r0,#0
	strb	r0,[r2, r1]
# [50] Inc(checksum_size);
	add	r1,#1
	uxth	r1,r1
.Lj6:
# [53] checksum := Calc_Checksum(PWORD(ICMP_Header), checksum_size>>1, 0);
	mov	r0,r1
	lsr	r0,r0,#1
# Peephole UxthUxth2Uxth done
	uxth	r1,r0
	mov	r2,#0
	mov	r4,r3
# Var ICMP_Header located in register r4
	mov	r0,r4
	bl	ETHERNET_IP_$$_CALC_CHECKSUM$PWORD$WORD$WORD$$WORD
	uxth	r1,r0
# Var checksum located in register r1
# [54] if (checksum <> $FFFF) then exit;
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
	ldrb	r0,[r4]
	cmp	r0,#8
	bne	.Lj14
	bl	.Lj12
.Lj14:
	bl	.Lj13
.Lj12:
.Lj13:
.Lj3:
# [60] end;
	uxth	r0,r5
	add	r13,r13,#64
	pop	{r4,r5,r15}
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
# Temps allocated between r13+200 and r13+212
# [70] begin
	push	{r4,r5,r6,r7,r14}
	sub	r13,r13,#244
# Var ETH_Header located at r13+0, size=OS_NO
# Var IP_Header located at r13+16, size=OS_NO
# Var ICMP_Header located at r13+36, size=OS_NO
# Var i located in register r0
# Var checksum located in register r0
# Var len located in register r0
# Var snd_buf located at r13+100, size=OS_NO
	mov	r5,r0
# Var dst_ip located in register r5
	mov	r4,r1
# Var dst_mac located in register r4
	uxth	r6,r2
# Var id located in register r6
	uxth	r7,r3
# Var seq located in register r7
	add	r1,r13,#264
	ldr	r0,[r13, #204]
	ldr	r0,[r1]
	str	r0,[r13, #204]
	add	r1,r13,#268
	ldr	r0,[r13, #208]
	ldr	r0,[r1]
	str	r0,[r13, #208]
# Var data_time located in register r0:r0
	add	r1,r13,#272
	ldr	r0,[r13, #200]
	ldr	r0,[r1]
	str	r0,[r13, #200]
# Var data located in register r0
# Var len located in register r0
# Peephole MovMov done
# Var checksum located in register r0
# [72] checksum := 0;
	mov	r0,#0
# [74] ETH_Header.hdrtype := ByteSwap16(ETH_FRAME_TYPE_IPV4);
	ldr	r0,.Lj17
	bl	ETHERNET_$$_BYTESWAP16$WORD$$WORD
	uxth	r1,r0
	add	r0,r13,#12
	strh	r1,[r0]
# Var i located in register r2
# [75] for i:=0 to 5 do begin
	mov	r2,#255
.Lj18:
	mov	r0,r2
	add	r0,#1
	uxtb	r2,r0
# Peephole UxtbMov2Data removed superfluous mov
# [76] ETH_Header.dst[i] := dst_mac[i];
	uxtb	r0,r2
	ldrb	r1,[r4, r2]
	add	r0,r13
	strb	r1,[r0]
# [77] ETH_Header.src[i] := MACADDR[i];
	ldr	r0,.Lj21
	ldr	r0,[r0]
	uxtb	r3,r2
	ldrb	r1,[r0, r2]
	mov	r0,r3
	add	r0,r13
	add	r0,#6
	strb	r1,[r0]
	cmp	r2,#5
	bcc	.Lj22
	bl	.Lj20
.Lj22:
	bl	.Lj18
.Lj20:
# [80] Inc(package_id);
	ldr	r1,.Lj23
# Peephole LdrMov2Ldr removed superfluous mov
	ldrh	r0,[r1]
	add	r0,#1
# Peephole UXTHStrh2Strh done
	strh	r0,[r1]
# [81] IP_Header.id := ByteSwap16(package_id);
	ldr	r0,.Lj23
	ldrh	r0,[r0]
	bl	ETHERNET_$$_BYTESWAP16$WORD$$WORD
	uxth	r1,r0
	add	r0,r13,#20
	strh	r1,[r0]
# [82] IP_Header.dsfield := 0;
	mov	r1,#0
	mov	r0,r13
	add	r0,#17
	strb	r1,[r0]
# [83] IP_Header.ver_len := $45;
	mov	r1,#69
	add	r0,r13,#16
	strb	r1,[r0]
# [84] IP_Header.flags := $40;
	mov	r1,#64
	mov	r0,r13
	add	r0,#22
	strb	r1,[r0]
# [85] IP_Header.protocol := IPV4_TYPE_ICMP;
	mov	r1,#1
	mov	r0,r13
	add	r0,#25
	strb	r1,[r0]
# [86] IP_Header.ttl := 128;
	mov	r1,#128
	add	r0,r13,#24
	strb	r1,[r0]
# [87] IP_Header.frag_offset := 0;
	mov	r1,#0
	mov	r0,r13
	add	r0,#23
	strb	r1,[r0]
# Var len located in register r0
# [89] len := sizeof(ICMP_Header);
	mov	r0,#64
# [90] len := len + sizeof(IP_Header);
	add	r0,#20
# Peephole UxthUxth2Uxth done
# Var len located in register r0
# Var len located in register r0
# [92] IP_Header.total_len := ByteSwap16(len);
	uxth	r0,r0
	bl	ETHERNET_$$_BYTESWAP16$WORD$$WORD
	uxth	r1,r0
	mov	r0,r13
	add	r0,#18
	strh	r1,[r0]
# [94] IP_Header.checksum := 0;
	mov	r1,#0
	mov	r0,r13
	add	r0,#26
	strh	r1,[r0]
# [96] IP_Header.dst := dst_ip;
	mov	r0,r5
# Var dst_ip located in register r0
	str	r0,[r13, #32]
	ldr	r0,.Lj25
	ldr	r1,[r0]
# [97] IP_Header.src := ByteSwap32((ip[0]<<24) OR (ip[1] << 16) OR (ip[2] << 8) OR ip[3]);
	ldrb	r2,[r1]
# Peephole LdrMov2Ldr removed superfluous mov
	lsl	r2,r2,#24
	ldrb	r0,[r1, #1]
	lsl	r0,r0,#16
	mov	r3,r0
	orr	r3,r2
	ldrb	r0,[r1, #2]
	lsl	r0,r0,#8
	mov	r2,r0
	orr	r2,r3
	ldrb	r0,[r1, #3]
	orr	r0,r2
	bl	ETHERNET_$$_BYTESWAP32$LONGWORD$$LONGWORD
	str	r0,[r13, #28]
# [99] checksum := calc_checksum(@IP_Header, 10, 0);
	add	r0,r13,#16
	mov	r2,#0
	mov	r1,#10
	bl	ETHERNET_IP_$$_CALC_CHECKSUM$PWORD$WORD$WORD$$WORD
	uxth	r0,r0
# Var checksum located in register r0
# [100] checksum := NOT checksum;
	mvn	r0,r0
# Var checksum located in register r0
# [101] IP_Header.checksum := checksum;
	mov	r1,r0
# Var checksum located in register r1
	mov	r0,r13
	add	r0,#26
	strh	r1,[r0]
# [103] ICMP_Header.hdr_type := ICMP_TYPE_REPLY;
	mov	r1,#0
	add	r0,r13,#36
	strb	r1,[r0]
# [104] ICMP_Header.code := 0;
	mov	r1,#0
	mov	r0,r13
	add	r0,#37
	strb	r1,[r0]
# [105] ICMP_Header.checksum := 0;
	mov	r1,#0
	mov	r0,r13
	add	r0,#38
	strh	r1,[r0]
# [106] ICMP_Header.identifier := id;
	mov	r1,r6
# Var id located in register r1
	add	r0,r13,#40
	strh	r1,[r0]
# [107] ICMP_Header.sequence := seq;
	mov	r1,r7
# Var seq located in register r1
	mov	r0,r13
	add	r0,#42
	strh	r1,[r0]
# [108] ICMP_Header.data_time := data_time;
	ldr	r2,[r13, #204]
# Peephole LdrMov2Ldr removed superfluous mov
	ldr	r1,[r13, #208]
# Peephole LdrMov2Ldr removed superfluous mov
# Var data_time located in register r1:r2
	str	r2,[r13, #44]
	str	r1,[r13, #48]
# [109] move(data[0], ICMP_Header.data[0], 48);
	add	r1,r13,#52
	mov	r2,#48
	ldr	r0,[r13, #200]
# Peephole LdrMov2Ldr removed superfluous mov
	bl	SYSTEM_$$_MOVE$formal$formal$LONGINT
# [112] checksum := calc_checksum(@ICMP_Header, sizeof(ICMP_Header)>>1, 0);
	add	r0,r13,#36
	mov	r2,#0
	mov	r1,#32
	bl	ETHERNET_IP_$$_CALC_CHECKSUM$PWORD$WORD$WORD$$WORD
	uxth	r0,r0
# Var checksum located in register r0
# [113] checksum := NOT checksum;
	mvn	r0,r0
# Var checksum located in register r0
# [114] ICMP_Header.checksum := checksum;
	mov	r1,r0
# Var checksum located in register r1
	mov	r0,r13
	add	r0,#38
	strh	r1,[r0]
# [116] FillByte(snd_buf[0], 41, 0);
	add	r0,r13,#100
	mov	r2,#0
	mov	r1,#41
	bl	SYSTEM_$$_FILLBYTE$formal$LONGINT$BYTE
# [117] move(ETH_Header, snd_buf[0], sizeof(ETH_Header));
	add	r1,r13,#100
	mov	r0,r13
	mov	r2,#14
	bl	SYSTEM_$$_MOVE$formal$formal$LONGINT
# [118] move(IP_Header, snd_buf[sizeof(ETH_Header)], sizeof(IP_Header));
	mov	r1,r13
	add	r1,#114
	add	r0,r13,#16
	mov	r2,#20
	bl	SYSTEM_$$_MOVE$formal$formal$LONGINT
# [119] move(ICMP_Header, snd_buf[sizeof(ETH_Header)+sizeof(IP_Header)], sizeof(ICMP_Header));
	mov	r1,r13
	add	r1,#134
	add	r0,r13,#36
	mov	r2,#64
	bl	SYSTEM_$$_MOVE$formal$formal$LONGINT
# [120] enc28j60PacketSend(sizeof(ETH_Header)+sizeof(IP_Header)+sizeof(ICMP_Header), @snd_buf[0]);
	add	r1,r13,#100
	mov	r0,#98
	bl	ENC28J60_$$_ENC28J60PACKETSEND$WORD$PBYTE
# [121] end;
	add	r13,r13,#244
	pop	{r4,r5,r6,r7,r15}
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

