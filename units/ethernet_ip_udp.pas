{
  Unit name: Ethernet UDP/IP for LPC1114
  Author: Dariusz Kwiecinski ( kwiecinskidarek@gmail.com )
  Date: 01.01.2020r;
}
unit ethernet_ip_udp;

interface

const
  UDP_HDR_SIZE = 8;

type
    Pudp_hdr = ^Tudp_hdr;
    Tudp_hdr = packed record
	src_port : word;
	dst_port : word;
	len : word;
	checksum : word;
    end;

  function ETH_Protocol_IP_UDP(ip_hdr, udp_hdr : PBYTE; ip_data_len : word) : word;

implementation

uses
    uart, utils, ethernet, ethernet_ip, enc28j60;

//------------------------------------------------------------------------------
function ETH_Protocol_IP_UDP(ip_hdr, udp_hdr : PBYTE; ip_data_len : word) : word;
var
  UDP_Header : Pudp_hdr;
  IP_Header : Pip_hdr;
  udp_data : PBYTE;
  udp_total_len, udp_data_len, src_port, dst_port, len, checksum, checksum_size : word;
  socket : PSocket = nil;
  tcb : PTCB;
begin
  Result := 0;
  UDP_Header := PUDP_HDR(udp_hdr);
  IP_Header := PIP_HDR(ip_hdr);
  len := 0;

  //UART_Send('UDP Start...'#10);
  checksum_size := ip_data_len;
  if (checksum_size AND $01) = 1 then begin
    udp_hdr[checksum_size] := 0;
    Inc(checksum_size);
  end;
  checksum := Calc_Checksum(PWord(udp_hdr), checksum_size>>1, 0);
  checksum := calc_psdh(IP_Header^.src, IP_Header^.dst, ip_data_len, checksum, IPV4_TYPE_UDP);
  if(checksum <> $FFFF) then exit;
  //UART_Send('Checksum OK.'#10);

  udp_total_len := ByteSwap16(UDP_Header^.len);
  if(udp_total_len <> ip_data_len) then exit;
  //UART_Send('Total len OK.'#10);

  udp_data := udp_hdr + UDP_HDR_SIZE;
  udp_data_len := udp_total_len - UDP_HDR_SIZE - 1;

  dst_port := ByteSwap16(UDP_Header^.dst_port);
  src_port := ByteSwap16(UDP_Header^.src_port);
  //UART_Send('UDP '+IntToStr(src_port)+' -> '+IntToStr(dst_port)+#10);

  socket := CheckPort(ByteSwap16(UDP_Header^.dst_port), IPV4_TYPE_UDP);
  if socket <> nil then begin

    tcb := TCB_CheckTCB(ByteSwap32(IP_Header^.src), ByteSwap16(UDP_Header^.src_port));
    if(tcb = nil) then
      tcb := TCB_GetTCB(socket);
    if(tcb = nil) then exit;

    tcb^.src_ip := ByteSwap32(IP_Header^.src);
    tcb^.src_port := ByteSwap16(UDP_Header^.src_port);

    //UART_Send('Data from UDP: '+PChar(udp_data));
    if(socket^.recv_func <> nil) then
      socket^.recv_func(tcb^.id, PChar(udp_data), udp_data_len);

  end;

  Result := len;
end;

end.
