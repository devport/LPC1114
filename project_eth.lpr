{
  Project name: Web Driver 4xDI 4xDO
  Author: Dariusz Kwiecinski ( kwiecinskidarek@gmail.com )
  Date: 01.01.2020r;
}
program project_eth;

uses
    system_LPC1114, uart, utils, delay, spi, enc28j60, ethernet,
    ethernet_ip_tcp, strings, il_interpreter;

type
  TPage = (PageMAIN = 0, PageCONFIG, PagePROGRAM);
var
   data_buf : array[0..BUFFER_SIZE] of Byte;
   snd_buff : array[0..BUFFER_SIZE] of char;
   Server80, Server1234 : TSocket;
   input_pin, output_pin : array[0..3] of Byte;


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

  SetInputs(GPIO_Port_1, GPIO_Pin_4);
  SetInputs(GPIO_Port_1, GPIO_Pin_11);
  SetInputs(GPIO_Port_3, GPIO_Pin_2);
  SetInputs(GPIO_Port_3, GPIO_Pin_3);
end;

procedure Conf_Output_Ports();
begin
  FillByte(output_pin[0], 4, 0);
  SetOutputs(GPIO_Port_1, GPIO_Pin_1);
  SetOutputs(GPIO_Port_1, GPIO_Pin_2);
  SetOutputs(GPIO_Port_2, GPIO_Pin_3);
  SetOutputs(GPIO_Port_3, GPIO_Pin_1);
end;


procedure server_recv1234(const id : byte; const rcv : PChar; const rcv_size : word);
const
  UDP_Start = 'UDP odpowiedz od serwera';
var
  size : longword;
begin
  size := 0;
  move(UDP_Start, snd_buff, length(UDP_Start));
  size := size + length(UDP_Start);

  UART_Send(rcv, rcv_size);
  SocketSendData(id, @snd_buff, size);
end;

procedure server_recv80(const id : byte; const rcv : PChar; const rcv_size : word);
const
  HTML_Start = 'HTTP/1.1 200 OK'#10#13'Content-Type: text/html'#10#13#10#13;
  HTML_Head = '<html><head><title>Web Driver</title></head><body><header><h1>Web Driver</h1>';
  HTML_main1 = '<div><a href="/">Start</a> | <a href="/program">Program</a></div>';
  HTML_main2 = '<div><table><tbody><tr><td>Clients:</td><td>';
  HTML_main3 = '<td></tr></tbody></table></div></header></body></html>';
var
   tmp : String;
   size, i, j : integer;
   page : TPage;
