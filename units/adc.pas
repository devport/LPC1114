unit adc;

interface

procedure ADC_Init();
function ADC_Get(channel : byte) : word;

implementation

uses system_LPC1114, utils;

procedure ADC_Init();
begin
	// Enable power
	ClearBit(LPC_SYSCON.PDRUNCFG, 4) ;
	// Enable clock
	SetBit(LPC_SYSCON.SYSAHBCLKCTRL, ADC_SYSAHBCLKCTRL_BIT);
end;

function ADC_Get(channel : byte) : word;
var
	val : longword = 0;
begin
	ADC_Get := 0;
	// Select channel and set converter frequency 48/11 = 4.36Mhz
	LPC_ADC.CR := ADCR_CLKDIV or (1 << channel);
	// Power on 
	SetBit(LPC_ADC.CR, 24);
	// Wait convert in progress
	val := LPC_ADC.GDR;
	while (val and (1 << 31)) = 0 do 
		val := LPC_ADC.GDR;
	// Power off
	ClearBit(LPC_ADC.CR, 24);
	if (val and (1 << 30)) = 0 then 
		ADC_Get := (val >> 6) and $3ff;
	
end;

end.
