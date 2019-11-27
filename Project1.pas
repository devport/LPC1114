Program Project1;

uses
	utils, delay, adc, spi, uart, system_LPC1114;

const
	OSC = 12000000;
	FREQ = 48000000;
        
begin
	SystemInit(OSC, FREQ);
	LPC_SYSCON.SYSAHBCLKCTRL := LPC_SYSCON.SYSAHBCLKCTRL or ((1 shl 6) or (1 shl 16));

	Delay_Init();
	UART_Init();
	ADC_Init();

	LPC_IOCON.R_PIO0_11 := $02;

	SetOutputs(2, GPIO_Pin_1);
	SetInputs(0, GPIO_Pin_11);

	UART_Send('Hello World'+#10+#13);
	UART_Send('ADC: '+IntToStr(ADC_Get(0)+#10+#13);
    

	while true do
	begin
		ClrPins(2, GPIO_Pin_1);
		Delay_MS(1000);

               
		SetPins(2, GPIO_Pin_1);
		Delay_MS(100);
	end;
end.


