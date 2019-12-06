unit ethernet_ip_udp;

interface

const
  UDP_HDR_SIZE = 8;
  UDP_PORT = 1234;

type
    PHDR_UDP = ^THDR_UDP;
    THDR_UDP = packed record
	src_port : array[0..1] of byte;
	dst_port : array[0..1] of byte;
	total_len : array[0..1] of byte;
	checksum : array[0..1] of byte;
    end;

  function ETH_Protocol_IP_UDP(ip_hdr, udp_hdr : PBYTE; size : word) : word;

implementation

uses
    uart, utils;

function ETH_Protocol_IP_UDP(ip_hdr, udp_hdr : PBYTE; size : word) : word;
var
  UDP_Header : PHDR_UDP;
  udp_data : PBYTE;
  udp_total_len, udp_data_len, src_port, dst_port, len : word;
begin
  Result := 0;
  UDP_Header := @udp_hdr[0];

  udp_total_len := ((UDP_Header^).total_len[0]<<8) OR (UDP_Header^).total_len[1];
  if(udp_total_len <> size) then exit;

  udp_data := udp_hdr + UDP_HDR_SIZE;
  udp_data_len := udp_total_len - UDP_HDR_SIZE;

  dst_port := ((UDP_Header^).dst_port[0]<<8) OR (UDP_Header^).dst_port[1];
  src_port := ((UDP_Header^).src_port[0]<<8) OR (UDP_Header^).src_port[1];

  if(dst_port = UDP_PORT) then begin
    // Next staff
    UART_Send(' Connection UDP !'+#10#13);
  end else
    len := 0;

  if(len > 0) then begin
    len := len + UDP_HDR_SIZE;

    (UDP_Header^).dst_port[0] := (UDP_Header^).src_port[0];
    (UDP_Header^).dst_port[1] := (UDP_Header^).src_port[1];

    (UDP_Header^).src_port[0] := UDP_PORT>>8;
    (UDP_Header^).src_port[1] := UDP_PORT AND $FF;

    (UDP_Header^).total_len[0] := len >> 8;
    (UDP_Header^).total_len[1] := len AND $FF;

    (UDP_Header^).checksum[0] := 0;
    (UDP_Header^).checksum[1] := 0;
  end;
  Result := len;
end;

end.
