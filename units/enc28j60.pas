unit enc28j60;

interface

{$macro on}
{$define ENC28J60_CS_PIN := (1<<2)}
{$define ENC28J60_CS_PORT := 0}

procedure ENC28J60_CS_OUTPUT();
procedure ENC28J60_CS_OFF();
procedure ENC28J60_CS_ON();

const
  ADDR_MASK = $1F;
  BANK_MASK = $60;
  SPRD_MASK = $80;

  // All-bank registers
 EIE     =    $1B;
 EIR     =    $1C;
 ESTAT   =    $1D;
 ECON2   =    $1E;
 ECON1   =    $1F;

 // Bank 0 registers
 ERDPTL      =     ($00 or $00);
 ERDPTH      =     ($01 or $00);
 EWRPTL      =     ($02 or $00);
 EWRPTH      =     ($03 or $00);
 ETXSTL      =     ($04 or $00);
 ETXSTH      =     ($05 or $00);
 ETXNDL      =     ($06 or $00);
 ETXNDH      =     ($07 or $00);
 ERXSTL      =     ($08 or $00);
 ERXSTH      =     ($09 or $00);
 ERXNDL      =     ($0A or $00);
 ERXNDH      =     ($0B or $00);
 ERXRDPTL    =     ($0C or $00);
 ERXRDPTH    =     ($0D or $00);
 ERXWRPTL    =     ($0E or $00);
 ERXWRPTH    =     ($0F or $00);
 EDMASTL     =     ($10 or $00);
 EDMASTH     =     ($11 or $00);
 EDMANDL     =     ($12 or $00);
 EDMANDH     =     ($13 or $00);
 EDMADSTL    =     ($14 or $00);
 EDMADSTH    =     ($15 or $00);
 EDMACSL     =     ($16 or $00);
 EDMACSH     =     ($17 or $00);
// Bank 1 registers
 EHT0        =     ($00 or $20);
 EHT1        =     ($01 or $20);
 EHT2        =     ($02 or $20);
 EHT3        =     ($03 or $20);
 EHT4        =     ($04 or $20);
 EHT5        =     ($05 or $20);
 EHT6        =     ($06 or $20);
 EHT7        =     ($07 or $20);
 EPMM0       =     ($08 or $20);
 EPMM1       =     ($09 or $20);
 EPMM2       =     ($0A or $20);
 EPMM3       =     ($0B or $20);
 EPMM4       =     ($0C or $20);
 EPMM5       =     ($0D or $20);
 EPMM6       =     ($0E or $20);
 EPMM7       =     ($0F or $20);
 EPMCSL      =     ($10 or $20);
 EPMCSH      =     ($11 or $20);
 EPMOL       =     ($14 or $20);
 EPMOH       =     ($15 or $20);
 EWOLIE      =     ($16 or $20);
 EWOLIR      =     ($17 or $20);
 ERXFCON     =     ($18 or $20);
 EPKTCNT     =     ($19 or $20);
 // Bank 2 registers
 MACON1      =     ($00 or $40 or $80);
 MACON2      =     ($01 or $40 or $80);
 MACON3      =     ($02 or $40 or $80);
 MACON4      =     ($03 or $40 or $80);
 MABBIPG     =     ($04 or $40 or $80);
 MAIPGL      =     ($06 or $40 or $80);
 MAIPGH      =     ($07 or $40 or $80);
 MACLCON1    =     ($08 or $40 or $80);
 MACLCON2    =     ($09 or $40 or $80);
 MAMXFLL     =     ($0A or $40 or $80);
 MAMXFLH     =     ($0B or $40 or $80);
 MAPHSUP     =     ($0D or $40 or $80);
 MICON       =     ($11 or $40 or $80);
 MICMD       =     ($12 or $40 or $80);
 MIREGADR    =     ($14 or $40 or $80);
 MIWRL       =     ($16 or $40 or $80);
 MIWRH       =     ($17 or $40 or $80);
 MIRDL       =     ($18 or $40 or $80);
 MIRDH       =     ($19 or $40 or $80);
