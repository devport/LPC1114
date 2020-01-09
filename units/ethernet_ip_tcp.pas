{
  Unit name: Ethernet TCP/IP for LPC1114
  Author: Dariusz Kwiecinski ( kwiecinskidarek@gmail.com )
  Date: 08.01.2020r;
}
unit ethernet_ip_tcp;

interface

uses
  ethernet;

type
  PTCP_HDR = ^TTCP_HDR;
  TTCP_HDR = packed record
           src_port : word;
	   dst_port : word;
	   seq : longword;
	   ack : longword;
	   hdr_len : byte;
	   flags :  byte;
	   window_size : word;
	   checksum : word;
	   urgent_ptr : word;
  end;

  PTCB = ^TTCB;
  TTCB = record
        src_ip : longword;
	dst_ip : longword;
	src_port : word;
	dst_port : word;
	snd_una : longword;
	snd_nxt : longword;
	snd_wnd : longword;
	rcv_nxt : longword;
	rcv_wnd : longword;
	iss : longword;
	irs : longword;
	state : TFSM_STATES;
	time : longword;
	id : byte;
	src_mac : array[0..5] of byte;
	tcb_flags : byte;
        tcb_use : byte;
        seg : byte;

	snd_data : PByte;
	snd_datalen : word;

	rcv_data : PByte;
	rcv_datalen : word;
  end;

const
  TCB_LENGTH = 3;
  TIMEOUT = 3*600;

  FLAG_NUL = $00;
  FLAG_FIN = $01;
  FLAG_SYN = $02;
  FLAG_RST = $04;
  FLAG_PSH = $08;
  FLAG_ACK = $10;
  FLAG_URG = $20;



var
  tcb_array : array[0..TCB_LENGTH] of TTCB;

  function Socket_TCPClientNum() : longword;
  procedure ETH_Protocol_IP_TCP(ip_hdr, tcp_hdr : PByte; ip_data_len : word);
  procedure ETH_Protocol_IP_TCP_Send(snd_buf : PByte; tcb : PTCB);
  procedure TCB_Process(buffer : PByte);
  procedure InitTCB();

implementation

uses
  ethernet_ip, enc28j60, system_LPC1114, utils;

function Socket_TCPClientNum() : longword;
var
  i, j : longword;
begin
  j := 1;
  for i:=0 to TCB_LENGTH do begin
    if(tcb_array[i].src_ip <> 0 ) then inc(j);
  end;
  Result := j-1;
end;

procedure InitTCB();
var
  i : byte;
begin
  for i:=0 to TCB_LENGTH do begin
   tcb_array[i].state := CLOSED;
   tcb_array[i].src_port := 0;
   tcb_array[i].src_ip := 0;
   tcb_array[i].dst_ip := 0;
   tcb_array[i].dst_port := 0;
   tcb_array[i].id := i;
   tcb_array[i].seg := 0;
   tcb_array[i].rcv_nxt := 0;
   tcb_array[i].snd_nxt := 0;
   tcb_array[i].tcb_flags := FLAG_NUL;
   tcb_array[i].snd_data := nil;
   tcb_array[i].snd_datalen := 0;
   tcb_array[i].rcv_data := nil;
   tcb_array[i].rcv_datalen := 0;
  end;
end;

function TCB_GetTCB(socket : PSocket) : PTCB;
var
  i : byte;
begin
  Result := nil;
  for i:=0 to TCB_LENGTH do
  begin
    if (tcb_array[i].src_ip = 0) AND (tcb_array[i].src_port = 0) AND (tcb_array[i].state = CLOSED) then
    begin
      tcb_array[i].state := socket^.fsm_state;
      tcb_array[i].dst_port := socket^.sck_port;
      tcb_array[i].src_port := 0;
      tcb_array[i].src_ip := 0;
      tcb_array[i].rcv_nxt := 0;
      tcb_array[i].snd_nxt := 0;
      tcb_array[i].seg := 0;
      tcb_array[i].tcb_flags := FLAG_NUL;
      tcb_array[i].snd_data := nil;
      tcb_array[i].snd_datalen := 0;
      Result := @tcb_array[i];
      //UART_SEND('NEW TCB id:'+IntToStr(tcb_array[i].id)+#10#13);
      //UART_SEND('state:'+IntToStr(tcb_array[i].state)+#10#13);
      //UART_SEND('port:'+IntToStr(tcb_array[i].dst_port)+#10#13);
      Exit;
    end;
  end;
