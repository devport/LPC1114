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
# Var $result located in register r0
# Var i located in register r0
# Var j located in register r0
# Var j located in register r0
# [87] j := 1;
	mov	r0,#1
# Var i located in register r3
# [88] for i:=0 to TCB_LENGTH do begin
	ldr	r3,.Lj5
.Lj6:
	mov	r1,r3
	add	r1,#1
	mov	r3,r1
# [89] if(tcb_array[i].src_ip <> 0 ) then inc(j);
	mov	r2,r3
	mov	r1,#76
	mul	r2,r1
	ldr	r1,.Lj9
	ldr	r1,[r2, r1]
	cmp	r1,#0
	beq	.Lj12
	bl	.Lj10
.Lj12:
	bl	.Lj11
.Lj10:
	add	r0,#1
.Lj11:
	cmp	r3,#3
	bcc	.Lj13
	bl	.Lj8
.Lj13:
	bl	.Lj6
.Lj8:
# [91] Result := j-1;
	sub	r0,#1
# Var $result located in register r0
# [92] end;
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
# Var i located in register r0
# Var i located in register r3
# [98] for i:=0 to TCB_LENGTH do begin
	mov	r3,#255
.Lj16:
	mov	r0,r3
	add	r0,#1
	uxtb	r3,r0
# Peephole UxtbMov2Data removed superfluous mov
# [99] tcb_array[i].state := CLOSED;
	uxtb	r2,r3
# Peephole UxtbMov2Data removed superfluous mov
	mov	r0,#76
	mul	r2,r0
	mov	r0,#0
	ldr	r1,.Lj19
	str	r0,[r2, r1]
# [100] tcb_array[i].src_port := 0;
	uxtb	r2,r3
# Peephole UxtbMov2Data removed superfluous mov
	mov	r0,#76
	mul	r2,r0
	mov	r0,#0
	ldr	r1,.Lj20
	strh	r0,[r2, r1]
# [101] tcb_array[i].src_ip := 0;
	uxtb	r2,r3
# Peephole UxtbMov2Data removed superfluous mov
	mov	r0,#76
	mul	r2,r0
	mov	r0,#0
	ldr	r1,.Lj21
	str	r0,[r2, r1]
# [102] tcb_array[i].dst_ip := 0;
	uxtb	r2,r3
# Peephole UxtbMov2Data removed superfluous mov
	mov	r0,#76
	mul	r2,r0
	mov	r0,#0
	ldr	r1,.Lj22
	str	r0,[r2, r1]
# [103] tcb_array[i].dst_port := 0;
	uxtb	r2,r3
# Peephole UxtbMov2Data removed superfluous mov
	mov	r0,#76
	mul	r2,r0
	mov	r0,#0
	ldr	r1,.Lj23
	strh	r0,[r2, r1]
# [104] tcb_array[i].id := i;
	uxtb	r1,r3
	mov	r0,#76
	mul	r1,r0
	ldr	r0,.Lj24
	add	r0,r1
	strb	r3,[r0]
# [105] tcb_array[i].seg := 0;
	uxtb	r2,r3
	mov	r0,#76
	mul	r2,r0
	mov	r1,#0
	ldr	r0,.Lj25
	add	r0,r2
	strb	r1,[r0]
# [106] tcb_array[i].rcv_nxt := 0;
	uxtb	r2,r3
# Peephole UxtbMov2Data removed superfluous mov
	mov	r0,#76
	mul	r2,r0
	mov	r1,#0
	ldr	r0,.Lj26
	str	r1,[r2, r0]
# [107] tcb_array[i].snd_nxt := 0;
	uxtb	r2,r3
# Peephole UxtbMov2Data removed superfluous mov
	mov	r0,#76
	mul	r2,r0
	mov	r1,#0
	ldr	r0,.Lj27
	str	r1,[r2, r0]
# [108] tcb_array[i].tcb_flags := FLAG_NUL;
	uxtb	r2,r3
	mov	r0,#76
	mul	r2,r0
	mov	r1,#0
	ldr	r0,.Lj28
	add	r0,r2
	strb	r1,[r0]
# [109] tcb_array[i].snd_data := nil;
	uxtb	r2,r3
# Peephole UxtbMov2Data removed superfluous mov
	mov	r0,#76
	mul	r2,r0
	mov	r0,#0
	ldr	r1,.Lj29
	str	r0,[r2, r1]
# [110] tcb_array[i].snd_datalen := 0;
	uxtb	r2,r3
	mov	r0,#76
	mul	r2,r0
	mov	r1,#0
	ldr	r0,.Lj30
	add	r0,r2
	strh	r1,[r0]
# [111] tcb_array[i].rcv_data := nil;
	uxtb	r2,r3
# Peephole UxtbMov2Data removed superfluous mov
	mov	r0,#76
	mul	r2,r0
	mov	r0,#0
	ldr	r1,.Lj31
	str	r0,[r2, r1]
# [112] tcb_array[i].rcv_datalen := 0;
	uxtb	r2,r3
	mov	r0,#76
	mul	r2,r0
	mov	r1,#0
	ldr	r0,.Lj32
	add	r0,r2
	strh	r1,[r0]
	cmp	r3,#3
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
	push	{r4,r5,r14}
	sub	r13,r13,#48
# Var $result located in register r0
# Var i located in register r0
	mov	r5,r0
# Var socket located in register r5
# Var $result located in register r4
# [120] Result := nil;
	mov	r4,#0
# Var i located in register r3
# [121] for i:=0 to TCB_LENGTH do
	mov	r3,#255
.Lj36:
	mov	r0,r3
	add	r0,#1
	uxtb	r3,r0
# Peephole UxtbMov2Data removed superfluous mov
# [123] if (tcb_array[i].src_ip = 0) AND (tcb_array[i].src_port = 0) AND (tcb_array[i].state = CLOSED) then
	uxtb	r1,r3
	mov	r0,#76
	mul	r1,r0
	ldr	r0,.Lj39
	add	r0,r1
	mov	r1,r0
	ldr	r0,[r1]
	cmp	r0,#0
	bne	.Lj42
	bl	.Lj40
.Lj42:
	bl	.Lj41
