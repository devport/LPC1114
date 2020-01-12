{
  Unit name: Ethernet IP for LPC1114
  Author: Dariusz Kwiecinski ( kwiecinskidarek@gmail.com )
  Date: 01.01.2020r;
}
unit ethernet_ip;

interface

type
  PIP_HDR = ^TIP_HDR;
  TIP_HDR = packed record
    ver_len : byte;
    dsfield : byte;
    total_len : word;
    id : word;
    flags : byte;
    frag_offset : byte;
    ttl : byte;
    protocol : byte;
    checksum : word;
    src : longword;
    dst : longword;
  end;


  function Calc_Checksum(buf : PWord; num_of_shorts, start : word) : word;
  function calc_psdh(src, dst : longword; datalen, sum : word; protocol : byte) : word;

  procedure ETH_Protocol_IP(ip_hdr, ip : PByte);

implementation

uses
 uart, ethernet, ethernet_ip_icmp, ethernet_ip_tcp, ethernet_ip_udp;

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

// Obliczanie pseudo naglowka
function calc_psdh(src, dst : longword; datalen, sum : word; protocol : byte) : word;
var
  psdh : array[0..5] of word;
  p : PByte;
begin
  p := @psdh[0];

  p[3] := (src >> 24) AND $FF;		//* src ip address */
  p[2] := (src >> 16) AND $FF;
  p[1] := (src >> 8) AND $FF;
  p[0] := src AND $FF;

  p[7] := (dst >> 24) AND $FF;		//* dst ip address */
  p[6] := (dst >> 16) AND $FF;
  p[5] := (dst >> 8) AND $FF;
  p[4] := dst AND $FF;

  p[8] := 0;
  p[9] := protocol;			//* protocol */
  p[10] := datalen>>8;		//* tcp size */
  p[11] := datalen AND $ff;

  Result := Calc_Checksum(psdh, 6, sum);
end;

procedure ETH_Protocol_IP(ip_hdr, ip : PByte);
var
  IP_Header : PIP_HDR;
  ip_header_ver, ip_header_len : longword;
  checksum, ip_total_len, ip_data_len : longword;
begin
  IP_Header := PIP_HDR(ip_hdr);
  // Get header info and check
  ip_header_ver := IP_Header^.ver_len >> 4;
  if(ip_header_ver <> 4) then exit;

  ip_header_len := (IP_Header^.ver_len AND $0F) << 2;
  if (ip_header_len <> 20) then exit;
 // UART_Send('IP Header ver : '+IntToStr(ip_header_ver) +#10#13+ 'IP Header len : ' + IntToStr(ip_header_len) + #10#13);

  checksum := Calc_Checksum(PWORD(ip_hdr), ip_header_len >> 1, 0);
  if (checksum <> $FFFF) then exit;

  ip_total_len := ByteSwap16(IP_Header^.total_len);

  //UART_Send('Check IP...');
  if((((IP_Header^).dst AND $FF) <> ip[0]) OR
     ((((IP_Header^).dst >> 8) AND $FF) <> ip[1]) OR
     ((((IP_Header^).dst >> 16) AND $FF)  <> ip[2]) OR
     ((((IP_Header^).dst >> 24) AND $FF)  <> ip[3])) then exit;

  //UART_Send('OK'+#10#13);

//---END OF CHECK---------------------------------------------------------------
  ip_data_len := ip_total_len - ip_header_len;
  case(IP_Header^.protocol) of
    IPV4_TYPE_ICMP : begin
                       //UART_Send(' IPV4 Type ICMP'+#10#13);
                       ETH_Protocol_IP_ICMP(ip_hdr, ip_hdr+ETH_IP_HEADER_SIZE, ip_data_len);
                     end;
    IPV4_TYPE_TCP : begin
                       //UART_Send(' IPV4 Type TCP'+#10#13);
                       ETH_Protocol_IP_TCP(ip_hdr, ip_hdr+ETH_IP_HEADER_SIZE, ip_data_len);
                    end;
    IPV4_TYPE_UDP : begin
                       //UART_Send(' IPV4 Type UDP'+#10#13);
                       ETH_Protocol_IP_UDP(ip_hdr, ip_hdr+ETH_IP_HEADER_SIZE, ip_data_len);
                    end;
  end;
end;

end.
