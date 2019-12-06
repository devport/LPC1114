unit ethernet;

interface

type
  TETH_HDR = packed record
    	       dst : array[0..5] of byte; // mac
	       src : array[0..5] of byte; // mac
	       hdrtype : array[0..5] of byte; // type
           end;

const
  ETH_FRAME_TYPE_IPV4 = $0800;
  ETH_FRAME_TYPE_ARP  = $0806;

  ETH_HEADER_SIZE = 14;

var
  MACADDR : array of byte = ($CC,$46,$D6,$10,$00,$29);
  IP : array of byte = (192, 168, 1, 220);

  function ETH_Process_Frame(buffer : PBYTE; size : word) : word;

implementation

uses
 uart, utils, enc28j60, ethernet_arp, ethernet_ip;

procedure ETH_Swap_Mac(buf : PBYTE);
var
  i : byte;
begin
 for i := 0 to 5 do begin
  buf[i] := buf[i+6];
  buf[i+6] := MACADDR[i];
 end;
end;

function ETH_Process_Frame(buffer : PBYTE; size : word) : word;
var
  ETH_HDR : ^TETH_HDR;
  data_len : word;
begin
  ETH_HDR := @buffer[0];
  result := 0;

  case ((ETH_HDR^).hdrtype[0] << 8 OR (ETH_HDR^).hdrtype[1]) of
    ETH_FRAME_TYPE_ARP : begin
                            UART_Send('Packet ARP'+#10+#13);
                            data_len := ETH_Protocol_ARP(buffer+ETH_HEADER_SIZE, PBYTE(MACADDR), PBYTE(IP));
                            if(data_len > 0) then begin
                              ETH_Swap_Mac(buffer);
                              data_len := data_len + ETH_HEADER_SIZE;
                              enc28j60PacketSend(data_len, PChar(buffer));
                              result := data_len;
                            end;
                         end;
    ETH_FRAME_TYPE_IPV4 : begin
                            UART_Send('Packet IP'+#10+#13);
                            data_len := ETH_Protocol_IP(PByte(buffer+ETH_HEADER_SIZE), PBYTE(MACADDR), PBYTE(IP));
                            if(data_len > 0) then begin
                              ETH_Swap_Mac(buffer);
                              data_len := data_len + ETH_HEADER_SIZE;
                              enc28j60PacketSend(data_len, PChar(buffer));
                              result := data_len;
                            end;
                          end;
  end;
end;

end.