.Lj40:
	ldrh	r0,[r1, #8]
	cmp	r0,#0
	bne	.Lj44
	bl	.Lj43
.Lj44:
	bl	.Lj41
.Lj43:
	ldr	r0,[r1, #40]
	cmp	r0,#0
	bne	.Lj46
	bl	.Lj45
.Lj46:
	bl	.Lj41
.Lj45:
# [125] tcb_array[i].state := socket^.fsm_state;
	uxtb	r2,r3
# Peephole UxtbMov2Data removed superfluous mov
	mov	r0,#76
	mul	r2,r0
	ldr	r0,[r5, #4]
	ldr	r1,.Lj47
	str	r0,[r2, r1]
# [126] tcb_array[i].dst_port := socket^.sck_port;
	uxtb	r2,r3
# Peephole UxtbMov2Data removed superfluous mov
	mov	r0,#76
	mul	r2,r0
	ldrh	r0,[r5, #2]
	ldr	r1,.Lj48
	strh	r0,[r2, r1]
# [127] tcb_array[i].src_port := 0;
	uxtb	r2,r3
# Peephole UxtbMov2Data removed superfluous mov
	mov	r0,#76
	mul	r2,r0
	mov	r0,#0
	ldr	r1,.Lj49
	strh	r0,[r2, r1]
# [128] tcb_array[i].src_ip := 0;
	uxtb	r2,r3
# Peephole UxtbMov2Data removed superfluous mov
	mov	r0,#76
	mul	r2,r0
	mov	r0,#0
	ldr	r1,.Lj39
	str	r0,[r2, r1]
# [129] tcb_array[i].rcv_nxt := 0;
	uxtb	r2,r3
# Peephole UxtbMov2Data removed superfluous mov
	mov	r0,#76
	mul	r2,r0
	mov	r1,#0
	ldr	r0,.Lj51
	str	r1,[r2, r0]
# [130] tcb_array[i].snd_nxt := 0;
	uxtb	r2,r3
# Peephole UxtbMov2Data removed superfluous mov
	mov	r0,#76
	mul	r2,r0
	mov	r1,#0
	ldr	r0,.Lj52
	str	r1,[r2, r0]
# [131] tcb_array[i].seg := 0;
	uxtb	r2,r3
	mov	r0,#76
	mul	r2,r0
	mov	r1,#0
	ldr	r0,.Lj53
	add	r0,r2
	strb	r1,[r0]
# [132] tcb_array[i].tcb_flags := FLAG_NUL;
	uxtb	r2,r3
	mov	r0,#76
	mul	r2,r0
	mov	r1,#0
	ldr	r0,.Lj54
	add	r0,r2
	strb	r1,[r0]
# [133] tcb_array[i].snd_data := nil;
	uxtb	r2,r3
# Peephole UxtbMov2Data removed superfluous mov
	mov	r0,#76
	mul	r2,r0
	mov	r1,#0
	ldr	r0,.Lj55
	str	r1,[r2, r0]
# [134] tcb_array[i].snd_datalen := 0;
	uxtb	r2,r3
	mov	r0,#76
	mul	r2,r0
	mov	r1,#0
	ldr	r0,.Lj56
	add	r0,r2
	strh	r1,[r0]
# [135] Result := @tcb_array[i];
	uxtb	r1,r3
	mov	r0,#76
	mul	r1,r0
	ldr	r0,.Lj39
	add	r0,r1
	mov	r4,r0
# [139] Exit;
	bl	.Lj34
.Lj41:
	cmp	r3,#3
	bcc	.Lj58
	bl	.Lj38
.Lj58:
	bl	.Lj36
.Lj38:
.Lj34:
# [142] end;
	mov	r0,r4
	add	r13,r13,#48
	pop	{r4,r5,r15}
.Lc5:
	.balign 4
.Lj39:
	.long	U_$ETHERNET_IP_TCP_$$_TCB_ARRAY
.Lj47:
	.long	U_$ETHERNET_IP_TCP_$$_TCB_ARRAY+40
.Lj48:
	.long	U_$ETHERNET_IP_TCP_$$_TCB_ARRAY+10
.Lj49:
	.long	U_$ETHERNET_IP_TCP_$$_TCB_ARRAY+8
.Lj51:
	.long	U_$ETHERNET_IP_TCP_$$_TCB_ARRAY+24
.Lj52:
	.long	U_$ETHERNET_IP_TCP_$$_TCB_ARRAY+16
.Lj53:
	.long	U_$ETHERNET_IP_TCP_$$_TCB_ARRAY+57
.Lj54:
	.long	U_$ETHERNET_IP_TCP_$$_TCB_ARRAY+55
.Lj55:
	.long	U_$ETHERNET_IP_TCP_$$_TCB_ARRAY+60
.Lj56:
	.long	U_$ETHERNET_IP_TCP_$$_TCB_ARRAY+64
.Le2:
	.size	ETHERNET_IP_TCP_$$_TCB_GETTCB$PSOCKET$$PTCB, .Le2 - ETHERNET_IP_TCP_$$_TCB_GETTCB$PSOCKET$$PTCB

.section .text.n_ethernet_ip_tcp_$$_tcb_checktcb$longword$word$$ptcb,"ax"
	.balign 4
.thumb_func 
ETHERNET_IP_TCP_$$_TCB_CHECKTCB$LONGWORD$WORD$$PTCB:
.Lc8:
# [147] begin
	push	{r4,r5,r14}
	sub	r13,r13,#48
# Var $result located in register r0
# Var i located in register r0
	mov	r5,r0
# Var ip located in register r5
	uxth	r3,r1
# Var port located in register r3
# Var $result located in register r4
# [148] Result := nil;
	mov	r4,#0
# Var i located in register r2
# [149] for i:=0 to TCB_LENGTH do
	mov	r2,#255
.Lj61:
	mov	r0,r2
	add	r0,#1
	uxtb	r2,r0
# Peephole UxtbMov2Data removed superfluous mov
# [153] if (tcb_array[i].src_ip = ip) AND (tcb_array[i].src_port = port) then
	uxtb	r1,r2
	mov	r0,#76
	mul	r1,r0
	ldr	r0,.Lj64
	add	r0,r1
	ldr	r1,[r0]
	cmp	r1,r5
	bne	.Lj67
	bl	.Lj65
.Lj67:
	bl	.Lj66
.Lj65:
	ldrh	r0,[r0, #8]
	cmp	r0,r3
	bne	.Lj69
	bl	.Lj68
.Lj69:
	bl	.Lj66
.Lj68:
# [155] Result := @tcb_array[i];
	uxtb	r1,r2
	mov	r0,#76
	mul	r1,r0
	ldr	r0,.Lj64
	add	r0,r1
	mov	r4,r0
# [156] Exit;
	bl	.Lj59
.Lj66:
	cmp	r2,#3
	bcc	.Lj71
	bl	.Lj63
.Lj71:
	bl	.Lj61
.Lj63:
.Lj59:
# [159] end;
	mov	r0,r4
	add	r13,r13,#48
	pop	{r4,r5,r15}
.Lc7:
	.balign 4
.Lj64:
	.long	U_$ETHERNET_IP_TCP_$$_TCB_ARRAY
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
# Var tcb located in register r0
# Var tcb located in register r0
# [163] tcb^.state := CLOSED;
	mov	r1,#0
	str	r1,[r0, #40]
# Var tcb located in register r0
# Peephole MovStrMov done
# [164] tcb^.src_ip := 0;
	str	r1,[r0]
# Var tcb located in register r0
# Peephole MovStrMov done
# [165] tcb^.src_port := 0;
	strh	r1,[r0, #8]
# Var tcb located in register r0
# Peephole MovStrMov done
# [166] tcb^.dst_ip := 0;
	str	r1,[r0, #4]
# Var tcb located in register r0
# Peephole MovStrMov done
# [167] tcb^.dst_port := 0;
	strh	r1,[r0, #10]
# Var tcb located in register r0
# Peephole MovStrMov done
# [168] tcb^.rcv_nxt := 0;
	str	r1,[r0, #24]
# [169] tcb^.seg := 0;
	mov	r2,r0
# Var tcb located in register r2
	mov	r1,#0
	mov	r0,r2
	add	r0,#57
	strb	r1,[r0]
# [170] tcb^.snd_nxt := 0;
	mov	r0,r2
# Var tcb located in register r0
	mov	r1,#0
	str	r1,[r0, #16]
# [171] tcb^.rcv_datalen := 0;
	mov	r2,r0
# Var tcb located in register r2
	mov	r1,#0
	mov	r0,r2
	add	r0,#72
	strh	r1,[r0]
# [172] tcb^.rcv_data := nil;
	mov	r0,r2
# Var tcb located in register r0
	mov	r1,#0
	str	r1,[r0, #68]
# Var tcb located in register r0
# Peephole MovStrMov done
# [173] tcb^.snd_data := nil;
	str	r1,[r0, #60]
# [174] tcb^.snd_datalen := 0;
	mov	r2,r0
# Var tcb located in register r2
	mov	r1,#0
	mov	r0,r2
	add	r0,#64
	strh	r1,[r0]
# Var tcb located in register r2
# [175] tcb^.tcb_flags := FLAG_NUL;
	mov	r1,#0
	mov	r0,r2
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
	push	{r4,r5,r14}
	sub	r13,r13,#48
# Var i located in register r0
	mov	r5,r0
# Var buffer located in register r5
# Var i located in register r4
# [182] for i:=0 to TCB_LENGTH do
	mov	r4,#255
.Lj76:
	mov	r0,r4
	add	r0,#1
	uxtb	r4,r0
# Peephole UxtbMov2Data removed superfluous mov
# [184] if(tcb_array[i].snd_datalen > 0) then begin
	uxtb	r1,r4
	mov	r0,#76
	mul	r1,r0
	ldr	r0,.Lj79
	add	r0,r1
	ldrh	r0,[r0]
	cmp	r0,#0
	bls	.Lj82
	bl	.Lj80
.Lj82:
	bl	.Lj81
.Lj80:
# [185] if ((tcb_array[i].tcb_flags AND FLAG_FIN) = 0) then tcb_array[i].tcb_flags := tcb_array[i].tcb_flags OR FLAG_PSH;
	uxtb	r1,r4
	mov	r0,#76
	mul	r1,r0
	ldr	r0,.Lj83
	add	r0,r1
	ldrb	r0,[r0]
	mov	r1,#1
	and	r0,r1
	cmp	r0,#0
	bne	.Lj86
	bl	.Lj84
.Lj86:
	bl	.Lj85
.Lj84:
	ldr	r2,.Lj87
# Peephole LdrMov2Ldr removed superfluous mov
	uxtb	r0,r4
	mov	r1,#76
	mul	r0,r1
	add	r0,r2
	add	r0,#55
	ldrb	r0,[r0]
	mov	r1,#8
	orr	r0,r1
	uxtb	r1,r0
	uxtb	r0,r4
	mov	r3,#76
	mul	r0,r3
	add	r0,r2
	add	r0,#55
	strb	r1,[r0]
.Lj85:
.Lj81:
# [188] if(tcb_array[i].tcb_flags > FLAG_NUL) then
	uxtb	r1,r4
	mov	r0,#76
	mul	r1,r0
	ldr	r0,.Lj83
	add	r0,r1
	ldrb	r0,[r0]
	cmp	r0,#0
	bls	.Lj91
	bl	.Lj89
.Lj91:
	bl	.Lj90
.Lj89:
# [190] ETH_Protocol_IP_TCP_Send(buffer, @tcb_array[i]);
	uxtb	r0,r4
	mov	r1,#76
	mul	r0,r1
	ldr	r1,.Lj87
	add	r1,r0
	mov	r0,r5
	bl	ETHERNET_IP_TCP_$$_ETH_PROTOCOL_IP_TCP_SEND$PBYTE$PTCB
# [191] tcb_array[i].snd_data := nil;
	uxtb	r2,r4
# Peephole UxtbMov2Data removed superfluous mov
	mov	r0,#76
	mul	r2,r0
	mov	r0,#0
	ldr	r1,.Lj93
	str	r0,[r2, r1]
# [192] tcb_array[i].snd_datalen := 0;
	uxtb	r2,r4
	mov	r0,#76
	mul	r2,r0
	mov	r1,#0
	ldr	r0,.Lj79
	add	r0,r2
	strh	r1,[r0]
.Lj90:
# [195] tcb_array[i].tcb_flags := FLAG_NUL;
	uxtb	r2,r4
	mov	r0,#76
	mul	r2,r0
	mov	r1,#0
	ldr	r0,.Lj83
	add	r0,r2
	strb	r1,[r0]
# [197] if(tcb_array[i].state = CLOSING) then begin
	uxtb	r1,r4
# Peephole UxtbMov2Data removed superfluous mov
	mov	r0,#76
	mul	r1,r0
	ldr	r0,.Lj96
	ldr	r0,[r1, r0]
	cmp	r0,#8
	bne	.Lj99
	bl	.Lj97
.Lj99:
	bl	.Lj98
.Lj97:
# [198] TCB_Destroy(@tcb_array[i]);
	uxtb	r1,r4
	mov	r0,#76
	mul	r1,r0
	ldr	r0,.Lj87
	add	r0,r1
	bl	ETHERNET_IP_TCP_$$_TCB_DESTROY$PTCB
.Lj98:
# [201] if(tcb_array[i].state <> CLOSED) AND (tcb_array[i].time > TIMEOUT) then begin
	uxtb	r1,r4
	mov	r0,#76
	mul	r1,r0
	ldr	r0,.Lj87
	add	r0,r1
	ldr	r1,[r0, #40]
	cmp	r1,#0
	beq	.Lj104
	bl	.Lj102
.Lj104:
	bl	.Lj103
.Lj102:
	ldr	r0,[r0, #44]
	ldr	r1,.Lj106
	cmp	r0,r1
	bls	.Lj107
	bl	.Lj105
.Lj107:
	bl	.Lj103
.Lj105:
# [202] tcb_array[i].state := CLOSING;
	uxtb	r2,r4
# Peephole UxtbMov2Data removed superfluous mov
	mov	r0,#76
	mul	r2,r0
	mov	r0,#8
	ldr	r1,.Lj96
	str	r0,[r2, r1]
.Lj103:
	cmp	r4,#3
	bcc	.Lj109
	bl	.Lj78
.Lj109:
	bl	.Lj76
.Lj78:
# [205] end;
	add	r13,r13,#48
	pop	{r4,r5,r15}
.Lc11:
	.balign 4
.Lj79:
	.long	U_$ETHERNET_IP_TCP_$$_TCB_ARRAY+64
.Lj83:
	.long	U_$ETHERNET_IP_TCP_$$_TCB_ARRAY+55
.Lj87:
	.long	U_$ETHERNET_IP_TCP_$$_TCB_ARRAY
.Lj93:
	.long	U_$ETHERNET_IP_TCP_$$_TCB_ARRAY+60
.Lj96:
	.long	U_$ETHERNET_IP_TCP_$$_TCB_ARRAY+40
.Lj106:
	.long	1800
.Le5:
	.size	ETHERNET_IP_TCP_$$_TCB_PROCESS$PBYTE, .Le5 - ETHERNET_IP_TCP_$$_TCB_PROCESS$PBYTE

.section .text.n_ethernet_ip_tcp_$$_calc_psdh$longword$longword$word$word$$word,"ax"
	.balign 4
.thumb_func 
ETHERNET_IP_TCP_$$_CALC_PSDH$LONGWORD$LONGWORD$WORD$WORD$$WORD:
.Lc14:
# [212] begin
	push	{r4,r5,r6,r14}
	sub	r13,r13,#64
# Var $result located in register r0
# Var psdh located at r13+0, size=OS_NO
# Var p located in register r0
# Var src located in register r0
	mov	r4,r1
# Var dst located in register r4
	uxth	r2,r2
# Var datalen located in register r2
	uxth	r3,r3
# Var sum located in register r3
# [213] p := @psdh[0];
	mov	r5,r13
# Var p located in register r5
# Peephole MovMov2Mov removed superfluous mov
# [215] p[3] := (src >> 24) AND $FF;..//* src ip address */
	mov	r1,r0
	lsr	r1,r1,#24
	mov	r6,#255
	and	r1,r6
# Peephole UxtbStrb2Strb done
	strb	r1,[r5, #3]
# [216] p[2] := (src >> 16) AND $FF;
	mov	r1,r0
	lsr	r1,r1,#16
	mov	r6,#255
	and	r1,r6
# Peephole UxtbStrb2Strb done
	strb	r1,[r5, #2]
# [217] p[1] := (src >> 8) AND $FF;
	mov	r1,r0
	lsr	r1,r1,#8
	mov	r6,#255
	and	r1,r6
# Peephole UxtbStrb2Strb done
	strb	r1,[r5, #1]
# [218] p[0] := src AND $FF;
	mov	r1,#255
	and	r0,r1
# Peephole UxtbStrb2Strb done
	strb	r0,[r5]
# [220] p[7] := (dst >> 24) AND $FF;..//* dst ip address */
	mov	r0,r4
	lsr	r0,r0,#24
	mov	r1,#255
	and	r0,r1
# Peephole UxtbStrb2Strb done
	strb	r0,[r5, #7]
# [221] p[6] := (dst >> 16) AND $FF;
	mov	r0,r4
	lsr	r0,r0,#16
	mov	r1,#255
	and	r0,r1
# Peephole UxtbStrb2Strb done
	strb	r0,[r5, #6]
# [222] p[5] := (dst >> 8) AND $FF;
	mov	r0,r4
	lsr	r0,r0,#8
	mov	r1,#255
	and	r0,r1
# Peephole UxtbStrb2Strb done
	strb	r0,[r5, #5]
# [223] p[4] := dst AND $FF;
	mov	r0,r4
	mov	r1,#255
	and	r0,r1
# Peephole UxtbStrb2Strb done
	strb	r0,[r5, #4]
# [225] p[8] := 0;
	mov	r0,#0
	strb	r0,[r5, #8]
# [226] p[9] := $06;...//* protocol */
	mov	r0,#6
	strb	r0,[r5, #9]
# [227] p[10] := datalen>>8;..//* tcp size */
	mov	r0,r2
	lsr	r0,r0,#8
# Peephole UxtbStrb2Strb done
	strb	r0,[r5, #10]
# [228] p[11] := datalen AND $ff;
	mov	r0,r2
	mov	r1,#255
	and	r0,r1
# Peephole UxtbStrb2Strb done
	strb	r0,[r5, #11]
# [230] Result := Calc_Checksum(psdh, 6, sum);
	mov	r0,r13
	mov	r1,r3
# Var sum located in register r1
	uxth	r2,r1
	mov	r1,#6
	bl	ETHERNET_IP_$$_CALC_CHECKSUM$PWORD$WORD$WORD$$WORD
# Peephole UxthUxth2Uxth done
# Var $result located in register r0
# [231] end;
	uxth	r0,r0
	add	r13,r13,#64
	pop	{r4,r5,r6,r15}
.Lc13:
.Le6:
	.size	ETHERNET_IP_TCP_$$_CALC_PSDH$LONGWORD$LONGWORD$WORD$WORD$$WORD, .Le6 - ETHERNET_IP_TCP_$$_CALC_PSDH$LONGWORD$LONGWORD$WORD$WORD$$WORD

.section .text.n_ethernet_ip_tcp_$$_eth_protocol_ip_tcp$pbyte$pbyte$word,"ax"
	.balign 4
.thumb_func 
.globl	ETHERNET_IP_TCP_$$_ETH_PROTOCOL_IP_TCP$PBYTE$PBYTE$WORD
ETHERNET_IP_TCP_$$_ETH_PROTOCOL_IP_TCP$PBYTE$PBYTE$WORD:
.Lc16:
# Temps allocated between r13+0 and r13+16
# [244] begin
	push	{r4,r5,r6,r7,r14}
	sub	r13,r13,#72
# Var TCP_Header located in register r0
# Var IP_Header located in register r0
# Var ETH_Header located in register r4
# Var tcb located in register r0
# Var checksum located in register r0
# Var checksum_size located in register r0
# Var socket located in register r0
# Var i located in register r3
# Var ip_hdr located in register r0
# Var tcp_hdr located in register r1
	uxth	r3,r2
# Var ip_data_len located in register r3
# Var socket located in register r4
# [234] var
	ldr	r2,.Lj114
	ldr	r4,[r2]
# Var socket located in register r2
# [245] socket := nil;
	mov	r2,#0
# Var tcb located in register r0
# [246] tcb := nil;
	ldr	r2,[r13]
	mov	r2,#0
	str	r2,[r13]
# Var IP_Header located in register r5
# [247] IP_Header := PIP_HDR(ip_hdr);
	ldr	r2,[r13, #12]
	mov	r2,r0
	str	r2,[r13, #12]
# Var ip_hdr located in register r0
# Peephole StrLdr2StrMov 2 done
	mov	r5,r2
# Peephole MovMov2Mov removed superfluous mov
# Var TCP_Header located in register r7
# [248] TCP_Header := PTCP_HDR(tcp_hdr);
	mov	r4,r1
# Var tcp_hdr located in register r4
	mov	r7,r4
# Var checksum_size located in register r1
# [250] checksum_size := ip_data_len;
	mov	r6,r3
# Var ip_data_len located in register r6
	mov	r1,r6
# [251] if (checksum_size AND $01) = 1 then begin
	mov	r0,r1
	mov	r2,#1
	and	r0,r2
	cmp	r0,#1
	bne	.Lj117
	bl	.Lj115
.Lj117:
	bl	.Lj116
.Lj115:
# [252] tcp_hdr[checksum_size] := 0;
	mov	r0,#0
	strb	r0,[r4, r1]
# [253] Inc(checksum_size);
	add	r1,#1
	uxth	r1,r1
.Lj116:
# [256] checksum := Calc_Checksum(PWord(tcp_hdr), checksum_size>>1, 0);
	mov	r0,r1
	lsr	r0,r0,#1
# Peephole UxthUxth2Uxth done
	uxth	r1,r0
	mov	r2,#0
	ldr	r0,[r13, #8]
	mov	r0,r4
	str	r0,[r13, #8]
# Var tcp_hdr located in register r0
# Peephole StrLdr2StrMov 2 done
	mov	r0,r0
# Peephole MovMov2Mov removed superfluous mov
	bl	ETHERNET_IP_$$_CALC_CHECKSUM$PWORD$WORD$WORD$$WORD
	uxth	r2,r0
# Var checksum located in register r2
# Peephole UxthMov2Data removed superfluous mov
# [257] checksum := calc_psdh(IP_Header^.src, IP_Header^.dst, ip_data_len, checksum);
	mov	r1,r5
# Var IP_Header located in register r1
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
	ldr	r0,[r13, #4]
	mov	r0,r1
	str	r0,[r13, #4]
# Var IP_Header located in register r0
# Peephole StrLdr2StrMov 1 done
	ldrb	r4,[r0, #12]
	ldr	r0,[r13, #4]
	ldrb	r1,[r0, #13]
	lsl	r1,#8
	orr	r4,r1
	ldr	r0,[r13, #4]
	ldrb	r1,[r0, #14]
	lsl	r1,#16
	orr	r4,r1
	ldr	r0,[r13, #4]
	ldrb	r1,[r0, #15]
	lsl	r1,#24
	orr	r4,r1
	mov	r0,r2
# Var checksum located in register r0
	uxth	r3,r0
	mov	r0,r6
# Var ip_data_len located in register r0
	uxth	r2,r0
	mov	r0,r4
	mov	r1,r5
	bl	ETHERNET_IP_TCP_$$_CALC_PSDH$LONGWORD$LONGWORD$WORD$WORD$$WORD
	uxth	r1,r0
# Var checksum located in register r1
# [258] if(checksum <> $FFFF) then exit;
	ldr	r0,.Lj118
	cmp	r1,r0
	beq	.Lj121
	bl	.Lj119
.Lj121:
	bl	.Lj120
.Lj119:
	bl	.Lj112
.Lj120:
# Var TCP_Header located in register r7
# [261] socket := CheckPort(ByteSwap16(TCP_Header^.dst_port), IPV4_TYPE_TCP);
	ldrb	r1,[r7, #2]
	ldrb	r0,[r7, #3]
	lsl	r0,#8
	orr	r1,r0
	mov	r0,r1
	bl	ETHERNET_$$_BYTESWAP16$WORD$$WORD
# Peephole UxthUxth2Uxth done
	uxth	r0,r0
	mov	r1,#6
	bl	ETHERNET_$$_CHECKPORT$WORD$BYTE$$PSOCKET
# Var socket located in register r5
	mov	r5,r0
# [263] if(socket <> nil) then begin
	cmp	r5,#0
	beq	.Lj124
	bl	.Lj122
.Lj124:
	bl	.Lj123
.Lj122:
# [266] tcb := TCB_CheckTCB(ByteSwap32(IP_Header^.src), ByteSwap16(TCP_Header^.src_port));
	ldrb	r1,[r7]
	ldrb	r0,[r7, #1]
	lsl	r0,#8
	orr	r1,r0
	mov	r0,r1
	bl	ETHERNET_$$_BYTESWAP16$WORD$$WORD
# Peephole UxthUxth2Uxth done
	uxth	r4,r0
	ldr	r0,[r13, #4]
	ldrb	r2,[r0, #12]
	ldr	r0,[r13, #4]
	ldrb	r1,[r0, #13]
	lsl	r1,#8
	orr	r2,r1
	ldr	r0,[r13, #4]
	ldrb	r1,[r0, #14]
	lsl	r1,#16
	orr	r2,r1
	ldr	r0,[r13, #4]
	ldrb	r1,[r0, #15]
	lsl	r1,#24
	orr	r2,r1
	mov	r0,r2
	bl	ETHERNET_$$_BYTESWAP32$LONGWORD$$LONGWORD
	mov	r1,r4
	bl	ETHERNET_IP_TCP_$$_TCB_CHECKTCB$LONGWORD$WORD$$PTCB
	ldr	r1,[r13]
	mov	r1,r0
	str	r1,[r13]
# Peephole StrLdr2StrMov 2 done
# [267] if(tcb = nil) then
	mov	r0,r1
	cmp	r0,#0
	bne	.Lj127
	bl	.Lj125
.Lj127:
	bl	.Lj126
.Lj125:
# [268] tcb := TCB_GetTCB(socket);
	mov	r0,r5
	bl	ETHERNET_IP_TCP_$$_TCB_GETTCB$PSOCKET$$PTCB
	ldr	r1,[r13]
	mov	r1,r0
	str	r1,[r13]
.Lj126:
# [269] if(tcb = nil) then exit;
	ldr	r0,[r13]
	cmp	r0,#0
	bne	.Lj130
	bl	.Lj128
.Lj130:
	bl	.Lj129
.Lj128:
	bl	.Lj112
.Lj129:
# [275] case (tcb^.state) of
	ldr	r0,[r13]
	ldr	r1,[r0, #40]
	cmp	r1,#1
	bcs	.Lj138
	bl	.Lj132
.Lj138:
	cmp	r1,#9
	bls	.Lj139
	bl	.Lj132
.Lj139:
	sub	r1,#1
	lsl	r1,r1,#2
	ldr	r0,.Lj140
	ldr	r0,[r0, r1]
	mov	r15,r0
	.balign 4
.La1:
	.long	.Lj133
	.long	.Lj132
	.long	.Lj134
	.long	.Lj135
	.long	.Lj132
	.long	.Lj136
	.long	.Lj132
	.long	.Lj132
	.long	.Lj137
.Lj133:
# [277] if (TCP_Header^.flags = FLAG_SYN) then begin
	ldrb	r0,[r7, #13]
	cmp	r0,#2
	bne	.Lj143
	bl	.Lj141
.Lj143:
	bl	.Lj142
.Lj141:
# [280] tcb^.src_ip := ByteSwap32(IP_Header^.src);
	ldr	r0,[r13, #4]
	ldrb	r2,[r0, #12]
	ldr	r0,[r13, #4]
	ldrb	r1,[r0, #13]
	lsl	r1,#8
	orr	r2,r1
	ldr	r0,[r13, #4]
	ldrb	r1,[r0, #14]
	lsl	r1,#16
	orr	r2,r1
	ldr	r0,[r13, #4]
	ldrb	r1,[r0, #15]
	lsl	r1,#24
	orr	r2,r1
	mov	r0,r2
	bl	ETHERNET_$$_BYTESWAP32$LONGWORD$$LONGWORD
	ldr	r1,[r13]
	str	r0,[r1]
# [281] tcb^.src_port := ByteSwap16(TCP_Header^.src_port);
	ldrb	r1,[r7]
	ldrb	r0,[r7, #1]
	lsl	r0,#8
	orr	r1,r0
	mov	r0,r1
	bl	ETHERNET_$$_BYTESWAP16$WORD$$WORD
	uxth	r1,r0
	ldr	r0,[r13]
	strh	r1,[r0, #8]
# [282] tcb^.irs := ByteSwap32(TCP_Header^.seq);
	ldrb	r1,[r7, #4]
	ldrb	r0,[r7, #5]
	lsl	r0,#8
	orr	r1,r0
	ldrb	r0,[r7, #6]
	lsl	r0,#16
	orr	r1,r0
	ldrb	r0,[r7, #7]
	lsl	r0,#24
	orr	r1,r0
	mov	r0,r1
	bl	ETHERNET_$$_BYTESWAP32$LONGWORD$$LONGWORD
	ldr	r1,[r13]
	str	r0,[r1, #36]
# [283] tcb^.rcv_nxt := ByteSwap32(TCP_Header^.seq) + 1;
	ldrb	r1,[r7, #4]
	ldrb	r0,[r7, #5]
	lsl	r0,#8
	orr	r1,r0
	ldrb	r0,[r7, #6]
	lsl	r0,#16
	orr	r1,r0
	ldrb	r0,[r7, #7]
	lsl	r0,#24
	orr	r1,r0
	mov	r0,r1
	bl	ETHERNET_$$_BYTESWAP32$LONGWORD$$LONGWORD
	add	r0,#1
	ldr	r1,[r13]
	str	r0,[r1, #24]
# [284] tcb^.rcv_wnd := ByteSwap16(TCP_Header^.window_size);
	ldrb	r1,[r7, #14]
	ldrb	r0,[r7, #15]
	lsl	r0,#8
	orr	r1,r0
	mov	r0,r1
	bl	ETHERNET_$$_BYTESWAP16$WORD$$WORD
	uxth	r1,r0
	ldr	r0,[r13]
	str	r1,[r0, #28]
# [285] tcb^.snd_una := tcb^.iss;
	ldr	r0,[r13]
	ldr	r1,[r0, #32]
	ldr	r0,[r13]
	str	r1,[r0, #12]
# [286] tcb^.snd_nxt := tcb^.iss;
	ldr	r0,[r13]
	ldr	r1,[r0, #32]
	ldr	r0,[r13]
	str	r1,[r0, #16]
# [287] tcb^.state := SYN_RECEIVED;
	mov	r1,#3
	ldr	r0,[r13]
	str	r1,[r0, #40]
# [289] ETH_Header := @ip_hdr[0] - ETH_HEADER_SIZE ;
	ldr	r1,[r13, #12]
# Peephole LdrMov2Ldr removed superfluous mov
	sub	r1,#14
	mov	r4,r1
# [290] for i:=0 to 5 do
	mov	r3,#255
.Lj144:
	mov	r0,r3
	add	r0,#1
	uxtb	r3,r0
# Peephole UxtbMov2Data removed superfluous mov
# [291] tcb^.src_mac[i] := ETH_Header^.src[i];
	uxtb	r6,r3
	uxtb	r1,r3
	mov	r0,r4
	add	r0,#6
	ldrb	r2,[r0, r1]
	mov	r1,r6
	ldr	r0,[r13]
	add	r1,r0
# [412] end;
	b	.Lj181
	.balign 4
.Lj114:
	.long	TC_$ETHERNET_IP_TCP$_$ETH_PROTOCOL_IP_TCP$PBYTE$PBYTE$WORD_$$_defaultsocket
.Lj118:
	.long	65535
.Lj140:
	.long	.La1
.Lj181:
	add	r1,#49
	strb	r2,[r1]
	cmp	r3,#5
	bcc	.Lj147
	bl	.Lj146
.Lj147:
	bl	.Lj144
.Lj146:
# [293] tcb^.tcb_flags := FLAG_SYN OR FLAG_ACK;
	mov	r2,#18
	ldr	r1,[r13]
# Peephole LdrMov2Ldr removed superfluous mov
	add	r1,#55
	strb	r2,[r1]
# [294] tcb^.time := 0;
	mov	r1,#0
	ldr	r0,[r13]
	str	r1,[r0, #44]
.Lj142:
# [297] if(TCP_Header^.flags = FLAG_RST) then begin
	ldrb	r0,[r7, #13]
	cmp	r0,#4
	bne	.Lj150
	bl	.Lj148
.Lj150:
	bl	.Lj149
.Lj148:
# [298] tcb^.state := CLOSING;
	mov	r1,#8
	ldr	r0,[r13]
	str	r1,[r0, #40]
# [299] tcb^.tcb_flags := FLAG_NUL;
	mov	r2,#0
	ldr	r1,[r13]
# Peephole LdrMov2Ldr removed superfluous mov
	add	r1,#55
	strb	r2,[r1]
.Lj149:
	bl	.Lj131
.Lj134:
# [304] if(TCP_Header^.flags = FLAG_ACK) then begin
	ldrb	r0,[r7, #13]
	cmp	r0,#16
	bne	.Lj153
	bl	.Lj151
.Lj153:
	bl	.Lj152
.Lj151:
# [307] if(tcb^.snd_nxt = ByteSwap32(TCP_Header^.ack)) then begin
	ldrb	r1,[r7, #8]
	ldrb	r0,[r7, #9]
	lsl	r0,#8
	orr	r1,r0
	ldrb	r0,[r7, #10]
	lsl	r0,#16
	orr	r1,r0
	ldrb	r0,[r7, #11]
	lsl	r0,#24
	orr	r1,r0
	mov	r0,r1
	bl	ETHERNET_$$_BYTESWAP32$LONGWORD$$LONGWORD
	ldr	r1,[r13]
	ldr	r2,[r1, #16]
	cmp	r2,r0
	bne	.Lj156
	bl	.Lj154
.Lj156:
	bl	.Lj155
.Lj154:
# [308] tcb^.state := ESTABLISHED;
	mov	r1,#4
	ldr	r0,[r13]
	str	r1,[r0, #40]
# [309] tcb^.rcv_nxt := ByteSwap32(TCP_Header^.seq) + 1;
	ldrb	r1,[r7, #4]
	ldrb	r0,[r7, #5]
	lsl	r0,#8
	orr	r1,r0
	ldrb	r0,[r7, #6]
	lsl	r0,#16
	orr	r1,r0
	ldrb	r0,[r7, #7]
	lsl	r0,#24
	orr	r1,r0
	mov	r0,r1
	bl	ETHERNET_$$_BYTESWAP32$LONGWORD$$LONGWORD
	add	r0,#1
	ldr	r1,[r13]
	str	r0,[r1, #24]
# [310] tcb^.snd_nxt := ByteSwap32(TCP_Header^.ack);
	ldrb	r1,[r7, #8]
	ldrb	r0,[r7, #9]
	lsl	r0,#8
	orr	r1,r0
	ldrb	r0,[r7, #10]
	lsl	r0,#16
	orr	r1,r0
	ldrb	r0,[r7, #11]
	lsl	r0,#24
	orr	r1,r0
	mov	r0,r1
	bl	ETHERNET_$$_BYTESWAP32$LONGWORD$$LONGWORD
	ldr	r1,[r13]
	str	r0,[r1, #16]
# [311] tcb^.time := 0;
	mov	r1,#0
	ldr	r0,[r13]
	str	r1,[r0, #44]
.Lj155:
.Lj152:
# [315] if(TCP_Header^.flags = FLAG_RST) then begin
	ldrb	r0,[r7, #13]
	cmp	r0,#4
	bne	.Lj159
	bl	.Lj157
.Lj159:
	bl	.Lj158
.Lj157:
# [318] TCB_Destroy(tcb);
	ldr	r0,[r13]
# Peephole LdrMov2Ldr removed superfluous mov
	bl	ETHERNET_IP_TCP_$$_TCB_DESTROY$PTCB
.Lj158:
	bl	.Lj131
.Lj135:
# [324] if(TCP_Header^.flags = (FLAG_PSH OR FLAG_ACK)  )then begin
	ldrb	r0,[r7, #13]
	cmp	r0,#24
	bne	.Lj162
	bl	.Lj160
.Lj162:
	bl	.Lj161
.Lj160:
# [327] tcb^.rcv_data := tcp_hdr + (TCP_Header^.hdr_len>>2) - 1;
	ldrb	r2,[r7, #12]
# Peephole LdrMov2Ldr removed superfluous mov
	lsr	r2,r2,#2
	ldr	r1,[r13, #8]
# Peephole LdrMov2Ldr removed superfluous mov
	add	r1,r2
	sub	r1,#1
	ldr	r0,[r13]
	str	r1,[r0, #68]
# [328] tcb^.rcv_datalen := ByteSwap16(IP_Header^.total_len) - word((IP_Header^.ver_len AND $0F) << 2) - word(TCP_Header^.hdr_len>>2);
	ldr	r0,[r13, #4]
	ldrb	r2,[r0, #2]
	ldr	r0,[r13, #4]
	ldrb	r1,[r0, #3]
	lsl	r1,#8
	orr	r2,r1
	mov	r0,r2
	bl	ETHERNET_$$_BYTESWAP16$WORD$$WORD
	uxth	r2,r0
	ldr	r0,[r13, #4]
	ldrb	r1,[r0]
	mov	r0,#15
	and	r1,r0
	mov	r0,r1
	lsl	r0,r0,#2
	uxth	r0,r0
	sub	r2,r0
	ldrb	r0,[r7, #12]
	lsr	r0,r0,#2
	uxth	r1,r0
	mov	r0,r2
	sub	r0,r1
	uxth	r2,r0
	ldr	r1,[r13]
# Peephole LdrMov2Ldr removed superfluous mov
	add	r1,#72
	strh	r2,[r1]
# [329] tcb^.rcv_nxt := ByteSwap32(TCP_Header^.seq) + tcb^.rcv_datalen; // + datalen
	ldrb	r1,[r7, #4]
	ldrb	r0,[r7, #5]
	lsl	r0,#8
	orr	r1,r0
	ldrb	r0,[r7, #6]
	lsl	r0,#16
	orr	r1,r0
	ldrb	r0,[r7, #7]
	lsl	r0,#24
	orr	r1,r0
	mov	r0,r1
	bl	ETHERNET_$$_BYTESWAP32$LONGWORD$$LONGWORD
	ldr	r2,[r13]
# Peephole LdrMov2Ldr removed superfluous mov
	add	r2,#72
	ldrh	r1,[r2]
	add	r1,r0
	ldr	r0,[r13]
	str	r1,[r0, #24]
# [330] tcb^.snd_nxt := ByteSwap32(TCP_Header^.ack);
	ldrb	r1,[r7, #8]
	ldrb	r0,[r7, #9]
	lsl	r0,#8
	orr	r1,r0
	ldrb	r0,[r7, #10]
	lsl	r0,#16
	orr	r1,r0
	ldrb	r0,[r7, #11]
	lsl	r0,#24
	orr	r1,r0
	mov	r0,r1
	bl	ETHERNET_$$_BYTESWAP32$LONGWORD$$LONGWORD
	ldr	r1,[r13]
	str	r0,[r1, #16]
# [331] tcb^.tcb_flags :=  FLAG_ACK;
	mov	r2,#16
	ldr	r1,[r13]
# Peephole LdrMov2Ldr removed superfluous mov
	add	r1,#55
	strb	r2,[r1]
# [332] tcb^.time := 0;
	mov	r1,#0
	ldr	r0,[r13]
	str	r1,[r0, #44]
# [340] if(socket^.recv_func <> nil) then
	ldr	r0,[r5, #12]
	cmp	r0,#0
	beq	.Lj165
	bl	.Lj163
.Lj165:
	bl	.Lj164
.Lj163:
# [341] socket^.recv_func(tcb^.id, tcb^.rcv_data, tcb^.rcv_datalen);
	ldr	r1,[r13]
# Peephole LdrMov2Ldr removed superfluous mov
	add	r1,#72
	ldrh	r4,[r1]
	ldr	r0,[r13]
	ldr	r2,[r0, #68]
	ldr	r1,[r13]
# Peephole LdrMov2Ldr removed superfluous mov
	add	r1,#48
	ldrb	r0,[r1]
	ldr	r3,[r5, #12]
	mov	r1,r2
	mov	r2,r4
	blx	r3
.Lj164:
# [342] if ((tcb^.tcb_flags AND FLAG_FIN) = FLAG_FIN) then
	ldr	r1,[r13]
# Peephole LdrMov2Ldr removed superfluous mov
	add	r1,#55
	ldrb	r0,[r1]
	mov	r1,#1
	and	r0,r1
	cmp	r0,#1
	bne	.Lj168
	bl	.Lj166
.Lj168:
	bl	.Lj167
.Lj166:
# [343] ClrPins(GPIO_Port_0, GPIO_Pin_3);
	mov	r1,#8
	mov	r0,#0
	bl	UTILS_$$_CLRPINS$BYTE$WORD
.Lj167:
# [345] tcb^.rcv_data := nil;
	mov	r1,#0
	ldr	r0,[r13]
	str	r1,[r0, #68]
# [346] tcb^.rcv_datalen := 0;
	mov	r2,#0
	ldr	r1,[r13]
# Peephole LdrMov2Ldr removed superfluous mov
	add	r1,#72
	strh	r2,[r1]
.Lj161:
# [349] if(TCP_Header^.flags = FLAG_ACK) then begin
	ldrb	r0,[r7, #13]
	cmp	r0,#16
	bne	.Lj171
	bl	.Lj169
.Lj171:
	bl	.Lj170
.Lj169:
# [350] tcb^.rcv_data := tcp_hdr + (TCP_Header^.hdr_len>>2) - 1;
	ldrb	r1,[r7, #12]
# Peephole LdrMov2Ldr removed superfluous mov
	lsr	r1,r1,#2
	ldr	r2,[r13, #8]
# Peephole LdrMov2Ldr removed superfluous mov
	add	r2,r1
	mov	r1,r2
	sub	r1,#1
	ldr	r0,[r13]
	str	r1,[r0, #68]
# [351] tcb^.rcv_datalen := ByteSwap16(IP_Header^.total_len) - word((IP_Header^.ver_len AND $0F) << 2) - word(TCP_Header^.hdr_len>>2);
	ldr	r0,[r13, #4]
	ldrb	r2,[r0, #2]
	ldr	r0,[r13, #4]
	ldrb	r1,[r0, #3]
	lsl	r1,#8
	orr	r2,r1
	mov	r0,r2
	bl	ETHERNET_$$_BYTESWAP16$WORD$$WORD
	uxth	r2,r0
	ldr	r0,[r13, #4]
	ldrb	r0,[r0]
# Peephole LdrMov2Ldr removed superfluous mov
	mov	r1,#15
	and	r0,r1
	lsl	r0,r0,#2
	uxth	r0,r0
	sub	r2,r0
	ldrb	r0,[r7, #12]
	lsr	r0,r0,#2
	uxth	r0,r0
	sub	r2,r0
	uxth	r2,r2
	ldr	r1,[r13]
# Peephole LdrMov2Ldr removed superfluous mov
	add	r1,#72
	strh	r2,[r1]
# [352] tcb^.rcv_nxt := ByteSwap32(TCP_Header^.seq) + tcb^.rcv_datalen; // + datalen
	ldrb	r1,[r7, #4]
	ldrb	r0,[r7, #5]
	lsl	r0,#8
	orr	r1,r0
	ldrb	r0,[r7, #6]
	lsl	r0,#16
	orr	r1,r0
	ldrb	r0,[r7, #7]
	lsl	r0,#24
	orr	r1,r0
	mov	r0,r1
	bl	ETHERNET_$$_BYTESWAP32$LONGWORD$$LONGWORD
	ldr	r2,[r13]
# Peephole LdrMov2Ldr removed superfluous mov
	add	r2,#72
	ldrh	r1,[r2]
	add	r1,r0
	ldr	r0,[r13]
	str	r1,[r0, #24]
# [353] tcb^.snd_nxt := ByteSwap32(TCP_Header^.ack);
	ldrb	r1,[r7, #8]
	ldrb	r0,[r7, #9]
	lsl	r0,#8
	orr	r1,r0
	ldrb	r0,[r7, #10]
	lsl	r0,#16
	orr	r1,r0
	ldrb	r0,[r7, #11]
	lsl	r0,#24
	orr	r1,r0
	mov	r0,r1
	bl	ETHERNET_$$_BYTESWAP32$LONGWORD$$LONGWORD
	ldr	r1,[r13]
	str	r0,[r1, #16]
# [354] tcb^.tcb_flags :=  FLAG_ACK;
	mov	r2,#16
	ldr	r1,[r13]
# Peephole LdrMov2Ldr removed superfluous mov
	add	r1,#55
	strb	r2,[r1]
# [355] tcb^.time := 0;
	mov	r1,#0
	ldr	r0,[r13]
	str	r1,[r0, #44]
.Lj170:
# [362] if((TCP_Header^.flags AND FLAG_FIN) = FLAG_FIN) then begin
	ldrb	r1,[r7, #13]
# Peephole LdrMov2Ldr removed superfluous mov
	mov	r0,#1
	and	r1,r0
	cmp	r1,#1
	bne	.Lj174
	bl	.Lj172
.Lj174:
	bl	.Lj173
.Lj172:
# [365] tcb^.rcv_nxt := ByteSwap32(TCP_Header^.seq) + 1;
	ldrb	r1,[r7, #4]
	ldrb	r0,[r7, #5]
	lsl	r0,#8
	orr	r1,r0
	ldrb	r0,[r7, #6]
	lsl	r0,#16
	orr	r1,r0
	ldrb	r0,[r7, #7]
	lsl	r0,#24
	orr	r1,r0
	mov	r0,r1
	bl	ETHERNET_$$_BYTESWAP32$LONGWORD$$LONGWORD
	add	r0,#1
	ldr	r1,[r13]
	str	r0,[r1, #24]
# [366] tcb^.snd_nxt := ByteSwap32(TCP_Header^.ack);
	ldrb	r1,[r7, #8]
	ldrb	r0,[r7, #9]
	lsl	r0,#8
	orr	r1,r0
	ldrb	r0,[r7, #10]
	lsl	r0,#16
	orr	r1,r0
	ldrb	r0,[r7, #11]
	lsl	r0,#24
	orr	r1,r0
	mov	r0,r1
	bl	ETHERNET_$$_BYTESWAP32$LONGWORD$$LONGWORD
	ldr	r1,[r13]
	str	r0,[r1, #16]
# [367] tcb^.tcb_flags := (FLAG_FIN OR FLAG_ACK);
	mov	r2,#17
	ldr	r1,[r13]
# Peephole LdrMov2Ldr removed superfluous mov
	add	r1,#55
	strb	r2,[r1]
# [368] tcb^.state := LAST_ACK;
	mov	r1,#9
	ldr	r0,[r13]
	str	r1,[r0, #40]
.Lj173:
	bl	.Lj131
.Lj136:
# [383] if(TCP_Header^.flags = (FLAG_FIN OR FLAG_ACK)) then begin
	ldrb	r0,[r7, #13]
	cmp	r0,#17
	bne	.Lj177
	bl	.Lj175
.Lj177:
	bl	.Lj176
.Lj175:
# [386] tcb^.rcv_nxt := ByteSwap32(TCP_Header^.seq) + 1;
	ldrb	r1,[r7, #4]
	ldrb	r0,[r7, #5]
	lsl	r0,#8
	orr	r1,r0
	ldrb	r0,[r7, #6]
	lsl	r0,#16
	orr	r1,r0
	ldrb	r0,[r7, #7]
	lsl	r0,#24
	orr	r1,r0
	mov	r0,r1
	bl	ETHERNET_$$_BYTESWAP32$LONGWORD$$LONGWORD
	add	r0,#1
	ldr	r1,[r13]
	str	r0,[r1, #24]
# [387] tcb^.snd_nxt := ByteSwap32(TCP_Header^.ack);
	ldrb	r1,[r7, #8]
	ldrb	r0,[r7, #9]
	lsl	r0,#8
	orr	r1,r0
	ldrb	r0,[r7, #10]
	lsl	r0,#16
	orr	r1,r0
	ldrb	r0,[r7, #11]
	lsl	r0,#24
	orr	r1,r0
	mov	r0,r1
	bl	ETHERNET_$$_BYTESWAP32$LONGWORD$$LONGWORD
	ldr	r1,[r13]
	str	r0,[r1, #16]
# [388] tcb^.state := CLOSING;
	mov	r1,#8
	ldr	r0,[r13]
	str	r1,[r0, #40]
# [389] tcb^.tcb_flags := FLAG_ACK;
	mov	r2,#16
	ldr	r1,[r13]
# Peephole LdrMov2Ldr removed superfluous mov
	add	r1,#55
	strb	r2,[r1]
# [390] tcb^.time := 0;
	mov	r1,#0
	ldr	r0,[r13]
	str	r1,[r0, #44]
.Lj176:
	bl	.Lj131
.Lj137:
# [395] if(TCP_Header^.flags AND FLAG_ACK) = FLAG_ACK then begin
	ldrb	r1,[r7, #13]
# Peephole LdrMov2Ldr removed superfluous mov
	mov	r0,#16
	and	r1,r0
	cmp	r1,#16
	bne	.Lj180
	bl	.Lj178
.Lj180:
	bl	.Lj179
.Lj178:
# [398] tcb^.rcv_nxt := ByteSwap32(TCP_Header^.seq) + 1;
	ldrb	r1,[r7, #4]
	ldrb	r0,[r7, #5]
	lsl	r0,#8
	orr	r1,r0
	ldrb	r0,[r7, #6]
	lsl	r0,#16
	orr	r1,r0
	ldrb	r0,[r7, #7]
	lsl	r0,#24
	orr	r1,r0
	mov	r0,r1
	bl	ETHERNET_$$_BYTESWAP32$LONGWORD$$LONGWORD
	add	r0,#1
	ldr	r1,[r13]
	str	r0,[r1, #24]
# [399] tcb^.snd_nxt := ByteSwap32(TCP_Header^.ack);
	ldrb	r1,[r7, #8]
	ldrb	r0,[r7, #9]
	lsl	r0,#8
	orr	r1,r0
	ldrb	r0,[r7, #10]
	lsl	r0,#16
	orr	r1,r0
	ldrb	r0,[r7, #11]
	lsl	r0,#24
	orr	r1,r0
	mov	r0,r1
	bl	ETHERNET_$$_BYTESWAP32$LONGWORD$$LONGWORD
	ldr	r1,[r13]
	str	r0,[r1, #16]
# [400] tcb^.state := CLOSING;
	mov	r1,#8
	ldr	r0,[r13]
	str	r1,[r0, #40]
# [401] TCB_Destroy(tcb);
	ldr	r0,[r13]
# Peephole LdrMov2Ldr removed superfluous mov
	bl	ETHERNET_IP_TCP_$$_TCB_DESTROY$PTCB
.Lj179:
	bl	.Lj131
.Lj132:
# [408] TCB_Destroy(tcb);
	ldr	r0,[r13]
# Peephole LdrMov2Ldr removed superfluous mov
	bl	ETHERNET_IP_TCP_$$_TCB_DESTROY$PTCB
.Lj131:
.Lj123:
.Lj112:
	add	r13,r13,#72
	pop	{r4,r5,r6,r7,r15}
.Lc15:
.Le7:
	.size	ETHERNET_IP_TCP_$$_ETH_PROTOCOL_IP_TCP$PBYTE$PBYTE$WORD, .Le7 - ETHERNET_IP_TCP_$$_ETH_PROTOCOL_IP_TCP$PBYTE$PBYTE$WORD

.section .text.n_ethernet_ip_tcp_$$_eth_protocol_ip_tcp_send$pbyte$ptcb,"ax"
	.balign 4
.thumb_func 
.globl	ETHERNET_IP_TCP_$$_ETH_PROTOCOL_IP_TCP_SEND$PBYTE$PTCB
ETHERNET_IP_TCP_$$_ETH_PROTOCOL_IP_TCP_SEND$PBYTE$PTCB:
.Lc18:
# Temps allocated between r13+56 and r13+64
# [423] begin
	push	{r4,r5,r6,r7,r14}
	sub	r13,r13,#112
# Var ETH_Header located at r13+0, size=OS_NO
# Var TCP_Header located at r13+16, size=OS_NO
# Var IP_Header located at r13+36, size=OS_NO
# Var i located in register r0
# Var checksum located in register r0
# Var checksum_psdh located in register r0
# Var checksum_data located in register r0
# Var datalen located in register r0
# Var olddatalen located in register r0
# Var len located in register r0
	mov	r7,r0
# Var snd_buf located in register r7
# Var tcb located in register r1
# [424] len := tcb^.snd_datalen;
	mov	r4,r1
# Var tcb located in register r4
# Var len located in register r0
	mov	r0,r4
	add	r0,#64
	ldrh	r6,[r0]
# Var datalen located in register r1
# Peephole LdrMov2Ldr removed superfluous mov
# Var len located in register r6
# [425] datalen := len;
	mov	r1,r6
# Var olddatalen located in register r0
# [426] olddatalen := datalen;
	ldr	r0,[r13, #56]
	mov	r0,r1
	str	r0,[r13, #56]
# Var datalen located in register r0
# Peephole StrLdr2StrMov 1 done
	ldr	r1,[r13, #60]
	mov	r1,r0
	str	r1,[r13, #60]
# [428] Fillbyte(snd_buf[0], BUFFER_SIZE, 0);
	ldr	r1,.Lj184
	mov	r2,#0
	mov	r0,r7
	bl	SYSTEM_$$_FILLBYTE$formal$LONGINT$BYTE
# [430] if datalen > 0 then
	ldr	r0,[r13, #56]
	cmp	r0,#0
	bls	.Lj187
	bl	.Lj185
.Lj187:
	bl	.Lj186
.Lj185:
# [431] move(tcb^.snd_data[0], snd_buf[0], datalen);
	ldr	r0,[r4, #60]
	ldr	r2,[r13, #56]
# Peephole LdrMov2Ldr removed superfluous mov
	mov	r1,r7
	bl	SYSTEM_$$_MOVE$formal$formal$LONGINT
.Lj186:
# [433] ETH_Header.hdrtype := ByteSwap16(ETH_FRAME_TYPE_IPV4);
	ldr	r0,.Lj188
	bl	ETHERNET_$$_BYTESWAP16$WORD$$WORD
	uxth	r1,r0
	add	r0,r13,#12
	strh	r1,[r0]
# Var i located in register r2
# [434] for i:=0 to 5 do begin
	mov	r2,#255
.Lj189:
	mov	r0,r2
	add	r0,#1
	uxtb	r2,r0
# Peephole UxtbMov2Data removed superfluous mov
# [435] ETH_Header.dst[i] := tcb^.src_mac[i];
	uxtb	r3,r2
	uxtb	r0,r2
	add	r0,r4
	add	r0,#49
	ldrb	r1,[r0]
	mov	r0,r3
	add	r0,r13
	strb	r1,[r0]
# [436] ETH_Header.src[i] := MACADDR[i];
	ldr	r0,.Lj192
	ldr	r0,[r0]
	uxtb	r3,r2
	ldrb	r1,[r0, r2]
	mov	r0,r3
	add	r0,r13
	add	r0,#6
	strb	r1,[r0]
	cmp	r2,#5
	bcc	.Lj193
	bl	.Lj191
.Lj193:
	bl	.Lj189
.Lj191:
# [439] Inc(package_id);
	ldr	r1,.Lj194
# Peephole LdrMov2Ldr removed superfluous mov
	ldrh	r0,[r1]
	add	r0,#1
# Peephole UXTHStrh2Strh done
	strh	r0,[r1]
# [440] IP_Header.id := ByteSwap16(package_id);
	ldr	r0,.Lj194
	ldrh	r0,[r0]
	bl	ETHERNET_$$_BYTESWAP16$WORD$$WORD
	uxth	r1,r0
	add	r0,r13,#40
	strh	r1,[r0]
# [441] IP_Header.dsfield := 0;
	mov	r1,#0
	mov	r0,r13
	add	r0,#37
	strb	r1,[r0]
# [442] IP_Header.ver_len := $45;
	mov	r1,#69
	add	r0,r13,#36
	strb	r1,[r0]
# [443] IP_Header.flags := $40;
	mov	r1,#64
	mov	r0,r13
	add	r0,#42
	strb	r1,[r0]
# [444] IP_Header.protocol := IPV4_TYPE_TCP;
	mov	r1,#6
	mov	r0,r13
	add	r0,#45
	strb	r1,[r0]
# [445] IP_Header.ttl := 128;
	mov	r1,#128
	add	r0,r13,#44
	strb	r1,[r0]
# [446] IP_Header.frag_offset := 0;
	mov	r1,#0
	mov	r0,r13
	add	r0,#43
	strb	r1,[r0]
# [448] IP_Header.checksum := 0;
	mov	r1,#0
	mov	r0,r13
	add	r0,#46
	strh	r1,[r0]
# Var tcb located in register r4
# [449] IP_Header.dst := ByteSwap32(tcb^.src_ip);
	ldr	r0,[r4]
	bl	ETHERNET_$$_BYTESWAP32$LONGWORD$$LONGWORD
	str	r0,[r13, #52]
	ldr	r0,.Lj196
	ldr	r1,[r0]
# [450] IP_Header.src := ByteSwap32((ip[0]<<24) OR (ip[1] << 16) OR (ip[2] << 8) OR ip[3]);
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
	str	r0,[r13, #48]
# Var tcb located in register r4
# [452] TCP_Header.dst_port := ByteSwap16(tcb^.src_port);
	ldrh	r0,[r4, #8]
	bl	ETHERNET_$$_BYTESWAP16$WORD$$WORD
	uxth	r1,r0
	mov	r0,r13
	add	r0,#18
	strh	r1,[r0]
# Var tcb located in register r4
# [453] TCP_Header.src_port := ByteSwap16(tcb^.dst_port);
	ldrh	r0,[r4, #10]
	bl	ETHERNET_$$_BYTESWAP16$WORD$$WORD
	uxth	r0,r0
	add	r1,r13,#16
	strh	r0,[r1]
# Var tcb located in register r4
# [455] TCP_Header.seq := ByteSwap32(tcb^.snd_nxt);
	ldr	r0,[r4, #16]
	bl	ETHERNET_$$_BYTESWAP32$LONGWORD$$LONGWORD
	str	r0,[r13, #20]
# [456] TCP_Header.ack := ByteSwap32(tcb^.rcv_nxt);
	mov	r5,r4
# Var tcb located in register r5
	ldr	r0,[r5, #24]
	bl	ETHERNET_$$_BYTESWAP32$LONGWORD$$LONGWORD
	str	r0,[r13, #24]
# [457] TCP_Header.hdr_len := (sizeof(TCP_Header) << 2);
	mov	r0,#80
	add	r1,r13,#28
	strb	r0,[r1]
# [458] TCP_Header.flags := tcb^.tcb_flags;
	mov	r0,r5
	add	r0,#55
	ldrb	r1,[r0]
	mov	r0,r13
	add	r0,#29
	strb	r1,[r0]
# [459] TCP_Header.window_size := ByteSwap16(BUFFER_SIZE);
	ldr	r0,.Lj184
	bl	ETHERNET_$$_BYTESWAP16$WORD$$WORD
	uxth	r1,r0
	mov	r0,r13
	add	r0,#30
	strh	r1,[r0]
# [460] TCP_Header.checksum := 0;
	mov	r0,#0
	add	r1,r13,#32
	strh	r0,[r1]
# [461] TCP_Header.urgent_ptr := 0;
	mov	r1,#0
	mov	r0,r13
	add	r0,#34
	strh	r1,[r0]
# [463] len := len + sizeof(TCP_Header);
	mov	r0,r6
	add	r0,#20
	uxth	r0,r0
# Var len located in register r0
# [464] len := len + sizeof(IP_Header);
	add	r0,#20
# Peephole UxthUxth2Uxth done
# Var len located in register r0
# Var len located in register r0
# [466] IP_Header.total_len := ByteSwap16(len);
	uxth	r0,r0
	bl	ETHERNET_$$_BYTESWAP16$WORD$$WORD
	uxth	r1,r0
	mov	r0,r13
	add	r0,#38
	strh	r1,[r0]
# [468] checksum := calc_checksum(@IP_Header, 10, 0);
	add	r0,r13,#36
	mov	r2,#0
	mov	r1,#10
	bl	ETHERNET_IP_$$_CALC_CHECKSUM$PWORD$WORD$WORD$$WORD
	uxth	r0,r0
# Var checksum located in register r0
# [469] checksum := NOT checksum;
	mvn	r0,r0
# Var checksum located in register r0
# [470] IP_Header.checksum := checksum;
	mov	r1,r0
# Var checksum located in register r1
	mov	r0,r13
	add	r0,#46
	strh	r1,[r0]
# [472] len := datalen + sizeof(TCP_Header);
	ldr	r1,[r13, #56]
# Peephole LdrMov2Ldr removed superfluous mov
	add	r1,#20
	uxth	r2,r1
# Var len located in register r2
# Peephole UxthMov2Data removed superfluous mov
# [474] checksum_psdh := calc_psdh(IP_Header.src, IP_Header.dst, len, 0);
	ldr	r1,[r13, #52]
	ldr	r0,[r13, #48]
	mov	r3,#0
# Var len located in register r2
	uxth	r2,r2
	bl	ETHERNET_IP_TCP_$$_CALC_PSDH$LONGWORD$LONGWORD$WORD$WORD$$WORD
	uxth	r4,r0
# Var checksum_psdh located in register r4
# Peephole UxthMov2Data removed superfluous mov
# [475] if (((datalen AND $01) = 1) AND (datalen > 0)) then begin
	ldr	r1,[r13, #56]
# Peephole LdrMov2Ldr removed superfluous mov
	mov	r0,#1
	and	r1,r0
	cmp	r1,#1
	bne	.Lj200
	bl	.Lj198
.Lj200:
	bl	.Lj199
.Lj198:
	ldr	r0,[r13, #56]
	cmp	r0,#0
	bls	.Lj202
	bl	.Lj201
.Lj202:
	bl	.Lj199
.Lj201:
# [476] snd_buf[datalen] := 0;
	mov	r1,#0
	ldr	r0,[r13, #56]
	strb	r1,[r7, r0]
# [477] Inc(datalen);
	ldr	r0,[r13, #56]
	add	r0,#1
	str	r0,[r13, #56]
# Peephole StrLdr2StrMov 1 done
	uxth	r0,r0
	str	r0,[r13, #56]
.Lj199:
# [480] tcb^.snd_nxt := tcb^.snd_nxt + datalen;
	mov	r1,r5
# Var tcb located in register r1
	ldr	r2,[r1, #16]
	ldr	r3,[r13, #56]
# Peephole LdrMov2Ldr removed superfluous mov
	add	r3,r2
	mov	r5,r1
# Var tcb located in register r5
	str	r3,[r5, #16]
# [481] if(tcb^.tcb_flags AND FLAG_SYN) = FLAG_SYN then
	mov	r0,r5
	add	r0,#55
	ldrb	r0,[r0]
	mov	r1,#2
	and	r0,r1
	cmp	r0,#2
	bne	.Lj205
	bl	.Lj203
.Lj205:
	bl	.Lj204
.Lj203:
# [482] Inc(tcb^.snd_nxt);
	ldr	r0,[r5, #16]
	add	r0,#1
	str	r0,[r5, #16]
.Lj204:
# [484] checksum_data := calc_checksum(PWord(snd_buf), datalen>>1, checksum_psdh);
	ldr	r1,[r13, #56]
# Peephole LdrMov2Ldr removed superfluous mov
	lsr	r1,r1,#1
# Peephole UxthUxth2Uxth done
	uxth	r1,r1
	mov	r0,r4
# Var checksum_psdh located in register r0
	uxth	r2,r0
	mov	r4,r7
# Var snd_buf located in register r4
	mov	r0,r4
	bl	ETHERNET_IP_$$_CALC_CHECKSUM$PWORD$WORD$WORD$$WORD
	uxth	r1,r0
# Var checksum_data located in register r1
# [485] checksum := calc_checksum(@TCP_Header, sizeof(TCP_Header)>>1, checksum_data);
	add	r0,r13,#16
# Var checksum_data located in register r1
	uxth	r2,r1
	mov	r1,#10
	bl	ETHERNET_IP_$$_CALC_CHECKSUM$PWORD$WORD$WORD$$WORD
	uxth	r0,r0
# Var checksum located in register r0
# [486] checksum := NOT checksum;
	mvn	r0,r0
# Var checksum located in register r0
# [487] TCP_Header.checksum := checksum;
	mov	r1,r0
# Var checksum located in register r1
	add	r0,r13,#32
	strh	r1,[r0]
# [489] FillByte(snd_buf[0], BUFFER_SIZE, 0);
	ldr	r1,.Lj184
	mov	r2,#0
	mov	r0,r4
	bl	SYSTEM_$$_FILLBYTE$formal$LONGINT$BYTE
# [491] move(ETH_Header, snd_buf[0], sizeof(ETH_Header));
	mov	r0,r13
	mov	r2,#14
	mov	r1,r4
	bl	SYSTEM_$$_MOVE$formal$formal$LONGINT
# [492] move(IP_Header, snd_buf[sizeof(ETH_Header)], sizeof(IP_Header));
	add	r0,r13,#36
	mov	r2,#20
	mov	r1,r4
	add	r1,#14
	bl	SYSTEM_$$_MOVE$formal$formal$LONGINT
# [493] move(TCP_Header, snd_buf[sizeof(ETH_Header)+sizeof(IP_Header)], sizeof(TCP_Header));
	add	r0,r13,#16
	mov	r2,#20
	mov	r1,r4
	add	r1,#34
	bl	SYSTEM_$$_MOVE$formal$formal$LONGINT
# [494] if(datalen > 0) then
	ldr	r0,[r13, #56]
	cmp	r0,#0
	bls	.Lj209
	bl	.Lj207
.Lj209:
	bl	.Lj208
.Lj207:
# [495] move(tcb^.snd_data[0], snd_buf[sizeof(ETH_Header)+sizeof(IP_Header)+sizeof(TCP_Header)], olddatalen);
	ldr	r0,[r5, #60]
	ldr	r2,[r13, #60]
# Peephole LdrMov2Ldr removed superfluous mov
	mov	r1,r4
	add	r1,#54
	bl	SYSTEM_$$_MOVE$formal$formal$LONGINT
.Lj208:
# [497] enc28j60PacketSend(sizeof(ETH_Header)+sizeof(IP_Header)+sizeof(TCP_Header)+datalen, snd_buf );
	ldr	r1,[r13, #56]
# Peephole LdrMov2Ldr removed superfluous mov
	add	r1,#54
# Peephole UxthUxth2Uxth done
	uxth	r0,r1
# [498] end;
	b	.Lj210
	.balign 4
.Lj184:
	.long	1460
.Lj188:
	.long	2048
.Lj192:
	.long	TC_$ETHERNET_$$_MACADDR
.Lj194:
	.long	TC_$ETHERNET_IP_$$_PACKAGE_ID
.Lj196:
	.long	TC_$ETHERNET_$$_IP
.Lj210:
	mov	r1,r4
# Var snd_buf located in register r1
	bl	ENC28J60_$$_ENC28J60PACKETSEND$WORD$PBYTE
	add	r13,r13,#112
	pop	{r4,r5,r6,r7,r15}
.Lc17:
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

