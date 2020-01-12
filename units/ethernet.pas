{
  Unit name: Ethernet for LPC1114
  Author: Dariusz Kwiecinski ( kwiecinskidarek@gmail.com )
  Date: 01.01.2020r;
}
unit ethernet;

interface

uses
 ethernet_ip;

type
  TSOCKET_STATE = (NOT_A_SOCKET = 0, SOCKET_CLOSED = 1, SOCKET_IN_PROGRESS, SOCKET_CONNECTED, SOCKET_CLOSING);
  TFSM_STATES = (CLOSED = 0, LISTEN = 1, SYN_SENT, SYN_RECEIVED, ESTABLISHED, FIN_WAIT_1, FIN_WAIT_2, CLOSE_WAIT, CLOSING, LAST_ACK, TIME_WAIT);

  TRecv_function = procedure(const tcb_id : byte; const rcv_data : PChar; const rcv_size : word);

  PEth_HDR = ^TEth_Hdr;
  TEth_HDR = packed record
    dst : array[0..5] of byte; // mac
    src : array[0..5] of byte; // mac
    hdrtype : word; // type
  end;

  PSocket = ^TSocket;
  TSocket = record
  	sck_type : byte;
	sck_port : word;
        fsm_state : TFSM_STATES;
        sck_State : TSOCKET_STATE;
        recv_func : TRecv_function;
	nextSocket : PSocket;
	prevSocket : PSocket;
  end;

  PTCB = ^TTCB;
  TTCB = packed record
        src_ip : longword;
  	dst_ip : longword;
  	src_port : word;
  	dst_port : word;
  	snd_una : longword;
  	snd_nxt : longword;
  	snd_wnd : longword;
  	rcv_nxt : longword;
  	rcv_wnd : longword;
  	iss : longword;
  	irs : longword;
  	state : TFSM_STATES;
  	time : longword;
  	id : longword;
  	src_mac : array[0..5] of byte;
  	tcb_flags : byte;
        tcb_type : byte;

  	snd_data : PByte;
  	snd_datalen : word;

  	rcv_data : PByte;
  	rcv_datalen : word;
    end;

const
  TCB_LENGTH = 3;
  TIMEOUT = 3*600;

  FLAG_NUL = $00;
  FLAG_FIN = $01;
  FLAG_SYN = $02;
  FLAG_RST = $04;
  FLAG_PSH = $08;
  FLAG_ACK = $10;
  FLAG_URG = $20;

  ETH_FRAME_TYPE_IPV4 = $0800;
  ETH_FRAME_TYPE_ARP  = $0806;

  IPV4_TYPE_ICMP = $01;
  IPV4_TYPE_TCP = $06;
  IPV4_TYPE_UDP = $11;

  ETH_HEADER_SIZE = 14;
  ETH_IP_HEADER_SIZE = 20;
  BUFFER_SIZE = 1460;

var
  tcb_array : array[0..TCB_LENGTH] of TTCB;
  package_id : word = 0;
  MACADDR : array of byte = ($CC,$46,$D6,$10,$00,$39);
  IP : array of byte = (192, 168, 1, 200);


  function ByteSwap16(const a : word) : word;
  function ByteSwap32(const a : longword) : longword;
  // Sockets
  procedure Socket_Create(socket : PSocket; sck_type : byte);
  procedure Socket_Remove(socket : PSocket);
  function SocketCheck(socket : PSocket) : boolean;
  function CheckPort(port : word; sck_type : byte) : PSocket;
  procedure Socket_Bind(socket : PSocket; port : word);
  function Socket_Listen(socket : PSocket) : boolean;
  procedure SocketProcess(data_buffer : PBYTE);
  procedure SocketSetFunction(socket : PSocket; func : TRecv_function);
  procedure SocketSendData(const id : byte; data : PByte; datalen : word);
  procedure SocketClose(const id : byte);
  procedure SocketIncreaseTime();
  function Socket_TCPClientNum() : longword;

  procedure InitTCB();
  function TCB_GetTCB(socket : PSocket) : PTCB;
  function TCB_CheckTCB(ip : longword; port : word) : PTCB;
  procedure TCB_Destroy(tcb : PTCB);
  procedure TCB_Process(buffer : PByte);


implementation

uses
 enc28j60, ethernet_arp, ethernet_ip_tcp;

var
  socketList : PSocket;
  socketListSize : word;

function ByteSwap16(const a : word) : word;
begin
  Result := (((WORD(a) AND WORD($FF00)) >> 8) OR ((WORD(a) AND WORD($00FF)) << 8));
end;

