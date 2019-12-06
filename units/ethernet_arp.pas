unit ethernet_arp;

interface

type
 PETH_ARP = ^TETH_ARP;
 TETH_ARP = packed record
	H_Type : array[0..1] of byte;
	P_Type : array[0..1] of byte;
	H_Size : byte;
	P_Size : byte;
	Opcode : array[0..1] of byte;
	Sender_MAC : array[0..5] of byte;
	Sender_IP : array[0..3] of byte;
	Target_MAC : array[0..5] of byte;
	Target_IP : array[0..3] of byte;
  end;

  PETH_ARP_ITEM = ^TETH_ARP_ITEM;
  TETH_ARP_ITEM = packed record
	ip : array[0..3] of byte;
	mac : array[0..5] of byte;
	next : PETH_ARP_ITEM;
  end;

const
 ARP_OPCODE_REQUEST      = 1;
 ARP_OPCODE_REPLY        = 2;
 HARDWARE_TYPE_ETHERNET  = 1;
 PROTOCOL_TYPE_IPV4      = $0800;
 HARDWARE_SIZE           = 6;
 PROTOCOL_SIZE           = 4;


function ETH_Protocol_ARP(arp_hdr : PByte; mac : PByte; ip : PByte) : word;

implementation

uses
 uart, utils;

{ // For futures
var
  ARP_Item : TETH_ARP_ITEM;
}
function ETH_Protocol_ARP(arp_hdr : PByte; mac : PByte; ip : PByte) : word;
var
  ARP_Header : PETH_ARP;
  opcode : word;
  it : byte;
begin
  ARP_Header := @arp_hdr[0];
  opcode := (ARP_Header^).Opcode[0]<<8 OR (ARP_Header^).Opcode[1];
  UART_Send('IP : ');
  UART_Send(IntToStr((ARP_Header^).Sender_IP[0])+'.'+IntToStr((ARP_Header^).Sender_IP[1])+'.'+IntToStr((ARP_Header^).Sender_IP[2])+'.'+IntToStr((ARP_Header^).Sender_IP[3]));
  UART_Send(' opcode: '+IntToStr(opcode)+#10+#13);

  case (opcode) of
   ARP_OPCODE_REQUEST : begin
                          (ARP_Header^).Opcode[0] := ARP_OPCODE_REPLY >> 8;
                          (ARP_Header^).Opcode[1] := ARP_OPCODE_REPLY;
                          for it :=0 to 5 do begin
                            (ARP_Header^).Target_MAC[it] := (ARP_Header^).Sender_MAC[it];
                            (ARP_Header^).Sender_MAC[it] := mac[it];
                          end;
                          for it :=0 to 3 do begin
                            (ARP_Header^).Target_IP[it] := (ARP_Header^).Sender_IP[it];
                            (ARP_Header^).Sender_IP[it] := ip[it];
                          end;
                          Result := sizeof(TETH_ARP);
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

end.