end;

function TCB_CheckTCB(ip : longword; port : word) : PTCB;
var
  i : byte;
begin
  Result := nil;
  for i:=0 to TCB_LENGTH do
  begin
    //UART_Send(IntToStr(i)+' IP: '+IntToStr(tcb_array[i].src_ip) + ' = ' +IntToStr(ip)+#10#13);
    //UART_Send(IntToStr(i)+' Port: '+IntToStr(tcb_array[i].src_port) + ' = ' +IntToStr(port)+#10#13);
    if (tcb_array[i].src_ip = ip) AND (tcb_array[i].src_port = port) then
    begin
      Result := @tcb_array[i];
      Exit;
    end;
  end;
end;

procedure TCB_Destroy(tcb : PTCB);
begin
  tcb^.state := CLOSED;
  tcb^.src_ip := 0;
  tcb^.src_port := 0;
  tcb^.dst_ip := 0;
  tcb^.dst_port := 0;
  tcb^.rcv_nxt := 0;
  tcb^.seg := 0;
  tcb^.snd_nxt := 0;
  tcb^.rcv_datalen := 0;
  tcb^.rcv_data := nil;
  tcb^.snd_data := nil;
  tcb^.snd_datalen := 0;
  tcb^.tcb_flags := FLAG_NUL;
end;

procedure TCB_Process(buffer : PByte);
var
  i : byte;
begin
  for i:=0 to TCB_LENGTH do
  begin
    if(tcb_array[i].snd_datalen > 0) then begin
      if ((tcb_array[i].tcb_flags AND FLAG_FIN) = 0) then tcb_array[i].tcb_flags := tcb_array[i].tcb_flags OR FLAG_PSH;
    end;

    if(tcb_array[i].tcb_flags > FLAG_NUL) then
    begin
      ETH_Protocol_IP_TCP_Send(buffer, @tcb_array[i]);
      tcb_array[i].snd_data := nil;
      tcb_array[i].snd_datalen := 0;
    end;

    tcb_array[i].tcb_flags := FLAG_NUL;

    if(tcb_array[i].state = CLOSING) then begin
      TCB_Destroy(@tcb_array[i]);
    end;

    if(tcb_array[i].state <> CLOSED) AND (tcb_array[i].time > TIMEOUT) then begin
      tcb_array[i].state := CLOSING;
    end;
  end;
end;

// Obliczanie pseudo naglowka
function calc_psdh(src, dst : longword; datalen, sum : word) : word;
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
  p[9] := $06;			//* protocol */
  p[10] := datalen>>8;		//* tcp size */
  p[11] := datalen AND $ff;

  Result := Calc_Checksum(psdh, 6, sum);
end;

procedure ETH_Protocol_IP_TCP(ip_hdr, tcp_hdr : PByte; ip_data_len : word);
var
  TCP_Header : PTCP_HDR;
  IP_Header : PIP_HDR;
  ETH_Header : PETH_HDR;
  tcb : PTCB;
  checksum, checksum_size : word;
  socket : PSocket = nil;
  i : byte;
  //
  //infostr : string;
