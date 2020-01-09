	.file "project_eth.lpr"
# Begin asmlist al_procedures

.section .text.n_p$project_eth_$$_systick_interrupt,"ax"
	.balign 4
.thumb_func 
.globl	P$PROJECT_ETH_$$_SYSTICK_INTERRUPT
P$PROJECT_ETH_$$_SYSTICK_INTERRUPT:
.thumb_func 
.globl	SysTick_interrupt
SysTick_interrupt:
.Lc2:
# [project_eth.lpr]
# [23] begin
	push	{r14}
	sub	r13,r13,#32
# [24] SocketIncreaseTime();
	bl	ETHERNET_$$_SOCKETINCREASETIME
# [25] Inc(time);
	ldr	r0,.Lj5
	mov	r1,r0
	ldr	r0,[r1]
	add	r0,#1
	str	r0,[r1]
# [26] end;
	add	r13,r13,#32
	pop	{r15}
.Lc1:
	.balign 4
.Lj5:
	.long	TC_$UTILS_$$_TIME
.Le0:
	.size	P$PROJECT_ETH_$$_SYSTICK_INTERRUPT, .Le0 - P$PROJECT_ETH_$$_SYSTICK_INTERRUPT

.section .text.n_p$project_eth_$$_conf_input_ports,"ax"
	.balign 4
.thumb_func 
.globl	P$PROJECT_ETH_$$_CONF_INPUT_PORTS
P$PROJECT_ETH_$$_CONF_INPUT_PORTS:
.Lc4:
# [29] begin
	push	{r14}
	sub	r13,r13,#32
# [30] FillByte(input_pin[0], 4, 0);
	ldr	r0,.Lj8
	mov	r2,#0
	mov	r1,#4
	bl	SYSTEM_$$_FILLBYTE$formal$LONGINT$BYTE
# [31] LPC_IOCON.PIO3_3 := LPC_IOCON.PIO3_3 AND NOT (1 << 4);
	ldr	r0,.Lj9
	ldr	r0,[r0]
	mov	r1,r0
	ldr	r0,.Lj10
	and	r1,r0
	ldr	r0,.Lj9
	str	r1,[r0]
# [32] LPC_IOCON.PIO3_2 := LPC_IOCON.PIO3_2 AND NOT (1 << 4);
	ldr	r0,.Lj12
	ldr	r0,[r0]
	mov	r1,r0
	ldr	r0,.Lj10
	and	r1,r0
	ldr	r0,.Lj12
	str	r1,[r0]
# [34] SetInputs(GPIO_Port_1, GPIO_Pin_4);
	mov	r1,#16
	mov	r0,#1
	bl	UTILS_$$_SETINPUTS$BYTE$WORD
# [35] SetInputs(GPIO_Port_1, GPIO_Pin_11);
	ldr	r1,.Lj15
	mov	r0,#1
	bl	UTILS_$$_SETINPUTS$BYTE$WORD
# [36] SetInputs(GPIO_Port_3, GPIO_Pin_2);
	mov	r1,#4
	mov	r0,#3
	bl	UTILS_$$_SETINPUTS$BYTE$WORD
# [37] SetInputs(GPIO_Port_3, GPIO_Pin_3);
	mov	r1,#8
	mov	r0,#3
	bl	UTILS_$$_SETINPUTS$BYTE$WORD
# [38] end;
	add	r13,r13,#32
	pop	{r15}
.Lc3:
	.balign 4
.Lj8:
	.long	U_$P$PROJECT_ETH_$$_INPUT_PIN
.Lj9:
	.long	1074020524
.Lj10:
	.long	-17
.Lj12:
	.long	1074020508
.Lj15:
	.long	2048
.Le1:
	.size	P$PROJECT_ETH_$$_CONF_INPUT_PORTS, .Le1 - P$PROJECT_ETH_$$_CONF_INPUT_PORTS

.section .text.n_p$project_eth_$$_conf_output_ports,"ax"
	.balign 4
.thumb_func 
.globl	P$PROJECT_ETH_$$_CONF_OUTPUT_PORTS
P$PROJECT_ETH_$$_CONF_OUTPUT_PORTS:
.Lc6:
# [41] begin
	push	{r14}
	sub	r13,r13,#32
# [42] FillByte(output_pin[0], 4, 0);
	ldr	r0,.Lj18
	mov	r2,#0
	mov	r1,#4
	bl	SYSTEM_$$_FILLBYTE$formal$LONGINT$BYTE
# [43] SetOutputs(GPIO_Port_1, GPIO_Pin_1);
	mov	r1,#2
	mov	r0,#1
	bl	UTILS_$$_SETOUTPUTS$BYTE$WORD
# [44] SetOutputs(GPIO_Port_1, GPIO_Pin_2);
	mov	r1,#4
	mov	r0,#1
	bl	UTILS_$$_SETOUTPUTS$BYTE$WORD
# [45] SetOutputs(GPIO_Port_2, GPIO_Pin_3);
	mov	r1,#8
	mov	r0,#2
	bl	UTILS_$$_SETOUTPUTS$BYTE$WORD
# [46] SetOutputs(GPIO_Port_3, GPIO_Pin_1);
	mov	r1,#2
	mov	r0,#3
	bl	UTILS_$$_SETOUTPUTS$BYTE$WORD
# [47] end;
	add	r13,r13,#32
	pop	{r15}
.Lc5:
	.balign 4
.Lj18:
	.long	U_$P$PROJECT_ETH_$$_OUTPUT_PIN
.Le2:
	.size	P$PROJECT_ETH_$$_CONF_OUTPUT_PORTS, .Le2 - P$PROJECT_ETH_$$_CONF_OUTPUT_PORTS

.section .text.n_p$project_eth_$$_server_recv80$byte$pbyte$word,"ax"
	.balign 4
.thumb_func 
.globl	P$PROJECT_ETH_$$_SERVER_RECV80$BYTE$PBYTE$WORD
P$PROJECT_ETH_$$_SERVER_RECV80$BYTE$PBYTE$WORD:
.Lc8:
# Temps allocated between r13+48 and r13+120
# [61] begin
	push	{r14}
	sub	r13,r13,#160
