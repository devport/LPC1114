{
  Unit name: Ethernet UDP/IP for LPC1114
  Author: Dariusz Kwiecinski ( kwiecinskidarek@gmail.com )
  Date: 01.01.2020r;
}
unit ethernet_ip_udp;

interface

const
  MAX_UDP_CLIENT_TABLE = 8;
  UDP_HDR_SIZE = 8;
  UDP_PORT = 48569;

type
    Pudp_hdr = ^Tudp_hdr;
    Tudp_hdr = packed record
	src_port : word;
	dst_port : word;
	total_len : word;
	checksum : word;
    end;

    PUDP_UCB = ^TUDP_UCB;
    TUDP_UCB = packed record
        src_mac : array[0..5] of byte;
	src_ip : longword;
	src_port : word;
	dst_port : word;
	id : byte;
	snd : byte;
    end;

  function ETH_Protocol_IP_UDP(ip_hdr, udp_hdr : PBYTE; size : word) : word;

implementation

uses
    uart, utils, ethernet, ethernet_ip, heapmgr;

var
  UDP_Client : array[0..MAX_UDP_CLIENT_TABLE] of TUDP_UCB;

//--CLIENT FUNCTIONS------------------------------------------------------------
function UCB_Add(port : word) : PUDP_UCB;
var
  i : byte;
begin
  Result := nil;
  for i:=0 to MAX_UDP_CLIENT_TABLE do begin
    if(UDP_Client[i].src_ip = 0) then begin
      UDP_Client[i].id := i;
      UDP_Client[i].src_port := port;
      Result := @UDP_Client[i];
      exit;
    end;
  end;
end;


function UCB_Check(ip : longword; port : word) : PUDP_UCB;
var
  i : byte;
begin
  Result := nil;
  for i:=0 to MAX_UDP_CLIENT_TABLE do begin
    if((UDP_Client[i].src_ip = ip) AND (UDP_Client[i].src_port = port)) then begin
      Result := @UDP_Client[i];
      exit;
    end;
  end;
end;

//------------------------------------------------------------------------------
function ETH_Protocol_IP_UDP(ip_hdr, udp_hdr : PBYTE; size : word) : word;
var
  UDP_Header : Pudp_hdr;
  IP_Header : Pip_hdr;
  udp_data : PBYTE;
  udp_total_len, udp_data_len, src_port, dst_port, len, checksum : word;
  socket : PSocket = nil;
  ucb : PUDP_UCB;
begin
  Result := 0;
  UDP_Header := PUDP_HDR(udp_hdr);
  IP_Header := PIP_HDR(ip_hdr);
  len := 0;

  checksum := Calc_Checksum(PWord(udp_hdr), ByteSwap16(UDP_Header^.total_len) >> 1, 0);
  if (checksum <> $FFFF) then exit;

  udp_total_len := ByteSwap16(UDP_Header^.total_len);
  if(udp_total_len <> size) then exit;

  udp_data := udp_hdr + UDP_HDR_SIZE;
  udp_data_len := udp_total_len - UDP_HDR_SIZE;

  //dst_port := ByteSwap16(UDP_Header^.dst_port);
  //src_port := ByteSwap16(UDP_Header^.src_port);
 // UART_Send('UDP '+IntToStr(src_port)+' -> '+IntToStr(dst_port)+#13);

  socket := CheckPort(ByteSwap16(UDP_Header^.dst_port), IPV4_TYPE_UDP);
  if socket <> nil then begin

    ucb := UCB_Check(ByteSwap32(IP_Header^.src), ByteSwap16(UDP_Header^.src_port));
    if ucb = nil then
      ucb := UCB_Add(ByteSwap16(UDP_Header^.src_port));

    if ucb = nil then exit;

    ucb^.src_ip := ByteSwap32(IP_Header^.src);

  //  UART_Send('Data from UDP: '+PChar(udp_data));

  end;

  Result := len;
end;

//   not yet
{
procedure ETH_Protocol_IP_UDP_Send(ucb : PUDP_UCB; data : PBYTE; datalen : word);
var
  eth : TETH_HDR;
  ip : TIP_HDR;
  udp : TUDP_HDR;
  i : byte;
  data_buf, snd_buf : PBYTE;
  total_len, checksum : word;
begin
  if(datalen > 0) then begin
    data_buf := GetMem(datalen+1);
    Move(data, data_buf, datalen);
  end;

  for i:=0 to 5 do begin
    eth.dst[i] := (ucb^).src_mac[i];
    eth.src[i] := MACADDR[i];
  end;
  eth.hdrtype := ByteSwap16(ETH_FRAME_TYPE_IPV4);

  Inc(packed_id);
  ip.id := ByteSwap16(packed_id);
  ip.dsfield := 0;
  ip.ver_len := $45;
  ip.flags := $40;
  ip.protocol := $11;
  ip.ttl := 128;
  ip.frag_offset := 0;

  ip.checksum := 0;
  ip.destination := ByteSwap32((ucb^).src_ip);
  //ip.source := ByteSwap32(IP_GetAddress());

  udp.src_port := ByteSwap16((ucb^).dst_port);
  udp.dst_port := ByteSwap16((ucb^).src_port);
  udp.total_len := ByteSwap16(datalen + sizeof(udp)) ;
  udp.checksum := 0;

  totallen := sizeof(ip) + sizeof(udp);

  if (datalen AND $01 > 0) then begin
    data_buf[datalen] := 0;
    Inc(datalen);
  end;

  if(datalen > 0) then
    totallen := totallen + datalen;

  ip.total_len := ByteSwap16(totallen);

  checksum := Calc_Checksum(PWORD(@ip), 10, 0);
  checksum := not checksum;
  ip.checksum := checksum;

	//udp.checksum = ~checksum;

  totallen := totallen + sizeof(eth);

  snd_buf := GetMem(totallen);

  move(PBYTE(eth), snd_buf, sizeof(eth));
  move(snd_buf+sizeof(eth), (uint8_t*)&ip, sizeof(ip));
  move(snd_buf+sizeof(eth)+sizeof(ip), (uint8_t*)&udp, sizeof(udp));

  if(datalen > 0)
    move(data_buf, snd_buf+sizeof(eth)+sizeof(ip)+sizeof(udp), datalen);

  enc28j60PacketSend(sizeof(eth)+sizeof(ip)+sizeof(udp)+datalen, (uint8_t*)snd_buf );
end; }


initialization
  FillByte(UDP_Client[0], sizeof(UDP_Client)* MAX_UDP_CLIENT_TABLE, 0);

end.
