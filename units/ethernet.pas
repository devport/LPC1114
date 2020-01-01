{
  Unit name: Ethernet for LPC1114
  Author: Dariusz Kwiecinski ( kwiecinskidarek@gmail.com )
  Date: 01.01.2020r;
}
unit ethernet;

interface

type
  TSOCKET_STATE = (NOT_A_SOCKET = 0, SOCKET_CLOSED = 1, SOCKET_IN_PROGRESS, SOCKET_CONNECTED, SOCKET_CLOSING);
  TFSM_STATES = (CLOSED = 0, LISTEN = 1, SYN_SENT, SYN_RECEIVED, ESTABLISHED, FIN_WAIT_1, FIN_WAIT_2, CLOSE_WAIT, CLOSING, LAST_ACK, TIME_WAIT);

  PRecv_function = ^TRecv_function;
  TRecv_function = procedure(tcb_id : byte; rcv_data : PByte; rcv_data_size : word);

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

const
  ETH_FRAME_TYPE_IPV4 = $0800;
  ETH_FRAME_TYPE_ARP  = $0806;

  IPV4_TYPE_ICMP = $01;
  IPV4_TYPE_TCP = $06;
  IPV4_TYPE_UDP = $11;

  ETH_HEADER_SIZE = 14;
  ETH_IP_HEADER_SIZE = 20;
  BUFFER_SIZE = 1460;

var
  MACADDR : array of byte = ($CC,$46,$D6,$10,$00,$39);
  IP : array of byte = (192, 168, 1, 200);

  procedure ETH_Process_Frame(buffer : PBYTE);
  function ByteSwap16(a : word) : word;
  function ByteSwap32(a : longword) : longword;
  // Sockets
  procedure Socket_Create(socket : PSocket; sck_type : byte);
  procedure Socket_Remove(socket : PSocket);
  function SocketCheck(socket : PSocket) : boolean;
  function CheckPort(port : word; sck_type : byte) : PSocket;
  procedure Socket_Bind(socket : PSocket; port : word);
  function Socket_Listen(socket : PSocket) : boolean;
  procedure SocketProcess(data_buffer : PBYTE);
  procedure SocketSetFunction(socket : PSocket; func : TRecv_function);
  procedure SocketSendData(id : byte; data : PByte; datalen : word);
  procedure SocketClose(id : byte);
  procedure SocketIncreaseTime();

implementation

uses
 uart, enc28j60, ethernet_arp, ethernet_ip, ethernet_ip_tcp;

var
  socketList : PSocket;
  socketListSize : word;

function ByteSwap16(a : word) : word;
begin
  Result := (((WORD(a) AND WORD($FF00)) >> 8) OR ((WORD(a) AND WORD($00FF)) << 8));
end;

function ByteSwap32(a : longword) : longword;
begin
  Result := (((longword(a) AND longword($FF000000)) >> 24) OR
            ((longword(a) AND longword($00ff0000)) >>  8) OR
            ((longword(a) AND longword($0000ff00)) <<  8) OR
            ((longword(a) AND longword($000000ff)) << 24) );
end;

procedure ETH_Swap_Mac(buf : PBYTE);
var
  i : byte;
begin
 for i := 0 to 5 do begin
  buf[i] := buf[i+6];
  buf[i+6] := MACADDR[i];
 end;
end;

procedure ETH_Process_Frame(buffer : PByte);
var
  ETH_Header : PEth_HDR;
begin
  ETH_Header := PEth_HDR(buffer);

  case (ByteSwap16(ETH_Header^.hdrtype)) of
    ETH_FRAME_TYPE_ARP : begin
                           // UART_Send('Packet ARP'+#10#13);
                           ETH_Protocol_ARP(buffer+ETH_HEADER_SIZE, PBYTE(IP));
                         end;
    ETH_FRAME_TYPE_IPV4 : begin
                           // UART_Send('Packet IP'+#10#13);
                           ETH_Protocol_IP(buffer+ETH_HEADER_SIZE, PBYTE(IP));
                          end;
  end;
end;

procedure ETH_Process(data_buffer : PByte);
var
  rcv_size : word = 0;
begin
  FillByte(data_buffer[0], BUFFER_SIZE, 0);
  if(enc28j60linkup() = 1)then begin
    rcv_size := enc28j60PacketReceive(BUFFER_SIZE, data_buffer);

    if(rcv_size > 0 )then
      ETH_Process_Frame(data_buffer);
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

procedure SocketSendData(id : byte; data : PByte; datalen : word);
begin
  tcb_array[id].snd_data := data;
  tcb_array[id].snd_datalen := datalen;
end;

procedure SocketClose(id : byte);
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



end.