begin
  socket := nil;
  tcb := nil;
  IP_Header := PIP_HDR(ip_hdr);
  TCP_Header := PTCP_HDR(tcp_hdr);

  checksum_size := ip_data_len;
  if (checksum_size AND $01) = 1 then begin
    tcp_hdr[checksum_size] := 0;
    Inc(checksum_size);
  end;

  checksum := Calc_Checksum(PWord(tcp_hdr), checksum_size>>1, 0);
  checksum := calc_psdh(IP_Header^.src, IP_Header^.dst, ip_data_len, checksum);
  if(checksum <> $FFFF) then exit;

  //UART_Send('Dst Port:'+IntToStr(ByteSwap16( TCP_Header^.dst_port)));
  socket := CheckPort(ByteSwap16(TCP_Header^.dst_port), IPV4_TYPE_TCP);

  if(socket <> nil) then begin
    //UART_Send('Src port : '+IntToStr(ByteSwap16(TCP_Header^.src_port))+#10#13 );

    tcb := TCB_CheckTCB(ByteSwap32(IP_Header^.src), ByteSwap16(TCP_Header^.src_port));
    if(tcb = nil) then
      tcb := TCB_GetTCB(socket);
    if(tcb = nil) then exit;

   //UART_Send('TCB State: '+IntToStr(tcb^.state)+#10#13);
   //UART_Send('Flags : '+IntToStr(TCP_Header^.flags)+#10#13);
   //UART_Send('TCB ID: '+IntToStr(tcb^.id)+#10#13);

    case (tcb^.state) of
      LISTEN: begin
              if (TCP_Header^.flags = FLAG_SYN) then begin
                //infostr := ' : TCB State: LISTEN -> SYN'#10#13;
                //UART_Send(infostr);
	        tcb^.src_ip := ByteSwap32(IP_Header^.src);
	        tcb^.src_port := ByteSwap16(TCP_Header^.src_port);
	        tcb^.irs := ByteSwap32(TCP_Header^.seq);
	        tcb^.rcv_nxt := ByteSwap32(TCP_Header^.seq) + 1;
	        tcb^.rcv_wnd := ByteSwap16(TCP_Header^.window_size);
	        tcb^.snd_una := tcb^.iss;
	        tcb^.snd_nxt := tcb^.iss;
	        tcb^.state := SYN_RECEIVED;

	        ETH_Header := @ip_hdr[0] - ETH_HEADER_SIZE ;
	        for i:=0 to 5 do
	          tcb^.src_mac[i] := ETH_Header^.src[i];

                tcb^.tcb_flags := FLAG_SYN OR FLAG_ACK;
                tcb^.time := 0;
              end;

              if(TCP_Header^.flags = FLAG_RST) then begin
                tcb^.state := CLOSING;
                tcb^.tcb_flags := FLAG_NUL;
              end;
           end;

      SYN_RECEIVED: begin
                    if(TCP_Header^.flags = FLAG_ACK) then begin
                      //infostr := ' : TCB State: SYN_RECEIVED -> ACK'#10#13;
                      //UART_Send(infostr);
		      if(tcb^.snd_nxt = ByteSwap32(TCP_Header^.ack)) then begin
		        tcb^.state := ESTABLISHED;
		        tcb^.rcv_nxt := ByteSwap32(TCP_Header^.seq) + 1;
		        tcb^.snd_nxt := ByteSwap32(TCP_Header^.ack);
                        tcb^.time := 0;
		      end;
		    end;

                    if(TCP_Header^.flags = FLAG_RST) then begin
                      //infostr := ' : TCB State: SYN_RECEIVED -> RST'#10#13;
                      //UART_Send(infostr);
                      TCB_Destroy(tcb);
		    end;

                   end;

      ESTABLISHED: begin
                     if(TCP_Header^.flags = (FLAG_PSH OR FLAG_ACK)  )then begin
                       //infostr := ' : TCB State: ESTABLISHED -> PSH'#10#13;
                       //UART_Send(infostr);
                       tcb^.rcv_data := tcp_hdr + (TCP_Header^.hdr_len>>2) - 1;
                       tcb^.rcv_datalen := ByteSwap16(IP_Header^.total_len) - word((IP_Header^.ver_len AND $0F) << 2) - word(TCP_Header^.hdr_len>>2);
                       tcb^.rcv_nxt := ByteSwap32(TCP_Header^.seq) + tcb^.rcv_datalen; // + datalen
		       tcb^.snd_nxt := ByteSwap32(TCP_Header^.ack);
                       tcb^.tcb_flags :=  FLAG_ACK;
                       tcb^.time := 0;

                       {if tcb^.rcv_datalen > 0 then begin
                         move(tcb^.rcv_data[1], tcb^.rcv_tmp[tcb^.rcv_datalen], data_size);
                         tcb^.rcv_datalen := tcb^.rcv_datalen + data_size;
                         tcb^.rcv_data := tcb^.rcv_tmp;
                       end;
                        }
                       if(socket^.recv_func <> nil) then
		         socket^.recv_func(tcb^.id, tcb^.rcv_data, tcb^.rcv_datalen);
                       if ((tcb^.tcb_flags AND FLAG_FIN) = FLAG_FIN) then
                         ClrPins(GPIO_Port_0, GPIO_Pin_3);

                       tcb^.rcv_data := nil;
                       tcb^.rcv_datalen := 0;
                     end;

                     if(TCP_Header^.flags = FLAG_ACK) then begin
                       tcb^.rcv_data := tcp_hdr + (TCP_Header^.hdr_len>>2) - 1;
                       tcb^.rcv_datalen := ByteSwap16(IP_Header^.total_len) - word((IP_Header^.ver_len AND $0F) << 2) - word(TCP_Header^.hdr_len>>2);
                       tcb^.rcv_nxt := ByteSwap32(TCP_Header^.seq) + tcb^.rcv_datalen; // + datalen
		       tcb^.snd_nxt := ByteSwap32(TCP_Header^.ack);
                       tcb^.tcb_flags :=  FLAG_ACK;
                       tcb^.time := 0;

                       //if tcb^.rcv_datalen > 0 then
                        // move(tcb^.rcv_data[1], tcb^.rcv_tmp, tcb^.rcv_datalen);
                     end;

                     // Pasive closed
		     if((TCP_Header^.flags AND FLAG_FIN) = FLAG_FIN) then begin
                       //infostr := ' : TCB State: ESTABLISHED -> FIN'#10#13;
                       //UART_Send(infostr);
		       tcb^.rcv_nxt := ByteSwap32(TCP_Header^.seq) + 1;
		       tcb^.snd_nxt := ByteSwap32(TCP_Header^.ack);
		       tcb^.tcb_flags := (FLAG_FIN OR FLAG_ACK);
                       tcb^.state := LAST_ACK;
		     end;
                   end;

    {  FIN_WAIT_1 : begin
                  if(TCP_Header^.flags AND FLAG_FIN) = FLAG_FIN then begin
                    UART_Send(IntToStr(tcb^.id)+' : TCB State: FIN_WAIT_1 -> FIN'+#10#13);
                    tcb^.rcv_nxt := ByteSwap32(TCP_Header^.seq) + 1;
		    tcb^.snd_nxt := ByteSwap32(TCP_Header^.ack);
		    tcb^.state := FIN_WAIT_2;
                    tcb^.tcb_flags := FLAG_ACK;
                  end;
      end; }

      FIN_WAIT_2 : begin
                     if(TCP_Header^.flags = (FLAG_FIN OR FLAG_ACK)) then begin
                       //infostr := ' : TCB State: FIN_WAIT_2 -> FIN & ACK'#10#13;
                       //UART_Send(infostr);
                       tcb^.rcv_nxt := ByteSwap32(TCP_Header^.seq) + 1;
		       tcb^.snd_nxt := ByteSwap32(TCP_Header^.ack);
		       tcb^.state := CLOSING;
                       tcb^.tcb_flags := FLAG_ACK;
                       tcb^.time := 0;
                     end;
      end;

      LAST_ACK: begin
                if(TCP_Header^.flags AND FLAG_ACK) = FLAG_ACK then begin
                    //infostr := ' : TCB State: LAST_ACK -> ACK'+#10#13;
                    //UART_Send(infostr);
		    tcb^.rcv_nxt := ByteSwap32(TCP_Header^.seq) + 1;
		    tcb^.snd_nxt := ByteSwap32(TCP_Header^.ack);
		    tcb^.state := CLOSING;
                    TCB_Destroy(tcb);
		  end;
                end;

    else
      //infostr := #10'Warning: State unknown! ';
      //UART_Send(infostr);
      TCB_Destroy(tcb);
    end;
  end;

end;

procedure ETH_Protocol_IP_TCP_Send(snd_buf : PByte; tcb : PTCB);
var
  ETH_Header : TETH_HDR;
  TCP_Header : TTCP_HDR;
  IP_Header : TIP_HDR;
  i : byte;
  checksum, checksum_psdh, checksum_data : word;
  datalen, olddatalen, len : word;
  //snd_buf : array[0..BUFFER_SIZE] of byte;
begin
  len := tcb^.snd_datalen;
  datalen := len;
  olddatalen := datalen;

  Fillbyte(snd_buf[0], BUFFER_SIZE, 0);

  if datalen > 0 then
   move(tcb^.snd_data[0], snd_buf[0], datalen);

    ETH_Header.hdrtype := ByteSwap16(ETH_FRAME_TYPE_IPV4);
    for i:=0 to 5 do begin
	ETH_Header.dst[i] := tcb^.src_mac[i];
	ETH_Header.src[i] := MACADDR[i];
    end;

    Inc(package_id);
    IP_Header.id := ByteSwap16(package_id);
    IP_Header.dsfield := 0;
    IP_Header.ver_len := $45;
    IP_Header.flags := $40;
    IP_Header.protocol := IPV4_TYPE_TCP;
    IP_Header.ttl := 128;
    IP_Header.frag_offset := 0;

    IP_Header.checksum := 0;
    IP_Header.dst := ByteSwap32(tcb^.src_ip);
    IP_Header.src := ByteSwap32((ip[0]<<24) OR (ip[1] << 16) OR (ip[2] << 8) OR ip[3]);

    TCP_Header.dst_port := ByteSwap16(tcb^.src_port);
    TCP_Header.src_port := ByteSwap16(tcb^.dst_port);

    TCP_Header.seq := ByteSwap32(tcb^.snd_nxt);
    TCP_Header.ack := ByteSwap32(tcb^.rcv_nxt);
    TCP_Header.hdr_len := (sizeof(TCP_Header) << 2);
    TCP_Header.flags := tcb^.tcb_flags;
    TCP_Header.window_size := ByteSwap16(BUFFER_SIZE);
    TCP_Header.checksum := 0;
    TCP_Header.urgent_ptr := 0;

    len := len + sizeof(TCP_Header);
    len := len + sizeof(IP_Header);

    IP_Header.total_len := ByteSwap16(len);
    // checksum ip  header
    checksum := calc_checksum(@IP_Header, 10, 0);
    checksum := NOT checksum;
    IP_Header.checksum := checksum;

    len := datalen + sizeof(TCP_Header);

    checksum_psdh := calc_psdh(IP_Header.src, IP_Header.dst, len, 0);
    if (((datalen AND $01) = 1) AND (datalen > 0)) then begin
      snd_buf[datalen] := 0;
      Inc(datalen);
    end;

    tcb^.snd_nxt := tcb^.snd_nxt + datalen;
    if(tcb^.tcb_flags AND FLAG_SYN) = FLAG_SYN then
      Inc(tcb^.snd_nxt);

    checksum_data := calc_checksum(PWord(snd_buf), datalen>>1, checksum_psdh);
    checksum := calc_checksum(@TCP_Header, sizeof(TCP_Header)>>1, checksum_data);
    checksum := NOT checksum;
    TCP_Header.checksum := checksum;

    FillByte(snd_buf[0], BUFFER_SIZE, 0);

    move(ETH_Header, snd_buf[0], sizeof(ETH_Header));
    move(IP_Header, snd_buf[sizeof(ETH_Header)], sizeof(IP_Header));
    move(TCP_Header, snd_buf[sizeof(ETH_Header)+sizeof(IP_Header)], sizeof(TCP_Header));
    if(datalen > 0) then
      move(tcb^.snd_data[0], snd_buf[sizeof(ETH_Header)+sizeof(IP_Header)+sizeof(TCP_Header)], olddatalen);

    enc28j60PacketSend(sizeof(ETH_Header)+sizeof(IP_Header)+sizeof(TCP_Header)+datalen, snd_buf );
end;

end.
