	.file "ethernet_ip_tcp.pas"
# Begin asmlist al_procedures

.section .text.n_ethernet_ip_tcp_$$_socket_tcpclientnum$$longword,"ax"
	.balign 4
.thumb_func 
.globl	ETHERNET_IP_TCP_$$_SOCKET_TCPCLIENTNUM$$LONGWORD
ETHERNET_IP_TCP_$$_SOCKET_TCPCLIENTNUM$$LONGWORD:
.Lc2:
# [ethernet_ip_tcp.pas]
# [86] begin
	push	{r14}
	sub	r13,r13,#48
# Var $result located at r13+0, size=OS_32
# Var i located at r13+4, size=OS_32
# Var j located at r13+8, size=OS_32
# [87] j := 1;
	mov	r0,#1
	str	r0,[r13, #8]
# [88] for i:=0 to TCB_LENGTH do begin
	ldr	r0,.Lj5
	str	r0,[r13, #4]
.Lj6:
	ldr	r0,[r13, #4]
	add	r0,#1
	str	r0,[r13, #4]
# [89] if(tcb_array[i].src_ip <> 0 ) then inc(j);
	ldr	r0,[r13, #4]
	mov	r1,r0
	mov	r0,#76
	mul	r1,r0
	ldr	r0,.Lj9
	ldr	r0,[r1, r0]
	cmp	r0,#0
	beq	.Lj12
	bl	.Lj10
.Lj12:
	bl	.Lj11
.Lj10:
	ldr	r0,[r13, #8]
	add	r0,#1
	str	r0,[r13, #8]
.Lj11:
	ldr	r0,[r13, #4]
	cmp	r0,#3
	bcc	.Lj13
	bl	.Lj8
.Lj13:
	bl	.Lj6
.Lj8:
# [91] Result := j-1;
	ldr	r0,[r13, #8]
	sub	r0,#1
	str	r0,[r13]
# [92] end;
	ldr	r0,[r13]
	add	r13,r13,#48
	pop	{r15}
.Lc1:
	.balign 4
.Lj5:
	.long	-1
.Lj9:
	.long	U_$ETHERNET_IP_TCP_$$_TCB_ARRAY
.Le0:
	.size	ETHERNET_IP_TCP_$$_SOCKET_TCPCLIENTNUM$$LONGWORD, .Le0 - ETHERNET_IP_TCP_$$_SOCKET_TCPCLIENTNUM$$LONGWORD

.section .text.n_ethernet_ip_tcp_$$_inittcb,"ax"
	.balign 4
.thumb_func 
.globl	ETHERNET_IP_TCP_$$_INITTCB
ETHERNET_IP_TCP_$$_INITTCB:
.Lc4:
# [97] begin
	push	{r14}
	sub	r13,r13,#40
# Var i located at r13+0, size=OS_8
# [98] for i:=0 to TCB_LENGTH do begin
	mov	r1,#255
	mov	r0,r13
	strb	r1,[r0]
.Lj16:
	mov	r0,r13
	ldrb	r0,[r0]
	add	r0,#1
	uxtb	r0,r0
	mov	r1,r13
	strb	r0,[r1]
# [99] tcb_array[i].state := CLOSED;
	mov	r0,r13
	ldrb	r0,[r0]
	mov	r2,r0
	mov	r0,#76
	mul	r2,r0
	mov	r1,#0
	ldr	r0,.Lj19
	str	r1,[r2, r0]
# [100] tcb_array[i].src_port := 0;
	mov	r0,r13
	ldrb	r0,[r0]
	mov	r2,r0
	mov	r0,#76
	mul	r2,r0
	mov	r1,#0
	ldr	r0,.Lj20
	strh	r1,[r2, r0]
# [101] tcb_array[i].src_ip := 0;
	mov	r0,r13
	ldrb	r0,[r0]
	mov	r2,r0
	mov	r0,#76
	mul	r2,r0
	mov	r1,#0
	ldr	r0,.Lj21
	str	r1,[r2, r0]
# [102] tcb_array[i].dst_ip := 0;
	mov	r0,r13
	ldrb	r0,[r0]
	mov	r2,r0
	mov	r0,#76
	mul	r2,r0
	mov	r1,#0
	ldr	r0,.Lj22
	str	r1,[r2, r0]
# [103] tcb_array[i].dst_port := 0;
	mov	r0,r13
	ldrb	r0,[r0]
	mov	r2,r0
	mov	r0,#76
	mul	r2,r0
	mov	r1,#0
	ldr	r0,.Lj23
	strh	r1,[r2, r0]
# [104] tcb_array[i].id := i;
	mov	r0,r13
	ldrb	r0,[r0]
	mov	r2,r0
	mov	r0,#76
	mul	r2,r0
	ldr	r0,.Lj24
	mov	r1,r0
	add	r1,r2
	mov	r0,r13
	ldrb	r0,[r0]
	strb	r0,[r1]
# [105] tcb_array[i].seg := 0;
	mov	r0,r13
	ldrb	r0,[r0]
	mov	r2,r0
	mov	r0,#76
	mul	r2,r0
	mov	r1,#0
	ldr	r0,.Lj25
	add	r0,r2
	strb	r1,[r0]
# [106] tcb_array[i].rcv_nxt := 0;
	mov	r0,r13
	ldrb	r0,[r0]
	mov	r2,r0
	mov	r0,#76
	mul	r2,r0
	mov	r0,#0
	ldr	r1,.Lj26
	str	r0,[r2, r1]
# [107] tcb_array[i].snd_nxt := 0;
	mov	r0,r13
	ldrb	r0,[r0]
	mov	r2,r0
	mov	r0,#76
	mul	r2,r0
	mov	r0,#0
	ldr	r1,.Lj27
	str	r0,[r2, r1]
# [108] tcb_array[i].tcb_flags := FLAG_NUL;
	mov	r0,r13
	ldrb	r0,[r0]
	mov	r2,r0
	mov	r0,#76
	mul	r2,r0
	mov	r1,#0
	ldr	r0,.Lj28
	add	r0,r2
	strb	r1,[r0]
# [109] tcb_array[i].snd_data := nil;
	mov	r0,r13
	ldrb	r0,[r0]
	mov	r2,r0
	mov	r0,#76
	mul	r2,r0
	mov	r0,#0
	ldr	r1,.Lj29
	str	r0,[r2, r1]
# [110] tcb_array[i].snd_datalen := 0;
	mov	r0,r13
	ldrb	r0,[r0]
	mov	r2,r0
	mov	r0,#76
	mul	r2,r0
	mov	r1,#0
	ldr	r0,.Lj30
	add	r0,r2
	strh	r1,[r0]
# [111] tcb_array[i].rcv_data := nil;
	mov	r0,r13
	ldrb	r0,[r0]
	mov	r2,r0
	mov	r0,#76
	mul	r2,r0
	mov	r0,#0
	ldr	r1,.Lj31
	str	r0,[r2, r1]
# [112] tcb_array[i].rcv_datalen := 0;
	mov	r0,r13
	ldrb	r0,[r0]
	mov	r2,r0
	mov	r0,#76
	mul	r2,r0
	mov	r1,#0
	ldr	r0,.Lj32
	add	r0,r2
	strh	r1,[r0]
	mov	r0,r13
	ldrb	r0,[r0]
	cmp	r0,#3
	bcc	.Lj33
	bl	.Lj18
.Lj33:
	bl	.Lj16
.Lj18:
# [114] end;
	add	r13,r13,#40
	pop	{r15}
.Lc3:
	.balign 4
.Lj19:
	.long	U_$ETHERNET_IP_TCP_$$_TCB_ARRAY+40
.Lj20:
	.long	U_$ETHERNET_IP_TCP_$$_TCB_ARRAY+8
.Lj21:
	.long	U_$ETHERNET_IP_TCP_$$_TCB_ARRAY
.Lj22:
	.long	U_$ETHERNET_IP_TCP_$$_TCB_ARRAY+4
.Lj23:
	.long	U_$ETHERNET_IP_TCP_$$_TCB_ARRAY+10
.Lj24:
	.long	U_$ETHERNET_IP_TCP_$$_TCB_ARRAY+48
.Lj25:
	.long	U_$ETHERNET_IP_TCP_$$_TCB_ARRAY+57
.Lj26:
	.long	U_$ETHERNET_IP_TCP_$$_TCB_ARRAY+24
.Lj27:
	.long	U_$ETHERNET_IP_TCP_$$_TCB_ARRAY+16
.Lj28:
	.long	U_$ETHERNET_IP_TCP_$$_TCB_ARRAY+55
.Lj29:
	.long	U_$ETHERNET_IP_TCP_$$_TCB_ARRAY+60
.Lj30:
	.long	U_$ETHERNET_IP_TCP_$$_TCB_ARRAY+64
.Lj31:
	.long	U_$ETHERNET_IP_TCP_$$_TCB_ARRAY+68
.Lj32:
	.long	U_$ETHERNET_IP_TCP_$$_TCB_ARRAY+72
.Le1:
	.size	ETHERNET_IP_TCP_$$_INITTCB, .Le1 - ETHERNET_IP_TCP_$$_INITTCB

.section .text.n_ethernet_ip_tcp_$$_tcb_gettcb$psocket$$ptcb,"ax"
	.balign 4
.thumb_func 
ETHERNET_IP_TCP_$$_TCB_GETTCB$PSOCKET$$PTCB:
.Lc6:
# [119] begin
	push	{r14}
	sub	r13,r13,#48
# Var socket located at r13+0, size=OS_32
# Var $result located at r13+4, size=OS_32
# Var i located at r13+8, size=OS_8
	str	r0,[r13]
# [120] Result := nil;
	mov	r0,#0
	str	r0,[r13, #4]
# [121] for i:=0 to TCB_LENGTH do
	mov	r1,#255
	add	r0,r13,#8
	strb	r1,[r0]
.Lj36:
	add	r0,r13,#8
	ldrb	r0,[r0]
	add	r0,#1
	uxtb	r0,r0
	add	r1,r13,#8
	strb	r0,[r1]
# [123] if (tcb_array[i].src_ip = 0) AND (tcb_array[i].src_port = 0) AND (tcb_array[i].state = CLOSED) then
	add	r0,r13,#8
	ldrb	r0,[r0]
	mov	r1,r0
	mov	r0,#76
	mul	r1,r0
	ldr	r0,.Lj39
	ldr	r0,[r1, r0]
	cmp	r0,#0
	bne	.Lj42
	bl	.Lj40
.Lj42:
	bl	.Lj41
.Lj40:
	add	r0,r13,#8
	ldrb	r0,[r0]
	mov	r1,r0
	mov	r0,#76
	mul	r1,r0
	ldr	r0,.Lj44
	ldrh	r0,[r1, r0]
	cmp	r0,#0
	bne	.Lj45
	bl	.Lj43
.Lj45:
	bl	.Lj41
.Lj43:
	add	r0,r13,#8
	ldrb	r0,[r0]
	mov	r1,r0
	mov	r0,#76
	mul	r1,r0
	ldr	r0,.Lj47
	ldr	r0,[r1, r0]
	cmp	r0,#0
	bne	.Lj48
	bl	.Lj46
.Lj48:
	bl	.Lj41
.Lj46:
# [125] tcb_array[i].state := socket^.fsm_state;
	add	r0,r13,#8
	ldrb	r0,[r0]
	mov	r2,r0
	mov	r0,#76
	mul	r2,r0
	ldr	r0,[r13]
	ldr	r1,[r0, #4]
	ldr	r0,.Lj47
	str	r1,[r2, r0]
# [126] tcb_array[i].dst_port := socket^.sck_port;
	add	r0,r13,#8
	ldrb	r0,[r0]
	mov	r2,r0
	mov	r0,#76
	mul	r2,r0
	ldr	r0,[r13]
	ldrh	r1,[r0, #2]
	ldr	r0,.Lj50
	strh	r1,[r2, r0]
# [127] tcb_array[i].src_port := 0;
	add	r0,r13,#8
	ldrb	r0,[r0]
	mov	r2,r0
	mov	r0,#76
	mul	r2,r0
	mov	r1,#0
	ldr	r0,.Lj44
	strh	r1,[r2, r0]
# [128] tcb_array[i].src_ip := 0;
	add	r0,r13,#8
	ldrb	r0,[r0]
	mov	r2,r0
	mov	r0,#76
	mul	r2,r0
	mov	r1,#0
	ldr	r0,.Lj39
	str	r1,[r2, r0]
# [129] tcb_array[i].rcv_nxt := 0;
	add	r0,r13,#8
	ldrb	r0,[r0]
	mov	r2,r0
	mov	r0,#76
	mul	r2,r0
	mov	r1,#0
	ldr	r0,.Lj53
	str	r1,[r2, r0]
# [130] tcb_array[i].snd_nxt := 0;
	add	r0,r13,#8
	ldrb	r0,[r0]
	mov	r2,r0
	mov	r0,#76
	mul	r2,r0
	mov	r1,#0
	ldr	r0,.Lj54
	str	r1,[r2, r0]
# [131] tcb_array[i].seg := 0;
	add	r0,r13,#8
	ldrb	r0,[r0]
	mov	r2,r0
	mov	r0,#76
	mul	r2,r0
	mov	r1,#0
	ldr	r0,.Lj55
	add	r0,r2
	strb	r1,[r0]
# [132] tcb_array[i].tcb_flags := FLAG_NUL;
	add	r0,r13,#8
	ldrb	r0,[r0]
	mov	r2,r0
	mov	r0,#76
	mul	r2,r0
	mov	r1,#0
	ldr	r0,.Lj56
	add	r0,r2
	strb	r1,[r0]
# [133] tcb_array[i].snd_data := nil;
	add	r0,r13,#8
	ldrb	r0,[r0]
	mov	r2,r0
	mov	r0,#76
	mul	r2,r0
	mov	r0,#0
	ldr	r1,.Lj57
	str	r0,[r2, r1]
# [134] tcb_array[i].snd_datalen := 0;
	add	r0,r13,#8
	ldrb	r0,[r0]
	mov	r2,r0
	mov	r0,#76
	mul	r2,r0
	mov	r1,#0
	ldr	r0,.Lj58
	add	r0,r2
	strh	r1,[r0]
# [135] Result := @tcb_array[i];
	add	r0,r13,#8
	ldrb	r0,[r0]
	mov	r1,r0
	mov	r0,#76
	mul	r1,r0
	ldr	r0,.Lj39
	add	r0,r1
	str	r0,[r13, #4]
# [139] Exit;
	bl	.Lj34
.Lj41:
	add	r0,r13,#8
	ldrb	r0,[r0]
	cmp	r0,#3
	bcc	.Lj60
	bl	.Lj38
.Lj60:
	bl	.Lj36
.Lj38:
.Lj34:
# [142] end;
	ldr	r0,[r13, #4]
	add	r13,r13,#48
	pop	{r15}
.Lc5:
	.balign 4
.Lj39:
	.long	U_$ETHERNET_IP_TCP_$$_TCB_ARRAY
.Lj44:
	.long	U_$ETHERNET_IP_TCP_$$_TCB_ARRAY+8
.Lj47:
	.long	U_$ETHERNET_IP_TCP_$$_TCB_ARRAY+40
.Lj50:
	.long	U_$ETHERNET_IP_TCP_$$_TCB_ARRAY+10
.Lj53:
	.long	U_$ETHERNET_IP_TCP_$$_TCB_ARRAY+24
.Lj54:
	.long	U_$ETHERNET_IP_TCP_$$_TCB_ARRAY+16
.Lj55:
	.long	U_$ETHERNET_IP_TCP_$$_TCB_ARRAY+57
.Lj56:
	.long	U_$ETHERNET_IP_TCP_$$_TCB_ARRAY+55
.Lj57:
	.long	U_$ETHERNET_IP_TCP_$$_TCB_ARRAY+60
.Lj58:
	.long	U_$ETHERNET_IP_TCP_$$_TCB_ARRAY+64
.Le2:
	.size	ETHERNET_IP_TCP_$$_TCB_GETTCB$PSOCKET$$PTCB, .Le2 - ETHERNET_IP_TCP_$$_TCB_GETTCB$PSOCKET$$PTCB

.section .text.n_ethernet_ip_tcp_$$_tcb_checktcb$longword$word$$ptcb,"ax"
	.balign 4
.thumb_func 
ETHERNET_IP_TCP_$$_TCB_CHECKTCB$LONGWORD$WORD$$PTCB:
.Lc8:
# [147] begin
	push	{r14}
	sub	r13,r13,#48
# Var ip located at r13+0, size=OS_32
# Var port located at r13+4, size=OS_16
# Var $result located at r13+8, size=OS_32
# Var i located at r13+12, size=OS_8
	str	r0,[r13]
	add	r0,r13,#4
	strh	r1,[r0]
# [148] Result := nil;
	mov	r0,#0
	str	r0,[r13, #8]
# [149] for i:=0 to TCB_LENGTH do
	mov	r1,#255
	add	r0,r13,#12
	strb	r1,[r0]
.Lj63:
	add	r0,r13,#12
	ldrb	r0,[r0]
	add	r0,#1
	uxtb	r0,r0
	add	r1,r13,#12
	strb	r0,[r1]
# [153] if (tcb_array[i].src_ip = ip) AND (tcb_array[i].src_port = port) then
	add	r0,r13,#12
	ldrb	r0,[r0]
	mov	r1,r0
	mov	r0,#76
	mul	r1,r0
	ldr	r0,.Lj66
	ldr	r1,[r1, r0]
	ldr	r0,[r13]
	cmp	r1,r0
	bne	.Lj69
	bl	.Lj67
.Lj69:
	bl	.Lj68
.Lj67:
	add	r0,r13,#12
	ldrb	r0,[r0]
	mov	r1,r0
	mov	r0,#76
	mul	r1,r0
	ldr	r0,.Lj71
	ldrh	r1,[r1, r0]
	add	r0,r13,#4
	ldrh	r0,[r0]
	cmp	r1,r0
	bne	.Lj72
	bl	.Lj70
.Lj72:
	bl	.Lj68
.Lj70:
# [155] Result := @tcb_array[i];
	add	r0,r13,#12
	ldrb	r0,[r0]
	mov	r1,r0
	mov	r0,#76
	mul	r1,r0
	ldr	r0,.Lj66
	add	r0,r1
	str	r0,[r13, #8]
# [156] Exit;
	bl	.Lj61
.Lj68:
	add	r0,r13,#12
	ldrb	r0,[r0]
	cmp	r0,#3
	bcc	.Lj74
	bl	.Lj65
.Lj74:
	bl	.Lj63
.Lj65:
.Lj61:
# [159] end;
	ldr	r0,[r13, #8]
	add	r13,r13,#48
	pop	{r15}
.Lc7:
	.balign 4
.Lj66:
	.long	U_$ETHERNET_IP_TCP_$$_TCB_ARRAY
.Lj71:
	.long	U_$ETHERNET_IP_TCP_$$_TCB_ARRAY+8
.Le3:
	.size	ETHERNET_IP_TCP_$$_TCB_CHECKTCB$LONGWORD$WORD$$PTCB, .Le3 - ETHERNET_IP_TCP_$$_TCB_CHECKTCB$LONGWORD$WORD$$PTCB

.section .text.n_ethernet_ip_tcp_$$_tcb_destroy$ptcb,"ax"
	.balign 4
.thumb_func 
ETHERNET_IP_TCP_$$_TCB_DESTROY$PTCB:
.Lc10:
# [162] begin
	push	{r14}
	sub	r13,r13,#40
# Var tcb located at r13+0, size=OS_32
	str	r0,[r13]
# [163] tcb^.state := CLOSED;
	ldr	r1,[r13]
	mov	r0,#0
	str	r0,[r1, #40]
# [164] tcb^.src_ip := 0;
	ldr	r1,[r13]
	mov	r0,#0
	str	r0,[r1]
# [165] tcb^.src_port := 0;
	ldr	r1,[r13]
	mov	r0,#0
	strh	r0,[r1, #8]
# [166] tcb^.dst_ip := 0;
	ldr	r0,[r13]
	mov	r1,#0
	str	r1,[r0, #4]
# [167] tcb^.dst_port := 0;
	ldr	r0,[r13]
	mov	r1,#0
	strh	r1,[r0, #10]
# [168] tcb^.rcv_nxt := 0;
	ldr	r0,[r13]
	mov	r1,#0
	str	r1,[r0, #24]
# [169] tcb^.seg := 0;
	ldr	r0,[r13]
	mov	r1,#0
	add	r0,#57
	strb	r1,[r0]
# [170] tcb^.snd_nxt := 0;
	ldr	r0,[r13]
	mov	r1,#0
	str	r1,[r0, #16]
# [171] tcb^.rcv_datalen := 0;
	ldr	r0,[r13]
	mov	r1,#0
	add	r0,#72
	strh	r1,[r0]
# [172] tcb^.rcv_data := nil;
	ldr	r0,[r13]
	mov	r1,#0
	str	r1,[r0, #68]
# [173] tcb^.snd_data := nil;
	ldr	r0,[r13]
	mov	r1,#0
	str	r1,[r0, #60]
# [174] tcb^.snd_datalen := 0;
	ldr	r0,[r13]
	mov	r1,#0
	add	r0,#64
	strh	r1,[r0]
# [175] tcb^.tcb_flags := FLAG_NUL;
	ldr	r0,[r13]
	mov	r1,#0
	add	r0,#55
	strb	r1,[r0]
# [176] end;
	add	r13,r13,#40
	pop	{r15}
.Lc9:
.Le4:
	.size	ETHERNET_IP_TCP_$$_TCB_DESTROY$PTCB, .Le4 - ETHERNET_IP_TCP_$$_TCB_DESTROY$PTCB

.section .text.n_ethernet_ip_tcp_$$_tcb_process$pbyte,"ax"
	.balign 4
.thumb_func 
.globl	ETHERNET_IP_TCP_$$_TCB_PROCESS$PBYTE
ETHERNET_IP_TCP_$$_TCB_PROCESS$PBYTE:
.Lc12:
# [181] begin
	push	{r14}
	sub	r13,r13,#40
# Var buffer located at r13+0, size=OS_32
# Var i located at r13+4, size=OS_8
	str	r0,[r13]
# [182] for i:=0 to TCB_LENGTH do
	mov	r1,#255
	add	r0,r13,#4
	strb	r1,[r0]
.Lj79:
	add	r0,r13,#4
	ldrb	r0,[r0]
	add	r0,#1
	uxtb	r0,r0
	add	r1,r13,#4
	strb	r0,[r1]
# [184] if(tcb_array[i].snd_datalen > 0) then begin
	add	r0,r13,#4
	ldrb	r0,[r0]
	mov	r1,r0
	mov	r0,#76
	mul	r1,r0
	ldr	r0,.Lj82
	add	r0,r1
	ldrh	r0,[r0]
	cmp	r0,#0
	bls	.Lj85
	bl	.Lj83
.Lj85:
	bl	.Lj84
.Lj83:
# [185] if ((tcb_array[i].tcb_flags AND FLAG_FIN) = 0) then tcb_array[i].tcb_flags := tcb_array[i].tcb_flags OR FLAG_PSH;
	add	r0,r13,#4
	ldrb	r0,[r0]
	mov	r1,r0
	mov	r0,#76
	mul	r1,r0
	ldr	r0,.Lj86
	add	r0,r1
	ldrb	r0,[r0]
	mov	r1,#1
	and	r0,r1
	cmp	r0,#0
	bne	.Lj89
	bl	.Lj87
.Lj89:
	bl	.Lj88
.Lj87:
	add	r0,r13,#4
	ldrb	r0,[r0]
	mov	r1,r0
	mov	r0,#76
	mul	r1,r0
	ldr	r0,.Lj86
	add	r0,r1
	ldrb	r0,[r0]
	mov	r1,#8
	orr	r0,r1
	uxtb	r1,r0
	add	r0,r13,#4
	ldrb	r0,[r0]
	mov	r2,r0
	mov	r0,#76
	mul	r2,r0
	ldr	r0,.Lj86
	add	r0,r2
	strb	r1,[r0]
.Lj88:
.Lj84:
# [188] if(tcb_array[i].tcb_flags > FLAG_NUL) then
	add	r0,r13,#4
	ldrb	r0,[r0]
	mov	r1,r0
	mov	r0,#76
	mul	r1,r0
	ldr	r0,.Lj86
	add	r0,r1
	ldrb	r0,[r0]
	cmp	r0,#0
	bls	.Lj95
	bl	.Lj93
.Lj95:
	bl	.Lj94
.Lj93:
# [190] ETH_Protocol_IP_TCP_Send(buffer, @tcb_array[i]);
	add	r0,r13,#4
	ldrb	r0,[r0]
	mov	r1,#76
	mul	r0,r1
	ldr	r1,.Lj96
	add	r1,r0
	ldr	r0,[r13]
	bl	ETHERNET_IP_TCP_$$_ETH_PROTOCOL_IP_TCP_SEND$PBYTE$PTCB
# [191] tcb_array[i].snd_data := nil;
	add	r0,r13,#4
	ldrb	r0,[r0]
	mov	r2,r0
	mov	r0,#76
	mul	r2,r0
	mov	r1,#0
	ldr	r0,.Lj97
	str	r1,[r2, r0]
# [192] tcb_array[i].snd_datalen := 0;
	add	r0,r13,#4
	ldrb	r0,[r0]
	mov	r2,r0
	mov	r0,#76
	mul	r2,r0
	mov	r1,#0
	ldr	r0,.Lj82
	add	r0,r2
	strh	r1,[r0]
.Lj94:
# [195] tcb_array[i].tcb_flags := FLAG_NUL;
	add	r0,r13,#4
	ldrb	r0,[r0]
	mov	r2,r0
	mov	r0,#76
	mul	r2,r0
	mov	r1,#0
	ldr	r0,.Lj86
	add	r0,r2
	strb	r1,[r0]
# [197] if(tcb_array[i].state = CLOSING) then begin
	add	r0,r13,#4
	ldrb	r0,[r0]
	mov	r1,r0
	mov	r0,#76
	mul	r1,r0
	ldr	r0,.Lj100
	ldr	r0,[r1, r0]
	cmp	r0,#8
	bne	.Lj103
	bl	.Lj101
.Lj103:
	bl	.Lj102
.Lj101:
# [198] TCB_Destroy(@tcb_array[i]);
	add	r0,r13,#4
	ldrb	r0,[r0]
	mov	r1,r0
	mov	r0,#76
	mul	r1,r0
	ldr	r0,.Lj96
	add	r0,r1
	bl	ETHERNET_IP_TCP_$$_TCB_DESTROY$PTCB
.Lj102:
# [201] if(tcb_array[i].state <> CLOSED) AND (tcb_array[i].time > TIMEOUT) then begin
	add	r0,r13,#4
	ldrb	r0,[r0]
	mov	r1,r0
	mov	r0,#76
	mul	r1,r0
	ldr	r0,.Lj100
	ldr	r0,[r1, r0]
	cmp	r0,#0
	beq	.Lj108
	bl	.Lj106
.Lj108:
	bl	.Lj107
.Lj106:
	add	r0,r13,#4
	ldrb	r0,[r0]
	mov	r1,r0
	mov	r0,#76
	mul	r1,r0
	ldr	r0,.Lj110
	ldr	r0,[r1, r0]
	ldr	r1,.Lj111
	cmp	r0,r1
	bls	.Lj112
	bl	.Lj109
.Lj112:
	bl	.Lj107
.Lj109:
# [202] tcb_array[i].state := CLOSING;
	add	r0,r13,#4
	ldrb	r0,[r0]
	mov	r2,r0
	mov	r0,#76
	mul	r2,r0
	mov	r1,#8
	ldr	r0,.Lj100
	str	r1,[r2, r0]
.Lj107:
	add	r0,r13,#4
	ldrb	r0,[r0]
	cmp	r0,#3
	bcc	.Lj114
	bl	.Lj81
.Lj114:
	bl	.Lj79
.Lj81:
# [205] end;
	add	r13,r13,#40
	pop	{r15}
.Lc11:
	.balign 4
.Lj82:
	.long	U_$ETHERNET_IP_TCP_$$_TCB_ARRAY+64
.Lj86:
	.long	U_$ETHERNET_IP_TCP_$$_TCB_ARRAY+55
.Lj96:
	.long	U_$ETHERNET_IP_TCP_$$_TCB_ARRAY
.Lj97:
	.long	U_$ETHERNET_IP_TCP_$$_TCB_ARRAY+60
.Lj100:
	.long	U_$ETHERNET_IP_TCP_$$_TCB_ARRAY+40
.Lj110:
	.long	U_$ETHERNET_IP_TCP_$$_TCB_ARRAY+44
.Lj111:
	.long	1800
.Le5:
	.size	ETHERNET_IP_TCP_$$_TCB_PROCESS$PBYTE, .Le5 - ETHERNET_IP_TCP_$$_TCB_PROCESS$PBYTE

.section .text.n_ethernet_ip_tcp_$$_calc_psdh$longword$longword$word$word$$word,"ax"
	.balign 4
.thumb_func 
ETHERNET_IP_TCP_$$_CALC_PSDH$LONGWORD$LONGWORD$WORD$WORD$$WORD:
.Lc14:
# [212] begin
	push	{r14}
	sub	r13,r13,#64
# Var src located at r13+0, size=OS_32
# Var dst located at r13+4, size=OS_32
# Var datalen located at r13+8, size=OS_16
# Var sum located at r13+12, size=OS_16
# Var $result located at r13+16, size=OS_16
# Var psdh located at r13+20, size=OS_NO
# Var p located at r13+32, size=OS_32
	str	r0,[r13]
	str	r1,[r13, #4]
	add	r0,r13,#8
	strh	r2,[r0]
	add	r0,r13,#12
	strh	r3,[r0]
# [213] p := @psdh[0];
	add	r0,r13,#20
	str	r0,[r13, #32]
# [215] p[3] := (src >> 24) AND $FF;..//* src ip address */
	ldr	r0,[r13]
	lsr	r0,r0,#24
	mov	r1,#255
	and	r0,r1
	uxtb	r1,r0
	ldr	r0,[r13, #32]
	strb	r1,[r0, #3]
# [216] p[2] := (src >> 16) AND $FF;
	ldr	r0,[r13]
	lsr	r0,r0,#16
	mov	r1,#255
	and	r0,r1
	uxtb	r1,r0
	ldr	r0,[r13, #32]
	strb	r1,[r0, #2]
# [217] p[1] := (src >> 8) AND $FF;
	ldr	r0,[r13]
	lsr	r0,r0,#8
	mov	r1,#255
	and	r0,r1
	uxtb	r1,r0
	ldr	r0,[r13, #32]
	strb	r1,[r0, #1]
# [218] p[0] := src AND $FF;
	ldr	r0,[r13]
	mov	r1,#255
	and	r0,r1
	uxtb	r1,r0
	ldr	r0,[r13, #32]
	strb	r1,[r0]
# [220] p[7] := (dst >> 24) AND $FF;..//* dst ip address */
	ldr	r0,[r13, #4]
	lsr	r0,r0,#24
	mov	r1,#255
	and	r0,r1
	uxtb	r0,r0
	ldr	r1,[r13, #32]
	strb	r0,[r1, #7]
# [221] p[6] := (dst >> 16) AND $FF;
	ldr	r0,[r13, #4]
	lsr	r0,r0,#16
	mov	r1,#255
	and	r0,r1
	uxtb	r0,r0
	ldr	r1,[r13, #32]
	strb	r0,[r1, #6]
# [222] p[5] := (dst >> 8) AND $FF;
	ldr	r0,[r13, #4]
	lsr	r0,r0,#8
	mov	r1,#255
	and	r0,r1
	uxtb	r0,r0
	ldr	r1,[r13, #32]
	strb	r0,[r1, #5]
# [223] p[4] := dst AND $FF;
	ldr	r0,[r13, #4]
	mov	r1,#255
	and	r0,r1
	uxtb	r0,r0
	ldr	r1,[r13, #32]
	strb	r0,[r1, #4]
# [225] p[8] := 0;
	ldr	r0,[r13, #32]
	mov	r1,#0
	strb	r1,[r0, #8]
# [226] p[9] := $06;...//* protocol */
	ldr	r0,[r13, #32]
	mov	r1,#6
	strb	r1,[r0, #9]
# [227] p[10] := datalen>>8;..//* tcp size */
	add	r0,r13,#8
	ldrh	r0,[r0]
	lsr	r0,r0,#8
	uxtb	r0,r0
	ldr	r1,[r13, #32]
	strb	r0,[r1, #10]
# [228] p[11] := datalen AND $ff;
	add	r0,r13,#8
	ldrh	r0,[r0]
	mov	r1,#255
	and	r0,r1
	uxtb	r0,r0
	ldr	r1,[r13, #32]
	strb	r0,[r1, #11]
# [230] Result := Calc_Checksum(psdh, 6, sum);
	add	r0,r13,#20
	add	r1,r13,#12
	ldrh	r2,[r1]
	mov	r1,#6
	bl	ETHERNET_IP_$$_CALC_CHECKSUM$PWORD$WORD$WORD$$WORD
	uxth	r0,r0
	add	r1,r13,#16
	strh	r0,[r1]
# [231] end;
	add	r1,r13,#16
	ldrh	r0,[r1]
	add	r13,r13,#64
	pop	{r15}
.Lc13:
.Le6:
	.size	ETHERNET_IP_TCP_$$_CALC_PSDH$LONGWORD$LONGWORD$WORD$WORD$$WORD, .Le6 - ETHERNET_IP_TCP_$$_CALC_PSDH$LONGWORD$LONGWORD$WORD$WORD$$WORD

.section .text.n_ethernet_ip_tcp_$$_eth_protocol_ip_tcp$pbyte$pbyte$word,"ax"
	.balign 4
.thumb_func 
.globl	ETHERNET_IP_TCP_$$_ETH_PROTOCOL_IP_TCP$PBYTE$PBYTE$WORD
ETHERNET_IP_TCP_$$_ETH_PROTOCOL_IP_TCP$PBYTE$PBYTE$WORD:
.Lc16:
# [244] begin
	push	{r4,r5,r14}
	sub	r13,r13,#72
# Var ip_hdr located at r13+0, size=OS_32
# Var tcp_hdr located at r13+4, size=OS_32
# Var ip_data_len located at r13+8, size=OS_16
# Var TCP_Header located at r13+12, size=OS_32
# Var IP_Header located at r13+16, size=OS_32
# Var ETH_Header located at r13+20, size=OS_32
# Var tcb located at r13+24, size=OS_32
# Var checksum located at r13+28, size=OS_16
# Var checksum_size located at r13+32, size=OS_16
# Var socket located at r13+36, size=OS_32
# Var i located at r13+40, size=OS_8
	str	r0,[r13]
	str	r1,[r13, #4]
	add	r0,r13,#8
	strh	r2,[r0]
# [234] var
	ldr	r0,.Lj119
	ldr	r0,[r0]
	str	r0,[r13, #36]
# [245] socket := nil;
	mov	r0,#0
	str	r0,[r13, #36]
# [246] tcb := nil;
	mov	r0,#0
	str	r0,[r13, #24]
# [247] IP_Header := PIP_HDR(ip_hdr);
	ldr	r0,[r13]
	str	r0,[r13, #16]
# [248] TCP_Header := PTCP_HDR(tcp_hdr);
	ldr	r0,[r13, #4]
	str	r0,[r13, #12]
# [250] checksum_size := ip_data_len;
	add	r0,r13,#8
	ldrh	r1,[r0]
	add	r0,r13,#32
	strh	r1,[r0]
# [251] if (checksum_size AND $01) = 1 then begin
	add	r0,r13,#32
	ldrh	r0,[r0]
	mov	r1,#1
	and	r0,r1
	cmp	r0,#1
	bne	.Lj122
	bl	.Lj120
.Lj122:
	bl	.Lj121
.Lj120:
# [252] tcp_hdr[checksum_size] := 0;
	ldr	r2,[r13, #4]
	add	r0,r13,#32
	ldrh	r1,[r0]
	mov	r0,#0
	strb	r0,[r2, r1]
# [253] Inc(checksum_size);
	add	r0,r13,#32
	ldrh	r0,[r0]
	add	r0,#1
	uxth	r0,r0
	add	r1,r13,#32
	strh	r0,[r1]
.Lj121:
# [256] checksum := Calc_Checksum(PWord(tcp_hdr), checksum_size>>1, 0);
	add	r0,r13,#32
	ldrh	r0,[r0]
	lsr	r0,r0,#1
	uxth	r0,r0
	uxth	r1,r0
	mov	r2,#0
	ldr	r0,[r13, #4]
	bl	ETHERNET_IP_$$_CALC_CHECKSUM$PWORD$WORD$WORD$$WORD
	uxth	r1,r0
	add	r0,r13,#28
	strh	r1,[r0]
# [257] checksum := calc_psdh(IP_Header^.src, IP_Header^.dst, ip_data_len, checksum);
	ldr	r1,[r13, #16]
	ldrb	r5,[r1, #16]
	ldrb	r0,[r1, #17]
	lsl	r0,#8
	orr	r5,r0
	ldrb	r0,[r1, #18]
	lsl	r0,#16
	orr	r5,r0
	ldrb	r0,[r1, #19]
	lsl	r0,#24
	orr	r5,r0
	ldr	r1,[r13, #16]
	ldrb	r4,[r1, #12]
	ldrb	r0,[r1, #13]
	lsl	r0,#8
	orr	r4,r0
	ldrb	r0,[r1, #14]
	lsl	r0,#16
	orr	r4,r0
	ldrb	r0,[r1, #15]
	lsl	r0,#24
	orr	r4,r0
	add	r0,r13,#28
	ldrh	r1,[r0]
	add	r0,r13,#8
	ldrh	r2,[r0]
	mov	r3,r1
	mov	r0,r4
	mov	r1,r5
	bl	ETHERNET_IP_TCP_$$_CALC_PSDH$LONGWORD$LONGWORD$WORD$WORD$$WORD
	uxth	r1,r0
	add	r0,r13,#28
	strh	r1,[r0]
# [258] if(checksum <> $FFFF) then exit;
	add	r0,r13,#28
	ldrh	r1,[r0]
	ldr	r0,.Lj123
	cmp	r1,r0
	beq	.Lj126
	bl	.Lj124
.Lj126:
	bl	.Lj125
.Lj124:
	bl	.Lj117
.Lj125:
# [261] socket := CheckPort(ByteSwap16(TCP_Header^.dst_port), IPV4_TYPE_TCP);
	ldr	r0,[r13, #12]
	ldrb	r1,[r0, #2]
	ldrb	r0,[r0, #3]
	lsl	r0,#8
	orr	r1,r0
	mov	r0,r1
	bl	ETHERNET_$$_BYTESWAP16$WORD$$WORD
	uxth	r0,r0
	uxth	r0,r0
	mov	r1,#6
	bl	ETHERNET_$$_CHECKPORT$WORD$BYTE$$PSOCKET
	str	r0,[r13, #36]
# [263] if(socket <> nil) then begin
	ldr	r0,[r13, #36]
	cmp	r0,#0
	beq	.Lj129
	bl	.Lj127
.Lj129:
	bl	.Lj128
.Lj127:
# [266] tcb := TCB_CheckTCB(ByteSwap32(IP_Header^.src), ByteSwap16(TCP_Header^.src_port));
	ldr	r0,[r13, #12]
	ldrb	r1,[r0]
	ldrb	r0,[r0, #1]
	lsl	r0,#8
	orr	r1,r0
	mov	r0,r1
	bl	ETHERNET_$$_BYTESWAP16$WORD$$WORD
	uxth	r0,r0
	uxth	r4,r0
	ldr	r2,[r13, #16]
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
	bl	ETHERNET_IP_TCP_$$_TCB_CHECKTCB$LONGWORD$WORD$$PTCB
	str	r0,[r13, #24]
# [267] if(tcb = nil) then
	ldr	r0,[r13, #24]
	cmp	r0,#0
	bne	.Lj132
	bl	.Lj130
.Lj132:
	bl	.Lj131
.Lj130:
# [268] tcb := TCB_GetTCB(socket);
	ldr	r0,[r13, #36]
	bl	ETHERNET_IP_TCP_$$_TCB_GETTCB$PSOCKET$$PTCB
	str	r0,[r13, #24]
.Lj131:
# [269] if(tcb = nil) then exit;
	ldr	r0,[r13, #24]
	cmp	r0,#0
	bne	.Lj135
	bl	.Lj133
.Lj135:
	bl	.Lj134
.Lj133:
	bl	.Lj117
.Lj134:
# [275] case (tcb^.state) of
	ldr	r0,[r13, #24]
	ldr	r0,[r0, #40]
	cmp	r0,#1
	bcs	.Lj143
	bl	.Lj137
.Lj143:
	sub	r0,#1
	bne	.Lj144
	bl	.Lj138
.Lj144:
	sub	r0,#2
	bne	.Lj145
	bl	.Lj139
.Lj145:
	sub	r0,#1
	bne	.Lj146
	bl	.Lj140
.Lj146:
	sub	r0,#2
	bne	.Lj147
	bl	.Lj141
.Lj147:
	sub	r0,#3
	bne	.Lj148
	bl	.Lj142
.Lj148:
	bl	.Lj137
.Lj138:
# [277] if (TCP_Header^.flags = FLAG_SYN) then begin
	ldr	r0,[r13, #12]
	ldrb	r0,[r0, #13]
	cmp	r0,#2
	bne	.Lj151
	bl	.Lj149
.Lj151:
	bl	.Lj150
.Lj149:
# [280] tcb^.src_ip := ByteSwap32(IP_Header^.src);
	ldr	r2,[r13, #16]
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
	mov	r1,r0
	ldr	r0,[r13, #24]
	str	r1,[r0]
# [281] tcb^.src_port := ByteSwap16(TCP_Header^.src_port);
	ldr	r0,[r13, #12]
	ldrb	r1,[r0]
	ldrb	r0,[r0, #1]
	lsl	r0,#8
	orr	r1,r0
	mov	r0,r1
	bl	ETHERNET_$$_BYTESWAP16$WORD$$WORD
	uxth	r1,r0
	ldr	r0,[r13, #24]
	strh	r1,[r0, #8]
# [282] tcb^.irs := ByteSwap32(TCP_Header^.seq);
	ldr	r2,[r13, #12]
	ldrb	r1,[r2, #4]
	ldrb	r0,[r2, #5]
	lsl	r0,#8
	orr	r1,r0
	ldrb	r0,[r2, #6]
	lsl	r0,#16
	orr	r1,r0
	ldrb	r0,[r2, #7]
	lsl	r0,#24
	orr	r1,r0
	mov	r0,r1
	bl	ETHERNET_$$_BYTESWAP32$LONGWORD$$LONGWORD
	mov	r1,r0
	ldr	r0,[r13, #24]
	str	r1,[r0, #36]
# [283] tcb^.rcv_nxt := ByteSwap32(TCP_Header^.seq) + 1;
	ldr	r2,[r13, #12]
	ldrb	r1,[r2, #4]
	ldrb	r0,[r2, #5]
	lsl	r0,#8
	orr	r1,r0
	ldrb	r0,[r2, #6]
	lsl	r0,#16
	orr	r1,r0
	ldrb	r0,[r2, #7]
	lsl	r0,#24
	orr	r1,r0
	mov	r0,r1
	bl	ETHERNET_$$_BYTESWAP32$LONGWORD$$LONGWORD
	add	r0,#1
	ldr	r1,[r13, #24]
	str	r0,[r1, #24]
# [284] tcb^.rcv_wnd := ByteSwap16(TCP_Header^.window_size);
	ldr	r0,[r13, #12]
	ldrb	r1,[r0, #14]
	ldrb	r0,[r0, #15]
	lsl	r0,#8
	orr	r1,r0
	mov	r0,r1
	bl	ETHERNET_$$_BYTESWAP16$WORD$$WORD
	uxth	r1,r0
	ldr	r0,[r13, #24]
	str	r1,[r0, #28]
# [285] tcb^.snd_una := tcb^.iss;
	ldr	r1,[r13, #24]
	ldr	r0,[r13, #24]
	ldr	r0,[r0, #32]
	str	r0,[r1, #12]
# [286] tcb^.snd_nxt := tcb^.iss;
	ldr	r1,[r13, #24]
	ldr	r0,[r13, #24]
	ldr	r0,[r0, #32]
	str	r0,[r1, #16]
# [287] tcb^.state := SYN_RECEIVED;
	ldr	r1,[r13, #24]
	mov	r0,#3
	str	r0,[r1, #40]
# [289] ETH_Header := @ip_hdr[0] - ETH_HEADER_SIZE ;
	ldr	r0,[r13]
	sub	r0,#14
	str	r0,[r13, #20]
# [290] for i:=0 to 5 do
	mov	r1,#255
	add	r0,r13,#40
# [412] end;
	b	.Lj189
	.balign 4
.Lj119:
	.long	TC_$ETHERNET_IP_TCP$_$ETH_PROTOCOL_IP_TCP$PBYTE$PBYTE$WORD_$$_defaultsocket
.Lj123:
	.long	65535
.Lj189:
	strb	r1,[r0]
.Lj152:
	add	r0,r13,#40
	ldrb	r0,[r0]
	add	r0,#1
	uxtb	r0,r0
	add	r1,r13,#40
	strb	r0,[r1]
# [291] tcb^.src_mac[i] := ETH_Header^.src[i];
	ldr	r4,[r13, #24]
	add	r0,r13,#40
	ldrb	r3,[r0]
	ldr	r2,[r13, #20]
	add	r0,r13,#40
	ldrb	r1,[r0]
	mov	r0,r2
	add	r0,#6
	ldrb	r1,[r0, r1]
	mov	r0,r3
	add	r0,r4
	add	r0,#49
	strb	r1,[r0]
	add	r0,r13,#40
	ldrb	r0,[r0]
	cmp	r0,#5
	bcc	.Lj155
	bl	.Lj154
.Lj155:
	bl	.Lj152
.Lj154:
# [293] tcb^.tcb_flags := FLAG_SYN OR FLAG_ACK;
	ldr	r0,[r13, #24]
	mov	r1,#18
	add	r0,#55
	strb	r1,[r0]
# [294] tcb^.time := 0;
	ldr	r0,[r13, #24]
	mov	r1,#0
	str	r1,[r0, #44]
.Lj150:
# [297] if(TCP_Header^.flags = FLAG_RST) then begin
	ldr	r0,[r13, #12]
	ldrb	r0,[r0, #13]
	cmp	r0,#4
	bne	.Lj158
	bl	.Lj156
.Lj158:
	bl	.Lj157
.Lj156:
# [298] tcb^.state := CLOSING;
	ldr	r0,[r13, #24]
	mov	r1,#8
	str	r1,[r0, #40]
# [299] tcb^.tcb_flags := FLAG_NUL;
	ldr	r0,[r13, #24]
	mov	r1,#0
	add	r0,#55
	strb	r1,[r0]
.Lj157:
	bl	.Lj136
.Lj139:
# [304] if(TCP_Header^.flags = FLAG_ACK) then begin
	ldr	r0,[r13, #12]
	ldrb	r0,[r0, #13]
	cmp	r0,#16
	bne	.Lj161
	bl	.Lj159
.Lj161:
	bl	.Lj160
.Lj159:
# [307] if(tcb^.snd_nxt = ByteSwap32(TCP_Header^.ack)) then begin
	ldr	r4,[r13, #24]
	ldr	r2,[r13, #12]
	ldrb	r1,[r2, #8]
	ldrb	r0,[r2, #9]
	lsl	r0,#8
	orr	r1,r0
	ldrb	r0,[r2, #10]
	lsl	r0,#16
	orr	r1,r0
	ldrb	r0,[r2, #11]
	lsl	r0,#24
	orr	r1,r0
	mov	r0,r1
	bl	ETHERNET_$$_BYTESWAP32$LONGWORD$$LONGWORD
	ldr	r1,[r4, #16]
	cmp	r1,r0
	bne	.Lj164
	bl	.Lj162
.Lj164:
	bl	.Lj163
.Lj162:
# [308] tcb^.state := ESTABLISHED;
	ldr	r1,[r13, #24]
	mov	r0,#4
	str	r0,[r1, #40]
# [309] tcb^.rcv_nxt := ByteSwap32(TCP_Header^.seq) + 1;
	ldr	r2,[r13, #12]
	ldrb	r1,[r2, #4]
	ldrb	r0,[r2, #5]
	lsl	r0,#8
	orr	r1,r0
	ldrb	r0,[r2, #6]
	lsl	r0,#16
	orr	r1,r0
	ldrb	r0,[r2, #7]
	lsl	r0,#24
	orr	r1,r0
	mov	r0,r1
	bl	ETHERNET_$$_BYTESWAP32$LONGWORD$$LONGWORD
	add	r0,#1
	ldr	r1,[r13, #24]
	str	r0,[r1, #24]
# [310] tcb^.snd_nxt := ByteSwap32(TCP_Header^.ack);
	ldr	r2,[r13, #12]
	ldrb	r1,[r2, #8]
	ldrb	r0,[r2, #9]
	lsl	r0,#8
	orr	r1,r0
	ldrb	r0,[r2, #10]
	lsl	r0,#16
	orr	r1,r0
	ldrb	r0,[r2, #11]
	lsl	r0,#24
	orr	r1,r0
	mov	r0,r1
	bl	ETHERNET_$$_BYTESWAP32$LONGWORD$$LONGWORD
	mov	r1,r0
	ldr	r0,[r13, #24]
	str	r1,[r0, #16]
# [311] tcb^.time := 0;
	ldr	r1,[r13, #24]
	mov	r0,#0
	str	r0,[r1, #44]
.Lj163:
.Lj160:
# [315] if(TCP_Header^.flags = FLAG_RST) then begin
	ldr	r0,[r13, #12]
	ldrb	r0,[r0, #13]
	cmp	r0,#4
	bne	.Lj167
	bl	.Lj165
.Lj167:
	bl	.Lj166
.Lj165:
# [318] TCB_Destroy(tcb);
	ldr	r0,[r13, #24]
	bl	ETHERNET_IP_TCP_$$_TCB_DESTROY$PTCB
.Lj166:
	bl	.Lj136
.Lj140:
# [324] if(TCP_Header^.flags = (FLAG_PSH OR FLAG_ACK)  )then begin
	ldr	r0,[r13, #12]
	ldrb	r0,[r0, #13]
	cmp	r0,#24
	bne	.Lj170
	bl	.Lj168
.Lj170:
	bl	.Lj169
.Lj168:
# [327] tcb^.rcv_data := tcp_hdr + (TCP_Header^.hdr_len>>2) - 1;
	ldr	r0,[r13, #12]
	ldrb	r0,[r0, #12]
	mov	r1,r0
	lsr	r1,r1,#2
	ldr	r0,[r13, #4]
	add	r0,r1
	sub	r0,#1
	ldr	r1,[r13, #24]
	str	r0,[r1, #68]
# [328] tcb^.rcv_datalen := ByteSwap16(IP_Header^.total_len) - word((IP_Header^.ver_len AND $0F) << 2) - word(TCP_Header^.hdr_len>>2);
	ldr	r0,[r13, #16]
	ldrb	r1,[r0, #2]
	ldrb	r0,[r0, #3]
	lsl	r0,#8
	orr	r1,r0
	mov	r0,r1
	bl	ETHERNET_$$_BYTESWAP16$WORD$$WORD
	uxth	r1,r0
	ldr	r0,[r13, #16]
	ldrb	r0,[r0]
	mov	r2,#15
	and	r0,r2
	lsl	r0,r0,#2
	uxth	r0,r0
	sub	r1,r0
	ldr	r0,[r13, #12]
	ldrb	r0,[r0, #12]
	lsr	r0,r0,#2
	uxth	r0,r0
	sub	r1,r0
	uxth	r1,r1
	ldr	r0,[r13, #24]
	add	r0,#72
	strh	r1,[r0]
# [329] tcb^.rcv_nxt := ByteSwap32(TCP_Header^.seq) + tcb^.rcv_datalen; // + datalen
	ldr	r2,[r13, #12]
	ldrb	r1,[r2, #4]
	ldrb	r0,[r2, #5]
	lsl	r0,#8
	orr	r1,r0
	ldrb	r0,[r2, #6]
	lsl	r0,#16
	orr	r1,r0
	ldrb	r0,[r2, #7]
	lsl	r0,#24
	orr	r1,r0
	mov	r0,r1
	bl	ETHERNET_$$_BYTESWAP32$LONGWORD$$LONGWORD
	ldr	r1,[r13, #24]
	add	r1,#72
	ldrh	r1,[r1]
	add	r1,r0
	ldr	r0,[r13, #24]
	str	r1,[r0, #24]
# [330] tcb^.snd_nxt := ByteSwap32(TCP_Header^.ack);
	ldr	r2,[r13, #12]
	ldrb	r1,[r2, #8]
	ldrb	r0,[r2, #9]
	lsl	r0,#8
	orr	r1,r0
	ldrb	r0,[r2, #10]
	lsl	r0,#16
	orr	r1,r0
	ldrb	r0,[r2, #11]
	lsl	r0,#24
	orr	r1,r0
	mov	r0,r1
	bl	ETHERNET_$$_BYTESWAP32$LONGWORD$$LONGWORD
	ldr	r1,[r13, #24]
	str	r0,[r1, #16]
# [331] tcb^.tcb_flags :=  FLAG_ACK;
	ldr	r0,[r13, #24]
	mov	r1,#16
	add	r0,#55
	strb	r1,[r0]
# [332] tcb^.time := 0;
	ldr	r1,[r13, #24]
	mov	r0,#0
	str	r0,[r1, #44]
# [340] if(socket^.recv_func <> nil) then
	ldr	r0,[r13, #36]
	ldr	r0,[r0, #12]
	cmp	r0,#0
	beq	.Lj173
	bl	.Lj171
.Lj173:
	bl	.Lj172
.Lj171:
# [341] socket^.recv_func(tcb^.id, tcb^.rcv_data, tcb^.rcv_datalen);
	ldr	r0,[r13, #24]
	add	r0,#72
	ldrh	r4,[r0]
	ldr	r0,[r13, #24]
	ldr	r2,[r0, #68]
	ldr	r0,[r13, #24]
	add	r0,#48
	ldrb	r1,[r0]
	ldr	r0,[r13, #36]
	ldr	r3,[r0, #12]
	mov	r0,r1
	mov	r1,r2
	mov	r2,r4
	blx	r3
.Lj172:
# [342] if ((tcb^.tcb_flags AND FLAG_FIN) = FLAG_FIN) then
	ldr	r0,[r13, #24]
	add	r0,#55
	ldrb	r0,[r0]
	mov	r1,#1
	and	r0,r1
	cmp	r0,#1
	bne	.Lj176
	bl	.Lj174
.Lj176:
	bl	.Lj175
.Lj174:
# [343] ClrPins(GPIO_Port_0, GPIO_Pin_3);
	mov	r1,#8
	mov	r0,#0
	bl	UTILS_$$_CLRPINS$BYTE$WORD
.Lj175:
# [345] tcb^.rcv_data := nil;
	ldr	r1,[r13, #24]
	mov	r0,#0
	str	r0,[r1, #68]
# [346] tcb^.rcv_datalen := 0;
	ldr	r0,[r13, #24]
	mov	r1,#0
	add	r0,#72
	strh	r1,[r0]
.Lj169:
# [349] if(TCP_Header^.flags = FLAG_ACK) then begin
	ldr	r0,[r13, #12]
	ldrb	r0,[r0, #13]
	cmp	r0,#16
	bne	.Lj179
	bl	.Lj177
.Lj179:
	bl	.Lj178
.Lj177:
# [350] tcb^.rcv_data := tcp_hdr + (TCP_Header^.hdr_len>>2) - 1;
	ldr	r0,[r13, #12]
	ldrb	r0,[r0, #12]
	mov	r1,r0
	lsr	r1,r1,#2
	ldr	r0,[r13, #4]
	add	r0,r1
	sub	r0,#1
	ldr	r1,[r13, #24]
	str	r0,[r1, #68]
# [351] tcb^.rcv_datalen := ByteSwap16(IP_Header^.total_len) - word((IP_Header^.ver_len AND $0F) << 2) - word(TCP_Header^.hdr_len>>2);
	ldr	r0,[r13, #16]
	ldrb	r1,[r0, #2]
	ldrb	r0,[r0, #3]
	lsl	r0,#8
	orr	r1,r0
	mov	r0,r1
	bl	ETHERNET_$$_BYTESWAP16$WORD$$WORD
	uxth	r1,r0
	ldr	r0,[r13, #16]
	ldrb	r0,[r0]
	mov	r2,#15
	and	r0,r2
	lsl	r0,r0,#2
	uxth	r0,r0
	sub	r1,r0
	ldr	r0,[r13, #12]
	ldrb	r0,[r0, #12]
	lsr	r0,r0,#2
	uxth	r0,r0
	sub	r1,r0
	uxth	r1,r1
	ldr	r0,[r13, #24]
	add	r0,#72
	strh	r1,[r0]
# [352] tcb^.rcv_nxt := ByteSwap32(TCP_Header^.seq) + tcb^.rcv_datalen; // + datalen
	ldr	r2,[r13, #12]
	ldrb	r1,[r2, #4]
	ldrb	r0,[r2, #5]
	lsl	r0,#8
	orr	r1,r0
	ldrb	r0,[r2, #6]
	lsl	r0,#16
	orr	r1,r0
	ldrb	r0,[r2, #7]
	lsl	r0,#24
	orr	r1,r0
	mov	r0,r1
	bl	ETHERNET_$$_BYTESWAP32$LONGWORD$$LONGWORD
	ldr	r1,[r13, #24]
	add	r1,#72
	ldrh	r1,[r1]
	add	r1,r0
	ldr	r0,[r13, #24]
	str	r1,[r0, #24]
# [353] tcb^.snd_nxt := ByteSwap32(TCP_Header^.ack);
	ldr	r2,[r13, #12]
	ldrb	r1,[r2, #8]
	ldrb	r0,[r2, #9]
	lsl	r0,#8
	orr	r1,r0
	ldrb	r0,[r2, #10]
	lsl	r0,#16
	orr	r1,r0
	ldrb	r0,[r2, #11]
	lsl	r0,#24
	orr	r1,r0
	mov	r0,r1
	bl	ETHERNET_$$_BYTESWAP32$LONGWORD$$LONGWORD
	ldr	r1,[r13, #24]
	str	r0,[r1, #16]
# [354] tcb^.tcb_flags :=  FLAG_ACK;
	ldr	r0,[r13, #24]
	mov	r1,#16
	add	r0,#55
	strb	r1,[r0]
# [355] tcb^.time := 0;
	ldr	r0,[r13, #24]
	mov	r1,#0
	str	r1,[r0, #44]
.Lj178:
# [362] if((TCP_Header^.flags AND FLAG_FIN) = FLAG_FIN) then begin
	ldr	r0,[r13, #12]
	ldrb	r0,[r0, #13]
	mov	r1,#1
	and	r0,r1
	cmp	r0,#1
	bne	.Lj182
	bl	.Lj180
.Lj182:
	bl	.Lj181
.Lj180:
# [365] tcb^.rcv_nxt := ByteSwap32(TCP_Header^.seq) + 1;
	ldr	r1,[r13, #12]
	ldrb	r2,[r1, #4]
	ldrb	r0,[r1, #5]
	lsl	r0,#8
	orr	r2,r0
	ldrb	r0,[r1, #6]
	lsl	r0,#16
	orr	r2,r0
	ldrb	r0,[r1, #7]
	lsl	r0,#24
	orr	r2,r0
	mov	r0,r2
	bl	ETHERNET_$$_BYTESWAP32$LONGWORD$$LONGWORD
	add	r0,#1
	ldr	r1,[r13, #24]
	str	r0,[r1, #24]
# [366] tcb^.snd_nxt := ByteSwap32(TCP_Header^.ack);
	ldr	r1,[r13, #12]
	ldrb	r2,[r1, #8]
	ldrb	r0,[r1, #9]
	lsl	r0,#8
	orr	r2,r0
	ldrb	r0,[r1, #10]
	lsl	r0,#16
	orr	r2,r0
	ldrb	r0,[r1, #11]
	lsl	r0,#24
	orr	r2,r0
	mov	r0,r2
	bl	ETHERNET_$$_BYTESWAP32$LONGWORD$$LONGWORD
	ldr	r1,[r13, #24]
	str	r0,[r1, #16]
# [367] tcb^.tcb_flags := (FLAG_FIN OR FLAG_ACK);
	ldr	r0,[r13, #24]
	mov	r1,#17
	add	r0,#55
	strb	r1,[r0]
# [368] tcb^.state := LAST_ACK;
	ldr	r1,[r13, #24]
	mov	r0,#9
	str	r0,[r1, #40]
.Lj181:
	bl	.Lj136
.Lj141:
# [383] if(TCP_Header^.flags = (FLAG_FIN OR FLAG_ACK)) then begin
	ldr	r0,[r13, #12]
	ldrb	r0,[r0, #13]
	cmp	r0,#17
	bne	.Lj185
	bl	.Lj183
.Lj185:
	bl	.Lj184
.Lj183:
# [386] tcb^.rcv_nxt := ByteSwap32(TCP_Header^.seq) + 1;
	ldr	r2,[r13, #12]
	ldrb	r1,[r2, #4]
	ldrb	r0,[r2, #5]
	lsl	r0,#8
	orr	r1,r0
	ldrb	r0,[r2, #6]
	lsl	r0,#16
	orr	r1,r0
	ldrb	r0,[r2, #7]
	lsl	r0,#24
	orr	r1,r0
	mov	r0,r1
	bl	ETHERNET_$$_BYTESWAP32$LONGWORD$$LONGWORD
	add	r0,#1
	ldr	r1,[r13, #24]
	str	r0,[r1, #24]
# [387] tcb^.snd_nxt := ByteSwap32(TCP_Header^.ack);
	ldr	r1,[r13, #12]
	ldrb	r2,[r1, #8]
	ldrb	r0,[r1, #9]
	lsl	r0,#8
	orr	r2,r0
	ldrb	r0,[r1, #10]
	lsl	r0,#16
	orr	r2,r0
	ldrb	r0,[r1, #11]
	lsl	r0,#24
	orr	r2,r0
	mov	r0,r2
	bl	ETHERNET_$$_BYTESWAP32$LONGWORD$$LONGWORD
	ldr	r1,[r13, #24]
	str	r0,[r1, #16]
# [388] tcb^.state := CLOSING;
	ldr	r1,[r13, #24]
	mov	r0,#8
	str	r0,[r1, #40]
# [389] tcb^.tcb_flags := FLAG_ACK;
	ldr	r0,[r13, #24]
	mov	r1,#16
	add	r0,#55
	strb	r1,[r0]
# [390] tcb^.time := 0;
	ldr	r1,[r13, #24]
	mov	r0,#0
	str	r0,[r1, #44]
.Lj184:
	bl	.Lj136
.Lj142:
# [395] if(TCP_Header^.flags AND FLAG_ACK) = FLAG_ACK then begin
	ldr	r0,[r13, #12]
	ldrb	r0,[r0, #13]
	mov	r1,#16
	and	r0,r1
	cmp	r0,#16
	bne	.Lj188
	bl	.Lj186
.Lj188:
	bl	.Lj187
.Lj186:
# [398] tcb^.rcv_nxt := ByteSwap32(TCP_Header^.seq) + 1;
	ldr	r2,[r13, #12]
	ldrb	r1,[r2, #4]
	ldrb	r0,[r2, #5]
	lsl	r0,#8
	orr	r1,r0
	ldrb	r0,[r2, #6]
	lsl	r0,#16
	orr	r1,r0
	ldrb	r0,[r2, #7]
	lsl	r0,#24
	orr	r1,r0
	mov	r0,r1
	bl	ETHERNET_$$_BYTESWAP32$LONGWORD$$LONGWORD
	add	r0,#1
	ldr	r1,[r13, #24]
	str	r0,[r1, #24]
# [399] tcb^.snd_nxt := ByteSwap32(TCP_Header^.ack);
	ldr	r2,[r13, #12]
	ldrb	r1,[r2, #8]
	ldrb	r0,[r2, #9]
	lsl	r0,#8
	orr	r1,r0
	ldrb	r0,[r2, #10]
	lsl	r0,#16
	orr	r1,r0
	ldrb	r0,[r2, #11]
	lsl	r0,#24
	orr	r1,r0
	mov	r0,r1
	bl	ETHERNET_$$_BYTESWAP32$LONGWORD$$LONGWORD
	mov	r1,r0
	ldr	r0,[r13, #24]
	str	r1,[r0, #16]
# [400] tcb^.state := CLOSING;
	ldr	r0,[r13, #24]
	mov	r1,#8
	str	r1,[r0, #40]
# [401] TCB_Destroy(tcb);
	ldr	r0,[r13, #24]
	bl	ETHERNET_IP_TCP_$$_TCB_DESTROY$PTCB
.Lj187:
	bl	.Lj136
.Lj137:
# [408] TCB_Destroy(tcb);
	ldr	r0,[r13, #24]
	bl	ETHERNET_IP_TCP_$$_TCB_DESTROY$PTCB
.Lj136:
.Lj128:
.Lj117:
	add	r13,r13,#72
	pop	{r4,r5,r15}
.Lc15:
.Le7:
	.size	ETHERNET_IP_TCP_$$_ETH_PROTOCOL_IP_TCP$PBYTE$PBYTE$WORD, .Le7 - ETHERNET_IP_TCP_$$_ETH_PROTOCOL_IP_TCP$PBYTE$PBYTE$WORD

.section .text.n_ethernet_ip_tcp_$$_eth_protocol_ip_tcp_send$pbyte$ptcb,"ax"
	.balign 4
.thumb_func 
.globl	ETHERNET_IP_TCP_$$_ETH_PROTOCOL_IP_TCP_SEND$PBYTE$PTCB
ETHERNET_IP_TCP_$$_ETH_PROTOCOL_IP_TCP_SEND$PBYTE$PTCB:
.Lc18:
# [423] begin
	push	{r4,r14}
	sub	r13,r13,#112
# Var snd_buf located at r13+0, size=OS_32
# Var tcb located at r13+4, size=OS_32
# Var ETH_Header located at r13+8, size=OS_NO
# Var TCP_Header located at r13+24, size=OS_NO
# Var IP_Header located at r13+44, size=OS_NO
# Var i located at r13+64, size=OS_8
# Var checksum located at r13+68, size=OS_16
# Var checksum_psdh located at r13+72, size=OS_16
# Var checksum_data located at r13+76, size=OS_16
# Var datalen located at r13+80, size=OS_16
# Var olddatalen located at r13+84, size=OS_16
# Var len located at r13+88, size=OS_16
	str	r0,[r13]
	str	r1,[r13, #4]
# [424] len := tcb^.snd_datalen;
	ldr	r0,[r13, #4]
	add	r0,#64
	ldrh	r1,[r0]
	add	r0,r13,#88
	strh	r1,[r0]
# [425] datalen := len;
	add	r0,r13,#88
	ldrh	r1,[r0]
	add	r0,r13,#80
	strh	r1,[r0]
# [426] olddatalen := datalen;
	add	r0,r13,#80
	ldrh	r1,[r0]
	add	r0,r13,#84
	strh	r1,[r0]
# [428] Fillbyte(snd_buf[0], BUFFER_SIZE, 0);
	ldr	r1,.Lj192
	ldr	r0,[r13]
	mov	r2,#0
	bl	SYSTEM_$$_FILLBYTE$formal$LONGINT$BYTE
# [430] if datalen > 0 then
	add	r0,r13,#80
	ldrh	r0,[r0]
	cmp	r0,#0
	bls	.Lj195
	bl	.Lj193
.Lj195:
	bl	.Lj194
.Lj193:
# [431] move(tcb^.snd_data[0], snd_buf[0], datalen);
	ldr	r0,[r13, #4]
	ldr	r0,[r0, #60]
	add	r1,r13,#80
	ldrh	r2,[r1]
	ldr	r1,[r13]
	bl	SYSTEM_$$_MOVE$formal$formal$LONGINT
.Lj194:
# [433] ETH_Header.hdrtype := ByteSwap16(ETH_FRAME_TYPE_IPV4);
	ldr	r0,.Lj196
	bl	ETHERNET_$$_BYTESWAP16$WORD$$WORD
	uxth	r1,r0
	add	r0,r13,#20
	strh	r1,[r0]
# [434] for i:=0 to 5 do begin
	mov	r1,#255
	add	r0,r13,#64
	strb	r1,[r0]
.Lj197:
	add	r0,r13,#64
	ldrb	r0,[r0]
	add	r0,#1
	uxtb	r0,r0
	add	r1,r13,#64
	strb	r0,[r1]
# [435] ETH_Header.dst[i] := tcb^.src_mac[i];
	add	r0,r13,#64
	ldrb	r2,[r0]
	ldr	r1,[r13, #4]
	add	r0,r13,#64
	ldrb	r0,[r0]
	add	r0,r1
	add	r0,#49
	ldrb	r1,[r0]
	mov	r0,r2
	add	r0,r13
	add	r0,#8
	strb	r1,[r0]
# [436] ETH_Header.src[i] := MACADDR[i];
	ldr	r0,.Lj200
	ldr	r2,[r0]
	add	r0,r13,#64
	ldrb	r1,[r0]
	add	r0,r13,#64
	ldrb	r0,[r0]
	ldrb	r1,[r2, r1]
	add	r0,r13
	add	r0,#14
	strb	r1,[r0]
	add	r0,r13,#64
	ldrb	r0,[r0]
	cmp	r0,#5
	bcc	.Lj201
	bl	.Lj199
.Lj201:
	bl	.Lj197
.Lj199:
# [439] Inc(package_id);
	ldr	r0,.Lj202
	mov	r1,r0
	ldrh	r0,[r1]
	add	r0,#1
	uxth	r0,r0
	strh	r0,[r1]
# [440] IP_Header.id := ByteSwap16(package_id);
	ldr	r0,.Lj202
	ldrh	r0,[r0]
	bl	ETHERNET_$$_BYTESWAP16$WORD$$WORD
	uxth	r1,r0
	add	r0,r13,#48
	strh	r1,[r0]
# [441] IP_Header.dsfield := 0;
	mov	r1,#0
	mov	r0,r13
	add	r0,#45
	strb	r1,[r0]
# [442] IP_Header.ver_len := $45;
	mov	r1,#69
	add	r0,r13,#44
	strb	r1,[r0]
# [443] IP_Header.flags := $40;
	mov	r1,#64
	mov	r0,r13
	add	r0,#50
	strb	r1,[r0]
# [444] IP_Header.protocol := IPV4_TYPE_TCP;
	mov	r1,#6
	mov	r0,r13
	add	r0,#53
	strb	r1,[r0]
# [445] IP_Header.ttl := 128;
	mov	r1,#128
	add	r0,r13,#52
	strb	r1,[r0]
# [446] IP_Header.frag_offset := 0;
	mov	r1,#0
	mov	r0,r13
	add	r0,#51
	strb	r1,[r0]
# [448] IP_Header.checksum := 0;
	mov	r1,#0
	mov	r0,r13
	add	r0,#54
	strh	r1,[r0]
# [449] IP_Header.dst := ByteSwap32(tcb^.src_ip);
	ldr	r0,[r13, #4]
	ldr	r0,[r0]
	bl	ETHERNET_$$_BYTESWAP32$LONGWORD$$LONGWORD
	str	r0,[r13, #60]
# [450] IP_Header.src := ByteSwap32((ip[0]<<24) OR (ip[1] << 16) OR (ip[2] << 8) OR ip[3]);
	ldr	r0,.Lj204
	ldr	r0,[r0]
	ldrb	r0,[r0]
	mov	r1,r0
	lsl	r1,r1,#24
	ldr	r0,.Lj204
	ldr	r0,[r0]
	ldrb	r0,[r0, #1]
	mov	r2,r0
	lsl	r2,r2,#16
	orr	r2,r1
	ldr	r0,.Lj204
	ldr	r0,[r0]
	ldrb	r0,[r0, #2]
	mov	r1,r0
	lsl	r1,r1,#8
	orr	r1,r2
	ldr	r0,.Lj204
	ldr	r0,[r0]
	ldrb	r0,[r0, #3]
	orr	r0,r1
	bl	ETHERNET_$$_BYTESWAP32$LONGWORD$$LONGWORD
	str	r0,[r13, #56]
# [452] TCP_Header.dst_port := ByteSwap16(tcb^.src_port);
	ldr	r0,[r13, #4]
	ldrh	r0,[r0, #8]
	bl	ETHERNET_$$_BYTESWAP16$WORD$$WORD
	uxth	r1,r0
	mov	r0,r13
	add	r0,#26
	strh	r1,[r0]
# [453] TCP_Header.src_port := ByteSwap16(tcb^.dst_port);
	ldr	r0,[r13, #4]
	ldrh	r0,[r0, #10]
	bl	ETHERNET_$$_BYTESWAP16$WORD$$WORD
	uxth	r0,r0
	add	r1,r13,#24
	strh	r0,[r1]
# [455] TCP_Header.seq := ByteSwap32(tcb^.snd_nxt);
	ldr	r0,[r13, #4]
	ldr	r0,[r0, #16]
	bl	ETHERNET_$$_BYTESWAP32$LONGWORD$$LONGWORD
	str	r0,[r13, #28]
# [456] TCP_Header.ack := ByteSwap32(tcb^.rcv_nxt);
	ldr	r0,[r13, #4]
	ldr	r0,[r0, #24]
	bl	ETHERNET_$$_BYTESWAP32$LONGWORD$$LONGWORD
	str	r0,[r13, #32]
# [457] TCP_Header.hdr_len := (sizeof(TCP_Header) << 2);
	mov	r0,#80
	add	r1,r13,#36
	strb	r0,[r1]
# [458] TCP_Header.flags := tcb^.tcb_flags;
	ldr	r0,[r13, #4]
	add	r0,#55
	ldrb	r1,[r0]
	mov	r0,r13
	add	r0,#37
	strb	r1,[r0]
# [459] TCP_Header.window_size := ByteSwap16(BUFFER_SIZE);
	ldr	r0,.Lj192
	bl	ETHERNET_$$_BYTESWAP16$WORD$$WORD
	uxth	r1,r0
	mov	r0,r13
	add	r0,#38
	strh	r1,[r0]
# [460] TCP_Header.checksum := 0;
	mov	r0,#0
	add	r1,r13,#40
	strh	r0,[r1]
# [461] TCP_Header.urgent_ptr := 0;
	mov	r1,#0
	mov	r0,r13
	add	r0,#42
	strh	r1,[r0]
# [463] len := len + sizeof(TCP_Header);
	add	r0,r13,#88
	ldrh	r0,[r0]
	add	r0,#20
	uxth	r0,r0
	add	r1,r13,#88
	strh	r0,[r1]
# [464] len := len + sizeof(IP_Header);
	add	r0,r13,#88
	ldrh	r0,[r0]
	add	r0,#20
	uxth	r0,r0
	add	r1,r13,#88
	strh	r0,[r1]
# [466] IP_Header.total_len := ByteSwap16(len);
	add	r0,r13,#88
	ldrh	r0,[r0]
	bl	ETHERNET_$$_BYTESWAP16$WORD$$WORD
	uxth	r1,r0
	mov	r0,r13
	add	r0,#46
	strh	r1,[r0]
# [468] checksum := calc_checksum(@IP_Header, 10, 0);
	add	r0,r13,#44
	mov	r2,#0
	mov	r1,#10
	bl	ETHERNET_IP_$$_CALC_CHECKSUM$PWORD$WORD$WORD$$WORD
	uxth	r0,r0
	add	r1,r13,#68
	strh	r0,[r1]
# [469] checksum := NOT checksum;
	add	r0,r13,#68
	ldrh	r0,[r0]
	mvn	r0,r0
	add	r1,r13,#68
	strh	r0,[r1]
# [470] IP_Header.checksum := checksum;
	add	r0,r13,#68
	ldrh	r1,[r0]
	mov	r0,r13
	add	r0,#54
	strh	r1,[r0]
# [472] len := datalen + sizeof(TCP_Header);
	add	r0,r13,#80
	ldrh	r0,[r0]
	add	r0,#20
	uxth	r1,r0
	add	r0,r13,#88
	strh	r1,[r0]
# [474] checksum_psdh := calc_psdh(IP_Header.src, IP_Header.dst, len, 0);
	ldr	r4,[r13, #60]
	ldr	r1,[r13, #56]
	mov	r3,#0
	add	r0,r13,#88
	ldrh	r2,[r0]
	mov	r0,r1
	mov	r1,r4
	bl	ETHERNET_IP_TCP_$$_CALC_PSDH$LONGWORD$LONGWORD$WORD$WORD$$WORD
	uxth	r0,r0
	add	r1,r13,#72
	strh	r0,[r1]
# [475] if (((datalen AND $01) = 1) AND (datalen > 0)) then begin
	add	r0,r13,#80
	ldrh	r0,[r0]
	mov	r1,#1
	and	r0,r1
	cmp	r0,#1
	bne	.Lj211
	bl	.Lj209
.Lj211:
	bl	.Lj210
.Lj209:
	add	r0,r13,#80
	ldrh	r0,[r0]
	cmp	r0,#0
	bls	.Lj213
	bl	.Lj212
.Lj213:
	bl	.Lj210
.Lj212:
# [476] snd_buf[datalen] := 0;
	ldr	r2,[r13]
	add	r0,r13,#80
	ldrh	r1,[r0]
	mov	r0,#0
	strb	r0,[r2, r1]
# [477] Inc(datalen);
	add	r0,r13,#80
	ldrh	r0,[r0]
	add	r0,#1
	uxth	r0,r0
	add	r1,r13,#80
	strh	r0,[r1]
.Lj210:
# [480] tcb^.snd_nxt := tcb^.snd_nxt + datalen;
	ldr	r1,[r13, #4]
	add	r0,r13,#80
	ldrh	r2,[r0]
	ldr	r0,[r1, #16]
	mov	r1,r2
	add	r1,r0
	ldr	r0,[r13, #4]
	str	r1,[r0, #16]
# [481] if(tcb^.tcb_flags AND FLAG_SYN) = FLAG_SYN then
	ldr	r0,[r13, #4]
# [498] end;
	b	.Lj221
	.balign 4
.Lj192:
	.long	1460
.Lj196:
	.long	2048
.Lj200:
	.long	TC_$ETHERNET_$$_MACADDR
.Lj202:
	.long	TC_$ETHERNET_IP_$$_PACKAGE_ID
.Lj204:
	.long	TC_$ETHERNET_$$_IP
.Lj221:
	add	r0,#55
	ldrb	r0,[r0]
	mov	r1,#2
	and	r0,r1
	cmp	r0,#2
	bne	.Lj216
	bl	.Lj214
.Lj216:
	bl	.Lj215
.Lj214:
# [482] Inc(tcb^.snd_nxt);
	ldr	r1,[r13, #4]
	ldr	r0,[r1, #16]
	add	r0,#1
	str	r0,[r1, #16]
.Lj215:
# [484] checksum_data := calc_checksum(PWord(snd_buf), datalen>>1, checksum_psdh);
	add	r0,r13,#80
	ldrh	r0,[r0]
	lsr	r0,r0,#1
	uxth	r0,r0
	uxth	r1,r0
	add	r0,r13,#72
	ldrh	r2,[r0]
	ldr	r0,[r13]
	bl	ETHERNET_IP_$$_CALC_CHECKSUM$PWORD$WORD$WORD$$WORD
	uxth	r1,r0
	add	r0,r13,#76
	strh	r1,[r0]
# [485] checksum := calc_checksum(@TCP_Header, sizeof(TCP_Header)>>1, checksum_data);
	add	r0,r13,#24
	add	r1,r13,#76
	ldrh	r2,[r1]
	mov	r1,#10
	bl	ETHERNET_IP_$$_CALC_CHECKSUM$PWORD$WORD$WORD$$WORD
	uxth	r1,r0
	add	r0,r13,#68
	strh	r1,[r0]
# [486] checksum := NOT checksum;
	add	r0,r13,#68
	ldrh	r0,[r0]
	mvn	r0,r0
	add	r1,r13,#68
	strh	r0,[r1]
# [487] TCP_Header.checksum := checksum;
	add	r0,r13,#68
	ldrh	r0,[r0]
	add	r1,r13,#40
	strh	r0,[r1]
# [489] FillByte(snd_buf[0], BUFFER_SIZE, 0);
	ldr	r1,.Lj217
	ldr	r0,[r13]
	mov	r2,#0
	bl	SYSTEM_$$_FILLBYTE$formal$LONGINT$BYTE
# [491] move(ETH_Header, snd_buf[0], sizeof(ETH_Header));
	ldr	r1,[r13]
	add	r0,r13,#8
	mov	r2,#14
	bl	SYSTEM_$$_MOVE$formal$formal$LONGINT
# [492] move(IP_Header, snd_buf[sizeof(ETH_Header)], sizeof(IP_Header));
	ldr	r1,[r13]
	add	r1,#14
	add	r0,r13,#44
	mov	r2,#20
	bl	SYSTEM_$$_MOVE$formal$formal$LONGINT
# [493] move(TCP_Header, snd_buf[sizeof(ETH_Header)+sizeof(IP_Header)], sizeof(TCP_Header));
	ldr	r1,[r13]
	add	r1,#34
	add	r0,r13,#24
	mov	r2,#20
	bl	SYSTEM_$$_MOVE$formal$formal$LONGINT
# [494] if(datalen > 0) then
	add	r0,r13,#80
	ldrh	r0,[r0]
	cmp	r0,#0
	bls	.Lj220
	bl	.Lj218
.Lj220:
	bl	.Lj219
.Lj218:
# [495] move(tcb^.snd_data[0], snd_buf[sizeof(ETH_Header)+sizeof(IP_Header)+sizeof(TCP_Header)], olddatalen);
	ldr	r0,[r13, #4]
	ldr	r0,[r0, #60]
	add	r1,r13,#84
	ldrh	r2,[r1]
	ldr	r1,[r13]
	add	r1,#54
	bl	SYSTEM_$$_MOVE$formal$formal$LONGINT
.Lj219:
# [497] enc28j60PacketSend(sizeof(ETH_Header)+sizeof(IP_Header)+sizeof(TCP_Header)+datalen, snd_buf );
	add	r0,r13,#80
	ldrh	r0,[r0]
	add	r0,#54
	uxth	r0,r0
	uxth	r0,r0
	ldr	r1,[r13]
	bl	ENC28J60_$$_ENC28J60PACKETSEND$WORD$PBYTE
	add	r13,r13,#112
	pop	{r4,r15}
.Lc17:
	.balign 4
.Lj217:
	.long	1460
.Le8:
	.size	ETHERNET_IP_TCP_$$_ETH_PROTOCOL_IP_TCP_SEND$PBYTE$PTCB, .Le8 - ETHERNET_IP_TCP_$$_ETH_PROTOCOL_IP_TCP_SEND$PBYTE$PTCB
# End asmlist al_procedures
# Begin asmlist al_globals

.section .bss.n_u_$ethernet_ip_tcp_$$_tcb_array,"aw",%nobits
	.balign 4
# [70] tcb_array : array[0..TCB_LENGTH] of TTCB;
	.globl U_$ETHERNET_IP_TCP_$$_TCB_ARRAY
	.size U_$ETHERNET_IP_TCP_$$_TCB_ARRAY,304
U_$ETHERNET_IP_TCP_$$_TCB_ARRAY:
	.zero 304
# End asmlist al_globals
# Begin asmlist al_typedconsts

.section .rodata.n_TC_$ETHERNET_IP_TCP$_$ETH_PROTOCOL_IP_TCP$PBYTE$PBYTE$WORD_$$_defaultsocket
	.balign 4
TC_$ETHERNET_IP_TCP$_$ETH_PROTOCOL_IP_TCP$PBYTE$PBYTE$WORD_$$_defaultsocket:
	.long	0
# [241] i : byte;
.Le9:
	.size	TC_$ETHERNET_IP_TCP$_$ETH_PROTOCOL_IP_TCP$PBYTE$PBYTE$WORD_$$_defaultsocket, .Le9 - TC_$ETHERNET_IP_TCP$_$ETH_PROTOCOL_IP_TCP$PBYTE$PBYTE$WORD_$$_defaultsocket
# End asmlist al_typedconsts
# Begin asmlist al_rtti

.section .rodata.n_INIT_$ETHERNET_IP_TCP_$$_TTCP_HDR
	.balign 4
.globl	INIT_$ETHERNET_IP_TCP_$$_TTCP_HDR
INIT_$ETHERNET_IP_TCP_$$_TTCP_HDR:
	.byte	13,8
# [501] 
	.ascii	"TTCP_HDR"
	.byte	0,0
	.long	0,0,20,0,0,0
.Le10:
	.size	INIT_$ETHERNET_IP_TCP_$$_TTCP_HDR, .Le10 - INIT_$ETHERNET_IP_TCP_$$_TTCP_HDR

.section .rodata.n_RTTI_$ETHERNET_IP_TCP_$$_TTCP_HDR
	.balign 4
.globl	RTTI_$ETHERNET_IP_TCP_$$_TTCP_HDR
RTTI_$ETHERNET_IP_TCP_$$_TTCP_HDR:
	.byte	13,8
	.ascii	"TTCP_HDR"
	.byte	0,0
	.long	0
	.long	INIT_$ETHERNET_IP_TCP_$$_TTCP_HDR
	.long	20,9
	.long	RTTI_$SYSTEM_$$_WORD$indirect
	.long	0
	.long	RTTI_$SYSTEM_$$_WORD$indirect
	.long	2
	.long	RTTI_$SYSTEM_$$_LONGWORD$indirect
	.long	4
	.long	RTTI_$SYSTEM_$$_LONGWORD$indirect
	.long	8
	.long	RTTI_$SYSTEM_$$_BYTE$indirect
	.long	12
	.long	RTTI_$SYSTEM_$$_BYTE$indirect
	.long	13
	.long	RTTI_$SYSTEM_$$_WORD$indirect
	.long	14
	.long	RTTI_$SYSTEM_$$_WORD$indirect
	.long	16
	.long	RTTI_$SYSTEM_$$_WORD$indirect
	.long	18
.Le11:
	.size	RTTI_$ETHERNET_IP_TCP_$$_TTCP_HDR, .Le11 - RTTI_$ETHERNET_IP_TCP_$$_TTCP_HDR

.section .rodata.n_RTTI_$ETHERNET_IP_TCP_$$_PTCP_HDR
	.balign 4
.globl	RTTI_$ETHERNET_IP_TCP_$$_PTCP_HDR
RTTI_$ETHERNET_IP_TCP_$$_PTCP_HDR:
	.byte	29,8
	.ascii	"PTCP_HDR"
	.byte	0,0
	.long	0
	.long	RTTI_$ETHERNET_IP_TCP_$$_TTCP_HDR$indirect
.Le12:
	.size	RTTI_$ETHERNET_IP_TCP_$$_PTCP_HDR, .Le12 - RTTI_$ETHERNET_IP_TCP_$$_PTCP_HDR

.section .rodata.n_INIT_$ETHERNET_IP_TCP_$$_TTCB
	.balign 4
.globl	INIT_$ETHERNET_IP_TCP_$$_TTCB
INIT_$ETHERNET_IP_TCP_$$_TTCB:
	.byte	13,4
	.ascii	"TTCB"
	.byte	0,0
	.long	0,0,76,0,0,0
.Le13:
	.size	INIT_$ETHERNET_IP_TCP_$$_TTCB, .Le13 - INIT_$ETHERNET_IP_TCP_$$_TTCB

.section .rodata.n_RTTI_$ETHERNET_IP_TCP_$$_def00000004
	.balign 4
.globl	RTTI_$ETHERNET_IP_TCP_$$_def00000004
RTTI_$ETHERNET_IP_TCP_$$_def00000004:
	.byte	12,0,0,0
	.long	0,6,6
	.long	RTTI_$SYSTEM_$$_BYTE$indirect
	.byte	1,0,0,0
	.long	RTTI_$SYSTEM_$$_SHORTINT$indirect
.Le14:
	.size	RTTI_$ETHERNET_IP_TCP_$$_def00000004, .Le14 - RTTI_$ETHERNET_IP_TCP_$$_def00000004

.section .rodata.n_RTTI_$ETHERNET_IP_TCP_$$_TTCB
	.balign 4
.globl	RTTI_$ETHERNET_IP_TCP_$$_TTCB
RTTI_$ETHERNET_IP_TCP_$$_TTCB:
	.byte	13,4
	.ascii	"TTCB"
	.byte	0,0
	.long	0
	.long	INIT_$ETHERNET_IP_TCP_$$_TTCB
	.long	76,22
	.long	RTTI_$SYSTEM_$$_LONGWORD$indirect
	.long	0
	.long	RTTI_$SYSTEM_$$_LONGWORD$indirect
	.long	4
	.long	RTTI_$SYSTEM_$$_WORD$indirect
	.long	8
	.long	RTTI_$SYSTEM_$$_WORD$indirect
	.long	10
	.long	RTTI_$SYSTEM_$$_LONGWORD$indirect
	.long	12
	.long	RTTI_$SYSTEM_$$_LONGWORD$indirect
	.long	16
	.long	RTTI_$SYSTEM_$$_LONGWORD$indirect
	.long	20
	.long	RTTI_$SYSTEM_$$_LONGWORD$indirect
	.long	24
	.long	RTTI_$SYSTEM_$$_LONGWORD$indirect
	.long	28
	.long	RTTI_$SYSTEM_$$_LONGWORD$indirect
	.long	32
	.long	RTTI_$SYSTEM_$$_LONGWORD$indirect
	.long	36
	.long	RTTI_$ETHERNET_$$_TFSM_STATES$indirect
	.long	40
	.long	RTTI_$SYSTEM_$$_LONGWORD$indirect
	.long	44
	.long	RTTI_$SYSTEM_$$_BYTE$indirect
	.long	48
	.long	RTTI_$ETHERNET_IP_TCP_$$_def00000004$indirect
	.long	49
	.long	RTTI_$SYSTEM_$$_BYTE$indirect
	.long	55
	.long	RTTI_$SYSTEM_$$_BYTE$indirect
	.long	56
	.long	RTTI_$SYSTEM_$$_BYTE$indirect
	.long	57
	.long	RTTI_$SYSTEM_$$_PBYTE$indirect
	.long	60
	.long	RTTI_$SYSTEM_$$_WORD$indirect
	.long	64
	.long	RTTI_$SYSTEM_$$_PBYTE$indirect
	.long	68
	.long	RTTI_$SYSTEM_$$_WORD$indirect
	.long	72
.Le15:
	.size	RTTI_$ETHERNET_IP_TCP_$$_TTCB, .Le15 - RTTI_$ETHERNET_IP_TCP_$$_TTCB

.section .rodata.n_RTTI_$ETHERNET_IP_TCP_$$_PTCB
	.balign 4
.globl	RTTI_$ETHERNET_IP_TCP_$$_PTCB
RTTI_$ETHERNET_IP_TCP_$$_PTCB:
	.byte	29,4
	.ascii	"PTCB"
	.byte	0,0
	.long	0
	.long	RTTI_$ETHERNET_IP_TCP_$$_TTCB$indirect
.Le16:
	.size	RTTI_$ETHERNET_IP_TCP_$$_PTCB, .Le16 - RTTI_$ETHERNET_IP_TCP_$$_PTCB
# End asmlist al_rtti
# Begin asmlist al_indirectglobals

.section .rodata.n_INIT_$ETHERNET_IP_TCP_$$_TTCP_HDR
	.balign 4
.globl	INIT_$ETHERNET_IP_TCP_$$_TTCP_HDR$indirect
INIT_$ETHERNET_IP_TCP_$$_TTCP_HDR$indirect:
	.long	INIT_$ETHERNET_IP_TCP_$$_TTCP_HDR
.Le17:
	.size	INIT_$ETHERNET_IP_TCP_$$_TTCP_HDR$indirect, .Le17 - INIT_$ETHERNET_IP_TCP_$$_TTCP_HDR$indirect

.section .rodata.n_RTTI_$ETHERNET_IP_TCP_$$_TTCP_HDR
	.balign 4
.globl	RTTI_$ETHERNET_IP_TCP_$$_TTCP_HDR$indirect
RTTI_$ETHERNET_IP_TCP_$$_TTCP_HDR$indirect:
	.long	RTTI_$ETHERNET_IP_TCP_$$_TTCP_HDR
.Le18:
	.size	RTTI_$ETHERNET_IP_TCP_$$_TTCP_HDR$indirect, .Le18 - RTTI_$ETHERNET_IP_TCP_$$_TTCP_HDR$indirect

.section .rodata.n_RTTI_$ETHERNET_IP_TCP_$$_PTCP_HDR
	.balign 4
.globl	RTTI_$ETHERNET_IP_TCP_$$_PTCP_HDR$indirect
RTTI_$ETHERNET_IP_TCP_$$_PTCP_HDR$indirect:
	.long	RTTI_$ETHERNET_IP_TCP_$$_PTCP_HDR
.Le19:
	.size	RTTI_$ETHERNET_IP_TCP_$$_PTCP_HDR$indirect, .Le19 - RTTI_$ETHERNET_IP_TCP_$$_PTCP_HDR$indirect

.section .rodata.n_INIT_$ETHERNET_IP_TCP_$$_TTCB
	.balign 4
.globl	INIT_$ETHERNET_IP_TCP_$$_TTCB$indirect
INIT_$ETHERNET_IP_TCP_$$_TTCB$indirect:
	.long	INIT_$ETHERNET_IP_TCP_$$_TTCB
.Le20:
	.size	INIT_$ETHERNET_IP_TCP_$$_TTCB$indirect, .Le20 - INIT_$ETHERNET_IP_TCP_$$_TTCB$indirect

.section .rodata.n_RTTI_$ETHERNET_IP_TCP_$$_def00000004
	.balign 4
.globl	RTTI_$ETHERNET_IP_TCP_$$_def00000004$indirect
RTTI_$ETHERNET_IP_TCP_$$_def00000004$indirect:
	.long	RTTI_$ETHERNET_IP_TCP_$$_def00000004
.Le21:
	.size	RTTI_$ETHERNET_IP_TCP_$$_def00000004$indirect, .Le21 - RTTI_$ETHERNET_IP_TCP_$$_def00000004$indirect

.section .rodata.n_RTTI_$ETHERNET_IP_TCP_$$_TTCB
	.balign 4
.globl	RTTI_$ETHERNET_IP_TCP_$$_TTCB$indirect
RTTI_$ETHERNET_IP_TCP_$$_TTCB$indirect:
	.long	RTTI_$ETHERNET_IP_TCP_$$_TTCB
.Le22:
	.size	RTTI_$ETHERNET_IP_TCP_$$_TTCB$indirect, .Le22 - RTTI_$ETHERNET_IP_TCP_$$_TTCB$indirect

.section .rodata.n_RTTI_$ETHERNET_IP_TCP_$$_PTCB
	.balign 4
.globl	RTTI_$ETHERNET_IP_TCP_$$_PTCB$indirect
RTTI_$ETHERNET_IP_TCP_$$_PTCB$indirect:
	.long	RTTI_$ETHERNET_IP_TCP_$$_PTCB
.Le23:
	.size	RTTI_$ETHERNET_IP_TCP_$$_PTCB$indirect, .Le23 - RTTI_$ETHERNET_IP_TCP_$$_PTCB$indirect
# End asmlist al_indirectglobals
# Begin asmlist al_dwarf_frame

.section .debug_frame
.Lc19:
	.long	.Lc21-.Lc20
.Lc20:
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
.Lc21:
	.long	.Lc23-.Lc22
.Lc22:
	.long	.Lc19
	.long	.Lc2
	.long	.Lc1-.Lc2
	.balign 4,0
.Lc23:
	.long	.Lc26-.Lc25
.Lc25:
	.long	.Lc19
	.long	.Lc4
	.long	.Lc3-.Lc4
	.balign 4,0
.Lc26:
	.long	.Lc29-.Lc28
.Lc28:
	.long	.Lc19
	.long	.Lc6
	.long	.Lc5-.Lc6
	.balign 4,0
.Lc29:
	.long	.Lc32-.Lc31
.Lc31:
	.long	.Lc19
	.long	.Lc8
	.long	.Lc7-.Lc8
	.balign 4,0
.Lc32:
	.long	.Lc35-.Lc34
.Lc34:
	.long	.Lc19
	.long	.Lc10
	.long	.Lc9-.Lc10
	.balign 4,0
.Lc35:
	.long	.Lc38-.Lc37
.Lc37:
	.long	.Lc19
	.long	.Lc12
	.long	.Lc11-.Lc12
	.balign 4,0
.Lc38:
	.long	.Lc41-.Lc40
.Lc40:
	.long	.Lc19
	.long	.Lc14
	.long	.Lc13-.Lc14
	.balign 4,0
.Lc41:
	.long	.Lc44-.Lc43
.Lc43:
	.long	.Lc19
	.long	.Lc16
	.long	.Lc15-.Lc16
	.balign 4,0
.Lc44:
	.long	.Lc47-.Lc46
.Lc46:
	.long	.Lc19
	.long	.Lc18
	.long	.Lc17-.Lc18
	.balign 4,0
.Lc47:
# End asmlist al_dwarf_frame

