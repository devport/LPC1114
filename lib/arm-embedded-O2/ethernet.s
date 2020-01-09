	.file "ethernet.pas"
# Begin asmlist al_procedures

.section .text.n_ethernet_$$_byteswap16$word$$word,"ax"
	.balign 4
.thumb_func 
.globl	ETHERNET_$$_BYTESWAP16$WORD$$WORD
ETHERNET_$$_BYTESWAP16$WORD$$WORD:
.Lc2:
# [ethernet.pas]
# [77] begin
	push	{r14}
	sub	r13,r13,#40
# Var $result located in register r0
	uxth	r2,r0
# Var a located in register r2
# [78] Result := (((WORD(a) AND WORD($FF00)) >> 8) OR ((WORD(a) AND WORD($00FF)) << 8));
	mov	r1,r2
	ldr	r0,.Lj5
	and	r1,r0
	lsr	r1,r1,#8
	mov	r0,#255
	and	r2,r0
	lsl	r2,r2,#8
	orr	r2,r1
# Peephole UxthUxth2Uxth done
# Var $result located in register r0
# [79] end;
	uxth	r0,r2
	add	r13,r13,#40
	pop	{r15}
.Lc1:
	.balign 4
.Lj5:
	.long	65280
.Le0:
	.size	ETHERNET_$$_BYTESWAP16$WORD$$WORD, .Le0 - ETHERNET_$$_BYTESWAP16$WORD$$WORD

.section .text.n_ethernet_$$_byteswap32$longword$$longword,"ax"
	.balign 4
.thumb_func 
.globl	ETHERNET_$$_BYTESWAP32$LONGWORD$$LONGWORD
ETHERNET_$$_BYTESWAP32$LONGWORD$$LONGWORD:
.Lc4:
# [82] begin
	push	{r14}
	sub	r13,r13,#40
# Var $result located in register r0
# Var a located in register r0
# [83] Result := (((longword(a) AND longword($FF000000)) >> 24) OR
	mov	r2,r0
	ldr	r1,.Lj8
	and	r2,r1
	lsr	r2,r2,#24
# [84] ((longword(a) AND longword($00ff0000)) >>  8) OR
	mov	r3,r0
	ldr	r1,.Lj9
	and	r3,r1
	lsr	r3,r3,#8
	orr	r3,r2
# [85] ((longword(a) AND longword($0000ff00)) <<  8) OR
	mov	r2,r0
	ldr	r1,.Lj10
	and	r2,r1
	lsl	r2,r2,#8
	orr	r2,r3
# [86] ((longword(a) AND longword($000000ff)) << 24) );
	mov	r1,#255
	and	r0,r1
	lsl	r0,r0,#24
	orr	r0,r2
# Var $result located in register r0
# [87] end;
	add	r13,r13,#40
	pop	{r15}
.Lc3:
	.balign 4
.Lj8:
	.long	-16777216
.Lj9:
	.long	16711680
.Lj10:
	.long	65280
.Le1:
	.size	ETHERNET_$$_BYTESWAP32$LONGWORD$$LONGWORD, .Le1 - ETHERNET_$$_BYTESWAP32$LONGWORD$$LONGWORD

.section .text.n_ethernet_$$_eth_swap_mac$pbyte,"ax"
	.balign 4
.thumb_func 
ETHERNET_$$_ETH_SWAP_MAC$PBYTE:
.Lc6:
# [92] begin
	push	{r4,r14}
	sub	r13,r13,#48
# Var i located in register r0
# Var buf located in register r0
# Var i located in register r4
# [93] for i := 0 to 5 do begin
	mov	r4,#255
.Lj13:
	mov	r1,r4
	add	r1,#1
	uxtb	r4,r1
# Peephole UxtbMov2Data removed superfluous mov
	mov	r3,r0
# Peephole MovMov2Mov removed superfluous mov
	mov	r2,r4
# [94] buf[i] := buf[i+6];
	mov	r1,r3
	add	r1,#6
	ldrb	r1,[r1, r2]
	strb	r1,[r3, r2]
# [95] buf[i+6] := MACADDR[i];
	ldr	r1,.Lj16
	ldr	r1,[r1]
	ldrb	r2,[r1, r4]
	mov	r1,r0
	add	r1,#6
	strb	r2,[r1, r4]
	cmp	r4,#5
	bcc	.Lj17
	bl	.Lj15
.Lj17:
	bl	.Lj13
.Lj15:
# [97] end;
	add	r13,r13,#48
	pop	{r4,r15}
.Lc5:
	.balign 4
.Lj16:
	.long	TC_$ETHERNET_$$_MACADDR
.Le2:
	.size	ETHERNET_$$_ETH_SWAP_MAC$PBYTE, .Le2 - ETHERNET_$$_ETH_SWAP_MAC$PBYTE

.section .text.n_ethernet_$$_eth_process_frame$pbyte,"ax"
	.balign 4
.thumb_func 
.globl	ETHERNET_$$_ETH_PROCESS_FRAME$PBYTE
ETHERNET_$$_ETH_PROCESS_FRAME$PBYTE:
.Lc8:
# [102] begin
	push	{r4,r14}
	sub	r13,r13,#40
# Var ETH_Header located in register r0
# Var buffer located in register r0
# Var ETH_Header located in register r0
# [103] ETH_Header := PEth_HDR(buffer);
	mov	r4,r0
# Var buffer located in register r4
	mov	r0,r4
