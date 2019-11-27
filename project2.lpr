program project2;

uses
    system_LPC1114, utils, delay, spi, sh1106, adc, onewire, ds18b20;

const
     OSC = 12000000;
     FREQ = 48000000;

var
  buffer : array [0..1024] of byte;
  temperature : byte;
  dev : byte;
  data : String;
  devState : TSearchState;

begin
     // Inicjalize System Clock
     SystemInit(OSC, FREQ);
     LPC_SYSCON.SYSAHBCLKCTRL := LPC_SYSCON.SYSAHBCLKCTRL or ((1 shl 6) or (1 shl 16));

     // Delay Init
     Delay_Init();
     SPI_Init(SPI0, SCK0_0_6);

     // ADC Init
     ADC_Init();
     LPC_IOCON.R_PIO0_11 := $02;
     SetInputs(0, GPIO_Pin_11);

     // Init OLED
     SH1106_Init();
     SH1106_Clear(@buffer);
     SH1106_Display(@buffer);

     // Configure ports
     SetOutputs(0, GPIO_Pin_1);

     // Main loop
     while true do
     begin
       SetPins(0, GPIO_Pin_1); // Led OFF
       Delay_MS(1000);
       // clear display buffer
       SH1106_Clear(@buffer);
       // convert temperature and get
       DS18B20_Start_Convert();
       temperature := DS18B20_Read_Temperature();

       // Inicjalize struct for searching devices
       devState.done:= false;
       devState.lastZeroBranch := -1;
       dev := 0;
       // search devices
       while (devState.done = false) do
       begin
         if(OW_Search_Device(devState)) then
          inc(dev)
         else devState.done:= true;
       end;

       data := 'OneWire devices: ' + IntToStr(dev) ;
       SH1106_String(0, 0, PChar(@data[1]), 12, 1, @buffer);
       FillChar(data, length(data)+1, #00); // clear buffer

       data := 'ADC: ' + IntToStr(ADC_Get(0));
       SH1106_String(0, 12, PChar(@data[1]), 12, 1, @buffer);
       FillChar(data, length(data)+1, #00);  // clear buffer

       // Show others graphics
       SH1106_Bitmap(0, 24, @Bat816, 16, 8, @buffer);
       SH1106_Bitmap(0, 34, @Bluetooth88, 8,8, @buffer);
       SH1106_Bitmap(0, 44, @Msg816, 16,8, @buffer);
       SH1106_Char3216(20, 24, char((temperature div 10) + $30), @buffer);
       SH1106_Char3216(36, 24, char((temperature mod 10) + $30), @buffer);

       // Send buffer to OLED
       SH1106_Display(@buffer);

       ClrPins(0, GPIO_Pin_1); // Led ON
       Delay_MS(100);
     end;
end.