// Bank 3 registers
MAADR1       =    ($00 or $60 or $80);
MAADR0       =    ($01 or $60 or $80);
MAADR3       =    ($02 or $60 or $80);
MAADR2       =    ($03 or $60 or $80);
MAADR5       =    ($04 or $60 or $80);
MAADR4       =    ($05 or $60 or $80);
EBSTSD       =    ($06 or $60);
EBSTCON      =    ($07 or $60);
EBSTCSL      =    ($08 or $60);
EBSTCSH      =    ($09 or $60);
MISTAT       =    ($0A or $60 or $80);
EREVID       =    ($12 or $60);
ECOCON       =    ($15 or $60);
EFLOCON      =    ($17 or $60);
EPAUSL       =    ($18 or $60);
EPAUSH       =    ($19 or $60);
// PHY registers
PHCON1       =    $00;
PHSTAT1      =    $01;
PHHID1       =    $02;
PHHID2       =    $03;
PHCON2       =    $10;
PHSTAT2      =    $11;
PHIE         =    $12;
PHIR         =    $13;
PHLCON       =    $14;

// ENC28J60 ERXFCON Register Bit Definitions
ERXFCON_UCEN    = $80;
ERXFCON_ANDOR   = $40;
ERXFCON_CRCEN   = $20;
ERXFCON_PMEN    = $10;
ERXFCON_MPEN    = $08;
ERXFCON_HTEN    = $04;
ERXFCON_MCEN    = $02;
ERXFCON_BCEN    = $01;
 // ENC28J60 EIE Register Bit Definitions
EIE_INTIE       = $80;
EIE_PKTIE       = $40;
EIE_DMAIE       = $20;
EIE_LINKIE      = $10;
EIE_TXIE        = $08;
EIE_WOLIE       = $04;
EIE_TXERIE      = $02;
EIE_RXERIE      = $01;
// ENC28J60 EIR Register Bit Definitions
EIR_PKTIF       = $40;
EIR_DMAIF       = $20;
EIR_LINKIF      = $10;
EIR_TXIF        = $08;
EIR_WOLIF       = $04;
EIR_TXERIF      = $02;
EIR_RXERIF      = $01;
// ENC28J60 ESTAT Register Bit Definitions
 ESTAT_INT       = $80;
 ESTAT_LATECOL   = $10;
 ESTAT_RXBUSY    = $04;
 ESTAT_TXABRT    = $02;
 ESTAT_CLKRDY    = $01;
// ENC28J60 ECON2 Register Bit Definitions
 ECON2_AUTOINC   = $80;
 ECON2_PKTDEC    = $40;
 ECON2_PWRSV     = $20;
 ECON2_VRPS      = $08;
 // ENC28J60 ECON1 Register Bit Definitions
 ECON1_TXRST     = $80;
 ECON1_RXRST     = $40;
 ECON1_DMAST     = $20;
 ECON1_CSUMEN    = $10;
 ECON1_TXRTS     = $08;
 ECON1_RXEN      = $04;
 ECON1_BSEL1     = $02;
 ECON1_BSEL0     = $01;
 // ENC28J60 MACON1 Register Bit Definitions
  MACON1_LOOPBK    = $10;
  MACON1_TXPAUS    = $08;
  MACON1_RXPAUS    = $04;
  MACON1_PASSALL   = $02;
  MACON1_MARXEN    = $01;
 // ENC28J60 MACON2 Register Bit Definitions
  MACON2_MARST     = $80;
  MACON2_RNDRST    = $40;
  MACON2_MARXRST   = $08;
  MACON2_RFUNRST   = $04;
  MACON2_MATXRST   = $02;
  MACON2_TFUNRST   = $01;
 // ENC28J60 MACON3 Register Bit Definitions
  MACON3_PADCFG2   = $80;
  MACON3_PADCFG1   = $40;
  MACON3_PADCFG0   = $20;
  MACON3_TXCRCEN   = $10;
  MACON3_PHDRLEN   = $08;
  MACON3_HFRMLEN   = $04;
  MACON3_FRMLNEN   = $02;
  MACON3_FULDPX    = $01;
 // ENC28J60 MICMD Register Bit Definitions
  MICMD_MIISCAN    = $02;
  MICMD_MIIRD      = $01;
 // ENC28J60 MISTAT Register Bit Definitions
  MISTAT_NVALID    = $04;
  MISTAT_SCAN      = $02;
  MISTAT_BUSY      = $01;
 // ENC28J60 PHY PHCON1 Register Bit Definitions
  PHCON1_PRST      = $8000;
  PHCON1_PLOOPBK   = $4000;
  PHCON1_PPWRSV    = $0800;
  PHCON1_PDPXMD    = $0100;
 // ENC28J60 PHY PHSTAT1 Register Bit Definitions
  PHSTAT1_PFDPX    = $1000;
  PHSTAT1_PHDPX    = $0800;
  PHSTAT1_LLSTAT   = $0004;
  PHSTAT1_JBSTAT   = $0002;
 // ENC28J60 PHY PHCON2 Register Bit Definitions
  PHCON2_FRCLINK   = $4000;
  PHCON2_TXDIS     = $2000;
  PHCON2_JABBER    = $0400;
  PHCON2_HDLDIS    = $0100;
 // ENC28J60 Packet Control Byte Bit Definitions
  PKTCTRL_PHUGEEN   = $08;
  PKTCTRL_PPADEN    = $04;
  PKTCTRL_PCRCEN    = $02;
  PKTCTRL_POVERRIDE = $01;
 // SPI operation codes
  ENC28J60_READ_CTRL_REG      = $00;
  ENC28J60_READ_BUF_MEM       = $3A;
  ENC28J60_WRITE_CTRL_REG     = $40;
  ENC28J60_WRITE_BUF_MEM      = $7A;
  ENC28J60_BIT_FIELD_SET      = $80;
  ENC28J60_BIT_FIELD_CLR      = $A0;
  ENC28J60_SOFT_RESET         = $FF;