function ByteSwap32(const a : longword) : longword;
begin
  Result := (((longword(a) AND longword($FF000000)) >> 24) OR
            ((longword(a) AND longword($00ff0000)) >>  8) OR
            ((longword(a) AND longword($0000ff00)) <<  8) OR
            ((longword(a) AND longword($000000ff)) << 24) );
end;

procedure ETH_Process(data_buffer : PByte);
var
  rcv_size : longword = 0;
  ETH_Header : PEth_HDR;
begin
  FillByte(data_buffer[0], BUFFER_SIZE, 0);
  if(enc28j60linkup() = 1)then begin
    rcv_size := enc28j60PacketReceive(BUFFER_SIZE, data_buffer);

    if(rcv_size > 0 )then begin
      ETH_Header := PEth_HDR(data_buffer);

      case (ByteSwap16(ETH_Header^.hdrtype)) of
        ETH_FRAME_TYPE_ARP : ETH_Protocol_ARP(data_buffer+ETH_HEADER_SIZE, PBYTE(IP));
        ETH_FRAME_TYPE_IPV4 : ETH_Protocol_IP(data_buffer+ETH_HEADER_SIZE, PBYTE(IP));
      end;
    end;
  end;
end;

//--SOCKETS---------------------------------------------------------------------

procedure Socket_Create(socket : PSocket; sck_type : byte);
var
  curr : PSocket;
begin
  socket^.sck_type := sck_type;
  socket^.fsm_state := CLOSED;
  socket^.sck_State := SOCKET_CLOSED;
  socket^.Recv_func := nil;
  socket^.nextSocket:= nil;
  socket^.prevSocket:= nil;
  curr := socketList;
  if(curr <> nil) then begin
    while(curr^.nextSocket <> nil) do
      curr := curr^.nextSocket;
    curr^.nextSocket := socket;
  end else socketList := socket;

  Inc(socketListSize);
end;

procedure Socket_Remove(socket : PSocket);
var
  curr : PSocket;
begin
  if(socket = nil) then exit;

  if(socketList = socket) then begin
    curr := socketList;
    if(curr <> nil) then begin
      socketList := curr^.nextSocket;
      socket := nil;
      Dec(socketListSize);
    end;
  end else begin
    curr := socketList;
    while (curr^.nextSocket <> socket) do curr := curr^.nextSocket;
    curr^.nextSocket := socket^.nextSocket;
    socket := nil;
    Dec(socketListSize);
  end;
end;

function SocketCheck(socket : PSocket) : boolean;
var
  socketPtr : PSocket;
  count : word = 0;
begin
  Result := False;
  if((socketList <> nil) AND (socket <> nil)) then begin
    socketPtr := socketList;
    while((socketPtr <> nil) AND (count < socketListSize)) do begin
      if (socketPtr = socket) then begin
        Result := True;
        Exit;
      end else begin
        socketPtr := socketPtr^.nextSocket;
        Inc(count);
      end;
    end;
  end;
end;

function CheckPort(port : word; sck_type : byte) : PSocket;
var
  socketPtr : PSocket;
  count : word = 0;
begin
  Result := nil;
  socketPtr := socketList;
  while((socketPtr <> nil) AND (count < socketListSize)) do begin
    if((socketPtr^.sck_port = port) AND (socketPtr^.sck_type = sck_type)) then begin
      Result := socketPtr;
      exit;
    end;

    socketPtr := socketPtr^.nextSocket;
    Inc(count);
  end;
end;


procedure Socket_Bind(socket : PSocket; port : word);
begin
  if(CheckPort(port, IPV4_TYPE_TCP) <> nil) then begin
    exit;
  end;

  socket^.fsm_state := CLOSED;
  socket^.sck_port := port;
end;

function Socket_Listen(socket : PSocket) : boolean;
begin
  Result := False;
  if(SocketCheck(socket)) then begin
    socket^.fsm_state := LISTEN;
    socket^.sck_State := SOCKET_IN_PROGRESS;
    Result := True;
  end;
end;

procedure SocketProcess(data_buffer : PBYTE);
begin
  ETH_Process(data_buffer);

  TCB_Process(data_buffer);
end;

procedure SocketSetFunction(socket : PSocket; func : TRecv_function);
begin
  socket^.recv_func := func;
end;

procedure SocketSendData(const id : byte; data : PByte; datalen : word);
begin
  tcb_array[id].snd_data := data;
  tcb_array[id].snd_datalen := datalen;
end;

procedure SocketClose(const id : byte);
begin
  tcb_array[id].tcb_flags := tcb_array[id].tcb_flags OR FLAG_FIN;
  tcb_array[id].state := FIN_WAIT_2;
end;

procedure SocketIncreaseTime();
var
  it : word;
begin
  for it:=0 to TCB_LENGTH do begin
    Inc(tcb_array[it].time);
  end;
end;

