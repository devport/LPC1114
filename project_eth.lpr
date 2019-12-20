program project_eth;

uses
    cortexm0, system_LPC1114, utils, delay, spi, uart, enc28j60, ethernet, ethernet_ip_tcp;

var
   data_buf : array[0..BUFFER_SIZE] of Byte;
   Server80, Server1234 : TSocket;

procedure SysTick_interrupt; public Name 'SysTick_interrupt'; interrupt;
begin
  SocketIncreaseTime();
end;

procedure server_recv80(tcb_id : byte; rcv_data : PByte; rcv_data_size : word);
var
   mydata : PChar;
begin
  mydata := 'Server LPC1114 in FreePascal';
  UART_Send('From server recv80 procedure ! '+IntToStr(tcb_id)+#10#13);
  UART_Send('Len : '+IntToStr(rcv_data_size)+#10#13);
  //UART_Send('data : '+PChar(rcv_data)+#10#13);
  SocketSendData(tcb_id, PByte(mydata), length(mydata));
  //if(PChar(rcv_data) = 'end') then
  SocketClose(tcb_id);
end;

begin
  // Inicjalize System Clock
  SystemInit();
  LPC_SYSCON.SYSAHBCLKCTRL := LPC_SYSCON.SYSAHBCLKCTRL or ((1 shl GPIO_SYSAHBCLKDIV_BIT) or (1 shl IOCON_SYSAHBCLKCTRL_BIT));

  // Delay Init
  Delay_Init();

  // UART Init
  UART_Init();

  // SPI Init
  SPI_Init(SPI0, SCK0_0_6);

  // Configure ports
  SetOutputs(0, GPIO_Pin_1);

  UART_Send('Hello World!'+#10+#13);
  ENC28J60_CS_OUTPUT;
  ENC28J60_CS_ON;

  // ENC28J60 Init
  ENC28J60_Init(PByte(MACADDR));
  // LedA - ON | LedB - Tx/Rx | 73ms  =  0xD76
  ENC28J60_PhyWrite(PHLCON, $D76); //0x746
  InitTCB();

  // SysTick Config    100ms
  SysTick_Config(48000000 div 10);

 // Socket_Create(@Server1234, IPV4_TYPE_UDP);
 // Socket_Bind(@Server1234, 1234);
 // Socket_Listen(@Server1234);

  Socket_Create(@Server80, IPV4_TYPE_TCP);
  Socket_Bind(@Server80, 80);
  Socket_Listen(@Server80);
  SocketSetFunction(@server80, @server_recv80);

  while true do
  begin
    SocketProcess(data_buf);
    TogglePin(0, GPIO_Pin_1);
  end;
end.