// The RXSTART_INIT must be zero. See Rev. B4 Silicon Errata point 5.
// Buffer boundaries applied to internal 8K ram
// the entire available packet buffer space is allocated
//
// start with recbuf at 0 (must be zero! assumed in code)
  RXSTART_INIT     = $0;
// receive buffer end, must be odd number:
  RXSTOP_INIT      = ($1FFF-$0600-1);
// start TX buffer after RXSTOP_INIT with space for one full ethernet frame (~1500 bytes)
  TXSTART_INIT     = ($1FFF-$0600);
// stp TX buffer at end of mem
  TXSTOP_INIT      = $1FFF;
//
// max frame length which the conroller will accept:
// (note: maximum ethernet frame length would be 1518)
  MAX_FRAMELEN    = 1500;


procedure ENC28J60_Init(macaddr : PByte);
procedure ENC28J60_PhyWrite(address: byte; data : word);
function enc28j60PacketReceive(maxlen : word; packet : PByte) : word;
procedure enc28j60PacketSend(len : word; packet : PByte);

function ENC28J60_getrev() : byte;
function enc28j60linkup() : word;

implementation

uses utils, spi, delay;

var
   Enc28j60Bank : byte;
   UnreleasedPacket : byte;
   gNextPacketPtr : word;

procedure ENC28J60_CS_OUTPUT();
begin
  SetOutputs(ENC28J60_CS_PORT, ENC28J60_CS_PIN);
end;

procedure ENC28J60_CS_OFF();
begin
  SetPins(ENC28J60_CS_PORT, ENC28J60_CS_PIN);
end;

procedure ENC28J60_CS_ON();
begin
  ClrPins(ENC28J60_CS_PORT, ENC28J60_CS_PIN);
end;

function ENC28J60_ReadOp(op : byte; address : byte): byte;
var
   data : byte;
begin
     ENC28J60_CS_ON;
     SPI_Write(0, op OR (address AND ADDR_MASK));
     data := SPI_Read(0);
     if(address and $80) = $80 then
       data := SPI_Read(0);
     ENC28J60_CS_OFF;
     Result := data;
end;

procedure ENC28J60_WriteOp(op : byte; address : byte; data : byte);
begin
     ENC28J60_CS_ON;
     // issue write command
     SPI_Write(0, op OR (address AND ADDR_MASK));
     SPI_Write(0, data);
     ENC28J60_CS_OFF;
end;

procedure ENC28J60_ReadBuffer(len : word; data : PByte);
begin
  ENC28J60_CS_ON;
	// issue write command
	SPI_Write(0, ENC28J60_READ_BUF_MEM);
	while(len > 0) do
        begin
		dec(len);
		// read data
		data^ := SPI_Read(0);
		inc(data);
	end;
	data^ := $00;
	ENC28J60_CS_OFF;
