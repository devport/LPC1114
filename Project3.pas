{

 SysTick Timer Demo
 Created by Darek Kwiecinski 2019 - kwiecinskidarek@gmail.com

} 
program project2;

uses
    cortexm0, system_LPC1114, utils, delay;

const
     OSC = 12000000;
     FREQ = 48000000;

procedure SysTick_interrupt; public Name 'SysTick_interrupt'; interrupt;
begin
  TogglePin(0, GPIO_Pin_1);
end;

begin
     // Inicjalize System Clock
     SystemInit(OSC, FREQ);
     LPC_SYSCON.SYSAHBCLKCTRL := LPC_SYSCON.SYSAHBCLKCTRL or ((1 shl 6) or (1 shl 16));

     // Delay Init
     Delay_Init();
   
     // Configure ports
     SetOutputs(0, GPIO_Pin_1 OR GPIO_Pin_2);

     // SysTick Config    100ms
     SysTick_Config(FREQ div 10);


     // Main loop
     while true do
     begin
       TogglePin(0, GPIO_Pin_2);
       Delay_MS(1000);
     end;
end.