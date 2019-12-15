unit ethernet_ip_icmp;

interface

const
  ICMP_TYPE_REPLY = 0;
  ICMP_TYPE_REQUEST = 8;

type
  PICMP_HDR = ^TICMP_HDR;
  TICMP_HDR = packed record
    hdr_type : byte;
    code : byte;
    checksum : word;
    identifier : word;
    sequence : word;
    data_time : QWord;
    data : array[0..47] of byte;
  end;


  function ETH_Protocol_IP_ICMP(ip_hdr, icmp_hdr : PBYTE; size : word) : word;
  procedure ETH_Protocol_IP_ICMP_Reply(dst_ip : longword; dst_mac : PByte; id, seq : word; data_time : QWord; data : PByte);

implementation

uses
    enc28j60, ethernet, ethernet_ip;

function ETH_Protocol_IP_ICMP(ip_hdr, icmp_hdr : PBYTE; size : word) : word;
var
  ETH_Header : PETH_HDR;
  IP_Header : PIP_HDR;
  ICMP_Header : PICMP_HDR;
  checksum, checksum_size : word;
begin
  Result := 0;
  ICMP_Header := @icmp_hdr[0];
  IP_Header := @ip_hdr[0];
  ETH_Header := (@ip_hdr[0])-ETH_HEADER_SIZE;

  checksum_size := size;
  if (checksum_size AND $01) = $01 then begin
    icmp_hdr[checksum_size] := 0;
    Inc(checksum_size);
  end;

  checksum := Calc_Checksum(PWORD(ICMP_Header), checksum_size>>1, 0);
  if (checksum <> $FFFF) then exit;


  if ((ICMP_Header^).hdr_type = ICMP_TYPE_REQUEST) then begin
    ETH_Protocol_IP_ICMP_Reply((IP_Header^).src, @(ETH_Header^).src[0], (ICMP_Header^).identifier, (ICMP_Header^).sequence, (ICMP_Header^).data_time, @(ICMP_Header^).data[0] );
  end;
end;

procedure ETH_Protocol_IP_ICMP_Reply(dst_ip : longword; dst_mac : PByte; id, seq : word;  data_time : QWord; data : PByte);
var
  ETH_Header : TETH_HDR;
  IP_Header : TIP_HDR;
  ICMP_Header : TICMP_HDR;
  i : byte;
  checksum, len : word;
  snd_buf : array[0..97] of byte;
begin
  len := 0;
  checksum := 0;

  ETH_Header.hdrtype := ByteSwap16(ETH_FRAME_TYPE_IPV4);
  for i:=0 to 5 do begin
    ETH_Header.dst[i] := dst_mac[i];
    ETH_Header.src[i] := MACADDR[i];
  end;

  Inc(package_id);
  IP_Header.id := ByteSwap16(package_id);
  IP_Header.dsfield := 0;
  IP_Header.ver_len := $45;
  IP_Header.flags := $40;
  IP_Header.protocol := IPV4_TYPE_ICMP;
  IP_Header.ttl := 128;
  IP_Header.frag_offset := 0;

  len := sizeof(ICMP_Header);
  len := len + sizeof(IP_Header);

  IP_Header.total_len := ByteSwap16(len);

  IP_Header.checksum := 0;
  //IP_Header.dst := ByteSwap32((tcb^).src_ip);
  IP_Header.dst := dst_ip;
  IP_Header.src := ByteSwap32((ip[0]<<24) OR (ip[1] << 16) OR (ip[2] << 8) OR ip[3]);

  checksum := calc_checksum(@IP_Header, 10, 0);
  checksum := NOT checksum;
  IP_Header.checksum := checksum;

  ICMP_Header.hdr_type := ICMP_TYPE_REPLY;
  ICMP_Header.code := 0;
  ICMP_Header.checksum := 0;
  ICMP_Header.identifier := id;
  ICMP_Header.sequence := seq;
  ICMP_Header.data_time := data_time;
  move(data[0], ICMP_Header.data[0], 48);


  checksum := calc_checksum(@ICMP_Header, sizeof(ICMP_Header)>>1, 0);
  checksum := NOT checksum;
  ICMP_Header.checksum := checksum;

  FillByte(snd_buf[0], 41, 0);
  move(ETH_Header, snd_buf[0], sizeof(ETH_Header));
  move(IP_Header, snd_buf[sizeof(ETH_Header)], sizeof(IP_Header));
  move(ICMP_Header, snd_buf[sizeof(ETH_Header)+sizeof(IP_Header)], sizeof(ICMP_Header));
  enc28j60PacketSend(sizeof(ETH_Header)+sizeof(IP_Header)+sizeof(ICMP_Header), @snd_buf[0]);
end;

end.