# [105] case (ByteSwap16(ETH_Header^.hdrtype)) of
	ldrb	r1,[r0, #12]
	ldrb	r0,[r0, #13]
	lsl	r0,#8
	orr	r1,r0
	mov	r0,r1
	bl	ETHERNET_$$_BYTESWAP16$WORD$$WORD
	uxth	r1,r0
	ldr	r0,.Lj23
	cmp	r1,r0
	bcs	.Lj24
	bl	.Lj20
.Lj24:
	ldr	r0,.Lj23
	sub	r1,r0
	bne	.Lj26
	bl	.Lj22
.Lj26:
	sub	r1,#6
	bne	.Lj27
	bl	.Lj21
.Lj27:
	bl	.Lj20
.Lj21:
# [108] ETH_Protocol_ARP(buffer+ETH_HEADER_SIZE, PBYTE(IP));
	mov	r0,r4
	add	r0,#14
	ldr	r1,.Lj28
	ldr	r1,[r1]
	bl	ETHERNET_ARP_$$_ETH_PROTOCOL_ARP$PBYTE$PBYTE
	bl	.Lj20
.Lj22:
# [112] ETH_Protocol_IP(buffer+ETH_HEADER_SIZE, PBYTE(IP));
	mov	r0,r4
	add	r0,#14
	ldr	r1,.Lj28
	ldr	r1,[r1]
	bl	ETHERNET_IP_$$_ETH_PROTOCOL_IP$PBYTE$PBYTE
	bl	.Lj20
.Lj20:
# [115] end;
	add	r13,r13,#40
	pop	{r4,r15}
.Lc7:
	.balign 4
.Lj23:
	.long	2048
.Lj28:
	.long	TC_$ETHERNET_$$_IP
.Le3:
	.size	ETHERNET_$$_ETH_PROCESS_FRAME$PBYTE, .Le3 - ETHERNET_$$_ETH_PROCESS_FRAME$PBYTE

.section .text.n_ethernet_$$_eth_process$pbyte,"ax"
	.balign 4
.thumb_func 
ETHERNET_$$_ETH_PROCESS$PBYTE:
.Lc10:
# [120] begin
	push	{r4,r5,r14}
	sub	r13,r13,#40
# Var rcv_size located in register r0
	mov	r4,r0
# Var data_buffer located in register r4
# Var rcv_size located in register r5
# [118] var
	ldr	r0,.Lj32
	ldrh	r5,[r0]
# [121] FillByte(data_buffer[0], BUFFER_SIZE, 0);
	ldr	r1,.Lj33
	mov	r2,#0
	mov	r0,r4
	bl	SYSTEM_$$_FILLBYTE$formal$LONGINT$BYTE
# [122] if(enc28j60linkup() = 1)then begin
	bl	ENC28J60_$$_ENC28J60LINKUP$$WORD
	uxth	r0,r0
	cmp	r0,#1
	bne	.Lj36
	bl	.Lj34
.Lj36:
	bl	.Lj35
.Lj34:
# [123] rcv_size := enc28j60PacketReceive(BUFFER_SIZE, data_buffer);
	ldr	r0,.Lj33
	mov	r1,r4
	bl	ENC28J60_$$_ENC28J60PACKETRECEIVE$WORD$PBYTE$$WORD
	uxth	r5,r0
# Peephole UxthMov2Data removed superfluous mov
# [125] if(rcv_size > 0 )then
	cmp	r5,#0
	bls	.Lj40
	bl	.Lj38
.Lj40:
	bl	.Lj39
.Lj38:
# [126] ETH_Process_Frame(data_buffer);
	mov	r0,r4
	bl	ETHERNET_$$_ETH_PROCESS_FRAME$PBYTE
.Lj39:
.Lj35:
# [128] end;
	add	r13,r13,#40
	pop	{r4,r5,r15}
.Lc9:
	.balign 4
.Lj32:
	.long	TC_$ETHERNET$_$ETH_PROCESS$PBYTE_$$_defaultrcv_size
.Lj33:
	.long	1460
.Le4:
	.size	ETHERNET_$$_ETH_PROCESS$PBYTE, .Le4 - ETHERNET_$$_ETH_PROCESS$PBYTE

.section .text.n_ethernet_$$_socket_create$psocket$byte,"ax"
	.balign 4
.thumb_func 
.globl	ETHERNET_$$_SOCKET_CREATE$PSOCKET$BYTE
ETHERNET_$$_SOCKET_CREATE$PSOCKET$BYTE:
.Lc12:
# [135] begin
	push	{r14}
	sub	r13,r13,#48
# Var curr located in register r0
# Var socket located in register r0
	uxtb	r2,r1
# Var sck_type located in register r2
# [136] socket^.sck_type := sck_type;
	mov	r1,r0
# Var socket located in register r1
	mov	r0,r2
# Var sck_type located in register r0
	strb	r0,[r1]
# [137] socket^.fsm_state := CLOSED;
	mov	r0,r1
# Var socket located in register r0
	mov	r1,#0
	str	r1,[r0, #4]
# Var socket located in register r0
# [138] socket^.sck_State := SOCKET_CLOSED;
	mov	r1,#1
	str	r1,[r0, #8]
# Var socket located in register r0
# [139] socket^.Recv_func := nil;
	mov	r1,#0
	str	r1,[r0, #12]
# Var socket located in register r0
# Peephole MovStrMov done
# [140] socket^.nextSocket:= nil;
	str	r1,[r0, #16]
# [141] socket^.prevSocket:= nil;
	mov	r2,r0
# Var socket located in register r2
	mov	r0,#0
	str	r0,[r2, #20]
# Var curr located in register r0
# [142] curr := socketList;
	ldr	r0,.Lj43
	ldr	r0,[r0]
# [143] if(curr <> nil) then begin
	cmp	r0,#0
	beq	.Lj46
	bl	.Lj44
.Lj46:
	bl	.Lj45
.Lj44:
# [144] while(curr^.nextSocket <> nil) do
	bl	.Lj48
.Lj47:
# [145] curr := curr^.nextSocket;
	ldr	r0,[r0, #16]
.Lj48:
	ldr	r1,[r0, #16]
	cmp	r1,#0
	beq	.Lj50
	bl	.Lj47
.Lj50:
	bl	.Lj49
.Lj49:
# [146] curr^.nextSocket := socket;
	str	r2,[r0, #16]
	bl	.Lj51
.Lj45:
# [147] end else socketList := socket;
	ldr	r0,.Lj43
	str	r2,[r0]
.Lj51:
# [149] Inc(socketListSize);
	ldr	r1,.Lj53
# Peephole LdrMov2Ldr removed superfluous mov
	ldrh	r0,[r1]
	add	r0,#1
# Peephole UXTHStrh2Strh done
	strh	r0,[r1]
# [150] end;
	add	r13,r13,#48
	pop	{r15}
.Lc11:
	.balign 4
.Lj43:
	.long	U_$ETHERNET_$$_SOCKETLIST
.Lj53:
	.long	U_$ETHERNET_$$_SOCKETLISTSIZE
.Le5:
	.size	ETHERNET_$$_SOCKET_CREATE$PSOCKET$BYTE, .Le5 - ETHERNET_$$_SOCKET_CREATE$PSOCKET$BYTE

.section .text.n_ethernet_$$_socket_remove$psocket,"ax"
	.balign 4
.thumb_func 
.globl	ETHERNET_$$_SOCKET_REMOVE$PSOCKET
ETHERNET_$$_SOCKET_REMOVE$PSOCKET:
.Lc14:
# [155] begin
	push	{r14}
	sub	r13,r13,#40
# Var curr located in register r2
	mov	r3,r0
# Var socket located in register r3
# [156] if(socket = nil) then exit;
	cmp	r3,#0
	bne	.Lj58
	bl	.Lj56
.Lj58:
	bl	.Lj57
.Lj56:
	bl	.Lj54
.Lj57:
# [158] if(socketList = socket) then begin
	ldr	r0,.Lj59
	ldr	r0,[r0]
	cmp	r0,r3
	bne	.Lj62
	bl	.Lj60
.Lj62:
	bl	.Lj61
.Lj60:
# [159] curr := socketList;
	ldr	r0,.Lj59
	ldr	r2,[r0]
# [160] if(curr <> nil) then begin
	cmp	r2,#0
	beq	.Lj66
	bl	.Lj64
.Lj66:
	bl	.Lj65
.Lj64:
# [161] socketList := curr^.nextSocket;
	ldr	r1,[r2, #16]
	ldr	r0,.Lj59
	str	r1,[r0]
# [162] socket := nil;
	mov	r3,#0
# [163] Dec(socketListSize);
	ldr	r1,.Lj68
# Peephole LdrMov2Ldr removed superfluous mov
	ldrh	r0,[r1]
	sub	r0,#1
# Peephole UXTHStrh2Strh done
	strh	r0,[r1]
.Lj65:
	bl	.Lj69
.Lj61:
# [166] curr := socketList;
	ldr	r0,.Lj59
	ldr	r2,[r0]
# [167] while (curr^.nextSocket <> socket) do curr := curr^.nextSocket;
	bl	.Lj72
.Lj71:
	ldr	r2,[r2, #16]
.Lj72:
	ldr	r0,[r2, #16]
	cmp	r0,r3
	beq	.Lj74
	bl	.Lj71
.Lj74:
	bl	.Lj73
.Lj73:
# [168] curr^.nextSocket := socket^.nextSocket;
	ldr	r0,[r3, #16]
	str	r0,[r2, #16]
# [169] socket := nil;
	mov	r3,#0
# [170] Dec(socketListSize);
	ldr	r1,.Lj68
# Peephole LdrMov2Ldr removed superfluous mov
	ldrh	r0,[r1]
	sub	r0,#1
# Peephole UXTHStrh2Strh done
	strh	r0,[r1]
.Lj69:
.Lj54:
# [172] end;
	add	r13,r13,#40
	pop	{r15}
.Lc13:
	.balign 4
.Lj59:
	.long	U_$ETHERNET_$$_SOCKETLIST
.Lj68:
	.long	U_$ETHERNET_$$_SOCKETLISTSIZE
.Le6:
	.size	ETHERNET_$$_SOCKET_REMOVE$PSOCKET, .Le6 - ETHERNET_$$_SOCKET_REMOVE$PSOCKET

.section .text.n_ethernet_$$_socketcheck$psocket$$boolean,"ax"
	.balign 4
.thumb_func 
.globl	ETHERNET_$$_SOCKETCHECK$PSOCKET$$BOOLEAN
ETHERNET_$$_SOCKETCHECK$PSOCKET$$BOOLEAN:
.Lc16:
# [178] begin
	push	{r4,r14}
	sub	r13,r13,#48
# Var $result located in register r0
# Var socketPtr located in register r3
# Var count located in register r0
# Var socket located in register r0
# Var count located in register r4
# [175] var
	ldr	r1,.Lj78
	ldrh	r4,[r1]
# Var $result located in register r2
# [179] Result := False;
	mov	r2,#0
# [180] if((socketList <> nil) AND (socket <> nil)) then begin
	ldr	r1,.Lj79
	ldr	r1,[r1]
	cmp	r1,#0
	beq	.Lj82
	bl	.Lj80
.Lj82:
	bl	.Lj81
.Lj80:
	cmp	r0,#0
	beq	.Lj84
	bl	.Lj83
.Lj84:
	bl	.Lj81
.Lj83:
# [181] socketPtr := socketList;
	ldr	r1,.Lj79
	ldr	r3,[r1]
# [182] while((socketPtr <> nil) AND (count < socketListSize)) do begin
	bl	.Lj87
.Lj86:
# [183] if (socketPtr = socket) then begin
	cmp	r3,r0
	bne	.Lj91
	bl	.Lj89
.Lj91:
	bl	.Lj90
.Lj89:
# [184] Result := True;
	mov	r2,#1
# [185] Exit;
	bl	.Lj76
	bl	.Lj92
.Lj90:
# [187] socketPtr := socketPtr^.nextSocket;
	ldr	r3,[r3, #16]
# [188] Inc(count);
	add	r4,#1
	uxth	r4,r4
.Lj92:
.Lj87:
	cmp	r3,#0
	beq	.Lj95
	bl	.Lj93
.Lj95:
	bl	.Lj94
.Lj93:
	ldr	r1,.Lj97
	ldrh	r1,[r1]
	cmp	r1,r4
	bls	.Lj98
	bl	.Lj96
.Lj98:
	bl	.Lj94
.Lj96:
	bl	.Lj86
.Lj94:
	bl	.Lj88
.Lj88:
.Lj81:
.Lj76:
# [192] end;
	uxtb	r0,r2
	add	r13,r13,#48
	pop	{r4,r15}
.Lc15:
	.balign 4
.Lj78:
	.long	TC_$ETHERNET$_$SOCKETCHECK$PSOCKET$$BOOLEAN_$$_defaultcount
.Lj79:
	.long	U_$ETHERNET_$$_SOCKETLIST
.Lj97:
	.long	U_$ETHERNET_$$_SOCKETLISTSIZE
.Le7:
	.size	ETHERNET_$$_SOCKETCHECK$PSOCKET$$BOOLEAN, .Le7 - ETHERNET_$$_SOCKETCHECK$PSOCKET$$BOOLEAN

.section .text.n_ethernet_$$_checkport$word$byte$$psocket,"ax"
	.balign 4
.thumb_func 
.globl	ETHERNET_$$_CHECKPORT$WORD$BYTE$$PSOCKET
ETHERNET_$$_CHECKPORT$WORD$BYTE$$PSOCKET:
.Lc18:
# [198] begin
	push	{r4,r5,r6,r14}
	sub	r13,r13,#56
# Var $result located in register r0
# Var socketPtr located in register r0
# Var count located in register r0
	uxth	r4,r0
# Var port located in register r4
	uxtb	r2,r1
# Var sck_type located in register r2
# Var count located in register r6
# [195] var
	ldr	r0,.Lj101
	ldrh	r6,[r0]
# Var $result located in register r0
# [199] Result := nil;
	mov	r0,#0
# Var socketPtr located in register r5
# [200] socketPtr := socketList;
	ldr	r1,.Lj102
	ldr	r5,[r1]
# [201] while((socketPtr <> nil) AND (count < socketListSize)) do begin
	bl	.Lj104
.Lj103:
	mov	r1,r5
# [202] if((socketPtr^.sck_port = port) AND (socketPtr^.sck_type = sck_type)) then begin
	ldrh	r3,[r1, #2]
	cmp	r3,r4
	bne	.Lj108
	bl	.Lj106
.Lj108:
	bl	.Lj107
.Lj106:
	ldrb	r1,[r1]
	cmp	r1,r2
	bne	.Lj110
	bl	.Lj109
.Lj110:
	bl	.Lj107
.Lj109:
# [203] Result := socketPtr;
	mov	r0,r5
# [204] exit;
	bl	.Lj99
.Lj107:
# [207] socketPtr := socketPtr^.nextSocket;
	ldr	r5,[r5, #16]
# [208] Inc(count);
	add	r6,#1
	uxth	r6,r6
.Lj104:
	cmp	r5,#0
	beq	.Lj113
	bl	.Lj111
.Lj113:
	bl	.Lj112
.Lj111:
	ldr	r1,.Lj115
	ldrh	r1,[r1]
	cmp	r1,r6
	bls	.Lj116
	bl	.Lj114
.Lj116:
	bl	.Lj112
.Lj114:
	bl	.Lj103
.Lj112:
	bl	.Lj105
.Lj105:
.Lj99:
# [210] end;
	add	r13,r13,#56
	pop	{r4,r5,r6,r15}
.Lc17:
	.balign 4
.Lj101:
	.long	TC_$ETHERNET$_$CHECKPORT$WORD$BYTE$$PSOCKET_$$_defaultcount
.Lj102:
	.long	U_$ETHERNET_$$_SOCKETLIST
.Lj115:
	.long	U_$ETHERNET_$$_SOCKETLISTSIZE
.Le8:
	.size	ETHERNET_$$_CHECKPORT$WORD$BYTE$$PSOCKET, .Le8 - ETHERNET_$$_CHECKPORT$WORD$BYTE$$PSOCKET

.section .text.n_ethernet_$$_socket_bind$psocket$word,"ax"
	.balign 4
.thumb_func 
.globl	ETHERNET_$$_SOCKET_BIND$PSOCKET$WORD
ETHERNET_$$_SOCKET_BIND$PSOCKET$WORD:
.Lc20:
# [214] begin
	push	{r4,r5,r14}
	sub	r13,r13,#40
	mov	r4,r0
# Var socket located in register r4
	uxth	r5,r1
# Var port located in register r5
# [215] if(CheckPort(port, IPV4_TYPE_TCP) <> nil) then begin
	mov	r1,#6
	uxth	r0,r5
	bl	ETHERNET_$$_CHECKPORT$WORD$BYTE$$PSOCKET
	cmp	r0,#0
	beq	.Lj121
	bl	.Lj119
.Lj121:
	bl	.Lj120
.Lj119:
# [216] exit;
	bl	.Lj117
.Lj120:
# [219] socket^.fsm_state := CLOSED;
	mov	r0,r4
# Var socket located in register r0
	mov	r1,#0
	str	r1,[r0, #4]
# [220] socket^.sck_port := port;
	mov	r1,r0
# Var socket located in register r1
	mov	r0,r5
# Var port located in register r0
	strh	r0,[r1, #2]
.Lj117:
# [221] end;
	add	r13,r13,#40
	pop	{r4,r5,r15}
.Lc19:
.Le9:
	.size	ETHERNET_$$_SOCKET_BIND$PSOCKET$WORD, .Le9 - ETHERNET_$$_SOCKET_BIND$PSOCKET$WORD

.section .text.n_ethernet_$$_socket_listen$psocket$$boolean,"ax"
	.balign 4
.thumb_func 
.globl	ETHERNET_$$_SOCKET_LISTEN$PSOCKET$$BOOLEAN
ETHERNET_$$_SOCKET_LISTEN$PSOCKET$$BOOLEAN:
.Lc22:
# [224] begin
	push	{r4,r5,r14}
	sub	r13,r13,#40
# Var $result located in register r0
	mov	r5,r0
# Var socket located in register r5
# Var $result located in register r4
# [225] Result := False;
	mov	r4,#0
# [226] if(SocketCheck(socket)) then begin
	mov	r0,r5
	bl	ETHERNET_$$_SOCKETCHECK$PSOCKET$$BOOLEAN
	uxtb	r0,r0
	cmp	r0,#0
	beq	.Lj126
	bl	.Lj124
.Lj126:
	bl	.Lj125
.Lj124:
# [227] socket^.fsm_state := LISTEN;
	mov	r0,#1
	str	r0,[r5, #4]
# [228] socket^.sck_State := SOCKET_IN_PROGRESS;
	mov	r0,#2
	str	r0,[r5, #8]
# [229] Result := True;
	mov	r4,#1
.Lj125:
# [231] end;
	uxtb	r0,r4
	add	r13,r13,#40
	pop	{r4,r5,r15}
.Lc21:
.Le10:
	.size	ETHERNET_$$_SOCKET_LISTEN$PSOCKET$$BOOLEAN, .Le10 - ETHERNET_$$_SOCKET_LISTEN$PSOCKET$$BOOLEAN

.section .text.n_ethernet_$$_socketprocess$pbyte,"ax"
	.balign 4
.thumb_func 
.globl	ETHERNET_$$_SOCKETPROCESS$PBYTE
ETHERNET_$$_SOCKETPROCESS$PBYTE:
.Lc24:
# [234] begin
	push	{r4,r14}
	sub	r13,r13,#40
	mov	r4,r0
# Var data_buffer located in register r4
# Var data_buffer located in register r4
# [235] ETH_Process(data_buffer);
	mov	r0,r4
	bl	ETHERNET_$$_ETH_PROCESS$PBYTE
# [237] TCB_Process(data_buffer);
	mov	r0,r4
# Var data_buffer located in register r0
	bl	ETHERNET_IP_TCP_$$_TCB_PROCESS$PBYTE
# [238] end;
	add	r13,r13,#40
	pop	{r4,r15}
.Lc23:
.Le11:
	.size	ETHERNET_$$_SOCKETPROCESS$PBYTE, .Le11 - ETHERNET_$$_SOCKETPROCESS$PBYTE

.section .text.n_ethernet_$$_socketsetfunction$psocket$trecv_function,"ax"
	.balign 4
.thumb_func 
.globl	ETHERNET_$$_SOCKETSETFUNCTION$PSOCKET$TRECV_FUNCTION
ETHERNET_$$_SOCKETSETFUNCTION$PSOCKET$TRECV_FUNCTION:
.Lc26:
# [241] begin
	push	{r14}
	sub	r13,r13,#40
# Var socket located in register r0
# Var func located in register r1
# Var socket located in register r0
# Var func located in register r1
# [242] socket^.recv_func := func;
	str	r1,[r0, #12]
# [243] end;
	add	r13,r13,#40
	pop	{r15}
.Lc25:
.Le12:
	.size	ETHERNET_$$_SOCKETSETFUNCTION$PSOCKET$TRECV_FUNCTION, .Le12 - ETHERNET_$$_SOCKETSETFUNCTION$PSOCKET$TRECV_FUNCTION

.section .text.n_ethernet_$$_socketsenddata$byte$pbyte$word,"ax"
	.balign 4
.thumb_func 
.globl	ETHERNET_$$_SOCKETSENDDATA$BYTE$PBYTE$WORD
ETHERNET_$$_SOCKETSENDDATA$BYTE$PBYTE$WORD:
.Lc28:
# [246] begin
	push	{r4,r14}
	sub	r13,r13,#40
	uxtb	r3,r0
# Var id located in register r3
# Var data located in register r1
	uxth	r4,r2
# Var datalen located in register r4
# [247] tcb_array[id].snd_data := data;
	uxtb	r2,r3
# Peephole UxtbMov2Data removed superfluous mov
	mov	r0,#76
	mul	r2,r0
	mov	r0,r1
# Var data located in register r0
	ldr	r1,.Lj133
	str	r0,[r2, r1]
# [248] tcb_array[id].snd_datalen := datalen;
	uxtb	r2,r3
	mov	r0,#76
	mul	r2,r0
	mov	r1,r4
# Var datalen located in register r1
	ldr	r0,.Lj134
	add	r0,r2
	strh	r1,[r0]
# [249] end;
	add	r13,r13,#40
	pop	{r4,r15}
.Lc27:
	.balign 4
.Lj133:
	.long	U_$ETHERNET_IP_TCP_$$_TCB_ARRAY+60
.Lj134:
	.long	U_$ETHERNET_IP_TCP_$$_TCB_ARRAY+64
.Le13:
	.size	ETHERNET_$$_SOCKETSENDDATA$BYTE$PBYTE$WORD, .Le13 - ETHERNET_$$_SOCKETSENDDATA$BYTE$PBYTE$WORD

.section .text.n_ethernet_$$_socketclose$byte,"ax"
	.balign 4
.thumb_func 
.globl	ETHERNET_$$_SOCKETCLOSE$BYTE
ETHERNET_$$_SOCKETCLOSE$BYTE:
.Lc30:
# [252] begin
	push	{r4,r14}
	sub	r13,r13,#40
	uxtb	r3,r0
# Var id located in register r3
	ldr	r2,.Lj137
# Peephole LdrMov2Ldr removed superfluous mov
# [253] tcb_array[id].tcb_flags := tcb_array[id].tcb_flags OR FLAG_FIN;
	uxtb	r0,r3
	mov	r1,#76
	mul	r0,r1
	add	r0,r2
	add	r0,#55
	ldrb	r0,[r0]
	mov	r1,#1
	orr	r0,r1
	uxtb	r1,r0
	uxtb	r0,r3
	mov	r4,#76
	mul	r0,r4
	add	r0,r2
	add	r0,#55
	strb	r1,[r0]
# [254] tcb_array[id].state := FIN_WAIT_2;
	uxtb	r2,r3
# Peephole UxtbMov2Data removed superfluous mov
	mov	r0,#76
	mul	r2,r0
	mov	r1,#6
	ldr	r0,.Lj138
	str	r1,[r2, r0]
# [255] end;
	add	r13,r13,#40
	pop	{r4,r15}
.Lc29:
	.balign 4
.Lj137:
	.long	U_$ETHERNET_IP_TCP_$$_TCB_ARRAY
.Lj138:
	.long	U_$ETHERNET_IP_TCP_$$_TCB_ARRAY+40
.Le14:
	.size	ETHERNET_$$_SOCKETCLOSE$BYTE, .Le14 - ETHERNET_$$_SOCKETCLOSE$BYTE

.section .text.n_ethernet_$$_socketincreasetime,"ax"
	.balign 4
.thumb_func 
.globl	ETHERNET_$$_SOCKETINCREASETIME
ETHERNET_$$_SOCKETINCREASETIME:
.Lc32:
# [260] begin
	push	{r14}
	sub	r13,r13,#40
# Var it located in register r0
# Var it located in register r2
# [261] for it:=0 to TCB_LENGTH do begin
	ldr	r2,.Lj141
.Lj142:
	mov	r0,r2
	add	r0,#1
	uxth	r2,r0
# Peephole UxthMov2Data removed superfluous mov
# [262] Inc(tcb_array[it].time);
	uxth	r3,r2
	mov	r0,#76
	mul	r3,r0
	ldr	r1,.Lj145
# Peephole LdrMov2Ldr removed superfluous mov
	add	r1,r3
	ldr	r0,[r1]
	add	r0,#1
	str	r0,[r1]
	cmp	r2,#3
	bcc	.Lj146
	bl	.Lj144
.Lj146:
	bl	.Lj142
.Lj144:
# [264] end;
	add	r13,r13,#40
	pop	{r15}
.Lc31:
	.balign 4
.Lj141:
	.long	65535
.Lj145:
	.long	U_$ETHERNET_IP_TCP_$$_TCB_ARRAY+44
.Le15:
	.size	ETHERNET_$$_SOCKETINCREASETIME, .Le15 - ETHERNET_$$_SOCKETINCREASETIME

.section .text.n_ethernet_$$_socketsegmentation$byte$$byte,"ax"
	.balign 4
.thumb_func 
.globl	ETHERNET_$$_SOCKETSEGMENTATION$BYTE$$BYTE
ETHERNET_$$_SOCKETSEGMENTATION$BYTE$$BYTE:
.Lc34:
# [267] begin
	push	{r14}
	sub	r13,r13,#40
# Var $result located in register r0
# Peephole UxtbUxtb2Uxtb done
	uxtb	r1,r0
# Var id located in register r0
# [268] Result := tcb_array[id].seg;
	mov	r0,#76
	mul	r1,r0
# Var $result located in register r0
	ldr	r0,.Lj149
	add	r0,r1
	ldrb	r0,[r0]
# [269] end;
	uxtb	r0,r0
	add	r13,r13,#40
	pop	{r15}
.Lc33:
	.balign 4
.Lj149:
	.long	U_$ETHERNET_IP_TCP_$$_TCB_ARRAY+57
.Le16:
	.size	ETHERNET_$$_SOCKETSEGMENTATION$BYTE$$BYTE, .Le16 - ETHERNET_$$_SOCKETSEGMENTATION$BYTE$$BYTE

.section .text.n_ethernet_$$_init_implicit$,"ax"
	.balign 4
.thumb_func 
.globl	ETHERNET_$$_init_implicit$
ETHERNET_$$_init_implicit$:
.thumb_func 
.globl	INIT$_$ETHERNET
INIT$_$ETHERNET:
.Lc36:
	push	{r14}
	sub	r13,r13,#32
	add	r13,r13,#32
	pop	{r15}
.Lc35:
.Le17:
	.size	ETHERNET_$$_init_implicit$, .Le17 - ETHERNET_$$_init_implicit$

.section .text.n_ethernet_$$_finalize_implicit$,"ax"
	.balign 4
.thumb_func 
.globl	ETHERNET_$$_finalize_implicit$
ETHERNET_$$_finalize_implicit$:
.thumb_func 
.globl	FINALIZE$_$ETHERNET
FINALIZE$_$ETHERNET:
.Lc38:
	push	{r14}
	sub	r13,r13,#72
	ldr	r1,.Lj154
	ldr	r0,.Lj155
	bl	fpc_finalize
	ldr	r1,.Lj156
	ldr	r0,.Lj157
	bl	fpc_finalize
	add	r13,r13,#72
	pop	{r15}
.Lc37:
	.balign 4
.Lj154:
	.long	RTTI_$ETHERNET_$$_def00000009
.Lj155:
	.long	TC_$ETHERNET_$$_MACADDR
.Lj156:
	.long	RTTI_$ETHERNET_$$_def0000000B
.Lj157:
	.long	TC_$ETHERNET_$$_IP
.Le18:
	.size	ETHERNET_$$_finalize_implicit$, .Le18 - ETHERNET_$$_finalize_implicit$
# End asmlist al_procedures
# Begin asmlist al_globals

.section .bss.n_u_$ethernet_$$_socketlist,"aw",%nobits
	.balign 4
# [ethernet.pas]
# [73] socketList : PSocket;
	.size U_$ETHERNET_$$_SOCKETLIST,4
U_$ETHERNET_$$_SOCKETLIST:
	.zero 4

.section .bss.n_u_$ethernet_$$_socketlistsize,"aw",%nobits
	.balign 2
# [74] socketListSize : word;
	.size U_$ETHERNET_$$_SOCKETLISTSIZE,2
U_$ETHERNET_$$_SOCKETLISTSIZE:
	.zero 2
# End asmlist al_globals
# Begin asmlist al_const

.section .data.n_.Ld1
	.balign 4
.Ld1$dynarrlab:
	.long	-1,5
.Ld1:
	.byte	204,70,214,16,0,57
# [47] MACADDR : array of byte = ($CC,$46,$D6,$10,$00,$39);
.Le19:
	.size	.Ld1$dynarrlab, .Le19 - .Ld1$dynarrlab

.section .data.n_.Ld2
	.balign 4
.Ld2$dynarrlab:
	.long	-1,3
.Ld2:
	.byte	192,168,1,220
# [48] IP : array of byte = (192, 168, 1, 220);
.Le20:
	.size	.Ld2$dynarrlab, .Le20 - .Ld2$dynarrlab
# End asmlist al_const
# Begin asmlist al_typedconsts

.section .data.n_TC_$ETHERNET_$$_MACADDR
	.balign 4
.globl	TC_$ETHERNET_$$_MACADDR
TC_$ETHERNET_$$_MACADDR:
	.long	.Ld1
.Le21:
	.size	TC_$ETHERNET_$$_MACADDR, .Le21 - TC_$ETHERNET_$$_MACADDR

.section .data.n_TC_$ETHERNET_$$_IP
	.balign 4
.globl	TC_$ETHERNET_$$_IP
TC_$ETHERNET_$$_IP:
	.long	.Ld2
# [50] procedure ETH_Process_Frame(buffer : PBYTE);
.Le22:
	.size	TC_$ETHERNET_$$_IP, .Le22 - TC_$ETHERNET_$$_IP

.section .rodata.n_TC_$ETHERNET$_$ETH_PROCESS$PBYTE_$$_defaultrcv_size
	.balign 2
TC_$ETHERNET$_$ETH_PROCESS$PBYTE_$$_defaultrcv_size:
	.short	0
.Le23:
	.size	TC_$ETHERNET$_$ETH_PROCESS$PBYTE_$$_defaultrcv_size, .Le23 - TC_$ETHERNET$_$ETH_PROCESS$PBYTE_$$_defaultrcv_size

.section .rodata.n_TC_$ETHERNET$_$SOCKETCHECK$PSOCKET$$BOOLEAN_$$_defaultcount
	.balign 2
TC_$ETHERNET$_$SOCKETCHECK$PSOCKET$$BOOLEAN_$$_defaultcount:
	.short	0
.Le24:
	.size	TC_$ETHERNET$_$SOCKETCHECK$PSOCKET$$BOOLEAN_$$_defaultcount, .Le24 - TC_$ETHERNET$_$SOCKETCHECK$PSOCKET$$BOOLEAN_$$_defaultcount

.section .rodata.n_TC_$ETHERNET$_$CHECKPORT$WORD$BYTE$$PSOCKET_$$_defaultcount
	.balign 2
TC_$ETHERNET$_$CHECKPORT$WORD$BYTE$$PSOCKET_$$_defaultcount:
	.short	0
.Le25:
	.size	TC_$ETHERNET$_$CHECKPORT$WORD$BYTE$$PSOCKET_$$_defaultcount, .Le25 - TC_$ETHERNET$_$CHECKPORT$WORD$BYTE$$PSOCKET_$$_defaultcount
# End asmlist al_typedconsts
# Begin asmlist al_rtti

.section .rodata.n_RTTI_$ETHERNET_$$_TSOCKET_STATE
	.balign 4
.globl	RTTI_$ETHERNET_$$_TSOCKET_STATE
RTTI_$ETHERNET_$$_TSOCKET_STATE:
	.byte	3,13
# [273] 
	.ascii	"TSOCKET_STATE"
	.byte	0
	.long	0
	.byte	5,0,0,0
	.long	0,4,0
	.byte	12
	.ascii	"NOT_A_SOCKET"
	.byte	13
	.ascii	"SOCKET_CLOSED"
	.byte	18
	.ascii	"SOCKET_IN_PROGRESS"
	.byte	16
	.ascii	"SOCKET_CONNECTED"
	.byte	14
	.ascii	"SOCKET_CLOSING"
	.byte	8
	.ascii	"ethernet"
	.byte	0
.Le26:
	.size	RTTI_$ETHERNET_$$_TSOCKET_STATE, .Le26 - RTTI_$ETHERNET_$$_TSOCKET_STATE

.section .rodata.n_RTTI_$ETHERNET_$$_TSOCKET_STATE_s2o
	.balign 4
.globl	RTTI_$ETHERNET_$$_TSOCKET_STATE_s2o
RTTI_$ETHERNET_$$_TSOCKET_STATE_s2o:
	.long	5,0
	.long	RTTI_$ETHERNET_$$_TSOCKET_STATE+36
	.long	1
	.long	RTTI_$ETHERNET_$$_TSOCKET_STATE+49
	.long	4
	.long	RTTI_$ETHERNET_$$_TSOCKET_STATE+99
	.long	3
	.long	RTTI_$ETHERNET_$$_TSOCKET_STATE+82
	.long	2
	.long	RTTI_$ETHERNET_$$_TSOCKET_STATE+63
.Le27:
	.size	RTTI_$ETHERNET_$$_TSOCKET_STATE_s2o, .Le27 - RTTI_$ETHERNET_$$_TSOCKET_STATE_s2o

.section .rodata.n_RTTI_$ETHERNET_$$_TSOCKET_STATE_o2s
	.balign 4
.globl	RTTI_$ETHERNET_$$_TSOCKET_STATE_o2s
RTTI_$ETHERNET_$$_TSOCKET_STATE_o2s:
	.long	0
	.long	RTTI_$ETHERNET_$$_TSOCKET_STATE+36
	.long	RTTI_$ETHERNET_$$_TSOCKET_STATE+49
	.long	RTTI_$ETHERNET_$$_TSOCKET_STATE+63
	.long	RTTI_$ETHERNET_$$_TSOCKET_STATE+82
	.long	RTTI_$ETHERNET_$$_TSOCKET_STATE+99
.Le28:
	.size	RTTI_$ETHERNET_$$_TSOCKET_STATE_o2s, .Le28 - RTTI_$ETHERNET_$$_TSOCKET_STATE_o2s

.section .rodata.n_RTTI_$ETHERNET_$$_TFSM_STATES
	.balign 4
.globl	RTTI_$ETHERNET_$$_TFSM_STATES
RTTI_$ETHERNET_$$_TFSM_STATES:
	.byte	3,11
	.ascii	"TFSM_STATES"
	.byte	0,0,0
	.long	0
	.byte	5,0,0,0
	.long	0,10,0
	.byte	6
	.ascii	"CLOSED"
	.byte	6
	.ascii	"LISTEN"
	.byte	8
	.ascii	"SYN_SENT"
	.byte	12
	.ascii	"SYN_RECEIVED"
	.byte	11
	.ascii	"ESTABLISHED"
	.byte	10
	.ascii	"FIN_WAIT_1"
	.byte	10
	.ascii	"FIN_WAIT_2"
	.byte	10
	.ascii	"CLOSE_WAIT"
	.byte	7
	.ascii	"CLOSING"
	.byte	8
	.ascii	"LAST_ACK"
	.byte	9
	.ascii	"TIME_WAIT"
	.byte	8
	.ascii	"ethernet"
	.byte	0,0,0
.Le29:
	.size	RTTI_$ETHERNET_$$_TFSM_STATES, .Le29 - RTTI_$ETHERNET_$$_TFSM_STATES

.section .rodata.n_RTTI_$ETHERNET_$$_TFSM_STATES_s2o
	.balign 4
.globl	RTTI_$ETHERNET_$$_TFSM_STATES_s2o
RTTI_$ETHERNET_$$_TFSM_STATES_s2o:
	.long	11,0
	.long	RTTI_$ETHERNET_$$_TFSM_STATES+36
	.long	7
	.long	RTTI_$ETHERNET_$$_TFSM_STATES+106
	.long	8
	.long	RTTI_$ETHERNET_$$_TFSM_STATES+117
	.long	4
	.long	RTTI_$ETHERNET_$$_TFSM_STATES+72
	.long	5
	.long	RTTI_$ETHERNET_$$_TFSM_STATES+84
	.long	6
	.long	RTTI_$ETHERNET_$$_TFSM_STATES+95
	.long	9
	.long	RTTI_$ETHERNET_$$_TFSM_STATES+125
	.long	1
	.long	RTTI_$ETHERNET_$$_TFSM_STATES+43
	.long	3
	.long	RTTI_$ETHERNET_$$_TFSM_STATES+59
	.long	2
	.long	RTTI_$ETHERNET_$$_TFSM_STATES+50
	.long	10
	.long	RTTI_$ETHERNET_$$_TFSM_STATES+134
.Le30:
	.size	RTTI_$ETHERNET_$$_TFSM_STATES_s2o, .Le30 - RTTI_$ETHERNET_$$_TFSM_STATES_s2o

.section .rodata.n_RTTI_$ETHERNET_$$_TFSM_STATES_o2s
	.balign 4
.globl	RTTI_$ETHERNET_$$_TFSM_STATES_o2s
RTTI_$ETHERNET_$$_TFSM_STATES_o2s:
	.long	0
	.long	RTTI_$ETHERNET_$$_TFSM_STATES+36
	.long	RTTI_$ETHERNET_$$_TFSM_STATES+43
	.long	RTTI_$ETHERNET_$$_TFSM_STATES+50
	.long	RTTI_$ETHERNET_$$_TFSM_STATES+59
	.long	RTTI_$ETHERNET_$$_TFSM_STATES+72
	.long	RTTI_$ETHERNET_$$_TFSM_STATES+84
	.long	RTTI_$ETHERNET_$$_TFSM_STATES+95
	.long	RTTI_$ETHERNET_$$_TFSM_STATES+106
	.long	RTTI_$ETHERNET_$$_TFSM_STATES+117
	.long	RTTI_$ETHERNET_$$_TFSM_STATES+125
	.long	RTTI_$ETHERNET_$$_TFSM_STATES+134
.Le31:
	.size	RTTI_$ETHERNET_$$_TFSM_STATES_o2s, .Le31 - RTTI_$ETHERNET_$$_TFSM_STATES_o2s

.section .rodata.n_RTTI_$ETHERNET_$$_TRECV_FUNCTION
	.balign 4
.globl	RTTI_$ETHERNET_$$_TRECV_FUNCTION
RTTI_$ETHERNET_$$_TRECV_FUNCTION:
	.byte	23,14
	.ascii	"TRecv_function"
	.long	0
	.byte	0,3,0,0
	.long	0
	.byte	3,0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_BYTE$indirect
	.byte	6
	.ascii	"tcb_id"
	.byte	0
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_PBYTE$indirect
	.byte	8
	.ascii	"rcv_data"
	.byte	0,0,0
	.short	0
	.byte	0,0
	.long	RTTI_$SYSTEM_$$_WORD$indirect
	.byte	8
	.ascii	"rcv_size"
	.byte	0,0,0
.Le32:
	.size	RTTI_$ETHERNET_$$_TRECV_FUNCTION, .Le32 - RTTI_$ETHERNET_$$_TRECV_FUNCTION

.section .rodata.n_INIT_$ETHERNET_$$_TETH_HDR
	.balign 4
.globl	INIT_$ETHERNET_$$_TETH_HDR
INIT_$ETHERNET_$$_TETH_HDR:
	.byte	13,8
	.ascii	"TEth_HDR"
	.byte	0,0
	.long	0,0,14,0,0,0
.Le33:
	.size	INIT_$ETHERNET_$$_TETH_HDR, .Le33 - INIT_$ETHERNET_$$_TETH_HDR

.section .rodata.n_RTTI_$ETHERNET_$$_def00000005
	.balign 4
.globl	RTTI_$ETHERNET_$$_def00000005
RTTI_$ETHERNET_$$_def00000005:
	.byte	12,0,0,0
	.long	0,6,6
	.long	RTTI_$SYSTEM_$$_BYTE$indirect
	.byte	1,0,0,0
	.long	RTTI_$SYSTEM_$$_SHORTINT$indirect
.Le34:
	.size	RTTI_$ETHERNET_$$_def00000005, .Le34 - RTTI_$ETHERNET_$$_def00000005

.section .rodata.n_RTTI_$ETHERNET_$$_def00000006
	.balign 4
.globl	RTTI_$ETHERNET_$$_def00000006
RTTI_$ETHERNET_$$_def00000006:
	.byte	12,0,0,0
	.long	0,6,6
	.long	RTTI_$SYSTEM_$$_BYTE$indirect
	.byte	1,0,0,0
	.long	RTTI_$SYSTEM_$$_SHORTINT$indirect
.Le35:
	.size	RTTI_$ETHERNET_$$_def00000006, .Le35 - RTTI_$ETHERNET_$$_def00000006

.section .rodata.n_RTTI_$ETHERNET_$$_TETH_HDR
	.balign 4
.globl	RTTI_$ETHERNET_$$_TETH_HDR
RTTI_$ETHERNET_$$_TETH_HDR:
	.byte	13,8
	.ascii	"TEth_HDR"
	.byte	0,0
	.long	0
	.long	INIT_$ETHERNET_$$_TETH_HDR
	.long	14,3
	.long	RTTI_$ETHERNET_$$_def00000005$indirect
	.long	0
	.long	RTTI_$ETHERNET_$$_def00000006$indirect
	.long	6
	.long	RTTI_$SYSTEM_$$_WORD$indirect
	.long	12
.Le36:
	.size	RTTI_$ETHERNET_$$_TETH_HDR, .Le36 - RTTI_$ETHERNET_$$_TETH_HDR

.section .rodata.n_RTTI_$ETHERNET_$$_PETH_HDR
	.balign 4
.globl	RTTI_$ETHERNET_$$_PETH_HDR
RTTI_$ETHERNET_$$_PETH_HDR:
	.byte	29,8
	.ascii	"PEth_HDR"
	.byte	0,0
	.long	0
	.long	RTTI_$ETHERNET_$$_TETH_HDR$indirect
.Le37:
	.size	RTTI_$ETHERNET_$$_PETH_HDR, .Le37 - RTTI_$ETHERNET_$$_PETH_HDR

.section .rodata.n_INIT_$ETHERNET_$$_TSOCKET
	.balign 4
.globl	INIT_$ETHERNET_$$_TSOCKET
INIT_$ETHERNET_$$_TSOCKET:
	.byte	13,7
	.ascii	"TSocket"
	.byte	0,0,0
	.long	0,0,24,0,0,0
.Le38:
	.size	INIT_$ETHERNET_$$_TSOCKET, .Le38 - INIT_$ETHERNET_$$_TSOCKET

.section .rodata.n_RTTI_$ETHERNET_$$_TSOCKET
	.balign 4
.globl	RTTI_$ETHERNET_$$_TSOCKET
RTTI_$ETHERNET_$$_TSOCKET:
	.byte	13,7
	.ascii	"TSocket"
	.byte	0,0,0
	.long	0
	.long	INIT_$ETHERNET_$$_TSOCKET
	.long	24,7
	.long	RTTI_$SYSTEM_$$_BYTE$indirect
	.long	0
	.long	RTTI_$SYSTEM_$$_WORD$indirect
	.long	2
	.long	RTTI_$ETHERNET_$$_TFSM_STATES$indirect
	.long	4
	.long	RTTI_$ETHERNET_$$_TSOCKET_STATE$indirect
	.long	8
	.long	RTTI_$ETHERNET_$$_TRECV_FUNCTION$indirect
	.long	12
	.long	RTTI_$ETHERNET_$$_PSOCKET$indirect
	.long	16
	.long	RTTI_$ETHERNET_$$_PSOCKET$indirect
	.long	20
.Le39:
	.size	RTTI_$ETHERNET_$$_TSOCKET, .Le39 - RTTI_$ETHERNET_$$_TSOCKET

.section .rodata.n_RTTI_$ETHERNET_$$_PSOCKET
	.balign 4
.globl	RTTI_$ETHERNET_$$_PSOCKET
RTTI_$ETHERNET_$$_PSOCKET:
	.byte	29,7
	.ascii	"PSocket"
	.byte	0,0,0
	.long	0
	.long	RTTI_$ETHERNET_$$_TSOCKET$indirect
.Le40:
	.size	RTTI_$ETHERNET_$$_PSOCKET, .Le40 - RTTI_$ETHERNET_$$_PSOCKET

.section .rodata.n_RTTI_$ETHERNET_$$_def00000009
	.balign 4
.globl	RTTI_$ETHERNET_$$_def00000009
RTTI_$ETHERNET_$$_def00000009:
	.byte	21,0,0,0
	.long	0,1
	.long	RTTI_$SYSTEM_$$_BYTE$indirect
	.long	17,0
	.byte	8
	.ascii	"ethernet"
	.byte	0,0,0
.Le41:
	.size	RTTI_$ETHERNET_$$_def00000009, .Le41 - RTTI_$ETHERNET_$$_def00000009

.section .rodata.n_RTTI_$ETHERNET_$$_def0000000B
	.balign 4
.globl	RTTI_$ETHERNET_$$_def0000000B
RTTI_$ETHERNET_$$_def0000000B:
	.byte	21,0,0,0
	.long	0,1
	.long	RTTI_$SYSTEM_$$_BYTE$indirect
	.long	17,0
	.byte	8
	.ascii	"ethernet"
	.byte	0,0,0
.Le42:
	.size	RTTI_$ETHERNET_$$_def0000000B, .Le42 - RTTI_$ETHERNET_$$_def0000000B
# End asmlist al_rtti
# Begin asmlist al_indirectglobals

.section .rodata.n_RTTI_$ETHERNET_$$_TSOCKET_STATE
	.balign 4
.globl	RTTI_$ETHERNET_$$_TSOCKET_STATE$indirect
RTTI_$ETHERNET_$$_TSOCKET_STATE$indirect:
	.long	RTTI_$ETHERNET_$$_TSOCKET_STATE
.Le43:
	.size	RTTI_$ETHERNET_$$_TSOCKET_STATE$indirect, .Le43 - RTTI_$ETHERNET_$$_TSOCKET_STATE$indirect

.section .rodata.n_RTTI_$ETHERNET_$$_TSOCKET_STATE_s2o
	.balign 4
.globl	RTTI_$ETHERNET_$$_TSOCKET_STATE_s2o$indirect
RTTI_$ETHERNET_$$_TSOCKET_STATE_s2o$indirect:
	.long	RTTI_$ETHERNET_$$_TSOCKET_STATE_s2o
.Le44:
	.size	RTTI_$ETHERNET_$$_TSOCKET_STATE_s2o$indirect, .Le44 - RTTI_$ETHERNET_$$_TSOCKET_STATE_s2o$indirect

.section .rodata.n_RTTI_$ETHERNET_$$_TSOCKET_STATE_o2s
	.balign 4
.globl	RTTI_$ETHERNET_$$_TSOCKET_STATE_o2s$indirect
RTTI_$ETHERNET_$$_TSOCKET_STATE_o2s$indirect:
	.long	RTTI_$ETHERNET_$$_TSOCKET_STATE_o2s
.Le45:
	.size	RTTI_$ETHERNET_$$_TSOCKET_STATE_o2s$indirect, .Le45 - RTTI_$ETHERNET_$$_TSOCKET_STATE_o2s$indirect

.section .rodata.n_RTTI_$ETHERNET_$$_TFSM_STATES
	.balign 4
.globl	RTTI_$ETHERNET_$$_TFSM_STATES$indirect
RTTI_$ETHERNET_$$_TFSM_STATES$indirect:
	.long	RTTI_$ETHERNET_$$_TFSM_STATES
.Le46:
	.size	RTTI_$ETHERNET_$$_TFSM_STATES$indirect, .Le46 - RTTI_$ETHERNET_$$_TFSM_STATES$indirect

.section .rodata.n_RTTI_$ETHERNET_$$_TFSM_STATES_s2o
	.balign 4
.globl	RTTI_$ETHERNET_$$_TFSM_STATES_s2o$indirect
RTTI_$ETHERNET_$$_TFSM_STATES_s2o$indirect:
	.long	RTTI_$ETHERNET_$$_TFSM_STATES_s2o
.Le47:
	.size	RTTI_$ETHERNET_$$_TFSM_STATES_s2o$indirect, .Le47 - RTTI_$ETHERNET_$$_TFSM_STATES_s2o$indirect

.section .rodata.n_RTTI_$ETHERNET_$$_TFSM_STATES_o2s
	.balign 4
.globl	RTTI_$ETHERNET_$$_TFSM_STATES_o2s$indirect
RTTI_$ETHERNET_$$_TFSM_STATES_o2s$indirect:
	.long	RTTI_$ETHERNET_$$_TFSM_STATES_o2s
.Le48:
	.size	RTTI_$ETHERNET_$$_TFSM_STATES_o2s$indirect, .Le48 - RTTI_$ETHERNET_$$_TFSM_STATES_o2s$indirect

.section .rodata.n_RTTI_$ETHERNET_$$_TRECV_FUNCTION
	.balign 4
.globl	RTTI_$ETHERNET_$$_TRECV_FUNCTION$indirect
RTTI_$ETHERNET_$$_TRECV_FUNCTION$indirect:
	.long	RTTI_$ETHERNET_$$_TRECV_FUNCTION
.Le49:
	.size	RTTI_$ETHERNET_$$_TRECV_FUNCTION$indirect, .Le49 - RTTI_$ETHERNET_$$_TRECV_FUNCTION$indirect

.section .rodata.n_INIT_$ETHERNET_$$_TETH_HDR
	.balign 4
.globl	INIT_$ETHERNET_$$_TETH_HDR$indirect
INIT_$ETHERNET_$$_TETH_HDR$indirect:
	.long	INIT_$ETHERNET_$$_TETH_HDR
.Le50:
	.size	INIT_$ETHERNET_$$_TETH_HDR$indirect, .Le50 - INIT_$ETHERNET_$$_TETH_HDR$indirect

.section .rodata.n_RTTI_$ETHERNET_$$_def00000005
	.balign 4
.globl	RTTI_$ETHERNET_$$_def00000005$indirect
RTTI_$ETHERNET_$$_def00000005$indirect:
	.long	RTTI_$ETHERNET_$$_def00000005
.Le51:
	.size	RTTI_$ETHERNET_$$_def00000005$indirect, .Le51 - RTTI_$ETHERNET_$$_def00000005$indirect

.section .rodata.n_RTTI_$ETHERNET_$$_def00000006
	.balign 4
.globl	RTTI_$ETHERNET_$$_def00000006$indirect
RTTI_$ETHERNET_$$_def00000006$indirect:
	.long	RTTI_$ETHERNET_$$_def00000006
.Le52:
	.size	RTTI_$ETHERNET_$$_def00000006$indirect, .Le52 - RTTI_$ETHERNET_$$_def00000006$indirect

.section .rodata.n_RTTI_$ETHERNET_$$_TETH_HDR
	.balign 4
.globl	RTTI_$ETHERNET_$$_TETH_HDR$indirect
RTTI_$ETHERNET_$$_TETH_HDR$indirect:
	.long	RTTI_$ETHERNET_$$_TETH_HDR
.Le53:
	.size	RTTI_$ETHERNET_$$_TETH_HDR$indirect, .Le53 - RTTI_$ETHERNET_$$_TETH_HDR$indirect

.section .rodata.n_RTTI_$ETHERNET_$$_PETH_HDR
	.balign 4
.globl	RTTI_$ETHERNET_$$_PETH_HDR$indirect
RTTI_$ETHERNET_$$_PETH_HDR$indirect:
	.long	RTTI_$ETHERNET_$$_PETH_HDR
.Le54:
	.size	RTTI_$ETHERNET_$$_PETH_HDR$indirect, .Le54 - RTTI_$ETHERNET_$$_PETH_HDR$indirect

.section .rodata.n_INIT_$ETHERNET_$$_TSOCKET
	.balign 4
.globl	INIT_$ETHERNET_$$_TSOCKET$indirect
INIT_$ETHERNET_$$_TSOCKET$indirect:
	.long	INIT_$ETHERNET_$$_TSOCKET
.Le55:
	.size	INIT_$ETHERNET_$$_TSOCKET$indirect, .Le55 - INIT_$ETHERNET_$$_TSOCKET$indirect

.section .rodata.n_RTTI_$ETHERNET_$$_TSOCKET
	.balign 4
.globl	RTTI_$ETHERNET_$$_TSOCKET$indirect
RTTI_$ETHERNET_$$_TSOCKET$indirect:
	.long	RTTI_$ETHERNET_$$_TSOCKET
.Le56:
	.size	RTTI_$ETHERNET_$$_TSOCKET$indirect, .Le56 - RTTI_$ETHERNET_$$_TSOCKET$indirect

.section .rodata.n_RTTI_$ETHERNET_$$_PSOCKET
	.balign 4
.globl	RTTI_$ETHERNET_$$_PSOCKET$indirect
RTTI_$ETHERNET_$$_PSOCKET$indirect:
	.long	RTTI_$ETHERNET_$$_PSOCKET
.Le57:
	.size	RTTI_$ETHERNET_$$_PSOCKET$indirect, .Le57 - RTTI_$ETHERNET_$$_PSOCKET$indirect

.section .rodata.n_RTTI_$ETHERNET_$$_def00000009
	.balign 4
.globl	RTTI_$ETHERNET_$$_def00000009$indirect
RTTI_$ETHERNET_$$_def00000009$indirect:
	.long	RTTI_$ETHERNET_$$_def00000009
.Le58:
	.size	RTTI_$ETHERNET_$$_def00000009$indirect, .Le58 - RTTI_$ETHERNET_$$_def00000009$indirect

.section .rodata.n_RTTI_$ETHERNET_$$_def0000000B
	.balign 4
.globl	RTTI_$ETHERNET_$$_def0000000B$indirect
RTTI_$ETHERNET_$$_def0000000B$indirect:
	.long	RTTI_$ETHERNET_$$_def0000000B
.Le59:
	.size	RTTI_$ETHERNET_$$_def0000000B$indirect, .Le59 - RTTI_$ETHERNET_$$_def0000000B$indirect
# End asmlist al_indirectglobals
# Begin asmlist al_dwarf_frame

.section .debug_frame
.Lc39:
	.long	.Lc41-.Lc40
.Lc40:
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
.Lc41:
	.long	.Lc43-.Lc42
.Lc42:
	.long	.Lc39
	.long	.Lc2
	.long	.Lc1-.Lc2
	.balign 4,0
.Lc43:
	.long	.Lc46-.Lc45
.Lc45:
	.long	.Lc39
	.long	.Lc4
	.long	.Lc3-.Lc4
	.balign 4,0
.Lc46:
	.long	.Lc49-.Lc48
.Lc48:
	.long	.Lc39
	.long	.Lc6
	.long	.Lc5-.Lc6
	.balign 4,0
.Lc49:
	.long	.Lc52-.Lc51
.Lc51:
	.long	.Lc39
	.long	.Lc8
	.long	.Lc7-.Lc8
	.balign 4,0
.Lc52:
	.long	.Lc55-.Lc54
.Lc54:
	.long	.Lc39
	.long	.Lc10
	.long	.Lc9-.Lc10
	.balign 4,0
.Lc55:
	.long	.Lc58-.Lc57
.Lc57:
	.long	.Lc39
	.long	.Lc12
	.long	.Lc11-.Lc12
	.balign 4,0
.Lc58:
	.long	.Lc61-.Lc60
.Lc60:
	.long	.Lc39
	.long	.Lc14
	.long	.Lc13-.Lc14
	.balign 4,0
.Lc61:
	.long	.Lc64-.Lc63
.Lc63:
	.long	.Lc39
	.long	.Lc16
	.long	.Lc15-.Lc16
	.balign 4,0
.Lc64:
	.long	.Lc67-.Lc66
.Lc66:
	.long	.Lc39
	.long	.Lc18
	.long	.Lc17-.Lc18
	.balign 4,0
.Lc67:
	.long	.Lc70-.Lc69
.Lc69:
	.long	.Lc39
	.long	.Lc20
	.long	.Lc19-.Lc20
	.balign 4,0
.Lc70:
	.long	.Lc73-.Lc72
.Lc72:
	.long	.Lc39
	.long	.Lc22
	.long	.Lc21-.Lc22
	.balign 4,0
.Lc73:
	.long	.Lc76-.Lc75
.Lc75:
	.long	.Lc39
	.long	.Lc24
	.long	.Lc23-.Lc24
	.balign 4,0
.Lc76:
	.long	.Lc79-.Lc78
.Lc78:
	.long	.Lc39
	.long	.Lc26
	.long	.Lc25-.Lc26
	.balign 4,0
.Lc79:
	.long	.Lc82-.Lc81
.Lc81:
	.long	.Lc39
	.long	.Lc28
	.long	.Lc27-.Lc28
	.balign 4,0
.Lc82:
	.long	.Lc85-.Lc84
.Lc84:
	.long	.Lc39
	.long	.Lc30
	.long	.Lc29-.Lc30
	.balign 4,0
.Lc85:
	.long	.Lc88-.Lc87
.Lc87:
	.long	.Lc39
	.long	.Lc32
	.long	.Lc31-.Lc32
	.balign 4,0
.Lc88:
	.long	.Lc91-.Lc90
.Lc90:
	.long	.Lc39
	.long	.Lc34
	.long	.Lc33-.Lc34
	.balign 4,0
.Lc91:
	.long	.Lc94-.Lc93
.Lc93:
	.long	.Lc39
	.long	.Lc36
	.long	.Lc35-.Lc36
	.balign 4,0
.Lc94:
	.long	.Lc97-.Lc96
.Lc96:
	.long	.Lc39
	.long	.Lc38
	.long	.Lc37-.Lc38
	.balign 4,0
.Lc97:
# End asmlist al_dwarf_frame