# Var tcb_id located at r13+0, size=OS_8
# Var rcv_data located at r13+4, size=OS_32
# Var rcv_size located at r13+8, size=OS_16
# Var num located at r13+12, size=OS_32
# Var pin located at r13+16, size=OS_32
# Var tmp located at r13+20, size=OS_32
# Var data_size located at r13+24, size=OS_16
# Var size located at r13+28, size=OS_16
# Var i located at r13+32, size=OS_16
# Var j located at r13+36, size=OS_16
# Var rcv located at r13+40, size=OS_32
# Var page located at r13+44, size=OS_32
	mov	r3,r13
	strb	r0,[r3]
	str	r1,[r13, #4]
	add	r0,r13,#8
	strh	r2,[r0]
	mov	r0,#0
	str	r0,[r13, #12]
	mov	r0,#0
	str	r0,[r13, #16]
	mov	r0,#0
	str	r0,[r13, #20]
	mov	r0,#0
	str	r0,[r13, #116]
	add	r2,r13,#48
	add	r1,r13,#60
	mov	r0,#1
	bl	fpc_pushexceptaddr
	bl	fpc_setjmp
	str	r0,[r13, #100]
	cmp	r0,#0
	beq	.Lj23
	bl	.Lj22
.Lj23:
# [62] rcv := PChar(rcv_data);
	ldr	r0,[r13, #4]
	str	r0,[r13, #40]
# [63] data_size := rcv_size;
	add	r0,r13,#8
	ldrh	r1,[r0]
	add	r0,r13,#24
	strh	r1,[r0]
# [64] page := PageMain;
	mov	r0,#0
	str	r0,[r13, #44]
# [66] size := 0;
	mov	r1,#0
	add	r0,r13,#28
	strh	r1,[r0]
# [67] move(HTML_Start, snd_buff, length(HTML_Start));
	ldr	r1,.Lj25
	mov	r2,#44
	ldr	r0,.Lj26
	bl	SYSTEM_$$_MOVE$formal$formal$LONGINT
# [68] size := size + length(HTML_Start);
	add	r0,r13,#28
	ldrh	r0,[r0]
	add	r0,#44
	uxth	r1,r0
	add	r0,r13,#28
	strh	r1,[r0]
# [69] move(HTML_Head, snd_buff[size], length(HTML_Head));
	add	r0,r13,#28
	ldrh	r0,[r0]
	ldr	r1,.Lj25
	add	r1,r0
	mov	r2,#77
	ldr	r0,.Lj28
	bl	SYSTEM_$$_MOVE$formal$formal$LONGINT
# [70] size := size + length(HTML_Head);
	add	r0,r13,#28
	ldrh	r0,[r0]
	add	r0,#77
	uxth	r1,r0
	add	r0,r13,#28
	strh	r1,[r0]
# [71] move(HTML_main1, snd_buff[size], length(HTML_main1));
	add	r0,r13,#28
	ldrh	r0,[r0]
	ldr	r1,.Lj25
	add	r1,r0
	mov	r2,#65
	ldr	r0,.Lj30
	bl	SYSTEM_$$_MOVE$formal$formal$LONGINT
# [72] size := size + length(HTML_main1);
	add	r0,r13,#28
	ldrh	r0,[r0]
	add	r0,#65
	uxth	r1,r0
	add	r0,r13,#28
	strh	r1,[r0]
# [74] if(strlcomp(rcv+1, 'GET', 3) = 0) then begin
	ldr	r0,[r13, #40]
	add	r0,#1
	mov	r2,#3
	ldr	r1,.Lj31
	bl	STRINGS_$$_STRLCOMP$PCHAR$PCHAR$LONGINT$$LONGINT
	cmp	r0,#0
	bne	.Lj34
	bl	.Lj32
.Lj34:
	bl	.Lj33
.Lj32:
# [75] if(strlcomp(rcv+6,'?Eoff=', 6) = 0) then if IsDigital(rcv[12]) then output_pin[Ord(rcv[12])-$30] := 0;
	ldr	r0,[r13, #40]
	add	r0,#6
	mov	r2,#6
	ldr	r1,.Lj35
	bl	STRINGS_$$_STRLCOMP$PCHAR$PCHAR$LONGINT$$LONGINT
	cmp	r0,#0
	bne	.Lj38
	bl	.Lj36
.Lj38:
	bl	.Lj37
.Lj36:
	ldr	r0,[r13, #40]
	ldrb	r0,[r0, #12]
	bl	UTILS_$$_ISDIGITAL$CHAR$$BOOLEAN
	uxtb	r0,r0
	cmp	r0,#0
	beq	.Lj41
	bl	.Lj39
.Lj41:
	bl	.Lj40
.Lj39:
	ldr	r0,[r13, #40]
	ldrb	r0,[r0, #12]
	sub	r0,#48
	mov	r2,#0
	ldr	r1,.Lj42
	strb	r2,[r0, r1]
.Lj40:
.Lj37:
# [76] if(strlcomp(rcv+6,'?Eon=', 5) = 0) then if IsDigital(rcv[11]) then output_pin[Ord(rcv[11])-$30] := 1;
	ldr	r0,[r13, #40]
	add	r0,#6
	mov	r2,#5
	ldr	r1,.Lj43
	bl	STRINGS_$$_STRLCOMP$PCHAR$PCHAR$LONGINT$$LONGINT
	cmp	r0,#0
	bne	.Lj46
	bl	.Lj44
.Lj46:
	bl	.Lj45
.Lj44:
	ldr	r0,[r13, #40]
	ldrb	r0,[r0, #11]
	bl	UTILS_$$_ISDIGITAL$CHAR$$BOOLEAN
	uxtb	r0,r0
	cmp	r0,#0
	beq	.Lj49
	bl	.Lj47
.Lj49:
	bl	.Lj48
.Lj47:
	ldr	r0,[r13, #40]
	ldrb	r0,[r0, #11]
	sub	r0,#48
	mov	r2,#1
	ldr	r1,.Lj42
	strb	r2,[r0, r1]
.Lj48:
.Lj45:
# [79] if(strlcomp(rcv+6,'program ', 8) = 0) then begin
	ldr	r0,[r13, #40]
	add	r0,#6
	mov	r2,#8
	ldr	r1,.Lj51
	bl	STRINGS_$$_STRLCOMP$PCHAR$PCHAR$LONGINT$$LONGINT
	cmp	r0,#0
	bne	.Lj54
	bl	.Lj52
.Lj54:
	bl	.Lj53
.Lj52:
# [80] page := PagePROGRAM;
	mov	r0,#2
	str	r0,[r13, #44]
.Lj53:
.Lj33:
# [84] j := 0;
	mov	r1,#0
	add	r0,r13,#36
	strh	r1,[r0]
# [85] while (j < data_size) do begin
	bl	.Lj56
.Lj55:
# [86] if (rcv[j] = 'p') AND (rcv[j+1] = 'r') AND (rcv[j+2] = 'g') then begin
	ldr	r1,[r13, #40]
	add	r0,r13,#36
	ldrh	r0,[r0]
	ldrb	r0,[r1, r0]
	cmp	r0,#112
	bne	.Lj60
	bl	.Lj58
.Lj60:
	bl	.Lj59
.Lj58:
	ldr	r1,[r13, #40]
	add	r0,r13,#36
	ldrh	r0,[r0]
	add	r0,#1
	ldrb	r0,[r1, r0]
	cmp	r0,#114
	bne	.Lj62
	bl	.Lj61
.Lj62:
	bl	.Lj59
.Lj61:
	ldr	r1,[r13, #40]
	add	r0,r13,#36
	ldrh	r0,[r0]
	add	r0,#2
	ldrb	r0,[r1, r0]
	cmp	r0,#103
	bne	.Lj64
	bl	.Lj63
.Lj64:
	bl	.Lj59
.Lj63:
# [87] ClrPins(GPIO_Port_0, GPIO_Pin_3);
	mov	r1,#8
	mov	r0,#0
	bl	UTILS_$$_CLRPINS$BYTE$WORD
# [88] move(rcv[j+4], UserSript[1], data_size-(j+5));
	add	r0,r13,#36
	ldrh	r0,[r0]
	mov	r1,r0
	add	r1,#5
	add	r0,r13,#24
	ldrh	r2,[r0]
	sub	r2,r1
	ldr	r1,[r13, #40]
	add	r0,r13,#36
	ldrh	r0,[r0]
	add	r0,#4
	add	r0,r1
	ldr	r1,.Lj65
	bl	SYSTEM_$$_MOVE$formal$formal$LONGINT
# [89] UserSript_Size := data_size-(j+5);
	add	r0,r13,#36
	ldrh	r0,[r0]
	mov	r1,r0
	add	r1,#5
	add	r0,r13,#24
	ldrh	r0,[r0]
	sub	r0,r1
	uxth	r1,r0
	ldr	r0,.Lj66
	strh	r1,[r0]
# [91] Script_Scanner(UserSript, UserSript_Size, ilProgram, ilProgram_Size);
	ldr	r2,.Lj67
	ldr	r0,.Lj68
	ldr	r3,.Lj69
	ldr	r1,.Lj66
	ldrh	r1,[r1]
	bl	IL_INTERPRETER_$$_SCRIPT_SCANNER$PCHAR$WORD$PBYTE$WORD
# [92] break;
	bl	.Lj57
.Lj59:
# [94] inc(j);
	add	r0,r13,#36
	ldrh	r0,[r0]
	add	r0,#1
	uxth	r0,r0
	add	r1,r13,#36
	strh	r0,[r1]
.Lj56:
	add	r0,r13,#36
	ldrh	r1,[r0]
	add	r0,r13,#24
	ldrh	r0,[r0]
	cmp	r1,r0
	bcs	.Lj71
	bl	.Lj55
.Lj71:
	bl	.Lj57
.Lj57:
# [97] if page = PageMain then begin
	ldr	r0,[r13, #44]
	cmp	r0,#0
	bne	.Lj74
	bl	.Lj72
.Lj74:
	bl	.Lj73
.Lj72:
# [98] move(HTML_main2, snd_buff[size], length(HTML_main2));
	add	r0,r13,#28
	ldrh	r0,[r0]
	ldr	r1,.Lj25
	add	r1,r0
	mov	r2,#44
	ldr	r0,.Lj76
	bl	SYSTEM_$$_MOVE$formal$formal$LONGINT
# [99] size := size + length(HTML_main2);
	add	r0,r13,#28
	ldrh	r0,[r0]
	add	r0,#44
	uxth	r1,r0
	add	r0,r13,#28
	strh	r1,[r0]
# [100] num:= IntToStr(Socket_TCPClientNum());
	bl	ETHERNET_IP_TCP_$$_SOCKET_TCPCLIENTNUM$$LONGWORD
	mov	r1,r0
	add	r0,r13,#12
	bl	UTILS_$$_INTTOSTR$LONGINT$$ANSISTRING
# [101] move(num[1], snd_buff[size], length(num));
	ldr	r0,[r13, #12]
	cmp	r0,#0
	bne	.Lj78
	bl	.Lj77
.Lj78:
	ldr	r1,.Lj79
	ldr	r0,[r0, r1]
.Lj77:
	mov	r2,r0
	add	r0,r13,#28
	ldrh	r0,[r0]
	ldr	r1,.Lj25
	add	r1,r0
	ldr	r0,[r13, #12]
	bl	SYSTEM_$$_MOVE$formal$formal$LONGINT
# [102] size := size + length(num);
	ldr	r1,[r13, #12]
	cmp	r1,#0
	bne	.Lj82
	bl	.Lj81
.Lj82:
	ldr	r0,.Lj79
	ldr	r1,[r1, r0]
.Lj81:
	add	r0,r13,#28
	ldrh	r0,[r0]
	add	r0,r1
	uxth	r1,r0
	add	r0,r13,#28
	strh	r1,[r0]
# [104] pin := '</td></tr><tr><td>Inputs:</td></tr><tr><td>';
	add	r0,r13,#16
	ldr	r1,.Lj84
	bl	fpc_ansistr_assign
# [105] move(pin[1], snd_buff[size], length(pin));
	ldr	r0,[r13, #16]
	cmp	r0,#0
	bne	.Lj86
	bl	.Lj85
.Lj86:
	ldr	r1,.Lj79
	ldr	r0,[r0, r1]
.Lj85:
	mov	r2,r0
	add	r0,r13,#28
	ldrh	r0,[r0]
	ldr	r1,.Lj25
	add	r1,r0
	ldr	r0,[r13, #16]
	bl	SYSTEM_$$_MOVE$formal$formal$LONGINT
# [106] size := size + length(pin);
	ldr	r1,[r13, #16]
	cmp	r1,#0
	bne	.Lj90
	bl	.Lj89
.Lj90:
	ldr	r0,.Lj79
	ldr	r1,[r1, r0]
.Lj89:
	add	r0,r13,#28
	ldrh	r0,[r0]
	add	r0,r1
	uxth	r0,r0
# [160] end;
	b	.Lj203
	.balign 4
.Lj25:
	.long	U_$P$PROJECT_ETH_$$_SND_BUFF
.Lj26:
	.long	_$PROJECT_ETH$_Ld1
.Lj28:
	.long	_$PROJECT_ETH$_Ld2
.Lj30:
	.long	_$PROJECT_ETH$_Ld3
.Lj31:
	.long	_$PROJECT_ETH$_Ld4
.Lj35:
	.long	_$PROJECT_ETH$_Ld5
.Lj42:
	.long	U_$P$PROJECT_ETH_$$_OUTPUT_PIN
.Lj43:
	.long	_$PROJECT_ETH$_Ld6
.Lj51:
	.long	_$PROJECT_ETH$_Ld7
.Lj65:
	.long	U_$IL_INTERPRETER_$$_USERSRIPT+1
.Lj66:
	.long	U_$IL_INTERPRETER_$$_USERSRIPT_SIZE
.Lj67:
	.long	U_$IL_INTERPRETER_$$_ILPROGRAM
.Lj68:
	.long	U_$IL_INTERPRETER_$$_USERSRIPT
.Lj69:
	.long	U_$IL_INTERPRETER_$$_ILPROGRAM_SIZE
.Lj76:
	.long	_$PROJECT_ETH$_Ld8
.Lj79:
	.long	-4
.Lj84:
	.long	.Ld9
.Lj203:
	add	r1,r13,#28
	strh	r0,[r1]
# [107] for i := 0 to 3 do begin
	ldr	r0,.Lj92
	add	r1,r13,#32
	strh	r0,[r1]
.Lj93:
	add	r0,r13,#32
	ldrh	r0,[r0]
	add	r0,#1
	uxth	r0,r0
	add	r1,r13,#32
	strh	r0,[r1]
# [108] if (input_pin[i] = 1) then
	add	r0,r13,#32
	ldrh	r1,[r0]
	ldr	r0,.Lj96
	ldrb	r0,[r1, r0]
	cmp	r0,#1
	bne	.Lj99
	bl	.Lj97
.Lj99:
	bl	.Lj98
.Lj97:
# [109] pin := '1  '
	add	r0,r13,#16
	ldr	r1,.Lj100
	bl	fpc_ansistr_assign
	bl	.Lj101
.Lj98:
# [111] pin := '0  ';
	add	r0,r13,#16
	ldr	r1,.Lj102
	bl	fpc_ansistr_assign
.Lj101:
# [112] move(pin[1], snd_buff[size], length(pin));
	ldr	r0,[r13, #16]
	cmp	r0,#0
	bne	.Lj104
	bl	.Lj103
.Lj104:
	ldr	r1,.Lj105
	ldr	r0,[r0, r1]
.Lj103:
	mov	r2,r0
	add	r0,r13,#28
	ldrh	r0,[r0]
	ldr	r1,.Lj106
	add	r1,r0
	ldr	r0,[r13, #16]
	bl	SYSTEM_$$_MOVE$formal$formal$LONGINT
# [113] size := size + length(pin);
	ldr	r1,[r13, #16]
	cmp	r1,#0
	bne	.Lj108
	bl	.Lj107
.Lj108:
	ldr	r0,.Lj105
	ldr	r1,[r1, r0]
.Lj107:
	add	r0,r13,#28
	ldrh	r0,[r0]
	add	r0,r1
	uxth	r1,r0
	add	r0,r13,#28
	strh	r1,[r0]
	add	r0,r13,#32
	ldrh	r0,[r0]
	cmp	r0,#3
	bcc	.Lj110
	bl	.Lj95
.Lj110:
	bl	.Lj93
.Lj95:
# [115] pin := '</td></tr>';
	add	r0,r13,#16
	ldr	r1,.Lj111
	bl	fpc_ansistr_assign
# [116] move(pin[1], snd_buff[size], length(pin));
	ldr	r0,[r13, #16]
	cmp	r0,#0
	bne	.Lj113
	bl	.Lj112
.Lj113:
	ldr	r1,.Lj105
	ldr	r0,[r0, r1]
.Lj112:
	mov	r2,r0
	add	r0,r13,#28
	ldrh	r0,[r0]
	ldr	r1,.Lj106
	add	r1,r0
	ldr	r0,[r13, #16]
	bl	SYSTEM_$$_MOVE$formal$formal$LONGINT
# [117] size := size + length(pin);
	ldr	r1,[r13, #16]
	cmp	r1,#0
	bne	.Lj117
	bl	.Lj116
.Lj117:
	ldr	r0,.Lj105
	ldr	r1,[r1, r0]
.Lj116:
	add	r0,r13,#28
	ldrh	r0,[r0]
	add	r0,r1
	uxth	r0,r0
	add	r1,r13,#28
	strh	r0,[r1]
# [119] pin := '<tr><td>Outputs:</td></tr><tr><td>';
	add	r0,r13,#16
	ldr	r1,.Lj119
	bl	fpc_ansistr_assign
# [120] move(pin[1], snd_buff[size], length(pin));
	ldr	r0,[r13, #16]
	cmp	r0,#0
	bne	.Lj121
	bl	.Lj120
.Lj121:
	ldr	r1,.Lj105
	ldr	r0,[r0, r1]
.Lj120:
	mov	r2,r0
	add	r0,r13,#28
	ldrh	r0,[r0]
	ldr	r1,.Lj106
	add	r1,r0
	ldr	r0,[r13, #16]
	bl	SYSTEM_$$_MOVE$formal$formal$LONGINT
# [121] size := size + length(pin);
	ldr	r1,[r13, #16]
	cmp	r1,#0
	bne	.Lj125
	bl	.Lj124
.Lj125:
	ldr	r0,.Lj105
	ldr	r1,[r1, r0]
.Lj124:
	add	r0,r13,#28
	ldrh	r0,[r0]
	add	r0,r1
	uxth	r0,r0
	add	r1,r13,#28
	strh	r0,[r1]
# [122] for i := 0 to 3 do begin
	ldr	r1,.Lj92
	add	r0,r13,#32
	strh	r1,[r0]
.Lj128:
	add	r0,r13,#32
	ldrh	r0,[r0]
	add	r0,#1
	uxth	r0,r0
	add	r1,r13,#32
	strh	r0,[r1]
# [123] if (output_pin[i] = 0) then
	add	r0,r13,#32
	ldrh	r0,[r0]
	ldr	r1,.Lj131
	ldrb	r0,[r0, r1]
	cmp	r0,#0
	bne	.Lj134
	bl	.Lj132
.Lj134:
	bl	.Lj133
.Lj132:
# [124] pin := '<a href="?Eon='+Char(i+$30)+'" >  OFF  </a>'
	ldr	r0,.Lj135
	str	r0,[r13, #104]
	add	r0,r13,#32
	ldrh	r0,[r0]
	add	r0,#48
	uxtb	r0,r0
	uxtb	r1,r0
	mov	r2,#0
	add	r0,r13,#116
	bl	fpc_char_to_ansistr
	ldr	r0,[r13, #116]
	str	r0,[r13, #108]
	ldr	r0,.Lj136
	str	r0,[r13, #112]
	add	r1,r13,#104
	add	r0,r13,#16
	mov	r3,#0
	mov	r2,#2
	bl	fpc_ansistr_concat_multi
	bl	.Lj137
.Lj133:
# [126] pin := '<a href="?Eoff='+Char(i+$30)+'" >  ON  </a>';
	ldr	r0,.Lj138
	str	r0,[r13, #104]
	add	r0,r13,#32
	ldrh	r0,[r0]
	add	r0,#48
	uxtb	r0,r0
	uxtb	r1,r0
	mov	r2,#0
	add	r0,r13,#116
	bl	fpc_char_to_ansistr
	ldr	r0,[r13, #116]
	str	r0,[r13, #108]
	ldr	r0,.Lj139
	str	r0,[r13, #112]
	add	r1,r13,#104
	add	r0,r13,#16
	mov	r3,#0
	mov	r2,#2
	bl	fpc_ansistr_concat_multi
.Lj137:
# [127] move(pin[1], snd_buff[size], length(pin));
	ldr	r0,[r13, #16]
	cmp	r0,#0
	bne	.Lj141
	bl	.Lj140
.Lj141:
	ldr	r1,.Lj105
	ldr	r0,[r0, r1]
.Lj140:
	mov	r2,r0
	add	r0,r13,#28
	ldrh	r0,[r0]
	ldr	r1,.Lj106
	add	r1,r0
	ldr	r0,[r13, #16]
	bl	SYSTEM_$$_MOVE$formal$formal$LONGINT
# [128] size := size + length(pin);
	ldr	r1,[r13, #16]
	cmp	r1,#0
	bne	.Lj145
	bl	.Lj144
.Lj145:
	ldr	r0,.Lj105
	ldr	r1,[r1, r0]
.Lj144:
	add	r0,r13,#28
	ldrh	r0,[r0]
	add	r0,r1
	uxth	r0,r0
	add	r1,r13,#28
	strh	r0,[r1]
	add	r0,r13,#32
	ldrh	r0,[r0]
	cmp	r0,#3
	bcc	.Lj147
	bl	.Lj130
.Lj147:
	bl	.Lj128
.Lj130:
# [130] pin := '</td></tr>';
	add	r0,r13,#16
	ldr	r1,.Lj111
	bl	fpc_ansistr_assign
# [131] move(pin[1], snd_buff[size], length(pin));
	ldr	r0,[r13, #16]
	cmp	r0,#0
	bne	.Lj150
	bl	.Lj149
.Lj150:
	ldr	r1,.Lj105
	ldr	r0,[r0, r1]
.Lj149:
	mov	r2,r0
	add	r0,r13,#28
	ldrh	r0,[r0]
	ldr	r1,.Lj106
	add	r1,r0
	ldr	r0,[r13, #16]
	bl	SYSTEM_$$_MOVE$formal$formal$LONGINT
# [132] size := size + length(pin);
	ldr	r1,[r13, #16]
	cmp	r1,#0
	bne	.Lj154
	bl	.Lj153
.Lj154:
	ldr	r0,.Lj105
	ldr	r1,[r1, r0]
.Lj153:
	add	r0,r13,#28
	ldrh	r0,[r0]
	add	r0,r1
	uxth	r1,r0
	add	r0,r13,#28
	strh	r1,[r0]
# [133] move(HTML_main3, snd_buff[size], length(HTML_main3));
	add	r0,r13,#28
	ldrh	r0,[r0]
	ldr	r1,.Lj106
	add	r1,r0
	mov	r2,#54
	ldr	r0,.Lj157
	bl	SYSTEM_$$_MOVE$formal$formal$LONGINT
# [134] size := size + length(HTML_main3);
	add	r0,r13,#28
	ldrh	r0,[r0]
	add	r0,#54
	uxth	r1,r0
	add	r0,r13,#28
	strh	r1,[r0]
.Lj73:
# [137] if page = PagePROGRAM then begin
	ldr	r0,[r13, #44]
	cmp	r0,#2
	bne	.Lj160
	bl	.Lj158
.Lj160:
	bl	.Lj159
.Lj158:
# [138] tmp := '<form action="/programsave" method="post" enctype="text/plain">';
	add	r0,r13,#20
	ldr	r1,.Lj161
	bl	fpc_ansistr_assign
# [139] move(tmp[1], snd_buff[size], length(tmp));
	ldr	r0,[r13, #20]
	cmp	r0,#0
	bne	.Lj163
	bl	.Lj162
.Lj163:
	ldr	r1,.Lj105
	b	.Lj204
	.balign 4
.Lj92:
	.long	65535
.Lj96:
	.long	U_$P$PROJECT_ETH_$$_INPUT_PIN
.Lj100:
	.long	.Ld10
.Lj102:
	.long	.Ld11
.Lj105:
	.long	-4
.Lj106:
	.long	U_$P$PROJECT_ETH_$$_SND_BUFF
.Lj111:
	.long	.Ld12
.Lj119:
	.long	.Ld13
.Lj131:
	.long	U_$P$PROJECT_ETH_$$_OUTPUT_PIN
.Lj135:
	.long	.Ld14
.Lj136:
	.long	.Ld15
.Lj138:
	.long	.Ld16
.Lj139:
	.long	.Ld17
.Lj157:
	.long	_$PROJECT_ETH$_Ld18
.Lj161:
	.long	.Ld19
.Lj204:
	ldr	r0,[r0, r1]
.Lj162:
	mov	r2,r0
	add	r0,r13,#28
	ldrh	r0,[r0]
	ldr	r1,.Lj165
	add	r1,r0
	ldr	r0,[r13, #20]
	bl	SYSTEM_$$_MOVE$formal$formal$LONGINT
# [140] size := size + length(tmp);
	ldr	r1,[r13, #20]
	cmp	r1,#0
	bne	.Lj167
	bl	.Lj166
.Lj167:
	ldr	r0,.Lj168
	ldr	r1,[r1, r0]
.Lj166:
	add	r0,r13,#28
	ldrh	r0,[r0]
	add	r0,r1
	uxth	r1,r0
	add	r0,r13,#28
	strh	r1,[r0]
# [141] tmp := '<table><tr><td>Program:</td></tr>';
	add	r0,r13,#20
	ldr	r1,.Lj169
	bl	fpc_ansistr_assign
# [142] move(tmp[1], snd_buff[size], length(tmp));
	ldr	r0,[r13, #20]
	cmp	r0,#0
	bne	.Lj171
	bl	.Lj170
.Lj171:
	ldr	r1,.Lj168
	ldr	r0,[r0, r1]
.Lj170:
	mov	r2,r0
	add	r0,r13,#28
	ldrh	r0,[r0]
	ldr	r1,.Lj165
	add	r1,r0
	ldr	r0,[r13, #20]
	bl	SYSTEM_$$_MOVE$formal$formal$LONGINT
# [143] size := size + length(tmp);
	ldr	r1,[r13, #20]
	cmp	r1,#0
	bne	.Lj175
	bl	.Lj174
.Lj175:
	ldr	r0,.Lj168
	ldr	r1,[r1, r0]
.Lj174:
	add	r0,r13,#28
	ldrh	r0,[r0]
	add	r0,r1
	uxth	r1,r0
	add	r0,r13,#28
	strh	r1,[r0]
# [144] tmp := '<tr><td><textarea name="prg" rows="10" cols="50">';
	add	r0,r13,#20
	ldr	r1,.Lj177
	bl	fpc_ansistr_assign
# [145] move(tmp[1], snd_buff[size], length(tmp));
	ldr	r0,[r13, #20]
	cmp	r0,#0
	bne	.Lj179
	bl	.Lj178
.Lj179:
	ldr	r1,.Lj168
	ldr	r0,[r0, r1]
.Lj178:
	mov	r2,r0
	add	r0,r13,#28
	ldrh	r0,[r0]
	ldr	r1,.Lj165
	add	r1,r0
	ldr	r0,[r13, #20]
	bl	SYSTEM_$$_MOVE$formal$formal$LONGINT
# [146] size := size + length(tmp);
	ldr	r1,[r13, #20]
	cmp	r1,#0
	bne	.Lj183
	bl	.Lj182
.Lj183:
	ldr	r0,.Lj168
	ldr	r1,[r1, r0]
.Lj182:
	add	r0,r13,#28
	ldrh	r0,[r0]
	add	r0,r1
	uxth	r0,r0
	add	r1,r13,#28
	strh	r0,[r1]
# [148] if(UserSript_Size > 0) then begin
	ldr	r0,.Lj185
	ldrh	r0,[r0]
	cmp	r0,#0
	bls	.Lj188
	bl	.Lj186
.Lj188:
	bl	.Lj187
.Lj186:
# [149] move(UserSript[1], snd_buff[size], UserSript_Size);
	ldr	r0,.Lj185
	ldrh	r2,[r0]
	add	r0,r13,#28
	ldrh	r0,[r0]
	ldr	r1,.Lj165
	add	r1,r0
	ldr	r0,.Lj191
	bl	SYSTEM_$$_MOVE$formal$formal$LONGINT
# [150] size := size + UserSript_Size;
	ldr	r0,.Lj185
	ldrh	r1,[r0]
	add	r0,r13,#28
	ldrh	r0,[r0]
	add	r0,r1
	uxth	r0,r0
	add	r1,r13,#28
	strh	r0,[r1]
.Lj187:
# [153] tmp := '</textarea></td></tr><tr><td><input type="submit" value="Save"></td></tr></table></form>';
	add	r0,r13,#20
	ldr	r1,.Lj193
	bl	fpc_ansistr_assign
# [154] move(tmp[1], snd_buff[size], length(tmp));
	ldr	r0,[r13, #20]
	cmp	r0,#0
	bne	.Lj195
	bl	.Lj194
.Lj195:
	ldr	r1,.Lj168
	ldr	r0,[r0, r1]
.Lj194:
	mov	r2,r0
	add	r0,r13,#28
	ldrh	r0,[r0]
	ldr	r1,.Lj165
	add	r1,r0
	ldr	r0,[r13, #20]
	bl	SYSTEM_$$_MOVE$formal$formal$LONGINT
# [155] size := size + length(tmp);
	ldr	r1,[r13, #20]
	cmp	r1,#0
	bne	.Lj199
	bl	.Lj198
.Lj199:
	ldr	r0,.Lj168
	ldr	r1,[r1, r0]
.Lj198:
	add	r0,r13,#28
	ldrh	r0,[r0]
	add	r0,r1
	uxth	r0,r0
	add	r1,r13,#28
	strh	r0,[r1]
.Lj159:
# [158] SocketSendData(tcb_id, @snd_buff[0], size);
	ldr	r1,.Lj165
	add	r0,r13,#28
	ldrh	r2,[r0]
	mov	r0,r13
	ldrb	r0,[r0]
	bl	ETHERNET_$$_SOCKETSENDDATA$BYTE$PBYTE$WORD
# [159] SocketClose(tcb_id);
	mov	r0,r13
	ldrb	r0,[r0]
	bl	ETHERNET_$$_SOCKETCLOSE$BYTE
.Lj22:
	bl	fpc_popaddrstack
	add	r0,r13,#116
	bl	fpc_ansistr_decr_ref
	add	r0,r13,#12
	bl	fpc_ansistr_decr_ref
	add	r0,r13,#16
	bl	fpc_ansistr_decr_ref
	add	r0,r13,#20
	bl	fpc_ansistr_decr_ref
	ldr	r0,[r13, #100]
	cmp	r0,#0
	bne	.Lj202
	bl	.Lj21
.Lj202:
	bl	fpc_reraise
	mov	r0,#0
	str	r0,[r13, #100]
	bl	.Lj22
.Lj21:
	add	r13,r13,#160
	pop	{r15}
.Lc7:
	.balign 4
.Lj165:
	.long	U_$P$PROJECT_ETH_$$_SND_BUFF
.Lj168:
	.long	-4
.Lj169:
	.long	.Ld20
.Lj177:
	.long	.Ld21
.Lj185:
	.long	U_$IL_INTERPRETER_$$_USERSRIPT_SIZE
.Lj191:
	.long	U_$IL_INTERPRETER_$$_USERSRIPT+1
.Lj193:
	.long	.Ld22
.Le3:
	.size	P$PROJECT_ETH_$$_SERVER_RECV80$BYTE$PBYTE$WORD, .Le3 - P$PROJECT_ETH_$$_SERVER_RECV80$BYTE$PBYTE$WORD

.section .text.n_main,"ax"
	.balign 4
.thumb_func 
.globl	main
main:
.thumb_func 
.globl	PASCALMAIN
PASCALMAIN:
.Lc10:
.Lc11:
# [162] begin
	push	{r14}
	sub	r13,r13,#32
	bl	fpc_initializeunits
# [164] SystemInit();
	bl	SYSTEM_LPC1114_$$_SYSTEMINIT
# [165] LPC_SYSCON.SYSAHBCLKCTRL := LPC_SYSCON.SYSAHBCLKCTRL or ((1 shl GPIO_SYSAHBCLKDIV_BIT) or (1 shl IOCON_SYSAHBCLKCTRL_BIT));
	ldr	r0,.Lj205
	ldr	r0,[r0]
	mov	r1,r0
	ldr	r0,.Lj206
	orr	r1,r0
	ldr	r0,.Lj205
	str	r1,[r0]
# [168] Delay_Init();
	bl	DELAY_$$_DELAY_INIT
# [171] SPI_Init(SPI0, SCK0_2_11);
	mov	r1,#1
	mov	r0,#0
	bl	SPI_$$_SPI_INIT$BYTE$BYTE
# [174] SetOutputs(GPIO_Port_2, GPIO_Pin_1);
	mov	r1,#2
	mov	r0,#2
	bl	UTILS_$$_SETOUTPUTS$BYTE$WORD
# [175] SetOutputs(GPIO_Port_1, GPIO_Pin_8);
	ldr	r1,.Lj208
	mov	r0,#1
	bl	UTILS_$$_SETOUTPUTS$BYTE$WORD
# [176] SetOutputs(GPIO_Port_0, GPIO_Pin_3);
	mov	r1,#8
	mov	r0,#0
	bl	UTILS_$$_SETOUTPUTS$BYTE$WORD
# [179] ENC28J60_CS_OUTPUT;
	bl	ENC28J60_$$_ENC28J60_CS_OUTPUT
# [180] ENC28J60_CS_ON;
	bl	ENC28J60_$$_ENC28J60_CS_ON
# [183] ENC28J60_Init(PByte(MACADDR));
	ldr	r0,.Lj209
	ldr	r0,[r0]
	bl	ENC28J60_$$_ENC28J60_INIT$PBYTE
# [185] ENC28J60_PhyWrite(PHLCON, $746); //0x746
	ldr	r1,.Lj210
	mov	r0,#20
	bl	ENC28J60_$$_ENC28J60_PHYWRITE$BYTE$WORD
# [186] InitTCB();
	bl	ETHERNET_IP_TCP_$$_INITTCB
# [189] SysTick_Config(48000000 div 100);
	ldr	r0,.Lj211
	bl	SYSTEM_LPC1114_$$_SYSTICK_CONFIG$LONGWORD$$LONGWORD
# [191] Conf_Output_Ports();
	bl	P$PROJECT_ETH_$$_CONF_OUTPUT_PORTS
# [192] Conf_Input_Ports();
	bl	P$PROJECT_ETH_$$_CONF_INPUT_PORTS
# [194] Socket_Create(@Server80, IPV4_TYPE_TCP);
	ldr	r0,.Lj212
	mov	r1,#6
	bl	ETHERNET_$$_SOCKET_CREATE$PSOCKET$BYTE
# [195] Socket_Bind(@Server80, 80);
	ldr	r0,.Lj212
	mov	r1,#80
	bl	ETHERNET_$$_SOCKET_BIND$PSOCKET$WORD
# [196] Socket_Listen(@Server80);
	ldr	r0,.Lj212
	bl	ETHERNET_$$_SOCKET_LISTEN$PSOCKET$$BOOLEAN
# [197] SocketSetFunction(@server80, @server_recv80);
	ldr	r1,.Lj215
	ldr	r0,.Lj212
	bl	ETHERNET_$$_SOCKETSETFUNCTION$PSOCKET$TRECV_FUNCTION
# [199] Set_Inputs(input_pin);
	ldr	r0,.Lj217
	bl	IL_INTERPRETER_$$_SET_INPUTS$PBYTE
# [200] Set_Outputs(output_pin);
	ldr	r0,.Lj218
	bl	IL_INTERPRETER_$$_SET_OUTPUTS$PBYTE
# [201] Interpreter_Run := True;
	mov	r1,#1
	ldr	r0,.Lj219
	strb	r1,[r0]
# [203] while true do
	bl	.Lj221
.Lj220:
# [205] SetPins(GPIO_Port_2, GPIO_Pin_1);
	mov	r1,#2
	mov	r0,#2
	bl	UTILS_$$_SETPINS$BYTE$WORD
# [207] SocketProcess(data_buf);
	ldr	r0,.Lj223
	bl	ETHERNET_$$_SOCKETPROCESS$PBYTE
# [209] if PinSense(GPIO_Port_3, GPIO_Pin_3) = True then input_pin[0] := 1 else input_pin[0] := 0;  // in 1
	mov	r1,#8
	mov	r0,#3
	bl	UTILS_$$_PINSENSE$BYTE$WORD$$BOOLEAN
	uxtb	r0,r0
	cmp	r0,#0
	beq	.Lj226
	bl	.Lj224
.Lj226:
	bl	.Lj225
.Lj224:
	mov	r0,#1
	ldr	r1,.Lj217
	strb	r0,[r1]
	bl	.Lj228
.Lj225:
	mov	r0,#0
	ldr	r1,.Lj217
	strb	r0,[r1]
.Lj228:
# [210] if PinSense(GPIO_Port_3, GPIO_Pin_2) = True then input_pin[1] := 1 else input_pin[1] := 0;  // in 2
	mov	r1,#4
	mov	r0,#3
	bl	UTILS_$$_PINSENSE$BYTE$WORD$$BOOLEAN
	uxtb	r0,r0
	cmp	r0,#0
	beq	.Lj232
	bl	.Lj230
.Lj232:
	bl	.Lj231
.Lj230:
	mov	r0,#1
	ldr	r1,.Lj233
	strb	r0,[r1]
	bl	.Lj234
.Lj231:
	mov	r1,#0
	ldr	r0,.Lj233
	strb	r1,[r0]
.Lj234:
# [211] if PinSense(GPIO_Port_1, GPIO_Pin_4) = True then input_pin[2] := 1 else input_pin[2] := 0;  // in 3
	mov	r1,#16
	mov	r0,#1
	bl	UTILS_$$_PINSENSE$BYTE$WORD$$BOOLEAN
	uxtb	r0,r0
	cmp	r0,#0
	beq	.Lj238
	bl	.Lj236
.Lj238:
	bl	.Lj237
.Lj236:
	mov	r0,#1
	ldr	r1,.Lj239
	strb	r0,[r1]
	bl	.Lj240
.Lj237:
	mov	r0,#0
	ldr	r1,.Lj239
	strb	r0,[r1]
.Lj240:
# [212] if PinSense(GPIO_Port_1, GPIO_Pin_11) = True then input_pin[3] := 1 else input_pin[3] := 0; // in 4
	ldr	r1,.Lj242
	mov	r0,#1
	bl	UTILS_$$_PINSENSE$BYTE$WORD$$BOOLEAN
	uxtb	r0,r0
	cmp	r0,#0
	beq	.Lj245
	bl	.Lj243
.Lj245:
	bl	.Lj244
.Lj243:
	mov	r1,#1
	ldr	r0,.Lj246
	strb	r1,[r0]
	bl	.Lj247
.Lj244:
	mov	r1,#0
	ldr	r0,.Lj246
	strb	r1,[r0]
.Lj247:
# [215] Interpreter_Loop();
	bl	IL_INTERPRETER_$$_INTERPRETER_LOOP
# [217] if output_pin[0] = 1 then ClrPins(GPIO_Port_1, GPIO_Pin_1) else SetPins(GPIO_Port_1, GPIO_Pin_1); // out 1
	ldr	r0,.Lj218
	ldrb	r0,[r0]
	cmp	r0,#1
	bne	.Lj252
	bl	.Lj250
.Lj252:
	bl	.Lj251
.Lj250:
	mov	r1,#2
	mov	r0,#1
	bl	UTILS_$$_CLRPINS$BYTE$WORD
	bl	.Lj253
.Lj251:
	mov	r1,#2
	mov	r0,#1
	bl	UTILS_$$_SETPINS$BYTE$WORD
.Lj253:
# [218] if output_pin[1] = 1 then ClrPins(GPIO_Port_1, GPIO_Pin_2) else SetPins(GPIO_Port_1, GPIO_Pin_2); // out 2
	ldr	r0,.Lj254
	ldrb	r0,[r0]
	cmp	r0,#1
	bne	.Lj257
	bl	.Lj255
.Lj257:
	bl	.Lj256
.Lj255:
	mov	r1,#4
	mov	r0,#1
	bl	UTILS_$$_CLRPINS$BYTE$WORD
	bl	.Lj258
.Lj256:
	mov	r1,#4
	mov	r0,#1
	bl	UTILS_$$_SETPINS$BYTE$WORD
.Lj258:
# [219] if output_pin[2] = 1 then ClrPins(GPIO_Port_3, GPIO_Pin_1) else SetPins(GPIO_Port_3, GPIO_Pin_1); // out 3
	ldr	r0,.Lj259
	ldrb	r0,[r0]
	cmp	r0,#1
	bne	.Lj262
	bl	.Lj260
.Lj262:
	bl	.Lj261
.Lj260:
	mov	r1,#2
	mov	r0,#3
	bl	UTILS_$$_CLRPINS$BYTE$WORD
	bl	.Lj263
.Lj261:
	mov	r1,#2
	mov	r0,#3
	bl	UTILS_$$_SETPINS$BYTE$WORD
.Lj263:
# [220] if output_pin[3] = 1 then ClrPins(GPIO_Port_2, GPIO_Pin_3) else SetPins(GPIO_Port_2, GPIO_Pin_3); // out 4
	ldr	r0,.Lj264
	ldrb	r0,[r0]
	cmp	r0,#1
	bne	.Lj267
	bl	.Lj265
.Lj267:
	bl	.Lj266
.Lj265:
	mov	r1,#8
	mov	r0,#2
	bl	UTILS_$$_CLRPINS$BYTE$WORD
	bl	.Lj268
.Lj266:
	mov	r1,#8
	mov	r0,#2
	bl	UTILS_$$_SETPINS$BYTE$WORD
.Lj268:
# [222] ClrPins(GPIO_Port_2, GPIO_Pin_1);
	mov	r1,#2
	mov	r0,#2
	bl	UTILS_$$_CLRPINS$BYTE$WORD
.Lj221:
	bl	.Lj220
# [225] end.
	bl	fpc_do_exit
	add	r13,r13,#32
	pop	{r15}
.Lc9:
	.balign 4
.Lj205:
	.long	1074036864
.Lj206:
	.long	65600
.Lj208:
	.long	256
.Lj209:
	.long	TC_$ETHERNET_$$_MACADDR
.Lj210:
	.long	1862
.Lj211:
	.long	480000
.Lj212:
	.long	U_$P$PROJECT_ETH_$$_SERVER80
.Lj215:
	.long	P$PROJECT_ETH_$$_SERVER_RECV80$BYTE$PBYTE$WORD
.Lj217:
	.long	U_$P$PROJECT_ETH_$$_INPUT_PIN
.Lj218:
	.long	U_$P$PROJECT_ETH_$$_OUTPUT_PIN
.Lj219:
	.long	U_$IL_INTERPRETER_$$_INTERPRETER_RUN
.Lj223:
	.long	U_$P$PROJECT_ETH_$$_DATA_BUF
.Lj233:
	.long	U_$P$PROJECT_ETH_$$_INPUT_PIN+1
.Lj239:
	.long	U_$P$PROJECT_ETH_$$_INPUT_PIN+2
.Lj242:
	.long	2048
.Lj246:
	.long	U_$P$PROJECT_ETH_$$_INPUT_PIN+3
.Lj254:
	.long	U_$P$PROJECT_ETH_$$_OUTPUT_PIN+1
.Lj259:
	.long	U_$P$PROJECT_ETH_$$_OUTPUT_PIN+2
.Lj264:
	.long	U_$P$PROJECT_ETH_$$_OUTPUT_PIN+3
.Le4:
	.size	main, .Le4 - main
# End asmlist al_procedures
# Begin asmlist al_globals

.section .bss.n_u_$p$project_eth_$$_data_buf,"aw",%nobits
# [16] data_buf : array[0..BUFFER_SIZE] of Byte;
	.size U_$P$PROJECT_ETH_$$_DATA_BUF,1461
U_$P$PROJECT_ETH_$$_DATA_BUF:
	.zero 1461

.section .bss.n_u_$p$project_eth_$$_snd_buff,"aw",%nobits
# [17] snd_buff : array[0..1023] of char;
	.size U_$P$PROJECT_ETH_$$_SND_BUFF,1024
U_$P$PROJECT_ETH_$$_SND_BUFF:
	.zero 1024

.section .bss.n_u_$p$project_eth_$$_server80,"aw",%nobits
	.balign 4
# [18] Server80 : TSocket;
	.size U_$P$PROJECT_ETH_$$_SERVER80,24
U_$P$PROJECT_ETH_$$_SERVER80:
	.zero 24

.section .bss.n_u_$p$project_eth_$$_input_pin,"aw",%nobits
# [19] input_pin, output_pin : array[0..3] of byte;
	.size U_$P$PROJECT_ETH_$$_INPUT_PIN,4
U_$P$PROJECT_ETH_$$_INPUT_PIN:
	.zero 4

.section .bss.n_u_$p$project_eth_$$_output_pin,"aw",%nobits
	.size U_$P$PROJECT_ETH_$$_OUTPUT_PIN,4
U_$P$PROJECT_ETH_$$_OUTPUT_PIN:
	.zero 4

.section .data.n_INITFINAL
	.balign 4
.globl	INITFINAL
INITFINAL:
	.long	4,0,0
	.long	FINALIZE$_$OBJPAS
	.long	INIT$_$HEAPMGR
	.long	0
	.long	INIT$_$ETHERNET_IP_UDP
	.long	0
	.long	INIT$_$ETHERNET
	.long	FINALIZE$_$ETHERNET
# [227] 
.Le5:
	.size	INITFINAL, .Le5 - INITFINAL

.section .data.n_FPC_THREADVARTABLES
	.balign 4
.globl	FPC_THREADVARTABLES
FPC_THREADVARTABLES:
	.long	1
	.long	THREADVARLIST_$SYSTEM$indirect
.Le6:
	.size	FPC_THREADVARTABLES, .Le6 - FPC_THREADVARTABLES

.section .rodata.n_FPC_RESOURCESTRINGTABLES
	.balign 4
.globl	FPC_RESOURCESTRINGTABLES
FPC_RESOURCESTRINGTABLES:
	.long	0
.Le7:
	.size	FPC_RESOURCESTRINGTABLES, .Le7 - FPC_RESOURCESTRINGTABLES

.section .data.n_FPC_WIDEINITTABLES
	.balign 4
.globl	FPC_WIDEINITTABLES
FPC_WIDEINITTABLES:
	.long	0
.Le8:
	.size	FPC_WIDEINITTABLES, .Le8 - FPC_WIDEINITTABLES

.section .data.n_FPC_RESSTRINITTABLES
	.balign 4
.globl	FPC_RESSTRINITTABLES
FPC_RESSTRINITTABLES:
	.long	0
.Le9:
	.size	FPC_RESSTRINITTABLES, .Le9 - FPC_RESSTRINITTABLES

.section .fpc.n_version,"aw"
	.balign 4
__fpc_ident:
	.ascii	"FPC 3.3.1 [2019/12/22] for arm - embedded"
.Le10:
	.size	__fpc_ident, .Le10 - __fpc_ident

.section .data.n___stklen
	.balign 4
.globl	__stklen
__stklen:
	.long	262144
.Le11:
	.size	__stklen, .Le11 - __stklen

.section .data.n___heapsize
	.balign 4
.globl	__heapsize
__heapsize:
	.long	256
.Le12:
	.size	__heapsize, .Le12 - __heapsize

.section .bss.n___fpc_initialheap,"aw",%nobits
	.balign 4
	.globl __fpc_initialheap
	.size __fpc_initialheap,256
__fpc_initialheap:
	.zero 256

.section .data.n___fpc_valgrind
	.balign 4
.globl	__fpc_valgrind
__fpc_valgrind:
	.byte	0
.Le13:
	.size	__fpc_valgrind, .Le13 - __fpc_valgrind
# End asmlist al_globals
# Begin asmlist al_typedconsts

.section .rodata.n__$PROJECT_ETH$_Ld1
	.balign 4
	.thumb_func	
.globl	_$PROJECT_ETH$_Ld1
_$PROJECT_ETH$_Ld1:
	.ascii	"HTTP/1.1 200 OK\012\015Content-Type: text/html\012\015"
	.ascii	"\012\015\000"
.Le14:
	.size	_$PROJECT_ETH$_Ld1, .Le14 - _$PROJECT_ETH$_Ld1

.section .rodata.n__$PROJECT_ETH$_Ld2
	.balign 4
	.thumb_func	
.globl	_$PROJECT_ETH$_Ld2
_$PROJECT_ETH$_Ld2:
	.ascii	"<html><head><title>Web Driver</title></head><body><"
	.ascii	"header><h1>Web Driver</h1>\000"
.Le15:
	.size	_$PROJECT_ETH$_Ld2, .Le15 - _$PROJECT_ETH$_Ld2

.section .rodata.n__$PROJECT_ETH$_Ld3
	.balign 4
	.thumb_func	
.globl	_$PROJECT_ETH$_Ld3
_$PROJECT_ETH$_Ld3:
	.ascii	"<div><a href=\"/\">Start</a> | <a href=\"/program\""
	.ascii	">Program</a></div>\000"
.Le16:
	.size	_$PROJECT_ETH$_Ld3, .Le16 - _$PROJECT_ETH$_Ld3

.section .rodata.n__$PROJECT_ETH$_Ld4
	.balign 4
	.thumb_func	
.globl	_$PROJECT_ETH$_Ld4
_$PROJECT_ETH$_Ld4:
	.ascii	"GET\000"
.Le17:
	.size	_$PROJECT_ETH$_Ld4, .Le17 - _$PROJECT_ETH$_Ld4

.section .rodata.n__$PROJECT_ETH$_Ld5
	.balign 4
	.thumb_func	
.globl	_$PROJECT_ETH$_Ld5
_$PROJECT_ETH$_Ld5:
	.ascii	"?Eoff=\000"
.Le18:
	.size	_$PROJECT_ETH$_Ld5, .Le18 - _$PROJECT_ETH$_Ld5

.section .rodata.n__$PROJECT_ETH$_Ld6
	.balign 4
	.thumb_func	
.globl	_$PROJECT_ETH$_Ld6
_$PROJECT_ETH$_Ld6:
	.ascii	"?Eon=\000"
.Le19:
	.size	_$PROJECT_ETH$_Ld6, .Le19 - _$PROJECT_ETH$_Ld6

.section .rodata.n__$PROJECT_ETH$_Ld7
	.balign 4
	.thumb_func	
.globl	_$PROJECT_ETH$_Ld7
_$PROJECT_ETH$_Ld7:
	.ascii	"program \000"
.Le20:
	.size	_$PROJECT_ETH$_Ld7, .Le20 - _$PROJECT_ETH$_Ld7

.section .rodata.n__$PROJECT_ETH$_Ld8
	.balign 4
	.thumb_func	
.globl	_$PROJECT_ETH$_Ld8
_$PROJECT_ETH$_Ld8:
	.ascii	"<div><table><tbody><tr><td>Clients:</td><td>\000"
.Le21:
	.size	_$PROJECT_ETH$_Ld8, .Le21 - _$PROJECT_ETH$_Ld8

.section .rodata.n_.Ld9
	.balign 4
.Ld9$strlab:
	.short	0,1
	.long	-1,43
.Ld9:
	.ascii	"</td></tr><tr><td>Inputs:</td></tr><tr><td>\000"
.Le22:
	.size	.Ld9$strlab, .Le22 - .Ld9$strlab

.section .rodata.n_.Ld10
	.balign 4
.Ld10$strlab:
	.short	0,1
	.long	-1,3
.Ld10:
	.ascii	"1  \000"
.Le23:
	.size	.Ld10$strlab, .Le23 - .Ld10$strlab

.section .rodata.n_.Ld11
	.balign 4
.Ld11$strlab:
	.short	0,1
	.long	-1,3
.Ld11:
	.ascii	"0  \000"
.Le24:
	.size	.Ld11$strlab, .Le24 - .Ld11$strlab

.section .rodata.n_.Ld12
	.balign 4
.Ld12$strlab:
	.short	0,1
	.long	-1,10
.Ld12:
	.ascii	"</td></tr>\000"
.Le25:
	.size	.Ld12$strlab, .Le25 - .Ld12$strlab

.section .rodata.n_.Ld13
	.balign 4
.Ld13$strlab:
	.short	0,1
	.long	-1,34
.Ld13:
	.ascii	"<tr><td>Outputs:</td></tr><tr><td>\000"
.Le26:
	.size	.Ld13$strlab, .Le26 - .Ld13$strlab

.section .rodata.n_.Ld14
	.balign 4
.Ld14$strlab:
	.short	0,1
	.long	-1,14
.Ld14:
	.ascii	"<a href=\"?Eon=\000"
.Le27:
	.size	.Ld14$strlab, .Le27 - .Ld14$strlab

.section .rodata.n_.Ld15
	.balign 4
.Ld15$strlab:
	.short	0,1
	.long	-1,14
.Ld15:
	.ascii	"\" >  OFF  </a>\000"
.Le28:
	.size	.Ld15$strlab, .Le28 - .Ld15$strlab

.section .rodata.n_.Ld16
	.balign 4
.Ld16$strlab:
	.short	0,1
	.long	-1,15
.Ld16:
	.ascii	"<a href=\"?Eoff=\000"
.Le29:
	.size	.Ld16$strlab, .Le29 - .Ld16$strlab

.section .rodata.n_.Ld17
	.balign 4
.Ld17$strlab:
	.short	0,1
	.long	-1,13
.Ld17:
	.ascii	"\" >  ON  </a>\000"
.Le30:
	.size	.Ld17$strlab, .Le30 - .Ld17$strlab

.section .rodata.n__$PROJECT_ETH$_Ld18
	.balign 4
	.thumb_func	
.globl	_$PROJECT_ETH$_Ld18
_$PROJECT_ETH$_Ld18:
	.ascii	"<td></tr></tbody></table></div></header></body></ht"
	.ascii	"ml>\000"
.Le31:
	.size	_$PROJECT_ETH$_Ld18, .Le31 - _$PROJECT_ETH$_Ld18

.section .rodata.n_.Ld19
	.balign 4
.Ld19$strlab:
	.short	0,1
	.long	-1,63
.Ld19:
	.ascii	"<form action=\"/programsave\" method=\"post\" encty"
	.ascii	"pe=\"text/plain\">\000"
.Le32:
	.size	.Ld19$strlab, .Le32 - .Ld19$strlab

.section .rodata.n_.Ld20
	.balign 4
.Ld20$strlab:
	.short	0,1
	.long	-1,33
.Ld20:
	.ascii	"<table><tr><td>Program:</td></tr>\000"
.Le33:
	.size	.Ld20$strlab, .Le33 - .Ld20$strlab

.section .rodata.n_.Ld21
	.balign 4
.Ld21$strlab:
	.short	0,1
	.long	-1,49
.Ld21:
	.ascii	"<tr><td><textarea name=\"prg\" rows=\"10\" cols=\"5"
	.ascii	"0\">\000"
.Le34:
	.size	.Ld21$strlab, .Le34 - .Ld21$strlab

.section .rodata.n_.Ld22
	.balign 4
.Ld22$strlab:
	.short	0,1
	.long	-1,88
.Ld22:
	.ascii	"</textarea></td></tr><tr><td><input type=\"submit\""
	.ascii	" value=\"Save\"></td></tr></table></form>\000"
.Le35:
	.size	.Ld22$strlab, .Le35 - .Ld22$strlab
# End asmlist al_typedconsts
# Begin asmlist al_rtti

.section .rodata.n_RTTI_$P$PROJECT_ETH_$$_def0000004C
	.balign 4
.globl	RTTI_$P$PROJECT_ETH_$$_def0000004C
RTTI_$P$PROJECT_ETH_$$_def0000004C:
	.byte	12,0,0,0
	.long	0,12,3
	.long	RTTI_$SYSTEM_$$_RAWBYTESTRING$indirect
	.byte	1,0,0,0
	.long	RTTI_$SYSTEM_$$_LONGINT$indirect
.Le36:
	.size	RTTI_$P$PROJECT_ETH_$$_def0000004C, .Le36 - RTTI_$P$PROJECT_ETH_$$_def0000004C

.section .rodata.n_RTTI_$P$PROJECT_ETH_$$_def0000004D
	.balign 4
.globl	RTTI_$P$PROJECT_ETH_$$_def0000004D
RTTI_$P$PROJECT_ETH_$$_def0000004D:
	.byte	12,0,0,0
	.long	0,12,3
	.long	RTTI_$SYSTEM_$$_RAWBYTESTRING$indirect
	.byte	1,0,0,0
	.long	RTTI_$SYSTEM_$$_LONGINT$indirect
.Le37:
	.size	RTTI_$P$PROJECT_ETH_$$_def0000004D, .Le37 - RTTI_$P$PROJECT_ETH_$$_def0000004D
# End asmlist al_rtti
# Begin asmlist al_indirectglobals

.section .rodata.n_RTTI_$P$PROJECT_ETH_$$_def0000004C
	.balign 4
.globl	RTTI_$P$PROJECT_ETH_$$_def0000004C$indirect
RTTI_$P$PROJECT_ETH_$$_def0000004C$indirect:
	.long	RTTI_$P$PROJECT_ETH_$$_def0000004C
.Le38:
	.size	RTTI_$P$PROJECT_ETH_$$_def0000004C$indirect, .Le38 - RTTI_$P$PROJECT_ETH_$$_def0000004C$indirect

.section .rodata.n_RTTI_$P$PROJECT_ETH_$$_def0000004D
	.balign 4
.globl	RTTI_$P$PROJECT_ETH_$$_def0000004D$indirect
RTTI_$P$PROJECT_ETH_$$_def0000004D$indirect:
	.long	RTTI_$P$PROJECT_ETH_$$_def0000004D
.Le39:
	.size	RTTI_$P$PROJECT_ETH_$$_def0000004D$indirect, .Le39 - RTTI_$P$PROJECT_ETH_$$_def0000004D$indirect
# End asmlist al_indirectglobals
# Begin asmlist al_dwarf_frame

.section .debug_frame
.Lc12:
	.long	.Lc14-.Lc13
.Lc13:
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
.Lc14:
	.long	.Lc16-.Lc15
.Lc15:
	.long	.Lc12
	.long	.Lc2
	.long	.Lc1-.Lc2
	.balign 4,0
.Lc16:
	.long	.Lc19-.Lc18
.Lc18:
	.long	.Lc12
	.long	.Lc4
	.long	.Lc3-.Lc4
	.balign 4,0
.Lc19:
	.long	.Lc22-.Lc21
.Lc21:
	.long	.Lc12
	.long	.Lc6
	.long	.Lc5-.Lc6
	.balign 4,0
.Lc22:
	.long	.Lc25-.Lc24
.Lc24:
	.long	.Lc12
	.long	.Lc8
	.long	.Lc7-.Lc8
	.balign 4,0
.Lc25:
	.long	.Lc28-.Lc27
.Lc27:
	.long	.Lc12
	.long	.Lc10
	.long	.Lc9-.Lc10
	.byte	4
	.long	.Lc11-.Lc10
	.byte	7
	.uleb128	0
	.balign 4,0
.Lc28:
# End asmlist al_dwarf_frame

