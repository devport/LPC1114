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

  function Calc_Checksum(buf : PWord; num_of_shorts, start : word) : word;
  function ETH_Protocol_IP(ip_hdr, mac, ip : PByte) : word;

implementation

uses
 utils, uart, ethernet_ip_icmp, ethernet_ip_udp;

var
  package_id : word = 0;

// works for big endian or little endian byte order
function Calc_Checksum(buf : PWord; num_of_shorts, start : word) : word;
var
  check : longword;
begin
  check := start;
  while(num_of_shorts > 0) do begin
    Dec(num_of_shorts);
    check := check + buf^;
    Inc(buf);
  end;

  check := (check>>16) + (check AND $FFFF);
  check := check + (check>>16);
  result := check;
end;


function ETH_Protocol_IP(ip_hdr, mac, ip : PByte) : word;
var
  IP_Header : PIP_HDR;
  i, ip_header_ver, ip_header_len : byte;
  checksum, ip_total_len, ip_data_len, len : word;
begin
  IP_Header := @ip_hdr[0];
  len := 0;
  result := 0;
  // Get header info and check
  ip_header_ver := (IP_Header^).ver_len >> 4;
  if(ip_header_ver <> 4) then exit;

  ip_header_len := ((IP_Header^).ver_len AND $0F) << 2;
  UART_Send('IP Header ver : '+IntToStr(ip_header_ver) +#10#13+ 'IP Header len : ' + IntToStr(ip_header_len) + #10#13);

  checksum := Calc_Checksum(PWORD(ip_hdr), ip_header_len >> 1, 0);
  UART_Send('Checksum : '+IntToStr(checksum)+#10#13);
  if (checksum <> $FFFF) then exit;

  ip_total_len := ((IP_Header^).total_len[0] << 8) OR (IP_Header^).total_len[1];

  if(((IP_Header^).dst[0] <> ip[0]) OR
     ((IP_Header^).dst[1] <> ip[1]) OR
     ((IP_Header^).dst[2] <> ip[2]) OR
     ((IP_Header^).dst[3] <> ip[3])) then exit;

//---END OF CHECK---------------------------------------------------------------
  ip_data_len := ip_total_len - ip_header_len;
  case((IP_Header^).protocol) of
    IPV4_TYPE_ICMP : begin
                       UART_Send(' IPV4 Type ICMP'+#10#13);
                       len := ETH_Protocol_IP_ICMP(ip_hdr, ip_hdr+ETH_IP_HEADER_SIZE, ip_data_len);
                     end;
    IPV4_TYPE_TCP : begin
                       UART_Send(' IPV4 Type TCP'+#10#13);
                       //len := ETH_Protocol_IP_TCP(ip_hdr, ip_hdr+ETH_IP_HEADER_SIZE, ip_data_len);
                    end;
    IPV4_TYPE_UDP : begin
                       UART_Send(' IPV4 Type UDP'+#10#13);
                       len := ETH_Protocol_IP_UDP(ip_hdr, ip_hdr+ETH_IP_HEADER_SIZE, ip_data_len);
                    end;
  end;

  if(len > 0) then begin
    Inc(package_id);
    len := len + ETH_IP_HEADER_SIZE;
    (IP_Header^).ver_len := $45;
    (IP_Header^).dsfield := 0;
    (IP_Header^).total_len[0] := len>>8;
    (IP_Header^).total_len[1] := len AND $FF;
    (IP_Header^).id[0] := package_id>>8;
    (IP_Header^).id[1] := package_id;
    (IP_Header^).flags := $40;
    (IP_Header^).frag_offset := 0;
    (IP_Header^).ttl := $80;

    (IP_Header^).checksum[0] := 0;
    (IP_Header^).checksum[1] := 0;

    // dest address from src address
    for i:=0 to 3 do begin
      (IP_Header^).dst[i] := (IP_Header^).src[i];
    end;
    // src address
    for i:=0 to 3 do begin
      (IP_Header^).src[i] := ip[i];
    end;
    checksum := Calc_Checksum(PWORD(ip_hdr), 10, 0);
    checksum := NOT checksum;
    (IP_Header^).checksum[0] := checksum AND $FF;
    (IP_Header^).checksum[1] := checksum>>8;
  end;
  Result := len;
end;

end.