function Socket_TCPClientNum() : longword;
var
  i, j : longword;
begin
  j := 1;
  for i:=0 to TCB_LENGTH do begin
    if(tcb_array[i].src_ip <> 0 ) then inc(j);
  end;
  Result := j-1;
end;

procedure InitTCB();
var
  i : byte;
begin
  for i:=0 to TCB_LENGTH do begin
   tcb_array[i].tcb_type := 0;
   tcb_array[i].state := CLOSED;
   tcb_array[i].src_port := 0;
   tcb_array[i].src_ip := 0;
   tcb_array[i].dst_ip := 0;
   tcb_array[i].dst_port := 0;
   tcb_array[i].id := i;
   tcb_array[i].rcv_nxt := 0;
   tcb_array[i].snd_nxt := 0;
   tcb_array[i].tcb_flags := FLAG_NUL;
   tcb_array[i].snd_data := nil;
   tcb_array[i].snd_datalen := 0;
   tcb_array[i].rcv_data := nil;
   tcb_array[i].rcv_datalen := 0;
  end;
end;

function TCB_GetTCB(socket : PSocket) : PTCB;
var
  i : byte;
begin
  Result := nil;
  for i:=0 to TCB_LENGTH do
  begin
    if (tcb_array[i].src_ip = 0) AND (tcb_array[i].src_port = 0) AND (tcb_array[i].state = CLOSED) then
    begin
      tcb_array[i].state := socket^.fsm_state;
      tcb_array[i].dst_port := socket^.sck_port;
      tcb_array[i].tcb_type := socket^.sck_type;
      tcb_array[i].src_port := 0;
      tcb_array[i].src_ip := 0;
      tcb_array[i].rcv_nxt := 0;
      tcb_array[i].snd_nxt := 0;
      tcb_array[i].tcb_flags := FLAG_NUL;
      tcb_array[i].snd_data := nil;
      tcb_array[i].snd_datalen := 0;
      Result := @tcb_array[i];
      //UART_SEND('NEW TCB id:'+IntToStr(tcb_array[i].id)+#10#13);
      //UART_SEND('state:'+IntToStr(tcb_array[i].state)+#10#13);
      //UART_SEND('port:'+IntToStr(tcb_array[i].dst_port)+#10#13);
      Exit;
    end;
  end;
end;

function TCB_CheckTCB(ip : longword; port : word) : PTCB;
var
  i : byte;
begin
  Result := nil;
  for i:=0 to TCB_LENGTH do
  begin
    //UART_Send(IntToStr(i)+' IP: '+IntToStr(tcb_array[i].src_ip) + ' = ' +IntToStr(ip)+#10#13);
    //UART_Send(IntToStr(i)+' Port: '+IntToStr(tcb_array[i].src_port) + ' = ' +IntToStr(port)+#10#13);
    if (tcb_array[i].src_ip = ip) AND (tcb_array[i].src_port = port) then
    begin
      Result := @tcb_array[i];
      Exit;
    end;
  end;
end;

procedure TCB_Destroy(tcb : PTCB);
begin
  tcb^.state := CLOSED;
  tcb^.src_ip := 0;
  tcb^.src_port := 0;
  tcb^.dst_ip := 0;
  tcb^.dst_port := 0;
  tcb^.rcv_nxt := 0;
  tcb^.snd_nxt := 0;
  tcb^.rcv_datalen := 0;
  tcb^.rcv_data := nil;
  tcb^.snd_data := nil;
  tcb^.snd_datalen := 0;
  tcb^.tcb_flags := FLAG_NUL;
end;

procedure TCB_Process(buffer : PByte);
var
  i : integer;
begin
  for i:=0 to TCB_LENGTH do
  begin
    if(tcb_array[i].snd_datalen > 0) then begin
      if ((tcb_array[i].tcb_flags AND FLAG_FIN) = 0) then tcb_array[i].tcb_flags := tcb_array[i].tcb_flags OR FLAG_PSH;
    end;

    if(tcb_array[i].tcb_flags > FLAG_NUL) then
    begin
      ETH_Protocol_IP_Send(buffer, @tcb_array[i]);
      tcb_array[i].snd_data := nil;
      tcb_array[i].snd_datalen := 0;
      if tcb_array[i].tcb_type = IPV4_TYPE_UDP then
       tcb_array[i].state := CLOSING;
    end;

    tcb_array[i].tcb_flags := FLAG_NUL;

    if(tcb_array[i].state = CLOSING) then begin
      TCB_Destroy(@tcb_array[i]);
    end;

    if(tcb_array[i].state <> CLOSED) AND (tcb_array[i].time > TIMEOUT) then begin
      tcb_array[i].state := CLOSING;
    end;
  end;
end;

end.
