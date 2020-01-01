{
  Unit name: Delay for LPC1114
  Author: Dariusz Kwiecinski ( kwiecinskidarek@gmail.com )
  Date: 01.01.2020r;
}
unit delay;

interface

const
	PRESCALE_US = 48;
	PRESCALE_MS = 48000;
{$MACRO ON}

{$DEFINE TIMER := LPC_TMR16B0}
//{$DEFINE TIMER := LPC_TMR16B1}
//{$DEFINE TIMER := LPC_TMR32B0}
//{$DEFINE TIMER := LPC_TMR32B1}

{$DEFINE TIMER_SYSAHBCLKCTRL_BIT := CT16B0_SYSAHBCLKCTRL_BIT}
//{$DEFINE TIMER_SYSAHBCLKCTRL_BIT := CT16B1_SYSAHBCLKCTRL_BIT}
//{$DEFINE TIMER_SYSAHBCLKCTRL_BIT := CT32B0_SYSAHBCLKCTRL_BIT}
//{$DEFINE TIMER_SYSAHBCLKCTRL_BIT := CT32B1_SYSAHBCLKCTRL_BIT}

procedure Delay_Init();
procedure Delay_MS(time : longword);
procedure Delay_US(time : longword);

implementation

uses system_LPC1114, utils;

procedure Delay_Init();
begin
	SetBit(LPC_SYSCON.SYSAHBCLKCTRL, TIMER_SYSAHBCLKCTRL_BIT);
	TIMER.IR := $FF;
	TIMER.MCR := $04;
	TIMER.PR := PRESCALE_MS;
end;

procedure Delay_Ticks(ticks : longword);
begin
	TIMER.TCR := $02;
	TIMER.MR0 := ticks;
	TIMER.TCR := $01;
	while (TIMER.TCR = 1) do;	
end;

procedure Delay_US(time : longword);
begin
	TIMER.PR := PRESCALE_US;
	Delay_Ticks(time);
end;

procedure Delay_MS(time : longword);
begin
	TIMER.PR := PRESCALE_MS;
	Delay_Ticks(time);
end;

end.