end;

procedure ENC28J60_WriteBuffer(len : word; data : PByte);
begin
	ENC28J60_CS_ON;
  // issue write command
	SPI_Write(0, ENC28J60_WRITE_BUF_MEM);
	while(len > 0) do
	begin
		dec(len);
		// write data
		SPI_Write(0, data^);
		inc(data);
	end;
	ENC28J60_CS_OFF;
end;

procedure ENC28J60_SetBank(address : byte);
begin
	// set the bank (if needed)
        if((address AND BANK_MASK) <> Enc28j60Bank) then
	begin
		// set the bank
		ENC28J60_WriteOp(ENC28J60_BIT_FIELD_CLR, ECON1, (ECON1_BSEL1 OR ECON1_BSEL0));
		ENC28J60_WriteOp(ENC28J60_BIT_FIELD_SET, ECON1, ((address AND BANK_MASK) >> 5));
		Enc28j60Bank := (address AND BANK_MASK);
        end;

end;

function ENC28J60_Read(address : byte) : byte;
begin
        // set the bank
        ENC28J60_SetBank(address);
        // do the read
        Result := ENC28J60_ReadOp(ENC28J60_READ_CTRL_REG, address);
end;

procedure ENC28J60_Write(address : byte; data : byte);
begin
        // set the bank
        ENC28J60_SetBank(address);
        // do the write
        ENC28J60_WriteOp(ENC28J60_WRITE_CTRL_REG, address, data);
end;


// read 16 bits
function ENC28J60_PhyRead(address : byte):word;
begin
	// Set the right address and start the register read operation
	ENC28J60_Write(MIREGADR, address);
	ENC28J60_Write(MICMD, MICMD_MIIRD);
	// wait until the PHY read completes
	while(ENC28J60_Read(MISTAT) AND MISTAT_BUSY) = MISTAT_BUSY do;
	// reset reading bit
	ENC28J60_Write(MICMD, $00);
        // get data value from MIRDL and MIRDH
	Result := ((ENC28J60_Read(MIRDH)<<8) OR ENC28J60_Read(MIRDL));
end;

procedure ENC28J60_WriteWord(address : byte; data : word);
begin
    ENC28J60_Write(address, data AND $ff);
    ENC28J60_Write(address + 1, data >> 8);
end;

procedure ENC28J60_PhyWrite(address: byte; data : word);
begin
        // set the PHY register address
        ENC28J60_Write(MIREGADR, address);
        // write the PHY data
        ENC28J60_Write(MIWRL, data);
        ENC28J60_Write(MIWRH, data>>8);
        // wait until the PHY write completes
        while(ENC28J60_Read(MISTAT) AND MISTAT_BUSY) = MISTAT_BUSY do
                Delay_US(10); // 10us
end;


// read the revision of the chip:
function ENC28J60_getrev() : byte;
var
   rev : byte;
begin
        rev := ENC28J60_Read(EREVID);
        // microchip forgott to step the number on the silcon when they
        // released the revision B7. 6 is now rev B7. We still have
        // to see what they do when they release B8. At the moment
        // there is no B8 out yet
        if (rev>5) then inc(rev);
		Result := rev;
end;

function enc28j60linkup() : word;
begin
  // bit 10 (= bit 3 in upper reg)
  Result := ((ENC28J60_PhyRead(PHSTAT2) AND $0400) >> 10);
end;

