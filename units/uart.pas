{
  Unit name: UART for LPC1114
  Author: Dariusz Kwiecinski ( kwiecinskidarek@gmail.com )
  Date: 01.01.2020r;
}
unit uart;

interface

{$MACRO ON}
{$define BAUDRATE := 115200}
{$define BAUDRATEDIVISOR := (48000000 div (BAUDRATE*16)) }


uses system_LPC1114;

procedure UART_Init();
procedure UART_Send_Byte(data : byte);
procedure UART_Send(data : String);
procedure UART_Send(data : PChar; data_size : word);
function UART_Recv_Byte() : byte;

implementation

uses utils;

procedure UART_Init();
begin
	SetBit(LPC_SYSCON.SYSAHBCLKCTRL, UART_SYSAHBCLKCTRL_BIT);
	SetBit(LPC_SYSCON.SYSAHBCLKCTRL, IOCON_SYSAHBCLKCTRL_BIT);
	
	LPC_IOCON.PIO1_6 := LPC_IOCON.PIO1_6 and $07;
	LPC_IOCON.PIO1_6 := LPC_IOCON.PIO1_6 or $01;
	
	LPC_IOCON.PIO1_7 := LPC_IOCON.PIO1_7 and $07;
	LPC_IOCON.PIO1_7 := LPC_IOCON.PIO1_7 or $01;
	
	LPC_SYSCON.UARTCLKDIV := $01;
	
	LPC_UART.IIR_FCR := $0700;

	LPC_UART.LCR := LPC_UART.LCR or $0080;// DLAB = 1;
	LPC_UART.RBR_THR_DLL := BAUDRATEDIVISOR;
	LPC_UART.DLM_IER := BAUDRATEDIVISOR >> 8;
	LPC_UART.LCR := LPC_UART.LCR and $0080; // DLAB = 0;
	
	//Ustaw tryb
	LPC_UART.LCR := $03; //8 bit word length, 1 stop bit, No parity 
	
	//LPC_IOCON->PIO1_5 |= 0x01;
	//LPC_GPIO1.DIR := LPC_GPIO1.DIR or GPIO_Pin_5;
	//LPC_GPIO1->DATA &= ~(1 << 5);
	//LPC_GPIO1.MASKED_ACCESS[GPIO_Pin_5] := GPIO_Pin_5;
	
end;

procedure UART_Send_Byte(data : byte);
begin
	while (LPC_UART.LSR and $20) = 0 do;
	LPC_UART.RBR_THR_DLL := data;
end;

procedure UART_Send(data : PChar; data_size : word);
var
	i : word;
begin
	i := 0;
	while i <= data_size do
	begin
		UART_Send_Byte(byte(data[i]));
		inc(i);
	end;
end;

procedure UART_Send(data : String);
var
	i : word;
begin
	i := 1;
	while i <= length(data) do
	begin
		UART_Send_Byte(byte(data[i]));
		inc(i);
	end;
end;

function UART_Recv_Byte() : byte;
begin
	while not (LPC_UART.LSR and $01) = 0 do;
	UART_Recv_Byte := LPC_UART.RBR_THR_DLL;
end;


end.
