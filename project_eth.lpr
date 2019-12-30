program project_eth;

uses
    cortexm0, system_LPC1114, utils, delay, spi, uart, enc28j60, ethernet, ethernet_ip_tcp, strings;

var
   data_buf : array[0..BUFFER_SIZE] of Byte;
   Server80 : TSocket;
   input_pin, output_pin : array[0..3] of byte;


procedure SysTick_interrupt; public Name 'SysTick_interrupt'; interrupt;
begin
  SocketIncreaseTime();
  Inc(time);
end;

procedure Conf_Input_Ports();
begin
  FillByte(input_pin[0], 4, 0);
  LPC_IOCON.PIO3_3 := LPC_IOCON.PIO3_3 AND NOT (1 << 4);
  LPC_IOCON.PIO3_2 := LPC_IOCON.PIO3_2 AND NOT (1 << 4);
  LPC_GPIO3.DIR := LPC_GPIO3.DIR AND (NOT(1 << 3) OR NOT(1 << 2));

end;

procedure Conf_Output_Ports();
begin
  FillByte(output_pin[0], 4, 0);
  SetOutputs(GPIO_Port_1, GPIO_Pin_1);
  SetOutputs(GPIO_Port_1, GPIO_Pin_2);
  SetOutputs(GPIO_Port_2, GPIO_Pin_3);
  SetOutputs(GPIO_Port_3, GPIO_Pin_1);
end;

procedure server_recv80(tcb_id : byte; rcv_data : PByte; rcv_data_size : word);
const
  HTML_Start = 'HTTP/1.1 200 OK'#10#13'Content-Type: text/html'#10#13#10#13;
  HTML_Head = '<html><head><title>Sterownik</title></head><body><header><h1>Sterownik</h1><div>';
  HTML_main1 = '<a href="/">Start</a></div><div><table><tbody>';
  HTML_main2 = '<tr><td>Klientow:</td><td>';
  HTML_main3 = '<td></tr></tbody></table></div></header></body></html>';
var
   infostr, num, pin : string;
   snd_buff : array[0..1023] of char;
   size, i : word;
   switch : byte;
   rcv : PChar;
begin
  rcv := PChar(rcv_data);

  num:= IntToStr(Socket_TCPClientNum());
  size := 0;
  move(HTML_Start, snd_buff, length(HTML_Start));
   size := size + length(HTML_Start);
  move(HTML_Head, snd_buff[size], length(HTML_Head));
   size := size + length(HTML_Head);
  move(HTML_main1, snd_buff[size], length(HTML_main1));
  size := size + length(HTML_main1);
  move(HTML_main2, snd_buff[size], length(HTML_main2));
  size := size + length(HTML_main2);
  move(num[1], snd_buff[size], length(num));
  size := size + length(num);

  switch := 0;
  if(strlcomp(rcv+1, 'GET', 3) = 0) then begin
    if(strlcomp(rcv+6,'?Eoff=', 6) = 0) then if IsDigital(rcv[12]) then output_pin[Ord(rcv[12])-$30] := 0;
    if(strlcomp(rcv+6,'?Eon=', 5) = 0) then if IsDigital(rcv[11]) then output_pin[Ord(rcv[11])-$30] := 1;
  end;

  pin := '</td></tr><tr><td>Wejscia:</td></tr><tr><td>';
  move(pin[1], snd_buff[size], length(pin));
  size := size + length(pin);
  for i := 0 to 3 do begin
    if (input_pin[i] = 1) then
      pin := '1  '
    else
      pin := '0  ';
    move(pin[1], snd_buff[size], length(pin));
    size := size + length(pin);
  end;
  pin := '</td></tr>';
  move(pin[1], snd_buff[size], length(pin));
  size := size + length(pin);

  pin := '<tr><td>Wyjscia:</td></tr><tr><td>';
  move(pin[1], snd_buff[size], length(pin));
  size := size + length(pin);
  for i := 0 to 3 do begin
    if (output_pin[i] = 0) then
      pin := '<a href="?Eon='+Char(i+$30)+'" >  OFF  </a>'
    else
      pin := '<a href="?Eoff='+Char(i+$30)+'" >  ON  </a>';
    move(pin[1], snd_buff[size], length(pin));
    size := size + length(pin);
  end;
  pin := '</td></tr>';
  move(pin[1], snd_buff[size], length(pin));
  size := size + length(pin);

  move(HTML_main3, snd_buff[size], length(HTML_main3));
  size := size + length(HTML_main3);

  //infostr := 'From server recv80 procedure ! Switch : '+IntToStr(switch)+#10#13;
  //UART_Send(infostr);

  SocketSendData(tcb_id, PByte(PChar(snd_buff)), size);
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
 // UART_Init();

  // SPI Init
  SPI_Init(SPI0, SCK0_0_6);

  // Configure ports
  SetOutputs(GPIO_Port_0, GPIO_Pin_1);
  SetOutputs(GPIO_Port_1, GPIO_Pin_8);

  //UART_Send(PChar('Hello World!'+#10+#13), length('Hello World!'+#10+#13));
  ENC28J60_CS_OUTPUT;
  ENC28J60_CS_ON;

  // ENC28J60 Init
  ENC28J60_Init(PByte(MACADDR));
  // LedA - ON | LedB - Tx/Rx | 73ms  =  0xD76
  ENC28J60_PhyWrite(PHLCON, $746); //0x746
  InitTCB();

  // SysTick Config    100ms
  SysTick_Config(48000000 div 100);

  Conf_Output_Ports();
  Conf_Input_Ports();

  Socket_Create(@Server80, IPV4_TYPE_TCP);
  Socket_Bind(@Server80, 80);
  Socket_Listen(@Server80);
  SocketSetFunction(@server80, @server_recv80);

  while true do
  begin
    ClrPins(GPIO_Port_0, GPIO_Pin_1);

    SocketProcess(data_buf);
   // {$IFDEF LPC1114}
    if output_pin[0] = 1 then ClrPins(GPIO_Port_1, GPIO_Pin_1) else SetPins(GPIO_Port_1, GPIO_Pin_1);
    if output_pin[1] = 1 then ClrPins(GPIO_Port_1, GPIO_Pin_2) else SetPins(GPIO_Port_1, GPIO_Pin_2);
    if output_pin[2] = 1 then ClrPins(GPIO_Port_3, GPIO_Pin_1) else SetPins(GPIO_Port_3, GPIO_Pin_1);
    if output_pin[3] = 1 then ClrPins(GPIO_Port_2, GPIO_Pin_3) else SetPins(GPIO_Port_2, GPIO_Pin_3);

    SetPins(GPIO_Port_0, GPIO_Pin_1);

    //{$ENDIF}
  end;
end.