procedure ENC28J60_Init(macaddr : PByte);
begin
        // initialize I/O
        // ss as output:
	ENC28J60_CS_OUTPUT;
	ENC28J60_CS_ON; // ss=0
	//
	// perform system reset
	ENC28J60_WriteOp(ENC28J60_SOFT_RESET, 0, ENC28J60_SOFT_RESET);
        Delay_MS(1); // 1ms
	// check CLKRDY bit to see if reset is complete
        // The CLKRDY does not work. See Rev. B4 Silicon Errata point. Just wait.
	//while(!(enc28j60Read(ESTAT) & ESTAT_CLKRDY));
	// do bank 0 stuff
	// initialize receive buffer
	// 16-bit transfers, must write low byte first
	// set receive buffer start address
	gNextPacketPtr := RXSTART_INIT;
        // Rx start
	ENC28J60_Write(ERXSTL, RXSTART_INIT AND $FF);
	ENC28J60_Write(ERXSTH, RXSTART_INIT>>8);
	// set receive pointer address
	ENC28J60_Write(ERXRDPTL, RXSTART_INIT AND $FF);
	ENC28J60_Write(ERXRDPTH, RXSTART_INIT>>8);
	// RX end
	ENC28J60_Write(ERXNDL, RXSTOP_INIT AND $FF);
	ENC28J60_Write(ERXNDH, RXSTOP_INIT>>8);
	// TX start
	ENC28J60_Write(ETXSTL, TXSTART_INIT AND $FF);
	ENC28J60_Write(ETXSTH, TXSTART_INIT>>8);
	// TX end
	ENC28J60_Write(ETXNDL, TXSTOP_INIT AND $FF);
	ENC28J60_Write(ETXNDH, TXSTOP_INIT>>8);
	// do bank 1 stuff, packet filter:
        // For broadcast packets we allow only ARP packtets
        // All other packets should be unicast only for our mac (MAADR)
        //
        // The pattern to match on is therefore
        // Type     ETH.DST
        // ARP      BROADCAST
        // 06 08 -- ff ff ff ff ff ff -> ip checksum for theses bytes=f7f9
        // in binary these poitions are:11 0000 0011 1111
        // This is hex 303F->EPMM0=0x3f,EPMM1=0x30
	ENC28J60_Write(ERXFCON, ERXFCON_UCEN OR ERXFCON_CRCEN OR ERXFCON_PMEN);
	ENC28J60_Write(EPMM0, $3f);
	ENC28J60_Write(EPMM1, $30);
	ENC28J60_Write(EPMCSL, $f9);
	ENC28J60_Write(EPMCSH, $f7);
        //
        //
	// do bank 2 stuff
	// enable MAC receive
	ENC28J60_Write(MACON1, MACON1_MARXEN OR MACON1_TXPAUS OR MACON1_RXPAUS);
	// bring MAC out of reset
	ENC28J60_Write(MACON2, $00);
	// enable automatic padding to 60bytes and CRC operations
	ENC28J60_WriteOp(ENC28J60_BIT_FIELD_SET, MACON3, MACON3_PADCFG0 OR MACON3_TXCRCEN OR MACON3_FRMLNEN);// MACON3_PADCFG0
	// set inter-frame gap (non-back-to-back)
	ENC28J60_Write(MAIPGL, $12);
	ENC28J60_Write(MAIPGH, $0C);
	// set inter-frame gap (back-to-back)
	ENC28J60_Write(MABBIPG, $12);
	// Set the maximum packet size which the controller will accept
        // Do not send packets longer than MAX_FRAMELEN:
	ENC28J60_Write(MAMXFLL, MAX_FRAMELEN AND $FF);
	ENC28J60_Write(MAMXFLH, MAX_FRAMELEN>>8);
	// do bank 3 stuff
        // write MAC address
        // NOTE: MAC address in ENC28J60 is byte-backward
        ENC28J60_Write(MAADR5, macaddr^);
        ENC28J60_Write(MAADR4, (macaddr+1)^);
        ENC28J60_Write(MAADR3, (macaddr+2)^);
        ENC28J60_Write(MAADR2, (macaddr+3)^);
        ENC28J60_Write(MAADR1, (macaddr+4)^);
        ENC28J60_Write(MAADR0, (macaddr+5)^);
	// no loopback of transmitted frames
	ENC28J60_PhyWrite(PHCON2, PHCON2_HDLDIS);
	// switch to bank 0
	ENC28J60_SetBank(ECON1);
	// enable interrutps
	ENC28J60_WriteOp(ENC28J60_BIT_FIELD_SET, EIE, EIE_INTIE OR EIE_PKTIE);
	// enable packet reception
	ENC28J60_WriteOp(ENC28J60_BIT_FIELD_SET, ECON1, ECON1_RXEN);
end;

function enc28j60PacketReceive(maxlen : word; packet : PByte) : word;
var
   len, rxstat : word;
