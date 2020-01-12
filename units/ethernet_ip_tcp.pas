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

  procedure ETH_Protocol_IP_TCP(const ip_hdr, tcp_hdr : PByte; const ip_data_len : longword);
  procedure ETH_Protocol_IP_Send(snd_buf : PByte; tcb : PTCB);

implementation

uses
  ethernet_ip, ethernet_ip_udp, enc28j60, system_LPC1114, utils;

procedure ETH_Protocol_IP_TCP(const ip_hdr, tcp_hdr : PByte; const ip_data_len : longword);
var
  TCP_Header : PTCP_HDR;
  IP_Header : PIP_HDR;
  ETH_Header : PETH_HDR;
  tcb : PTCB;
  checksum, checksum_size : longword;
  socket : PSocket = nil;
  i : integer;
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
  checksum := calc_psdh(IP_Header^.src, IP_Header^.dst, ip_data_len, checksum, IPV4_TYPE_TCP);
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

                       if(socket^.recv_func <> nil) then
		         socket^.recv_func(tcb^.id, PChar(tcb^.rcv_data), tcb^.rcv_datalen);
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

procedure ETH_Protocol_IP_Send(snd_buf : PByte; tcb : PTCB);
var
  ETH_Header : TETH_HDR;
  TCP_Header : TTCP_HDR;
  UDP_Header : TUDP_HDR;
  IP_Header : TIP_HDR;
  i : longword;
  checksum, checksum_psdh, checksum_data : word;
  datalen, olddatalen, len : word;
begin
  len := tcb^.snd_datalen;
  datalen := tcb^.snd_datalen;
  olddatalen := tcb^.snd_datalen;

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
    IP_Header.protocol := tcb^.tcb_type;
    IP_Header.ttl := 128;
    IP_Header.frag_offset := 0;

    IP_Header.checksum := 0;
    IP_Header.dst := ByteSwap32(tcb^.src_ip);
    IP_Header.src := ByteSwap32((ip[0]<<24) OR (ip[1] << 16) OR (ip[2] << 8) OR ip[3]);

    if tcb^.tcb_type = IPV4_TYPE_TCP then begin
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

    end else if tcb^.tcb_type = IPV4_TYPE_UDP then begin
      UDP_Header.dst_port := ByteSwap16(tcb^.src_port);
      UDP_Header.src_port := ByteSwap16(tcb^.dst_port);
      UDP_Header.checksum := 0;
      len := len + sizeof(UDP_Header);
      UDP_Header.len := ByteSwap16(len) ;
    end;

    len := len + sizeof(IP_Header);

    IP_Header.total_len := ByteSwap16(len);
    // checksum ip  header
    checksum := calc_checksum(@IP_Header, 10, 0);
    checksum := NOT checksum;
    IP_Header.checksum := checksum;

    if tcb^.tcb_type = IPV4_TYPE_TCP then
       len := datalen + sizeof(TCP_Header)
    else if tcb^.tcb_type = IPV4_TYPE_UDP then
       len := datalen + sizeof(UDP_Header);

    checksum_psdh := calc_psdh(IP_Header.src, IP_Header.dst, len, 0, tcb^.tcb_type);
    if (((datalen AND $01) = 1) AND (datalen > 0)) then begin
      snd_buf[datalen] := 0;
      Inc(datalen);
    end;

    tcb^.snd_nxt := tcb^.snd_nxt + datalen;
    if(tcb^.tcb_flags AND FLAG_SYN) = FLAG_SYN then
      Inc(tcb^.snd_nxt);

    checksum_data := calc_checksum(PWord(snd_buf), datalen>>1, checksum_psdh);
    if tcb^.tcb_type = IPV4_TYPE_TCP then begin
      checksum := calc_checksum(@TCP_Header, sizeof(TCP_Header)>>1, checksum_data);
      checksum := NOT checksum;
      TCP_Header.checksum := checksum;
    end else if tcb^.tcb_type = IPV4_TYPE_UDP then begin
      checksum := calc_checksum(@UDP_Header, sizeof(UDP_Header)>>1, checksum_data);
      checksum := NOT checksum;
      UDP_Header.checksum := checksum;
    end;

    FillByte(snd_buf[0], BUFFER_SIZE, 0);

    move(ETH_Header, snd_buf[0], sizeof(ETH_Header));
    move(IP_Header, snd_buf[sizeof(ETH_Header)], sizeof(IP_Header));
    if tcb^.tcb_type = IPV4_TYPE_TCP then begin
      move(TCP_Header, snd_buf[sizeof(ETH_Header)+sizeof(IP_Header)], sizeof(TCP_Header));
      if(datalen > 0) then
        move(tcb^.snd_data[0], snd_buf[sizeof(ETH_Header)+sizeof(IP_Header)+sizeof(TCP_Header)], olddatalen);

      enc28j60PacketSend(sizeof(ETH_Header)+sizeof(IP_Header)+sizeof(TCP_Header)+datalen, snd_buf );
    end else if tcb^.tcb_type = IPV4_TYPE_UDP then begin
      move(UDP_Header, snd_buf[sizeof(ETH_Header)+sizeof(IP_Header)], sizeof(UDP_Header));
      if(datalen > 0) then
        move(tcb^.snd_data[0], snd_buf[sizeof(ETH_Header)+sizeof(IP_Header)+sizeof(UDP_Header)], olddatalen);

      enc28j60PacketSend(sizeof(ETH_Header)+sizeof(IP_Header)+sizeof(UDP_Header)+datalen, snd_buf );
    end;
end;

end.
