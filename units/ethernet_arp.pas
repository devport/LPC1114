{
  Unit name: Ethernet ARP for LPC1114
  Author: Dariusz Kwiecinski ( kwiecinskidarek@gmail.com )
  Date: 01.01.2020r;
}
unit ethernet_arp;

interface

type
 PARP_HDR = ^TARP_HDR;
 TARP_HDR = packed record
	hardware_type : word;
	protocol_type : word;
	hardware_Size : byte;
	protocol_Size : byte;
	Opcode : word;
	Sender_MAC : array[0..5] of byte;
	Sender_IP : longword;
	Target_MAC : array[0..5] of byte;
	Target_IP : longword;
  end;

const
 ARP_OPCODE_REQUEST      = 1;
 ARP_OPCODE_REPLY        = 2;
 HARDWARE_TYPE_ETHERNET  = 1;
 PROTOCOL_TYPE_IPV4      = $0800;
 HARDWARE_SIZE           = 6;
 PROTOCOL_SIZE           = 4;


procedure ETH_Protocol_ARP(arp_hdr : PByte; ip : PByte);
procedure ETH_Protocol_ARP_Reply(snd_buf : PByte; dst_ip : longword; dst_mac : PByte);

implementation

uses
 enc28j60, ethernet;

procedure ETH_Protocol_ARP(arp_hdr : PByte; ip : PByte);
var
  ARP_Header : PARP_HDR;
  buffer : PByte;
  opcode : word;
begin
  ARP_Header := PARP_HDR(arp_hdr);
  opcode := ByteSwap16(ARP_Header^.Opcode);
  //UART_Send('IP : ');
  //UART_Send(' opcode: '+IntToStr(opcode)+#10+#13);

  if(((ARP_Header^.Target_IP AND $FF) <> ip[0]) OR
     (((ARP_Header^.Target_IP >> 8) AND $FF) <> ip[1]) OR
     (((ARP_Header^.Target_IP >> 16) AND $FF)  <> ip[2]) OR
     (((ARP_Header^.Target_IP >> 24) AND $FF)  <> ip[3])) then exit;

  case (opcode) of
   ARP_OPCODE_REQUEST : begin
                          //UART_Send('Packet ARP -> ARP_OPCODE_REQUEST: '+#10#13);
                          buffer := arp_hdr - ETH_HEADER_SIZE;
                          ETH_Protocol_ARP_Reply(buffer, ARP_Header^.Sender_IP, ARP_Header^.Sender_MAC);
                        end;
  { ARP_OPCODE_REPLY : begin
                        for it :=0 to 5 do begin
                          ARP_Item.mac[it] := (ARP_Header^).Sender_MAC[it];
                        end;
                        for it :=0 to 3 do begin
                          ARP_Item.ip[it] := (ARP_Header^).Sender_IP[it];
                        end;
                      end;
  }
  end;
end;

procedure ETH_Protocol_ARP_Reply(snd_buf : PByte; dst_ip : longword; dst_mac : PByte);
var
  ETH_Header : TETH_HDR;
  ARP_Header : TARP_HDR;
  i : byte;
begin
	ETH_Header.hdrtype := ByteSwap16(ETH_FRAME_TYPE_ARP);
	for i:=0 to 5 do begin
		ETH_Header.dst[i] := dst_mac[i];
		ETH_Header.src[i] := MACADDR[i];
		ARP_Header.Sender_MAC[i] := MACADDR[i];
		ARP_Header.Target_MAC[i] := dst_mac[i];
	end;

	ARP_Header.Sender_IP := ByteSwap32((ip[0]<<24) OR (ip[1] << 16) OR (ip[2] << 8) OR ip[3]);
	ARP_Header.Target_IP := dst_ip;
	ARP_Header.hardware_type := ByteSwap16(HARDWARE_TYPE_ETHERNET);
	ARP_Header.protocol_type := ByteSwap16(PROTOCOL_TYPE_IPV4);
	ARP_Header.hardware_Size := HARDWARE_SIZE;
	ARP_Header.protocol_Size := PROTOCOL_SIZE;
	ARP_Header.opcode := ByteSwap16(ARP_OPCODE_REPLY);

        FillByte(snd_buf[0], BUFFER_SIZE, 0);
	move(ETH_Header, snd_buf[0], sizeof(ETH_Header));
	move(ARP_Header, snd_buf[sizeof(ETH_Header)], sizeof(ARP_Header));

	enc28j60PacketSend(sizeof(ETH_Header) + sizeof(ARP_Header), snd_buf);
end;


end.
