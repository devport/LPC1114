	.file "il_interpreter.pas"
# Begin asmlist al_procedures

.section .text.n_il_interpreter_$$_script_emitcode$byte$pbyte$pword,"ax"
	.balign 4
.thumb_func 
IL_INTERPRETER_$$_SCRIPT_EMITCODE$BYTE$PBYTE$PWORD:
.Lc2:
# [il_interpreter.pas]
# [72] begin
	push	{r14}
	sub	r13,r13,#48
# Var Inst located at r13+0, size=OS_8
# Var Code located at r13+4, size=OS_32
# Var Code_Size located at r13+8, size=OS_32
	mov	r3,r13
	strb	r0,[r3]
	str	r1,[r13, #4]
	str	r2,[r13, #8]
# [73] Code[Code_Size^] := Inst;
	ldr	r2,[r13, #4]
	ldr	r0,[r13, #8]
	ldrh	r1,[r0]
	mov	r0,r13
	ldrb	r0,[r0]
	strb	r0,[r2, r1]
# [74] Inc(Code_Size^);
	ldr	r1,[r13, #8]
	ldrh	r0,[r1]
	add	r0,#1
	uxth	r0,r0
	strh	r0,[r1]
# [75] end;
	add	r13,r13,#48
	pop	{r15}
.Lc1:
.Le0:
	.size	IL_INTERPRETER_$$_SCRIPT_EMITCODE$BYTE$PBYTE$PWORD, .Le0 - IL_INTERPRETER_$$_SCRIPT_EMITCODE$BYTE$PBYTE$PWORD

.section .text.n_il_interpreter_$$_script_scanner$pchar$word$pbyte$word,"ax"
	.balign 4
.thumb_func 
.globl	IL_INTERPRETER_$$_SCRIPT_SCANNER$PCHAR$WORD$PBYTE$WORD
IL_INTERPRETER_$$_SCRIPT_SCANNER$PCHAR$WORD$PBYTE$WORD:
.Lc4:
# [80] begin
	push	{r14}
	sub	r13,r13,#56
# Var Script located at r13+0, size=OS_32
# Var Script_Size located at r13+4, size=OS_16
# Var Code located at r13+8, size=OS_32
# Var Code_Size located at r13+12, size=OS_32
# Var sPtr located at r13+16, size=OS_16
# Var cPtr located at r13+20, size=OS_16
	str	r0,[r13]
	add	r0,r13,#4
	strh	r1,[r0]
	str	r2,[r13, #8]
	str	r3,[r13, #12]
# [81] sPtr := 1;
	mov	r1,#1
	add	r0,r13,#16
	strh	r1,[r0]
# [82] cPtr := 0;
	mov	r1,#0
	add	r0,r13,#20
	strh	r1,[r0]
# [83] while true do begin
	bl	.Lj8
.Lj7:
# [85] while ((Script[sPtr] = #10) OR (Script[sPtr] = #13) OR (Script[sPtr] = #32) OR (Script[sPtr] = #9)) do Inc(sPtr);
	bl	.Lj11
.Lj10:
	add	r0,r13,#16
	ldrh	r0,[r0]
	add	r0,#1
	uxth	r0,r0
	add	r1,r13,#16
	strh	r0,[r1]
.Lj11:
	ldr	r1,[r13]
	add	r0,r13,#16
	ldrh	r0,[r0]
	ldrb	r0,[r1, r0]
	cmp	r0,#10
	bne	.Lj15
	bl	.Lj13
.Lj15:
	bl	.Lj14
.Lj14:
	ldr	r1,[r13]
	add	r0,r13,#16
	ldrh	r0,[r0]
	ldrb	r0,[r1, r0]
	cmp	r0,#13
	bne	.Lj17
	bl	.Lj13
.Lj17:
	bl	.Lj16
.Lj16:
	ldr	r1,[r13]
	add	r0,r13,#16
	ldrh	r0,[r0]
	ldrb	r0,[r1, r0]
	cmp	r0,#32
	bne	.Lj19
	bl	.Lj13
.Lj19:
	bl	.Lj18
.Lj18:
	ldr	r1,[r13]
	add	r0,r13,#16
	ldrh	r0,[r0]
	ldrb	r0,[r1, r0]
	cmp	r0,#9
	bne	.Lj21
	bl	.Lj13
.Lj21:
	bl	.Lj20
.Lj13:
	bl	.Lj10
.Lj20:
	bl	.Lj12
.Lj12:
# [87] if sPtr >= Script_Size then break;
	add	r0,r13,#16
	ldrh	r1,[r0]
	add	r0,r13,#4
	ldrh	r0,[r0]
	cmp	r1,r0
	bcc	.Lj24
	bl	.Lj22
.Lj24:
	bl	.Lj23
.Lj22:
	bl	.Lj9
.Lj23:
# [89] case Script[sPtr] of
	ldr	r1,[r13]
	add	r0,r13,#16
	ldrh	r0,[r0]
	ldrb	r0,[r1, r0]
	cmp	r0,#47
	bcs	.Lj34
	bl	.Lj26
.Lj34:
	sub	r0,#47
	bne	.Lj35
	bl	.Lj27
.Lj35:
	sub	r0,#14
	bne	.Lj36
	bl	.Lj29
.Lj36:
	sub	r0,#4
	bne	.Lj37
	bl	.Lj32
.Lj37:
	sub	r0,#2
	bne	.Lj38
	bl	.Lj31
.Lj38:
	sub	r0,#9
	bne	.Lj39
	bl	.Lj28
.Lj39:
	sub	r0,#3
	bne	.Lj40
	bl	.Lj33
.Lj40:
	sub	r0,#4
	bne	.Lj41
	bl	.Lj30
.Lj41:
	bl	.Lj26
.Lj27:
# [91] if(Script[sPtr+1] = '/') then
	ldr	r1,[r13]
	add	r0,r13,#16
	ldrh	r0,[r0]
	add	r0,#1
	ldrb	r0,[r1, r0]
	cmp	r0,#47
	bne	.Lj44
	bl	.Lj42
.Lj44:
	bl	.Lj43
.Lj42:
# [92] while (Script[sPtr] <> #10) do Inc(sPtr);
	bl	.Lj46
.Lj45:
	add	r0,r13,#16
	ldrh	r0,[r0]
	add	r0,#1
	uxth	r0,r0
	add	r1,r13,#16
	strh	r0,[r1]
.Lj46:
	ldr	r1,[r13]
	add	r0,r13,#16
	ldrh	r0,[r0]
	ldrb	r0,[r1, r0]
	cmp	r0,#10
	beq	.Lj48
	bl	.Lj45
.Lj48:
	bl	.Lj47
.Lj47:
.Lj43:
# [93] Inc(sPtr);
	add	r0,r13,#16
	ldrh	r0,[r0]
	add	r0,#1
	uxth	r0,r0
	add	r1,r13,#16
	strh	r0,[r1]
	bl	.Lj25
.Lj28:
# [97] Inc(sPtr);
	add	r0,r13,#16
	ldrh	r0,[r0]
	add	r0,#1
	uxth	r0,r0
	add	r1,r13,#16
	strh	r0,[r1]
# [98] if(Script[sPtr] = 'D') then begin
	ldr	r1,[r13]
	add	r0,r13,#16
	ldrh	r0,[r0]
	ldrb	r0,[r1, r0]
	cmp	r0,#68
	bne	.Lj51
	bl	.Lj49
.Lj51:
	bl	.Lj50
.Lj49:
# [99] Inc(sPtr);
	add	r0,r13,#16
	ldrh	r0,[r0]
	add	r0,#1
	uxth	r0,r0
	add	r1,r13,#16
	strh	r0,[r1]
# [100] Script_EmitCode(i_LD, Code, @cPtr);
	add	r2,r13,#20
	ldr	r1,[r13, #8]
	mov	r0,#1
	bl	IL_INTERPRETER_$$_SCRIPT_EMITCODE$BYTE$PBYTE$PWORD
# [101] while(Script[sPtr] = ' ') do Inc(sPtr);
	bl	.Lj53
.Lj52:
	add	r0,r13,#16
	ldrh	r0,[r0]
	add	r0,#1
	uxth	r0,r0
	add	r1,r13,#16
	strh	r0,[r1]
.Lj53:
	ldr	r1,[r13]
	add	r0,r13,#16
	ldrh	r0,[r0]
	ldrb	r0,[r1, r0]
	cmp	r0,#32
	bne	.Lj55
	bl	.Lj52
.Lj55:
	bl	.Lj54
.Lj54:
# [102] case Script[sPtr] of
	ldr	r1,[r13]
	add	r0,r13,#16
	ldrh	r0,[r0]
	ldrb	r0,[r1, r0]
	cmp	r0,#73
	bcs	.Lj59
	bl	.Lj56
.Lj59:
	sub	r0,#73
	bne	.Lj60
	bl	.Lj57
.Lj60:
	sub	r0,#8
	bne	.Lj61
	bl	.Lj58
.Lj61:
	bl	.Lj56
.Lj57:
# [104] Script_EmitCode(i_I, Code, @cPtr);
	add	r2,r13,#20
	ldr	r1,[r13, #8]
	mov	r0,#100
	bl	IL_INTERPRETER_$$_SCRIPT_EMITCODE$BYTE$PBYTE$PWORD
# [105] Inc(sPtr);
	add	r0,r13,#16
	ldrh	r0,[r0]
	add	r0,#1
	uxth	r0,r0
	add	r1,r13,#16
	strh	r0,[r1]
# [106] while(Script[sPtr] = ' ') do Inc(sPtr);
	bl	.Lj63
.Lj62:
	add	r0,r13,#16
	ldrh	r0,[r0]
	add	r0,#1
	uxth	r0,r0
	add	r1,r13,#16
	strh	r0,[r1]
.Lj63:
	ldr	r1,[r13]
	add	r0,r13,#16
	ldrh	r0,[r0]
	ldrb	r0,[r1, r0]
	cmp	r0,#32
	bne	.Lj65
	bl	.Lj62
.Lj65:
	bl	.Lj64
.Lj64:
# [107] Script_EmitCode(Ord(Script[sPtr])-48, Code, @cPtr);
	ldr	r1,[r13]
	add	r0,r13,#16
	ldrh	r0,[r0]
	ldrb	r0,[r1, r0]
	sub	r0,#48
	uxtb	r0,r0
	uxtb	r0,r0
	add	r2,r13,#20
	ldr	r1,[r13, #8]
	bl	IL_INTERPRETER_$$_SCRIPT_EMITCODE$BYTE$PBYTE$PWORD
	bl	.Lj56
.Lj58:
# [110] Script_EmitCode(i_Q, Code, @cPtr);
	add	r2,r13,#20
	ldr	r1,[r13, #8]
	mov	r0,#101
	bl	IL_INTERPRETER_$$_SCRIPT_EMITCODE$BYTE$PBYTE$PWORD
# [111] Inc(sPtr);
	add	r0,r13,#16
	ldrh	r0,[r0]
	add	r0,#1
	uxth	r0,r0
	add	r1,r13,#16
	strh	r0,[r1]
# [112] while(Script[sPtr] = ' ') do Inc(sPtr);
	bl	.Lj67
.Lj66:
	add	r0,r13,#16
	ldrh	r0,[r0]
	add	r0,#1
	uxth	r0,r0
	add	r1,r13,#16
	strh	r0,[r1]
.Lj67:
	ldr	r1,[r13]
	add	r0,r13,#16
	ldrh	r0,[r0]
	ldrb	r0,[r1, r0]
	cmp	r0,#32
	bne	.Lj69
	bl	.Lj66
.Lj69:
	bl	.Lj68
.Lj68:
# [113] Script_EmitCode(Ord(Script[sPtr])-48, Code, @cPtr);
	ldr	r1,[r13]
	add	r0,r13,#16
	ldrh	r0,[r0]
	ldrb	r0,[r1, r0]
	sub	r0,#48
	uxtb	r0,r0
	uxtb	r0,r0
	add	r2,r13,#20
	ldr	r1,[r13, #8]
	bl	IL_INTERPRETER_$$_SCRIPT_EMITCODE$BYTE$PBYTE$PWORD
	bl	.Lj56
.Lj56:
.Lj50:
# [117] while (Script[sPtr] <> #10) do Inc(sPtr);
	bl	.Lj71
.Lj70:
	add	r0,r13,#16
	ldrh	r0,[r0]
	add	r0,#1
	uxth	r0,r0
	add	r1,r13,#16
	strh	r0,[r1]
.Lj71:
	ldr	r1,[r13]
	add	r0,r13,#16
	ldrh	r0,[r0]
	ldrb	r0,[r1, r0]
	cmp	r0,#10
	beq	.Lj73
	bl	.Lj70
.Lj73:
	bl	.Lj72
.Lj72:
# [118] Inc(sPtr);
	add	r0,r13,#16
	ldrh	r0,[r0]
	add	r0,#1
	uxth	r0,r0
	add	r1,r13,#16
	strh	r0,[r1]
	bl	.Lj25
.Lj29:
# [122] Inc(sPtr);
	add	r0,r13,#16
	ldrh	r0,[r0]
	add	r0,#1
	uxth	r0,r0
	add	r1,r13,#16
	strh	r0,[r1]
# [123] while(Script[sPtr] = ' ') do Inc(sPtr);
	bl	.Lj75
.Lj74:
	add	r0,r13,#16
	ldrh	r0,[r0]
	add	r0,#1
	uxth	r0,r0
	add	r1,r13,#16
	strh	r0,[r1]
.Lj75:
	ldr	r1,[r13]
	add	r0,r13,#16
	ldrh	r0,[r0]
	ldrb	r0,[r1, r0]
	cmp	r0,#32
	bne	.Lj77
	bl	.Lj74
.Lj77:
	bl	.Lj76
.Lj76:
# [124] Script_EmitCode(i_ST, Code, @cPtr);
	add	r2,r13,#20
	ldr	r1,[r13, #8]
	mov	r0,#2
	bl	IL_INTERPRETER_$$_SCRIPT_EMITCODE$BYTE$PBYTE$PWORD
# [125] if (Script[sPtr] = 'Q') then begin
	ldr	r1,[r13]
	add	r0,r13,#16
	ldrh	r0,[r0]
	ldrb	r0,[r1, r0]
	cmp	r0,#81
	bne	.Lj80
	bl	.Lj78
.Lj80:
	bl	.Lj79
.Lj78:
# [126] Inc(sPtr);
	add	r0,r13,#16
	ldrh	r0,[r0]
	add	r0,#1
	uxth	r0,r0
	add	r1,r13,#16
	strh	r0,[r1]
# [127] while(Script[sPtr] = ' ' ) do Inc(sPtr);
	bl	.Lj82
.Lj81:
	add	r0,r13,#16
	ldrh	r0,[r0]
	add	r0,#1
	uxth	r0,r0
	add	r1,r13,#16
	strh	r0,[r1]
.Lj82:
	ldr	r1,[r13]
	add	r0,r13,#16
	ldrh	r0,[r0]
	ldrb	r0,[r1, r0]
	cmp	r0,#32
	bne	.Lj84
	bl	.Lj81
.Lj84:
	bl	.Lj83
.Lj83:
# [128] Script_EmitCode(i_Q, Code, @cPtr);
	add	r2,r13,#20
	ldr	r1,[r13, #8]
	mov	r0,#101
	bl	IL_INTERPRETER_$$_SCRIPT_EMITCODE$BYTE$PBYTE$PWORD
# [129] Script_EmitCode(Ord(Script[sPtr])-48, Code, @cPtr);
	ldr	r1,[r13]
	add	r0,r13,#16
	ldrh	r0,[r0]
	ldrb	r0,[r1, r0]
	sub	r0,#48
	uxtb	r0,r0
	uxtb	r0,r0
	add	r2,r13,#20
	ldr	r1,[r13, #8]
	bl	IL_INTERPRETER_$$_SCRIPT_EMITCODE$BYTE$PBYTE$PWORD
.Lj79:
# [131] while (Script[sPtr] <> #10) do Inc(sPtr);
	bl	.Lj86
.Lj85:
	add	r0,r13,#16
	ldrh	r0,[r0]
	add	r0,#1
	uxth	r0,r0
	add	r1,r13,#16
	strh	r0,[r1]
.Lj86:
	ldr	r1,[r13]
	add	r0,r13,#16
	ldrh	r0,[r0]
	ldrb	r0,[r1, r0]
	cmp	r0,#10
	beq	.Lj88
	bl	.Lj85
.Lj88:
	bl	.Lj87
.Lj87:
# [132] Inc(sPtr);
	add	r0,r13,#16
	ldrh	r0,[r0]
	add	r0,#1
	uxth	r0,r0
	add	r1,r13,#16
	strh	r0,[r1]
	bl	.Lj25
.Lj30:
# [135] Inc(sPtr);
	add	r0,r13,#16
	ldrh	r0,[r0]
	add	r0,#1
	uxth	r0,r0
	add	r1,r13,#16
	strh	r0,[r1]
# [136] case Script[sPtr] of
	ldr	r1,[r13]
	add	r0,r13,#16
	ldrh	r0,[r0]
	ldrb	r0,[r1, r0]
	cmp	r0,#69
	bcs	.Lj92
	bl	.Lj89
.Lj92:
	sub	r0,#69
	bne	.Lj93
	bl	.Lj90
.Lj93:
	sub	r0,#15
	bne	.Lj94
	bl	.Lj91
.Lj94:
	bl	.Lj89
.Lj90:
# [138] Inc(sPtr);
	add	r0,r13,#16
	ldrh	r0,[r0]
	add	r0,#1
	uxth	r0,r0
	add	r1,r13,#16
	strh	r0,[r1]
# [139] if(Script[sPtr] = 'T') then begin
	ldr	r1,[r13]
	add	r0,r13,#16
	ldrh	r0,[r0]
	ldrb	r0,[r1, r0]
	cmp	r0,#84
	bne	.Lj97
	bl	.Lj95
.Lj97:
	bl	.Lj96
.Lj95:
# [140] Script_EmitCode(i_SET, Code, @cPtr);
	add	r2,r13,#20
	ldr	r1,[r13, #8]
	mov	r0,#12
	bl	IL_INTERPRETER_$$_SCRIPT_EMITCODE$BYTE$PBYTE$PWORD
.Lj96:
	bl	.Lj89
.Lj91:
# [144] Inc(sPtr);
	add	r0,r13,#16
	ldrh	r0,[r0]
	add	r0,#1
	uxth	r0,r0
	add	r1,r13,#16
	strh	r0,[r1]
# [145] while(Script[sPtr] = ' ') do Inc(sPtr);
	bl	.Lj99
.Lj98:
	add	r0,r13,#16
	ldrh	r0,[r0]
	add	r0,#1
	uxth	r0,r0
	add	r1,r13,#16
	strh	r0,[r1]
.Lj99:
	ldr	r1,[r13]
	add	r0,r13,#16
	ldrh	r0,[r0]
	ldrb	r0,[r1, r0]
	cmp	r0,#32
	bne	.Lj101
	bl	.Lj98
.Lj101:
	bl	.Lj100
.Lj100:
# [146] Script_EmitCode(i_ST, Code, @cPtr);
	add	r2,r13,#20
	ldr	r1,[r13, #8]
	mov	r0,#2
	bl	IL_INTERPRETER_$$_SCRIPT_EMITCODE$BYTE$PBYTE$PWORD
# [147] if (Script[sPtr] = 'Q') then begin
	ldr	r1,[r13]
	add	r0,r13,#16
	ldrh	r0,[r0]
	ldrb	r0,[r1, r0]
	cmp	r0,#81
	bne	.Lj104
	bl	.Lj102
.Lj104:
	bl	.Lj103
.Lj102:
# [148] Inc(sPtr);
	add	r0,r13,#16
	ldrh	r0,[r0]
	add	r0,#1
	uxth	r0,r0
	add	r1,r13,#16
	strh	r0,[r1]
# [149] while(Script[sPtr] = ' ' ) do Inc(sPtr);
	bl	.Lj106
.Lj105:
	add	r0,r13,#16
	ldrh	r0,[r0]
	add	r0,#1
	uxth	r0,r0
	add	r1,r13,#16
	strh	r0,[r1]
.Lj106:
	ldr	r1,[r13]
	add	r0,r13,#16
	ldrh	r0,[r0]
	ldrb	r0,[r1, r0]
	cmp	r0,#32
	bne	.Lj108
	bl	.Lj105
.Lj108:
	bl	.Lj107
.Lj107:
# [150] Script_EmitCode(i_Q, Code, @cPtr);
	add	r2,r13,#20
	ldr	r1,[r13, #8]
	mov	r0,#101
	bl	IL_INTERPRETER_$$_SCRIPT_EMITCODE$BYTE$PBYTE$PWORD
# [151] Script_EmitCode(Ord(Script[sPtr])-48, Code, @cPtr);
	ldr	r1,[r13]
	add	r0,r13,#16
	ldrh	r0,[r0]
	ldrb	r0,[r1, r0]
	sub	r0,#48
	uxtb	r0,r0
	uxtb	r0,r0
	add	r2,r13,#20
	ldr	r1,[r13, #8]
	bl	IL_INTERPRETER_$$_SCRIPT_EMITCODE$BYTE$PBYTE$PWORD
.Lj103:
	bl	.Lj89
.Lj89:
# [155] while (Script[sPtr] <> #10) do Inc(sPtr);
	bl	.Lj110
.Lj109:
	add	r0,r13,#16
	ldrh	r0,[r0]
	add	r0,#1
	uxth	r0,r0
	add	r1,r13,#16
	strh	r0,[r1]
.Lj110:
	ldr	r1,[r13]
	add	r0,r13,#16
	ldrh	r0,[r0]
	ldrb	r0,[r1, r0]
	cmp	r0,#10
	beq	.Lj112
	bl	.Lj109
.Lj112:
	bl	.Lj111
.Lj111:
# [156] Inc(sPtr);
	add	r0,r13,#16
	ldrh	r0,[r0]
	add	r0,#1
	uxth	r0,r0
	add	r1,r13,#16
	strh	r0,[r1]
	bl	.Lj25
.Lj31:
# [159] Inc(sPtr);
	add	r0,r13,#16
	ldrh	r0,[r0]
	add	r0,#1
	uxth	r0,r0
	add	r1,r13,#16
	strh	r0,[r1]
# [160] if(Script[sPtr] = 'L') and (Script[sPtr+1] = 'R') then begin
	ldr	r1,[r13]
	add	r0,r13,#16
	ldrh	r0,[r0]
	ldrb	r0,[r1, r0]
	cmp	r0,#76
	bne	.Lj115
	bl	.Lj113
.Lj115:
	bl	.Lj114
.Lj113:
	ldr	r1,[r13]
	add	r0,r13,#16
	ldrh	r0,[r0]
	add	r0,#1
	ldrb	r0,[r1, r0]
	cmp	r0,#82
	bne	.Lj117
	bl	.Lj116
.Lj117:
	bl	.Lj114
.Lj116:
# [161] Inc(sPtr, 2);
	add	r0,r13,#16
	ldrh	r0,[r0]
	add	r0,#2
	uxth	r0,r0
	add	r1,r13,#16
	strh	r0,[r1]
# [162] Script_EmitCode(i_CLR, Code, @cPtr);
	add	r2,r13,#20
	ldr	r1,[r13, #8]
	mov	r0,#13
	bl	IL_INTERPRETER_$$_SCRIPT_EMITCODE$BYTE$PBYTE$PWORD
.Lj114:
# [164] while (Script[sPtr] <> #10) do Inc(sPtr);
	bl	.Lj119
.Lj118:
	add	r0,r13,#16
	ldrh	r0,[r0]
	add	r0,#1
	uxth	r0,r0
	add	r1,r13,#16
	strh	r0,[r1]
.Lj119:
	ldr	r1,[r13]
	add	r0,r13,#16
	ldrh	r0,[r0]
	ldrb	r0,[r1, r0]
	cmp	r0,#10
	beq	.Lj121
	bl	.Lj118
.Lj121:
	bl	.Lj120
.Lj120:
# [165] Inc(sPtr);
	add	r0,r13,#16
	ldrh	r0,[r0]
	add	r0,#1
	uxth	r0,r0
	add	r1,r13,#16
	strh	r0,[r1]
	bl	.Lj25
.Lj32:
# [168] Inc(sPtr);
	add	r0,r13,#16
	ldrh	r0,[r0]
	add	r0,#1
	uxth	r0,r0
	add	r1,r13,#16
	strh	r0,[r1]
# [169] if(Script[sPtr] = 'N') then begin
	ldr	r1,[r13]
	add	r0,r13,#16
	ldrh	r0,[r0]
	ldrb	r0,[r1, r0]
	cmp	r0,#78
	bne	.Lj124
	bl	.Lj122
.Lj124:
	bl	.Lj123
.Lj122:
# [170] Inc(sPtr);
	add	r0,r13,#16
	ldrh	r0,[r0]
	add	r0,#1
	uxth	r0,r0
	add	r1,r13,#16
	strh	r0,[r1]
# [171] while(Script[sPtr] = ' ') do Inc(sPtr);
	bl	.Lj126
.Lj125:
	add	r0,r13,#16
	ldrh	r0,[r0]
	add	r0,#1
	uxth	r0,r0
	add	r1,r13,#16
	strh	r0,[r1]
.Lj126:
	ldr	r1,[r13]
	add	r0,r13,#16
	ldrh	r0,[r0]
	ldrb	r0,[r1, r0]
	cmp	r0,#32
	bne	.Lj128
	bl	.Lj125
.Lj128:
	bl	.Lj127
.Lj127:
# [172] Script_EmitCode(i_ANDN, Code, @cPtr);
	add	r2,r13,#20
	ldr	r1,[r13, #8]
	mov	r0,#4
	bl	IL_INTERPRETER_$$_SCRIPT_EMITCODE$BYTE$PBYTE$PWORD
# [173] case Script[sPtr] of
	ldr	r1,[r13]
	add	r0,r13,#16
	ldrh	r0,[r0]
	ldrb	r0,[r1, r0]
	cmp	r0,#73
	bcs	.Lj132
	bl	.Lj129
.Lj132:
	sub	r0,#73
	bne	.Lj133
	bl	.Lj130
.Lj133:
	sub	r0,#8
	bne	.Lj134
	bl	.Lj131
.Lj134:
	bl	.Lj129
.Lj130:
# [175] Script_EmitCode(i_I, Code, @cPtr);
	add	r2,r13,#20
	ldr	r1,[r13, #8]
	mov	r0,#100
	bl	IL_INTERPRETER_$$_SCRIPT_EMITCODE$BYTE$PBYTE$PWORD
# [176] Inc(sPtr);
	add	r0,r13,#16
	ldrh	r0,[r0]
	add	r0,#1
	uxth	r0,r0
	add	r1,r13,#16
	strh	r0,[r1]
# [177] while(Script[sPtr] = ' ') do Inc(sPtr);
	bl	.Lj136
.Lj135:
	add	r0,r13,#16
	ldrh	r0,[r0]
	add	r0,#1
	uxth	r0,r0
	add	r1,r13,#16
	strh	r0,[r1]
.Lj136:
	ldr	r1,[r13]
	add	r0,r13,#16
	ldrh	r0,[r0]
	ldrb	r0,[r1, r0]
	cmp	r0,#32
	bne	.Lj138
	bl	.Lj135
.Lj138:
	bl	.Lj137
.Lj137:
# [178] Script_EmitCode(Ord(Script[sPtr])-48, Code, @cPtr);
	ldr	r1,[r13]
	add	r0,r13,#16
	ldrh	r0,[r0]
	ldrb	r0,[r1, r0]
	sub	r0,#48
	uxtb	r0,r0
	uxtb	r0,r0
	add	r2,r13,#20
	ldr	r1,[r13, #8]
	bl	IL_INTERPRETER_$$_SCRIPT_EMITCODE$BYTE$PBYTE$PWORD
	bl	.Lj129
.Lj131:
# [181] Script_EmitCode(i_Q, Code, @cPtr);
	add	r2,r13,#20
	ldr	r1,[r13, #8]
	mov	r0,#101
	bl	IL_INTERPRETER_$$_SCRIPT_EMITCODE$BYTE$PBYTE$PWORD
# [182] Inc(sPtr);
	add	r0,r13,#16
	ldrh	r0,[r0]
	add	r0,#1
	uxth	r0,r0
	add	r1,r13,#16
	strh	r0,[r1]
# [183] while(Script[sPtr] = ' ') do Inc(sPtr);
	bl	.Lj140
.Lj139:
	add	r0,r13,#16
	ldrh	r0,[r0]
	add	r0,#1
	uxth	r0,r0
	add	r1,r13,#16
	strh	r0,[r1]
.Lj140:
	ldr	r1,[r13]
	add	r0,r13,#16
	ldrh	r0,[r0]
	ldrb	r0,[r1, r0]
	cmp	r0,#32
	bne	.Lj142
	bl	.Lj139
.Lj142:
	bl	.Lj141
.Lj141:
# [184] Script_EmitCode(Ord(Script[sPtr])-48, Code, @cPtr);
	ldr	r1,[r13]
	add	r0,r13,#16
	ldrh	r0,[r0]
	ldrb	r0,[r1, r0]
	sub	r0,#48
	uxtb	r0,r0
	uxtb	r0,r0
	add	r2,r13,#20
	ldr	r1,[r13, #8]
	bl	IL_INTERPRETER_$$_SCRIPT_EMITCODE$BYTE$PBYTE$PWORD
	bl	.Lj129
.Lj129:
	bl	.Lj143
.Lj123:
# [188] while(Script[sPtr] = ' ') do Inc(sPtr);
	bl	.Lj145
.Lj144:
	add	r0,r13,#16
	ldrh	r0,[r0]
	add	r0,#1
	uxth	r0,r0
	add	r1,r13,#16
	strh	r0,[r1]
.Lj145:
	ldr	r1,[r13]
	add	r0,r13,#16
	ldrh	r0,[r0]
	ldrb	r0,[r1, r0]
	cmp	r0,#32
	bne	.Lj147
	bl	.Lj144
.Lj147:
	bl	.Lj146
.Lj146:
# [189] Script_EmitCode(i_AND, Code, @cPtr);
	add	r2,r13,#20
	ldr	r1,[r13, #8]
	mov	r0,#3
	bl	IL_INTERPRETER_$$_SCRIPT_EMITCODE$BYTE$PBYTE$PWORD
# [190] case Script[sPtr] of
	ldr	r1,[r13]
	add	r0,r13,#16
	ldrh	r0,[r0]
	ldrb	r0,[r1, r0]
	cmp	r0,#73
	bcs	.Lj151
	bl	.Lj148
.Lj151:
	sub	r0,#73
	bne	.Lj152
	bl	.Lj149
.Lj152:
	sub	r0,#8
	bne	.Lj153
	bl	.Lj150
.Lj153:
	bl	.Lj148
.Lj149:
# [192] Script_EmitCode(i_I, Code, @cPtr);
	add	r2,r13,#20
	ldr	r1,[r13, #8]
	mov	r0,#100
	bl	IL_INTERPRETER_$$_SCRIPT_EMITCODE$BYTE$PBYTE$PWORD
# [193] Inc(sPtr);
	add	r0,r13,#16
	ldrh	r0,[r0]
	add	r0,#1
	uxth	r0,r0
	add	r1,r13,#16
	strh	r0,[r1]
# [194] while(Script[sPtr] = ' ') do Inc(sPtr);
	bl	.Lj155
.Lj154:
	add	r0,r13,#16
	ldrh	r0,[r0]
	add	r0,#1
	uxth	r0,r0
	add	r1,r13,#16
	strh	r0,[r1]
.Lj155:
	ldr	r1,[r13]
	add	r0,r13,#16
	ldrh	r0,[r0]
	ldrb	r0,[r1, r0]
	cmp	r0,#32
	bne	.Lj157
	bl	.Lj154
.Lj157:
	bl	.Lj156
.Lj156:
# [195] Script_EmitCode(Ord(Script[sPtr])-48, Code, @cPtr);
	ldr	r1,[r13]
	add	r0,r13,#16
	ldrh	r0,[r0]
	ldrb	r0,[r1, r0]
	sub	r0,#48
	uxtb	r0,r0
	uxtb	r0,r0
	add	r2,r13,#20
	ldr	r1,[r13, #8]
	bl	IL_INTERPRETER_$$_SCRIPT_EMITCODE$BYTE$PBYTE$PWORD
	bl	.Lj148
.Lj150:
# [198] Script_EmitCode(i_Q, Code, @cPtr);
	add	r2,r13,#20
	ldr	r1,[r13, #8]
	mov	r0,#101
	bl	IL_INTERPRETER_$$_SCRIPT_EMITCODE$BYTE$PBYTE$PWORD
# [199] Inc(sPtr);
	add	r0,r13,#16
	ldrh	r0,[r0]
	add	r0,#1
	uxth	r0,r0
	add	r1,r13,#16
	strh	r0,[r1]
# [200] while(Script[sPtr] = ' ') do Inc(sPtr);
	bl	.Lj159
.Lj158:
	add	r0,r13,#16
	ldrh	r0,[r0]
	add	r0,#1
	uxth	r0,r0
	add	r1,r13,#16
	strh	r0,[r1]
.Lj159:
	ldr	r1,[r13]
	add	r0,r13,#16
	ldrh	r0,[r0]
	ldrb	r0,[r1, r0]
	cmp	r0,#32
	bne	.Lj161
	bl	.Lj158
.Lj161:
	bl	.Lj160
.Lj160:
# [201] Script_EmitCode(Ord(Script[sPtr])-48, Code, @cPtr);
	ldr	r1,[r13]
	add	r0,r13,#16
	ldrh	r0,[r0]
	ldrb	r0,[r1, r0]
	sub	r0,#48
	uxtb	r0,r0
	uxtb	r0,r0
	add	r2,r13,#20
	ldr	r1,[r13, #8]
	bl	IL_INTERPRETER_$$_SCRIPT_EMITCODE$BYTE$PBYTE$PWORD
	bl	.Lj148
.Lj148:
.Lj143:
# [205] while (Script[sPtr] <> #10) do Inc(sPtr);
	bl	.Lj163
.Lj162:
	add	r0,r13,#16
	ldrh	r0,[r0]
	add	r0,#1
	uxth	r0,r0
	add	r1,r13,#16
	strh	r0,[r1]
.Lj163:
	ldr	r1,[r13]
	add	r0,r13,#16
	ldrh	r0,[r0]
	ldrb	r0,[r1, r0]
	cmp	r0,#10
	beq	.Lj165
	bl	.Lj162
.Lj165:
	bl	.Lj164
.Lj164:
# [206] Inc(sPtr);
	add	r0,r13,#16
	ldrh	r0,[r0]
	add	r0,#1
	uxth	r0,r0
	add	r1,r13,#16
	strh	r0,[r1]
	bl	.Lj25
.Lj33:
# [209] Inc(sPtr);
	add	r0,r13,#16
	ldrh	r0,[r0]
	add	r0,#1
	uxth	r0,r0
	add	r1,r13,#16
	strh	r0,[r1]
# [210] if(Script[sPtr] = 'N') then begin
	ldr	r1,[r13]
	add	r0,r13,#16
	ldrh	r0,[r0]
	ldrb	r0,[r1, r0]
	cmp	r0,#78
	bne	.Lj168
	bl	.Lj166
.Lj168:
	bl	.Lj167
.Lj166:
# [211] Inc(sPtr);
	add	r0,r13,#16
	ldrh	r0,[r0]
	add	r0,#1
	uxth	r0,r0
	add	r1,r13,#16
	strh	r0,[r1]
# [212] while(Script[sPtr] = ' ') do Inc(sPtr);
	bl	.Lj170
.Lj169:
	add	r0,r13,#16
	ldrh	r0,[r0]
	add	r0,#1
	uxth	r0,r0
	add	r1,r13,#16
	strh	r0,[r1]
.Lj170:
	ldr	r1,[r13]
	add	r0,r13,#16
	ldrh	r0,[r0]
	ldrb	r0,[r1, r0]
	cmp	r0,#32
	bne	.Lj172
	bl	.Lj169
.Lj172:
	bl	.Lj171
.Lj171:
# [213] Script_EmitCode(i_ORN, Code, @cPtr);
	add	r2,r13,#20
	ldr	r1,[r13, #8]
	mov	r0,#6
	bl	IL_INTERPRETER_$$_SCRIPT_EMITCODE$BYTE$PBYTE$PWORD
# [214] case Script[sPtr] of
	ldr	r1,[r13]
	add	r0,r13,#16
	ldrh	r0,[r0]
	ldrb	r0,[r1, r0]
	cmp	r0,#73
	bcs	.Lj176
	bl	.Lj173
.Lj176:
	sub	r0,#73
	bne	.Lj177
	bl	.Lj174
.Lj177:
	sub	r0,#8
	bne	.Lj178
	bl	.Lj175
.Lj178:
	bl	.Lj173
.Lj174:
# [216] Script_EmitCode(i_I, Code, @cPtr);
	add	r2,r13,#20
	ldr	r1,[r13, #8]
	mov	r0,#100
	bl	IL_INTERPRETER_$$_SCRIPT_EMITCODE$BYTE$PBYTE$PWORD
# [217] Inc(sPtr);
	add	r0,r13,#16
	ldrh	r0,[r0]
	add	r0,#1
	uxth	r0,r0
	add	r1,r13,#16
	strh	r0,[r1]
# [218] while(Script[sPtr] = ' ') do Inc(sPtr);
	bl	.Lj180
.Lj179:
	add	r0,r13,#16
	ldrh	r0,[r0]
	add	r0,#1
	uxth	r0,r0
	add	r1,r13,#16
	strh	r0,[r1]
.Lj180:
	ldr	r1,[r13]
	add	r0,r13,#16
	ldrh	r0,[r0]
	ldrb	r0,[r1, r0]
	cmp	r0,#32
	bne	.Lj182
	bl	.Lj179
.Lj182:
	bl	.Lj181
.Lj181:
# [219] Script_EmitCode(Ord(Script[sPtr])-48, Code, @cPtr);
	ldr	r1,[r13]
	add	r0,r13,#16
	ldrh	r0,[r0]
	ldrb	r0,[r1, r0]
	sub	r0,#48
	uxtb	r0,r0
	uxtb	r0,r0
	add	r2,r13,#20
	ldr	r1,[r13, #8]
	bl	IL_INTERPRETER_$$_SCRIPT_EMITCODE$BYTE$PBYTE$PWORD
	bl	.Lj173
.Lj175:
# [222] Script_EmitCode(i_Q, Code, @cPtr);
	add	r2,r13,#20
	ldr	r1,[r13, #8]
	mov	r0,#101
	bl	IL_INTERPRETER_$$_SCRIPT_EMITCODE$BYTE$PBYTE$PWORD
# [223] Inc(sPtr);
	add	r0,r13,#16
	ldrh	r0,[r0]
	add	r0,#1
	uxth	r0,r0
	add	r1,r13,#16
	strh	r0,[r1]
# [224] while(Script[sPtr] = ' ') do Inc(sPtr);
	bl	.Lj184
.Lj183:
	add	r0,r13,#16
	ldrh	r0,[r0]
	add	r0,#1
	uxth	r0,r0
	add	r1,r13,#16
	strh	r0,[r1]
.Lj184:
	ldr	r1,[r13]
	add	r0,r13,#16
	ldrh	r0,[r0]
	ldrb	r0,[r1, r0]
	cmp	r0,#32
	bne	.Lj186
	bl	.Lj183
.Lj186:
	bl	.Lj185
.Lj185:
# [225] Script_EmitCode(Ord(Script[sPtr])-48, Code, @cPtr);
	ldr	r1,[r13]
	add	r0,r13,#16
	ldrh	r0,[r0]
	ldrb	r0,[r1, r0]
	sub	r0,#48
	uxtb	r0,r0
	uxtb	r0,r0
	add	r2,r13,#20
	ldr	r1,[r13, #8]
	bl	IL_INTERPRETER_$$_SCRIPT_EMITCODE$BYTE$PBYTE$PWORD
	bl	.Lj173
.Lj173:
	bl	.Lj187
.Lj167:
# [229] while(Script[sPtr] = ' ') do Inc(sPtr);
	bl	.Lj189
.Lj188:
	add	r0,r13,#16
	ldrh	r0,[r0]
	add	r0,#1
	uxth	r0,r0
	add	r1,r13,#16
	strh	r0,[r1]
.Lj189:
	ldr	r1,[r13]
	add	r0,r13,#16
	ldrh	r0,[r0]
	ldrb	r0,[r1, r0]
	cmp	r0,#32
	bne	.Lj191
	bl	.Lj188
.Lj191:
	bl	.Lj190
.Lj190:
# [230] Script_EmitCode(i_OR, Code, @cPtr);
	add	r2,r13,#20
	ldr	r1,[r13, #8]
	mov	r0,#5
	bl	IL_INTERPRETER_$$_SCRIPT_EMITCODE$BYTE$PBYTE$PWORD
# [231] case Script[sPtr] of
	ldr	r1,[r13]
	add	r0,r13,#16
	ldrh	r0,[r0]
	ldrb	r0,[r1, r0]
	cmp	r0,#73
	bcs	.Lj195
	bl	.Lj192
.Lj195:
	sub	r0,#73
	bne	.Lj196
	bl	.Lj193
.Lj196:
	sub	r0,#8
	bne	.Lj197
	bl	.Lj194
.Lj197:
	bl	.Lj192
.Lj193:
# [233] Script_EmitCode(i_I, Code, @cPtr);
	add	r2,r13,#20
	ldr	r1,[r13, #8]
	mov	r0,#100
	bl	IL_INTERPRETER_$$_SCRIPT_EMITCODE$BYTE$PBYTE$PWORD
# [234] Inc(sPtr);
	add	r0,r13,#16
	ldrh	r0,[r0]
	add	r0,#1
	uxth	r0,r0
	add	r1,r13,#16
	strh	r0,[r1]
# [235] while(Script[sPtr] = ' ') do Inc(sPtr);
	bl	.Lj199
.Lj198:
	add	r0,r13,#16
	ldrh	r0,[r0]
	add	r0,#1
	uxth	r0,r0
	add	r1,r13,#16
	strh	r0,[r1]
.Lj199:
	ldr	r1,[r13]
	add	r0,r13,#16
	ldrh	r0,[r0]
	ldrb	r0,[r1, r0]
	cmp	r0,#32
	bne	.Lj201
	bl	.Lj198
.Lj201:
	bl	.Lj200
.Lj200:
# [236] Script_EmitCode(Ord(Script[sPtr])-48, Code, @cPtr);
	ldr	r1,[r13]
	add	r0,r13,#16
	ldrh	r0,[r0]
	ldrb	r0,[r1, r0]
	sub	r0,#48
	uxtb	r0,r0
	uxtb	r0,r0
	add	r2,r13,#20
	ldr	r1,[r13, #8]
	bl	IL_INTERPRETER_$$_SCRIPT_EMITCODE$BYTE$PBYTE$PWORD
	bl	.Lj192
.Lj194:
# [239] Script_EmitCode(i_Q, Code, @cPtr);
	add	r2,r13,#20
	ldr	r1,[r13, #8]
	mov	r0,#101
	bl	IL_INTERPRETER_$$_SCRIPT_EMITCODE$BYTE$PBYTE$PWORD
# [240] Inc(sPtr);
	add	r0,r13,#16
	ldrh	r0,[r0]
	add	r0,#1
	uxth	r0,r0
	add	r1,r13,#16
	strh	r0,[r1]
# [241] while(Script[sPtr] = ' ') do Inc(sPtr);
	bl	.Lj203
.Lj202:
	add	r0,r13,#16
	ldrh	r0,[r0]
	add	r0,#1
	uxth	r0,r0
	add	r1,r13,#16
	strh	r0,[r1]
.Lj203:
	ldr	r1,[r13]
	add	r0,r13,#16
	ldrh	r0,[r0]
	ldrb	r0,[r1, r0]
	cmp	r0,#32
	bne	.Lj205
	bl	.Lj202
.Lj205:
	bl	.Lj204
.Lj204:
# [242] Script_EmitCode(Ord(Script[sPtr])-48, Code, @cPtr);
	ldr	r1,[r13]
	add	r0,r13,#16
	ldrh	r0,[r0]
	ldrb	r0,[r1, r0]
	sub	r0,#48
	uxtb	r0,r0
	uxtb	r0,r0
	add	r2,r13,#20
	ldr	r1,[r13, #8]
	bl	IL_INTERPRETER_$$_SCRIPT_EMITCODE$BYTE$PBYTE$PWORD
	bl	.Lj192
.Lj192:
.Lj187:
# [246] while (Script[sPtr] <> #10) do Inc(sPtr);
	bl	.Lj207
.Lj206:
	add	r0,r13,#16
	ldrh	r0,[r0]
	add	r0,#1
	uxth	r0,r0
	add	r1,r13,#16
	strh	r0,[r1]
.Lj207:
	ldr	r1,[r13]
	add	r0,r13,#16
	ldrh	r0,[r0]
	ldrb	r0,[r1, r0]
	cmp	r0,#10
	beq	.Lj209
	bl	.Lj206
.Lj209:
	bl	.Lj208
.Lj208:
# [247] Inc(sPtr);
	add	r0,r13,#16
	ldrh	r0,[r0]
	add	r0,#1
	uxth	r0,r0
	add	r1,r13,#16
	strh	r0,[r1]
	bl	.Lj25
.Lj26:
# [251] Inc(sPtr);
	add	r0,r13,#16
	ldrh	r0,[r0]
	add	r0,#1
	uxth	r0,r0
	add	r1,r13,#16
	strh	r0,[r1]
.Lj25:
.Lj8:
	bl	.Lj7
.Lj9:
# [254] Code_Size := cPtr;
	ldr	r1,[r13, #12]
	add	r0,r13,#20
	ldrh	r0,[r0]
	strh	r0,[r1]
# [255] end;
	add	r13,r13,#56
	pop	{r15}
.Lc3:
.Le1:
	.size	IL_INTERPRETER_$$_SCRIPT_SCANNER$PCHAR$WORD$PBYTE$WORD, .Le1 - IL_INTERPRETER_$$_SCRIPT_SCANNER$PCHAR$WORD$PBYTE$WORD

.section .text.n_il_interpreter_$$_set_inputs$pbyte,"ax"
	.balign 4
.thumb_func 
.globl	IL_INTERPRETER_$$_SET_INPUTS$PBYTE
IL_INTERPRETER_$$_SET_INPUTS$PBYTE:
.Lc6:
# [260] begin
	push	{r14}
	sub	r13,r13,#40
# Var inputs located at r13+0, size=OS_32
	str	r0,[r13]
# [261] iIn := inputs;
	ldr	r1,[r13]
	ldr	r0,.Lj212
	str	r1,[r0]
# [262] end;
	add	r13,r13,#40
	pop	{r15}
.Lc5:
	.balign 4
.Lj212:
	.long	U_$IL_INTERPRETER_$$_IIN
.Le2:
	.size	IL_INTERPRETER_$$_SET_INPUTS$PBYTE, .Le2 - IL_INTERPRETER_$$_SET_INPUTS$PBYTE

.section .text.n_il_interpreter_$$_set_outputs$pbyte,"ax"
	.balign 4
.thumb_func 
.globl	IL_INTERPRETER_$$_SET_OUTPUTS$PBYTE
IL_INTERPRETER_$$_SET_OUTPUTS$PBYTE:
.Lc8:
# [265] begin
	push	{r14}
	sub	r13,r13,#40
# Var outputs located at r13+0, size=OS_32
	str	r0,[r13]
# [266] iOut := outputs;
	ldr	r1,[r13]
	ldr	r0,.Lj215
	str	r1,[r0]
# [267] end;
	add	r13,r13,#40
	pop	{r15}
.Lc7:
	.balign 4
.Lj215:
	.long	U_$IL_INTERPRETER_$$_IOUT
.Le3:
	.size	IL_INTERPRETER_$$_SET_OUTPUTS$PBYTE, .Le3 - IL_INTERPRETER_$$_SET_OUTPUTS$PBYTE

.section .text.n_il_interpreter_$$_get_value$pbyte$$byte,"ax"
	.balign 4
.thumb_func 
IL_INTERPRETER_$$_GET_VALUE$PBYTE$$BYTE:
.Lc10:
# [270] begin
	push	{r14}
	sub	r13,r13,#40
# Var pProgram located at r13+0, size=OS_32
# Var $result located at r13+4, size=OS_8
	str	r0,[r13]
# [271] Result := pProgram[pPtr];
	ldr	r1,[r13]
	ldr	r0,.Lj218
	ldrh	r0,[r0]
	ldrb	r0,[r1, r0]
	add	r1,r13,#4
	strb	r0,[r1]
# [272] end;
	add	r1,r13,#4
	ldrb	r0,[r1]
	add	r13,r13,#40
	pop	{r15}
.Lc9:
	.balign 4
.Lj218:
	.long	U_$IL_INTERPRETER_$$_PPTR
.Le4:
	.size	IL_INTERPRETER_$$_GET_VALUE$PBYTE$$BYTE, .Le4 - IL_INTERPRETER_$$_GET_VALUE$PBYTE$$BYTE

.section .text.n_il_interpreter_$$_get_addressing$pbyte$$byte,"ax"
	.balign 4
.thumb_func 
IL_INTERPRETER_$$_GET_ADDRESSING$PBYTE$$BYTE:
.Lc12:
# [275] begin
	push	{r4,r14}
	sub	r13,r13,#40
# Var pProgram located at r13+0, size=OS_32
# Var $result located at r13+4, size=OS_8
	str	r0,[r13]
# [276] Result := 0;
	mov	r1,#0
	add	r0,r13,#4
	strb	r1,[r0]
# [277] case pProgram[pPtr] of
	ldr	r1,[r13]
	ldr	r0,.Lj224
	ldrh	r0,[r0]
	ldrb	r0,[r1, r0]
	cmp	r0,#100
	bcs	.Lj225
	bl	.Lj221
.Lj225:
	sub	r0,#100
	bne	.Lj226
	bl	.Lj222
.Lj226:
	sub	r0,#1
	bne	.Lj227
	bl	.Lj223
.Lj227:
	bl	.Lj221
.Lj222:
# [279] Inc(pPtr);
	ldr	r0,.Lj224
	mov	r1,r0
	ldrh	r0,[r1]
	add	r0,#1
	uxth	r0,r0
	strh	r0,[r1]
# [280] vm_r2 := iIn[Get_Value(pProgram)];
	ldr	r0,.Lj229
	ldr	r4,[r0]
	ldr	r0,[r13]
	bl	IL_INTERPRETER_$$_GET_VALUE$PBYTE$$BYTE
	uxtb	r0,r0
	ldrb	r1,[r4, r0]
	ldr	r0,.Lj230
	strb	r1,[r0]
# [281] if(vm_r2 = 1) then
	ldr	r0,.Lj230
	ldrb	r0,[r0]
	cmp	r0,#1
	bne	.Lj234
	bl	.Lj232
.Lj234:
	bl	.Lj233
.Lj232:
# [282] status_register := status_register OR ( 1 << SR_STATE)
	ldr	r0,.Lj235
	ldrb	r0,[r0]
	mov	r1,#2
	orr	r0,r1
	uxtb	r1,r0
	ldr	r0,.Lj235
	strb	r1,[r0]
	bl	.Lj237
.Lj233:
# [284] status_register := status_register AND NOT ( 1 << SR_STATE);
	ldr	r0,.Lj235
	ldrb	r0,[r0]
	mov	r1,r0
	ldr	r0,.Lj239
	and	r1,r0
	uxtb	r1,r1
	ldr	r0,.Lj235
	strb	r1,[r0]
.Lj237:
	bl	.Lj221
.Lj223:
# [287] Inc(pPtr);
	ldr	r0,.Lj224
	mov	r1,r0
	ldrh	r0,[r1]
	add	r0,#1
	uxth	r0,r0
	strh	r0,[r1]
# [288] vm_r2 := iOut[Get_Value(pProgram)];
	ldr	r0,.Lj242
	ldr	r4,[r0]
	ldr	r0,[r13]
	bl	IL_INTERPRETER_$$_GET_VALUE$PBYTE$$BYTE
	uxtb	r0,r0
	ldrb	r0,[r4, r0]
	ldr	r1,.Lj230
	strb	r0,[r1]
# [289] if(vm_r2 = 1) then
	ldr	r0,.Lj230
	ldrb	r0,[r0]
	cmp	r0,#1
	bne	.Lj247
	bl	.Lj245
.Lj247:
	bl	.Lj246
.Lj245:
# [290] status_register := status_register OR ( 1 << SR_STATE)
	ldr	r0,.Lj235
	ldrb	r0,[r0]
	mov	r1,#2
	orr	r0,r1
	uxtb	r0,r0
	ldr	r1,.Lj235
	strb	r0,[r1]
	bl	.Lj250
.Lj246:
# [292] status_register := status_register AND NOT ( 1 << SR_STATE);
	ldr	r0,.Lj235
	ldrb	r0,[r0]
	mov	r1,r0
	ldr	r0,.Lj239
	and	r1,r0
	uxtb	r0,r1
	ldr	r1,.Lj235
	strb	r0,[r1]
.Lj250:
	bl	.Lj221
.Lj221:
# [295] Result := vm_r2;
	ldr	r0,.Lj230
	ldrb	r0,[r0]
	add	r1,r13,#4
	strb	r0,[r1]
# [296] end;
	add	r1,r13,#4
	ldrb	r0,[r1]
	add	r13,r13,#40
	pop	{r4,r15}
.Lc11:
	.balign 4
.Lj224:
	.long	U_$IL_INTERPRETER_$$_PPTR
.Lj229:
	.long	U_$IL_INTERPRETER_$$_IIN
.Lj230:
	.long	U_$IL_INTERPRETER_$$_VM_R2
.Lj235:
	.long	U_$IL_INTERPRETER_$$_STATUS_REGISTER
.Lj239:
	.long	-3
.Lj242:
	.long	U_$IL_INTERPRETER_$$_IOUT
.Le5:
	.size	IL_INTERPRETER_$$_GET_ADDRESSING$PBYTE$$BYTE, .Le5 - IL_INTERPRETER_$$_GET_ADDRESSING$PBYTE$$BYTE

.section .text.n_il_interpreter_$$_put_addressing$pbyte,"ax"
	.balign 4
.thumb_func 
IL_INTERPRETER_$$_PUT_ADDRESSING$PBYTE:
.Lc14:
# [301] begin
	push	{r14}
	sub	r13,r13,#40
# Var pProgram located at r13+0, size=OS_32
# Var val located at r13+4, size=OS_8
	str	r0,[r13]
# [302] case pProgram[pPtr] of
	ldr	r1,[r13]
	ldr	r0,.Lj259
	ldrh	r0,[r0]
	ldrb	r0,[r1, r0]
	cmp	r0,#101
	bcs	.Lj260
	bl	.Lj257
.Lj260:
	sub	r0,#101
	bne	.Lj261
	bl	.Lj258
.Lj261:
	bl	.Lj257
.Lj258:
# [305] Inc(pPtr);
	ldr	r0,.Lj259
	mov	r1,r0
	ldrh	r0,[r1]
	add	r0,#1
	uxth	r0,r0
	strh	r0,[r1]
# [306] val := Get_Value(pProgram);
	ldr	r0,[r13]
	bl	IL_INTERPRETER_$$_GET_VALUE$PBYTE$$BYTE
	uxtb	r0,r0
	add	r1,r13,#4
	strb	r0,[r1]
# [307] iOut[val] := vm_r1;
	ldr	r0,.Lj263
	ldr	r2,[r0]
	add	r0,r13,#4
	ldrb	r1,[r0]
	ldr	r0,.Lj264
	ldrb	r0,[r0]
	strb	r0,[r2, r1]
	bl	.Lj257
.Lj257:
# [310] end;
	add	r13,r13,#40
	pop	{r15}
.Lc13:
	.balign 4
.Lj259:
	.long	U_$IL_INTERPRETER_$$_PPTR
.Lj263:
	.long	U_$IL_INTERPRETER_$$_IOUT
.Lj264:
	.long	U_$IL_INTERPRETER_$$_VM_R1
.Le6:
	.size	IL_INTERPRETER_$$_PUT_ADDRESSING$PBYTE, .Le6 - IL_INTERPRETER_$$_PUT_ADDRESSING$PBYTE

.section .text.n_il_interpreter_$$_interpreter_get_instruction$pbyte,"ax"
	.balign 4
.thumb_func 
IL_INTERPRETER_$$_INTERPRETER_GET_INSTRUCTION$PBYTE:
.Lc16:
# [314] begin
	push	{r14}
	sub	r13,r13,#40
# Var pProgram located at r13+0, size=OS_32
	str	r0,[r13]
# [315] case pProgram[pPtr] of
	ldr	r1,[r13]
	ldr	r0,.Lj276
	ldrh	r0,[r0]
	ldrb	r0,[r1, r0]
	cmp	r0,#1
	bcs	.Lj277
	bl	.Lj267
.Lj277:
	sub	r0,#1
	bne	.Lj278
	bl	.Lj268
.Lj278:
	sub	r0,#1
	bne	.Lj279
	bl	.Lj269
.Lj279:
	sub	r0,#1
	bne	.Lj280
	bl	.Lj270
.Lj280:
	sub	r0,#1
	bne	.Lj281
	bl	.Lj271
.Lj281:
	sub	r0,#1
	bne	.Lj282
	bl	.Lj272
.Lj282:
	sub	r0,#1
	bne	.Lj283
	bl	.Lj273
.Lj283:
	sub	r0,#6
	bne	.Lj284
	bl	.Lj274
.Lj284:
	sub	r0,#1
	bne	.Lj285
	bl	.Lj275
.Lj285:
	bl	.Lj267
.Lj268:
# [317] Inc(pPtr);
	ldr	r0,.Lj276
	mov	r1,r0
	ldrh	r0,[r1]
	add	r0,#1
	uxth	r0,r0
	strh	r0,[r1]
# [318] vm_r1 := Get_Addressing(pProgram);
	ldr	r0,[r13]
	bl	IL_INTERPRETER_$$_GET_ADDRESSING$PBYTE$$BYTE
	uxtb	r1,r0
	ldr	r0,.Lj287
	strb	r1,[r0]
	bl	.Lj267
.Lj269:
# [322] Inc(pPtr);
	ldr	r0,.Lj276
	mov	r1,r0
	ldrh	r0,[r1]
	add	r0,#1
	uxth	r0,r0
	strh	r0,[r1]
# [323] Put_Addressing(pProgram);
	ldr	r0,[r13]
	bl	IL_INTERPRETER_$$_PUT_ADDRESSING$PBYTE
	bl	.Lj267
.Lj270:
# [326] Inc(pPtr);
	ldr	r0,.Lj276
	mov	r1,r0
	ldrh	r0,[r1]
	add	r0,#1
	uxth	r0,r0
	strh	r0,[r1]
# [327] vm_r1 := vm_r1 AND Get_Addressing(pProgram);
	ldr	r0,[r13]
	bl	IL_INTERPRETER_$$_GET_ADDRESSING$PBYTE$$BYTE
	uxtb	r1,r0
	ldr	r0,.Lj287
	ldrb	r0,[r0]
	and	r1,r0
	ldr	r0,.Lj287
	strb	r1,[r0]
	bl	.Lj267
.Lj271:
# [330] Inc(pPtr);
	ldr	r0,.Lj276
	mov	r1,r0
	ldrh	r0,[r1]
	add	r0,#1
	uxth	r0,r0
	strh	r0,[r1]
# [331] vm_r1 := (vm_r1 AND NOT Get_Addressing(pProgram));
	ldr	r0,[r13]
	bl	IL_INTERPRETER_$$_GET_ADDRESSING$PBYTE$$BYTE
	uxtb	r0,r0
	mvn	r1,r0
	ldr	r0,.Lj287
	ldrb	r0,[r0]
	and	r1,r0
	ldr	r0,.Lj287
	strb	r1,[r0]
	bl	.Lj267
.Lj272:
# [334] Inc(pPtr);
	ldr	r0,.Lj276
	mov	r1,r0
	ldrh	r0,[r1]
	add	r0,#1
	uxth	r0,r0
	strh	r0,[r1]
# [335] vm_r1 := vm_r1 OR Get_Addressing(pProgram);
	ldr	r0,[r13]
	bl	IL_INTERPRETER_$$_GET_ADDRESSING$PBYTE$$BYTE
	uxtb	r1,r0
	ldr	r0,.Lj287
	ldrb	r0,[r0]
	orr	r1,r0
	ldr	r0,.Lj287
	strb	r1,[r0]
	bl	.Lj267
.Lj273:
# [338] Inc(pPtr);
	ldr	r0,.Lj276
	mov	r1,r0
	ldrh	r0,[r1]
	add	r0,#1
	uxth	r0,r0
	strh	r0,[r1]
# [339] vm_r1 := vm_r1 OR NOT Get_Addressing(pProgram);
	ldr	r0,[r13]
	bl	IL_INTERPRETER_$$_GET_ADDRESSING$PBYTE$$BYTE
	uxtb	r0,r0
	mvn	r1,r0
	ldr	r0,.Lj287
	ldrb	r0,[r0]
	orr	r1,r0
	ldr	r0,.Lj287
	strb	r1,[r0]
	bl	.Lj267
.Lj274:
# [342] i_SET: vm_r1 := 1;
	mov	r1,#1
	ldr	r0,.Lj287
	strb	r1,[r0]
	bl	.Lj267
.Lj275:
# [343] i_CLR: vm_r1 := 0;
	mov	r1,#0
	ldr	r0,.Lj287
	strb	r1,[r0]
	bl	.Lj267
.Lj267:
# [346] if(vm_r1 = 1) then
	ldr	r0,.Lj287
	ldrb	r0,[r0]
	cmp	r0,#1
	bne	.Lj306
	bl	.Lj304
.Lj306:
	bl	.Lj305
.Lj304:
# [347] status_register := status_register OR ( 1 << SR_RESULT)
	ldr	r0,.Lj307
	ldrb	r0,[r0]
	mov	r1,#4
	orr	r0,r1
	uxtb	r0,r0
	ldr	r1,.Lj307
	strb	r0,[r1]
	bl	.Lj309
.Lj305:
# [349] status_register := status_register AND NOT( 1 << SR_RESULT);
	ldr	r0,.Lj307
	ldrb	r0,[r0]
	mov	r1,r0
	ldr	r0,.Lj311
	and	r1,r0
	uxtb	r0,r1
	ldr	r1,.Lj307
	strb	r0,[r1]
.Lj309:
# [350] end;
	add	r13,r13,#40
	pop	{r15}
.Lc15:
	.balign 4
.Lj276:
	.long	U_$IL_INTERPRETER_$$_PPTR
.Lj287:
	.long	U_$IL_INTERPRETER_$$_VM_R1
.Lj307:
	.long	U_$IL_INTERPRETER_$$_STATUS_REGISTER
.Lj311:
	.long	-5
.Le7:
	.size	IL_INTERPRETER_$$_INTERPRETER_GET_INSTRUCTION$PBYTE, .Le7 - IL_INTERPRETER_$$_INTERPRETER_GET_INSTRUCTION$PBYTE

.section .text.n_il_interpreter_$$_interpreter_loop,"ax"
	.balign 4
.thumb_func 
.globl	IL_INTERPRETER_$$_INTERPRETER_LOOP
IL_INTERPRETER_$$_INTERPRETER_LOOP:
.Lc18:
# [353] begin
	push	{r14}
	sub	r13,r13,#32
# [354] if(Interpreter_Run = True) then begin
	ldr	r0,.Lj317
	ldrb	r0,[r0]
	cmp	r0,#0
	beq	.Lj318
	bl	.Lj315
.Lj318:
	bl	.Lj316
.Lj315:
# [355] pPtr := 0;
	mov	r1,#0
	ldr	r0,.Lj319
	strh	r1,[r0]
# [356] while(pPtr < ilProgram_Size) do begin
	bl	.Lj321
.Lj320:
# [357] Interpreter_Get_Instruction(ilProgram);
	ldr	r0,.Lj323
	bl	IL_INTERPRETER_$$_INTERPRETER_GET_INSTRUCTION$PBYTE
# [358] Inc(pPtr);
	ldr	r0,.Lj319
	mov	r1,r0
	ldrh	r0,[r1]
	add	r0,#1
	uxth	r0,r0
	strh	r0,[r1]
.Lj321:
	ldr	r0,.Lj319
	ldrh	r1,[r0]
	ldr	r0,.Lj326
	ldrh	r0,[r0]
	cmp	r1,r0
	bcs	.Lj327
	bl	.Lj320
.Lj327:
	bl	.Lj322
.Lj322:
.Lj316:
# [361] end;
	add	r13,r13,#32
	pop	{r15}
.Lc17:
	.balign 4
.Lj317:
	.long	U_$IL_INTERPRETER_$$_INTERPRETER_RUN
.Lj319:
	.long	U_$IL_INTERPRETER_$$_PPTR
.Lj323:
	.long	U_$IL_INTERPRETER_$$_ILPROGRAM
.Lj326:
	.long	U_$IL_INTERPRETER_$$_ILPROGRAM_SIZE
.Le8:
	.size	IL_INTERPRETER_$$_INTERPRETER_LOOP, .Le8 - IL_INTERPRETER_$$_INTERPRETER_LOOP
# End asmlist al_procedures
# Begin asmlist al_globals

.section .bss.n_u_$il_interpreter_$$_interpreter_run,"aw",%nobits
# [46] Interpreter_Run : Boolean;
	.globl U_$IL_INTERPRETER_$$_INTERPRETER_RUN
	.size U_$IL_INTERPRETER_$$_INTERPRETER_RUN,1
U_$IL_INTERPRETER_$$_INTERPRETER_RUN:
	.zero 1

.section .bss.n_u_$il_interpreter_$$_usersript,"aw",%nobits
# [47] UserSript : array[0..MAX_SCRIPT_SIZE] of Char;
	.globl U_$IL_INTERPRETER_$$_USERSRIPT
	.size U_$IL_INTERPRETER_$$_USERSRIPT,1025
U_$IL_INTERPRETER_$$_USERSRIPT:
	.zero 1025

.section .bss.n_u_$il_interpreter_$$_usersript_size,"aw",%nobits
	.balign 2
# [48] UserSript_Size : word;
	.globl U_$IL_INTERPRETER_$$_USERSRIPT_SIZE
	.size U_$IL_INTERPRETER_$$_USERSRIPT_SIZE,2
U_$IL_INTERPRETER_$$_USERSRIPT_SIZE:
	.zero 2

.section .bss.n_u_$il_interpreter_$$_ilprogram,"aw",%nobits
# [49] ilProgram : array[0..MAX_PROGRAM_SIZE] of Byte;
	.globl U_$IL_INTERPRETER_$$_ILPROGRAM
	.size U_$IL_INTERPRETER_$$_ILPROGRAM,513
U_$IL_INTERPRETER_$$_ILPROGRAM:
	.zero 513

.section .bss.n_u_$il_interpreter_$$_ilprogram_size,"aw",%nobits
	.balign 2
# [50] ilProgram_Size : word;
	.globl U_$IL_INTERPRETER_$$_ILPROGRAM_SIZE
	.size U_$IL_INTERPRETER_$$_ILPROGRAM_SIZE,2
U_$IL_INTERPRETER_$$_ILPROGRAM_SIZE:
	.zero 2

.section .bss.n_u_$il_interpreter_$$_iin,"aw",%nobits
	.balign 4
# [61] iIn : PByte;
	.size U_$IL_INTERPRETER_$$_IIN,4
U_$IL_INTERPRETER_$$_IIN:
	.zero 4

.section .bss.n_u_$il_interpreter_$$_iout,"aw",%nobits
	.balign 4
# [62] iOut : PByte;
	.size U_$IL_INTERPRETER_$$_IOUT,4
U_$IL_INTERPRETER_$$_IOUT:
	.zero 4

.section .bss.n_u_$il_interpreter_$$_pptr,"aw",%nobits
	.balign 2
# [64] pPtr : word;
	.size U_$IL_INTERPRETER_$$_PPTR,2
U_$IL_INTERPRETER_$$_PPTR:
	.zero 2

.section .bss.n_u_$il_interpreter_$$_vm_r1,"aw",%nobits
# [65] vm_r1, vm_r2 : byte;
	.size U_$IL_INTERPRETER_$$_VM_R1,1
U_$IL_INTERPRETER_$$_VM_R1:
	.zero 1

.section .bss.n_u_$il_interpreter_$$_vm_r2,"aw",%nobits
	.size U_$IL_INTERPRETER_$$_VM_R2,1
U_$IL_INTERPRETER_$$_VM_R2:
	.zero 1

.section .bss.n_u_$il_interpreter_$$_status_register,"aw",%nobits
# [66] status_register : byte;
	.size U_$IL_INTERPRETER_$$_STATUS_REGISTER,1
U_$IL_INTERPRETER_$$_STATUS_REGISTER:
	.zero 1
# End asmlist al_globals
# Begin asmlist al_rtti

.section .rodata.n_RTTI_$IL_INTERPRETER_$$_TINPUTPINS
	.balign 4
.globl	RTTI_$IL_INTERPRETER_$$_TINPUTPINS
RTTI_$IL_INTERPRETER_$$_TINPUTPINS:
	.byte	12,10
# [364] 
	.ascii	"TInputPins"
	.long	0,4,4
	.long	RTTI_$SYSTEM_$$_BYTE$indirect
	.byte	1,0,0,0
	.long	RTTI_$SYSTEM_$$_SHORTINT$indirect
.Le9:
	.size	RTTI_$IL_INTERPRETER_$$_TINPUTPINS, .Le9 - RTTI_$IL_INTERPRETER_$$_TINPUTPINS

.section .rodata.n_RTTI_$IL_INTERPRETER_$$_TOUTPUTPINS
	.balign 4
.globl	RTTI_$IL_INTERPRETER_$$_TOUTPUTPINS
RTTI_$IL_INTERPRETER_$$_TOUTPUTPINS:
	.byte	12,11
	.ascii	"TOutputPins"
	.byte	0,0,0
	.long	0,4,4
	.long	RTTI_$SYSTEM_$$_BYTE$indirect
	.byte	1,0,0,0
	.long	RTTI_$SYSTEM_$$_SHORTINT$indirect
.Le10:
	.size	RTTI_$IL_INTERPRETER_$$_TOUTPUTPINS, .Le10 - RTTI_$IL_INTERPRETER_$$_TOUTPUTPINS
# End asmlist al_rtti
# Begin asmlist al_indirectglobals

.section .rodata.n_RTTI_$IL_INTERPRETER_$$_TINPUTPINS
	.balign 4
.globl	RTTI_$IL_INTERPRETER_$$_TINPUTPINS$indirect
RTTI_$IL_INTERPRETER_$$_TINPUTPINS$indirect:
	.long	RTTI_$IL_INTERPRETER_$$_TINPUTPINS
.Le11:
	.size	RTTI_$IL_INTERPRETER_$$_TINPUTPINS$indirect, .Le11 - RTTI_$IL_INTERPRETER_$$_TINPUTPINS$indirect

.section .rodata.n_RTTI_$IL_INTERPRETER_$$_TOUTPUTPINS
	.balign 4
.globl	RTTI_$IL_INTERPRETER_$$_TOUTPUTPINS$indirect
RTTI_$IL_INTERPRETER_$$_TOUTPUTPINS$indirect:
	.long	RTTI_$IL_INTERPRETER_$$_TOUTPUTPINS
.Le12:
	.size	RTTI_$IL_INTERPRETER_$$_TOUTPUTPINS$indirect, .Le12 - RTTI_$IL_INTERPRETER_$$_TOUTPUTPINS$indirect
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

