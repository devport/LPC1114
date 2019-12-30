unit system_LPC1114;

interface

{$define CLOCK_SETUP}
{$define MAIN_PLL_SETUP}

const
  IRC_OSCILATOR         = $00000000;
  INPUT_TO_SYS_PLL      = $00000001;
  WDT_OSCILATOR         = $00000002;
  SYS_PLL_CLK_OUT       = $00000003;

  // -- CONFIG --
  MAIN_CLKSRCSEL_Val = INPUT_TO_SYS_PLL;
  MAIN_PLL_P_Val = $00000001;
  MAIN_PLL_M_Val = $00000003;
  SYS_AHB_DIV_Val = 1;

  XTAL     = 12000000;
  OSC_CLK  = XTAL;
  IRC_OSC  = 4000000;
  WDT_OSC  = 240000;
  // -- CONFIG --


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

  // Port
 GPIO_Port_0				= 0;
 GPIO_Port_1				= 1;
 GPIO_Port_2				= 2;
 GPIO_Port_3				= 3;

 //SYSAHBCLKDIV bits
 SYS_SYSAHBCLKDIV_BIT			= 0;
 ROM_SYSAHBCLKDIV_BIT			= 1;
 RAM_SYSAHBCLKDIV_BIT			= 2;
 FLASHREG_SYSAHBCLKDIV_BIT		= 3;
 FLASHARRAY_SYSAHBCLKDIV_BIT	        = 4;
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

 // ADC
 ADCR_CLKDIV				= ( 10 << 8);
 
 procedure SystemInit();

var
  ClockSource : longword = IRC_OSC;
  SystemFrequency : longword = IRC_OSC;
  SystemAHBFrequency : longword = IRC_OSC;
 
implementation


procedure SystemInit();
var
	i, regVal : longword;
begin
{$ifdef CLOCK_SETUP}
  LPC_SYSCON.SYSOSCCTRL := $00;
  LPC_SYSCON.PDRUNCFG := LPC_SYSCON.PDRUNCFG AND NOT (1 shl 5);

  for i := 0 to 255 do;

  {$ifdef MAIN_PLL_SETUP}
    ClockSource := OSC_CLK;
    LPC_SYSCON.SYSPLLCLKSEL := MAIN_CLKSRCSEL_Val;
    LPC_SYSCON.SYSPLLCLKUEN := $01;
    LPC_SYSCON.SYSPLLCLKUEN := $00;
    LPC_SYSCON.SYSPLLCLKUEN := $01;
    while (LPC_SYSCON.SYSPLLCLKUEN AND $01) = 0 do; // wait until updated

    regVal := LPC_SYSCON.SYSPLLCTRL;
    regVal := regVal AND NOT $1FF;
    LPC_SYSCON.SYSPLLCTRL := (regVal OR (MAIN_PLL_P_Val shl 5) OR MAIN_PLL_M_Val);

    LPC_SYSCON.PDRUNCFG := LPC_SYSCON.PDRUNCFG AND NOT (1 shl 7);
    while (LPC_SYSCON.SYSPLLSTAT AND $01) = 0 do; // wait until it's locked

    LPC_SYSCON.MAINCLKSEL := $03;
    LPC_SYSCON.MAINCLKUEN := $01;
    LPC_SYSCON.MAINCLKUEN := $00;
    LPC_SYSCON.MAINCLKUEN := $01;
    while (LPC_SYSCON.MAINCLKUEN AND $01) = 0 do;  // wait until updated

    LPC_SYSCON.SYSAHBCLKDIV := SYS_AHB_DIV_Val;

    SystemFrequency := ClockSource * (MAIN_PLL_M_Val + 1);

    SystemAHBFrequency := SystemFrequency div SYS_AHB_DIV_Val;
  {$endif}

{$endif} // Endif CLOCK_SETUP
  LPC_SYSCON.SYSAHBCLKCTRL := LPC_SYSCON.SYSAHBCLKCTRL OR (1 shl IOCON_SYSAHBCLKCTRL_BIT);
end;

end.