begin
     if(UnreleasedPacket = 1) then
     begin
          if (gNextPacketPtr = 0) then
          begin
	    ENC28J60_Write(ERXRDPTL, (RXSTOP_INIT AND $FF));
	    ENC28J60_Write(ERXRDPTH, (RXSTOP_INIT) >> 8);
           // writeReg(ERXRDPTL, RXSTOP_INIT);
          end else begin
	    ENC28J60_Write(ERXRDPTL, (gNextPacketPtr-1) AND $FF);
	    ENC28J60_Write(ERXRDPTH, (gNextPacketPtr-1) >> 8);
           //writeReg(ERXRDPT, gNextPacketPtr - 1);
          end;
	  UnreleasedPacket := 0;
     end;

     if( ENC28J60_Read(EPKTCNT) > 0 ) then
     begin

      // Set the read pointer to the start of the received packet
	ENC28J60_Write(ERDPTL, (gNextPacketPtr AND $FF));
	ENC28J60_Write(ERDPTH, (gNextPacketPtr) >> 8);

	// read the next packet pointer
	gNextPacketPtr := ENC28J60_ReadOp(ENC28J60_READ_BUF_MEM, 0);
	gNextPacketPtr := gNextPacketPtr OR ENC28J60_ReadOp(ENC28J60_READ_BUF_MEM, 0)<<8;
	// read the packet length (see datasheet page 43)
	len := ENC28J60_ReadOp(ENC28J60_READ_BUF_MEM, 0);
	len := len OR (ENC28J60_ReadOp(ENC28J60_READ_BUF_MEM, 0)<<8);
        len := len - 4; //remove the CRC count
	// read the receive status (see datasheet page 43)
	rxstat := ENC28J60_ReadOp(ENC28J60_READ_BUF_MEM, 0);
	rxstat := rxstat OR ENC28J60_ReadOp(ENC28J60_READ_BUF_MEM, 0)<<8;

        // limit retrieve length
        if (len > maxlen - 1) then
         len := maxlen - 1;

        // check CRC and symbol errors (see datasheet page 44, table 7-3):
        // The ERXFCON.CRCEN is set by default. Normally we should not
        // need to check this.
        if ((rxstat AND $80) = 0)then
         // invalid
         len := 0
        else
         // copy the packet from the receive buffer
         ENC28J60_ReadBuffer(len, packet);
	// decrement the packet counter indicate we are done with this packet
	ENC28J60_WriteOp(ENC28J60_BIT_FIELD_SET, ECON2, ECON2_PKTDEC);
	UnreleasedPacket := 1;

     end;
     Result := len;
end;

procedure enc28j60PacketSend(len : word; packet : PByte);
begin
        // Check no transmit in progress
  // Check no transmit in progress
        while (ENC28J60_ReadOp(ENC28J60_READ_CTRL_REG, ECON1) AND ECON1_TXRTS) = ECON1_TXRTS do
        begin
                // Reset the transmit logic problem. See Rev. B4 Silicon Errata point 12.
                if( (ENC28J60_Read(EIR) AND EIR_TXERIF) = EIR_TXERIF ) then
                begin
                        ENC28J60_WriteOp(ENC28J60_BIT_FIELD_SET, ECON1, ECON1_TXRST);
                        ENC28J60_WriteOp(ENC28J60_BIT_FIELD_CLR, ECON1, ECON1_TXRST);
                end;
        end;
	// Set the write pointer to start of transmit buffer area
	ENC28J60_WriteWord(EWRPTL, TXSTART_INIT);
	//ENC28J60_Write(EWRPTH, TXSTART_INIT>>8);
	// Set the TXND pointer to correspond to the packet size given
	ENC28J60_WriteWord(ETXNDL, TXSTART_INIT+len);
	//ENC28J60_Write(ETXNDH, (TXSTART_INIT+len)>>8);
	// write per-packet control byte (0x00 means use macon3 settings)
	ENC28J60_WriteOp(ENC28J60_WRITE_BUF_MEM, 0, $00);
	// copy the packet into the transmit buffer
	ENC28J60_WriteBuffer(len, packet);
	// Reset the transmit logic problem. Unblock stall in the transmit logic.
	ENC28J60_WriteOp(ENC28J60_BIT_FIELD_SET, ECON1, ECON1_TXRTS);

	//if( (ENC28J60_Read(EIR) & EIR_TXERIF) ){
		//ENC28J60_WriteOp(ENC28J60_BIT_FIELD_CLR, ECON1, ECON1_TXRTS);
	//}

end;

end.

