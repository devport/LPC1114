{

 System definitions and utility code for Init LPC1114
 Created by Darek Kwiecinski 2019 - kwiecinskidarek@gmail.com

}
unit system_LPC1114;

interface

const 
 // GPIO PINS
 GPIO_Pin_0                 = $0001;  { Pin 0 selected }
 GPIO_Pin_1                 = $0002;  { Pin 1 selected }
 GPIO_Pin_2                 = $0004;  { Pin 2 selected }
 GPIO_Pin_3                 = $0008;  { Pin 3 selected }
 GPIO_Pin_4                 = $0010;  { Pin 4 selected }
 GPIO_Pin_5                 = $0020;  { Pin 5 selected }
 GPIO_Pin_6                 = $0040;  { Pin 6 selected }
 GPIO_Pin_7                 = $0080;  { Pin 7 selected }
 GPIO_Pin_8                 = $0100;  { Pin 8 selected }
 GPIO_Pin_9                 = $0200;  { Pin 9 selected }
 GPIO_Pin_10                = $0400;  { Pin 10 selected }
 GPIO_Pin_11                = $0800;  { Pin 11 selected }
 GPIO_Pin_12                = $1000;  { Pin 12 selected }
 GPIO_Pin_13                = $2000;  { Pin 13 selected }
 GPIO_Pin_14                = $4000;  { Pin 14 selected }
 GPIO_Pin_15                = $8000;  { Pin 15 selected }
 GPIO_Pin_All               = $FFFF;  { All pins selected }

 CLOCK_SETUP           		= 1;
 SYSOSCCTRL_Val        		= $0000;              // Reset: 0x000
 WDTOSCCTRL_Val        		= $0000;              // Reset: 0x000
 SYSPLLCTRL_Val        		= $0023;              // Reset: 0x000
 MAINCLKSEL_Val        		= $0003;              // Reset: 0x000
 SYSAHBCLKDIV_Val      		= $0001;              // Reset: 0x001
 
 SYSOSCCTRL_FREQRANGE		= $00010;
 SYSPLLCLKSEL_OSC      		= $0001;
 
 //SYSAHBCLKDIV bits
 SYS_SYSAHBCLKDIV_BIT			= 0;
 ROM_SYSAHBCLKDIV_BIT			= 1;
 RAM_SYSAHBCLKDIV_BIT			= 2;
 FLASHREG_SYSAHBCLKDIV_BIT		= 3;
 FLASHARRAY_SYSAHBCLKDIV_BIT	= 4;
 I2C_SYSAHBCLKDIV_BIT			= 5;
 GPIO_SYSAHBCLKDIV_BIT			= 6;
 CT16B0_SYSAHBCLKCTRL_BIT		= 7;
 CT16B1_SYSAHBCLKCTRL_BIT		= 8;
 CT32B0_SYSAHBCLKCTRL_BIT		= 9;
 CT32B1_SYSAHBCLKCTRL_BIT		= 10;
 SSP0_SYSAHBCLKCTRL_BIT			= 11;
 UART_SYSAHBCLKCTRL_BIT			= 12;
 ADC_SYSAHBCLKCTRL_BIT			= 13;
 WDT_SYSAHBCLKCTRL_BIT			= 15;
 IOCON_SYSAHBCLKCTRL_BIT		= 16;
 CAN_SYSAHBCLKCTRL_BIT			= 17;
 SSP1_SYSAHBCLKCTRL_BIT			= 18;
 
 // Port
 GPIO_Port_0				= 0;
 GPIO_Port_1				= 1;
 GPIO_Port_2				= 2;
 GPIO_Port_3				= 3;
 // ADC
 
 ADCR_CLKDIV				= ( 10 << 8);
 
 procedure SystemInit(crystal : longword; frequency : longword ); 
 
implementation


procedure SystemInit(crystal : longword; frequency : longword );
var
	i, p : byte;
	m, fcco : longword;
begin
	p := 0;
	// select source osc
	if crystal < 17500000 then 
		LPC_SYSCON.SYSOSCCTRL := 0
	else
		LPC_SYSCON.SYSOSCCTRL := SYSOSCCTRL_FREQRANGE;
		
	LPC_SYSCON.PDRUNCFG := LPC_SYSCON.PDRUNCFG and not(1 shl 5);
		
	for i:=0 to 200 do asm nop; end;
	// ------------------------------------------------
	LPC_SYSCON.SYSPLLCLKSEL := SYSPLLCLKSEL_OSC;
  LPC_SYSCON.SYSPLLCLKUEN := $01;
  LPC_SYSCON.SYSPLLCLKUEN := $00;
	LPC_SYSCON.SYSPLLCLKUEN := $01;
	while ((LPC_SYSCON.SYSPLLCLKUEN and $01) = 0) do begin end;
	
	
	m := frequency div crystal;
	fcco := m * crystal * 2;
	
	frequency := crystal * m;
	
	while fcco < 156000000 do 
	begin
		fcco := fcco * 2;
		inc(p);
	end;
	
	LPC_SYSCON.SYSPLLCTRL := ((m-1) shl 0) or (p shl 5);
	LPC_SYSCON.PDRUNCFG  := LPC_SYSCON.PDRUNCFG and not (1 shl 7);
	while ((LPC_SYSCON.SYSPLLSTAT and $01) = 0) do begin end;
	
	
	LPC_SYSCON.MAINCLKSEL := MAINCLKSEL_Val;
  LPC_SYSCON.MAINCLKUEN := $01;
  LPC_SYSCON.MAINCLKUEN := $00;
	LPC_SYSCON.MAINCLKUEN := $01;
	while ((LPC_SYSCON.MAINCLKUEN and $01) = 0) do begin end;
	
	LPC_SYSCON.SYSAHBCLKDIV := SYSAHBCLKDIV_Val;
	
end;

end.