begin
  page := PageMain;

  size := 0;
  move(HTML_Start, snd_buff, length(HTML_Start));
   size := size + length(HTML_Start);
  move(HTML_Head, snd_buff[size], length(HTML_Head));
   size := size + length(HTML_Head);
  move(HTML_main1, snd_buff[size], length(HTML_main1));
  size := size + length(HTML_main1);

  if(strlcomp(rcv+1, 'GET', 3) = 0) then begin
    if(strlcomp(rcv+6,'?Eoff=', 6) = 0) then if IsDigital(rcv[12]) then output_pin[Ord(rcv[12])-$30] := 0;
    if(strlcomp(rcv+6,'?Eon=', 5) = 0) then if IsDigital(rcv[11]) then output_pin[Ord(rcv[11])-$30] := 1;


    if(strlcomp(rcv+6,'program ', 8) = 0) then begin
      page := PagePROGRAM;
    end;
  end;

  j := 0;
  while (j < rcv_size) do begin
    if (rcv[j] = 'p') AND (rcv[j+1] = 'r') AND (rcv[j+2] = 'g') then begin
      ClrPins(GPIO_Port_0, GPIO_Pin_3);
      move(rcv[j+4], UserSript[1], rcv_size-(j+5));
      UserSript_Size := rcv_size-(j+5);
      page := PagePROGRAM;
      Script_Scanner(UserSript, UserSript_Size, ilProgram, ilProgram_Size);
      break;
    end;
    inc(j);
  end;

  if page = PageMain then begin
    move(HTML_main2, snd_buff[size], length(HTML_main2));
    size := size + length(HTML_main2);
    tmp:= IntToStr(Socket_TCPClientNum());
    move(tmp[1], snd_buff[size], length(tmp));
    size := size + length(tmp);

    tmp := '</td></tr><tr><td>Inputs:</td></tr><tr><td>';
    move(tmp[1], snd_buff[size], length(tmp));
    size := size + length(tmp);
    for i := 0 to 3 do begin
      if (input_pin[i] = 1) then
        tmp := '1  '
      else
        tmp := '0  ';
      move(tmp[1], snd_buff[size], length(tmp));
      size := size + length(tmp);
    end;
    tmp := '</td></tr>';
    move(tmp[1], snd_buff[size], length(tmp));
    size := size + length(tmp);

    tmp := '<tr><td>Outputs:</td></tr><tr><td>';
    move(tmp[1], snd_buff[size], length(tmp));
    size := size + length(tmp);
    for i := 0 to 3 do begin
      if (output_pin[i] = 0) then
        tmp := '<a href="?Eon='+Char(i+$30)+'" >  OFF  </a>'
      else
        tmp := '<a href="?Eoff='+Char(i+$30)+'" >  ON  </a>';
      move(tmp[1], snd_buff[size], length(tmp));
      size := size + length(tmp);
    end;
    tmp := '</td></tr>';
    move(tmp[1], snd_buff[size], length(tmp));
    size := size + length(tmp);
    move(HTML_main3, snd_buff[size], length(HTML_main3));
    size := size + length(HTML_main3);
  end;

  if page = PagePROGRAM then begin
    tmp := '<form action="/programsave" method="post" enctype="text/plain">';
    move(tmp[1], snd_buff[size], length(tmp));
    size := size + length(tmp);
    tmp := '<table><tr><td>Program:</td></tr>';
    move(tmp[1], snd_buff[size], length(tmp));
    size := size + length(tmp);
    if (Script_ErrorCode > 0) then begin
      tmp := '<tr><td style="color: red;" >Error char : '+IntToStr(Script_ErrorCode)+'</td></tr>';
      move(tmp[1], snd_buff[size], length(tmp));
      size := size + length(tmp);
    end;
    tmp := '<tr><td><textarea name="prg" rows="10" cols="50">';
    move(tmp[1], snd_buff[size], length(tmp));
    size := size + length(tmp);

    if(UserSript_Size > 0) then begin
      move(UserSript[1], snd_buff[size], UserSript_Size);
      size := size + UserSript_Size;
    end;
    // paste script
    tmp := '</textarea></td></tr><tr><td><input type="submit" value="Save"></td></tr></table></form>';
    move(tmp[1], snd_buff[size], length(tmp));
    size := size + length(tmp);
  end;
  SocketSendData(id, @snd_buff, size);
  SocketClose(id);
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
  SPI_Init(SPI0, SCK0_2_11);

  // Configure ports
  SetOutputs(GPIO_Port_2, GPIO_Pin_1);
  SetOutputs(GPIO_Port_1, GPIO_Pin_8);
  SetOutputs(GPIO_Port_0, GPIO_Pin_3);

  // ENC ports
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

  Socket_Create(@Server1234, IPV4_TYPE_UDP);
  Socket_Bind(@Server1234, 1234);
  Socket_Listen(@Server1234);
  SocketSetFunction(@server1234, @server_recv1234);

  FillByte(input_pin, sizeof(input_pin), 0);
  FillByte(output_pin, sizeof(output_pin), 0);
  FillByte(data_buf[0], sizeof(data_buf), 0);

  Set_Inputs(input_pin);
  Set_Outputs(output_pin);
  Interpreter_Run := True;

  while true do
  begin
    SetPins(GPIO_Port_2, GPIO_Pin_1);

    SocketProcess(data_buf);

    if PinSense(GPIO_Port_3, GPIO_Pin_3) = True then input_pin[0] := 0 else input_pin[0] := 1;  // in 1
    if PinSense(GPIO_Port_3, GPIO_Pin_2) = True then input_pin[1] := 0 else input_pin[1] := 1;  // in 2
    if PinSense(GPIO_Port_1, GPIO_Pin_4) = True then input_pin[2] := 0 else input_pin[2] := 1;  // in 3
    if PinSense(GPIO_Port_1, GPIO_Pin_11) = True then input_pin[3] := 0 else input_pin[3] := 1; // in 4


    Interpreter_Loop();

    if output_pin[0] = 1 then ClrPins(GPIO_Port_1, GPIO_Pin_1) else SetPins(GPIO_Port_1, GPIO_Pin_1); // out 1
    if output_pin[1] = 1 then ClrPins(GPIO_Port_1, GPIO_Pin_2) else SetPins(GPIO_Port_1, GPIO_Pin_2); // out 2
    if output_pin[2] = 1 then ClrPins(GPIO_Port_3, GPIO_Pin_1) else SetPins(GPIO_Port_3, GPIO_Pin_1); // out 3
    if output_pin[3] = 1 then ClrPins(GPIO_Port_2, GPIO_Pin_3) else SetPins(GPIO_Port_2, GPIO_Pin_3); // out 4

    ClrPins(GPIO_Port_2, GPIO_Pin_1);

  end;
end.

