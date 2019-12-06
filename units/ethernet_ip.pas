unit ethernet_ip;

interface

const
  IPV4_TYPE_ICMP = 01;
  IPV4_TYPE_TCP = 06;
  IPV4_TYPE_UDP = 11;

  ETH_IP_HEADER_SIZE = 20;

type
  PIP_HDR = ^TIP_HDR;
  TIP_HDR = packed record
    ver_len : byte;
    dsfield : byte;
    total_len : array[0..1] of byte;
    id : array[0..1] of byte;
    flags : byte;
    frag_offset : byte;
    ttl : byte;
    protocol : byte;
    checksum : array[0..1] of byte;
    src : array[0..3] of byte;
    dst : array[0..3] of byte;
  end;

  function ETH_Protocol_IP(ip_hdr, mac, ip : PByte) : word;

implementation

uses
 utils, uart;

// works for big endian or little endian byte order
function calc_checksum(buf : PWord; num_of_shorts, start : word) : word;
var
  check : word;
begin
  check := start;
  while(num_of_shorts > 0) do begin
    Dec(num_of_shorts);
    check := check + buf^;
    Inc(buf);
  end;

  check := (check>>16) + (check AND $ffff);
  check := check + (check>>16);
  result := check;
end;


function ETH_Protocol_IP(ip_hdr, mac, ip : PByte) : word;
var
  IP_Header : PIP_HDR;
  ip_header_ver, ip_header_len : byte;
begin
  IP_Header := @ip_hdr[0];
  result := 0;
  // Get header info
  ip_header_ver := (IP_Header^).ver_len >> 4;
  if(ip_header_ver <> 4) then exit;

  ip_header_len := ((IP_Header^).ver_len AND $0F) << 2;
  UART_Send('IP Header ver : '+IntToStr(ip_header_ver) +#10#13+ 'IP Header len : ' + IntToStr(ip_header_len) + #10#13);

end;

end.
