unit spi;

//{$define LOOPBACK_MODE}
interface

const
  FIFOSIZE = 8;

  SPI0 = 0;
  SPI1 = 1;

  SCK0_0_10 = $00;
  SCK0_2_11 = $01;
  SCK0_0_6  = $02;

  SSPSR_TFE = (1 << 0);
  SSPSR_TNF = (1 << 1);
  SSPSR_RNE = (1 << 2);
  SSPSR_RFF = (1 << 3);
  SSPSR_BSY = (1 << 4);


procedure SPI_Init(port : byte; sckpin : byte);
procedure SPI_Write(port : byte; data : byte);
function SPI_Read(port : byte) : byte;

implementation

uses utils, system_LPC1114;

procedure SPI_Init(port : byte; sckpin : byte);
var
   i, v : longword;
begin
     v := 0;
     if(port = 0) then
     begin
          // Turn off Reset SSP0
          SetBit(LPC_SYSCON.PRESETCTRL, 0);
          // Enable SSP0 Clock and set system divider 2 = 48/2 = 24 Mhz
          SetBit(LPC_SYSCON.SYSAHBCLKCTRL, SSP0_SYSAHBCLKCTRL_BIT);
          LPC_SYSCON.SSP0CLKDIV := $02;

          // Settings ports MISO <-> MOSI
          LPC_IOCON.PIO0_8 := LPC_IOCON.PIO0_8 and not $07;
          LPC_IOCON.PIO0_8 := LPC_IOCON.PIO0_8 or $01;

          LPC_IOCON.PIO0_9 := LPC_IOCON.PIO0_9 and not $07;
          LPC_IOCON.PIO0_9 := LPC_IOCON.PIO0_9 or $01;

          // Set out clock signal SCK
          // 0x00 - 0.10 | 0x01 - 2.11 | 0x02 - 0.6
	  LPC_IOCON.SCK0_LOC := sckPin;
          case sckPin of
                $00: LPC_IOCON.SWCLK_PIO0_10 := $02;
                $01: LPC_IOCON.PIO2_11 := $01;
		$02: LPC_IOCON.PIO0_6 := $02;
          end;

          // Clear Rx buffer
          for i := 0 to FIFOSIZE do
              v := LPC_SSP0.DR;
          v := v; // for clean warrnings "v not used"

          //Set DSS data to 8-bit, Frame format SPI, CPOL = 0, CPHA = 0, and SCR is 15
          LPC_SSP0.CR0 := $0707;
          //SSPCPSR clock prescale register, master mode, minimum divisor is 0x02
          LPC_SSP0.CPSR := $06;
          {$ifdef LOOPBACK_MODE}
             LPC_SSP0.CR1 := (1<<0) or (1<<1)
          {$else}
             LPC_SSP0.CR1 := (1 << 1);
          {$endif}
     end else if (port = 1) then
     begin
          // Turn off Reset SSP1
          SetBit(LPC_SYSCON.PRESETCTRL, 2);
          // Enable SSP1 Clock and set system divider 2 = 48/2 = 24 Mhz
          SetBit(LPC_SYSCON.SYSAHBCLKCTRL, SSP1_SYSAHBCLKCTRL_BIT);
          LPC_SYSCON.SSP1CLKDIV := $02;

          // Settings ports MISO <-> MOSI
          LPC_IOCON.MISO1_LOC := $00;
          LPC_IOCON.PIO2_2 := LPC_IOCON.PIO2_2 AND NOT $07;
          LPC_IOCON.PIO2_2 := LPC_IOCON.PIO2_2 OR $02;

          LPC_IOCON.MOSI1_LOC := $00;
          LPC_IOCON.PIO2_3 := LPC_IOCON.PIO2_3 AND NOT $07;
          LPC_IOCON.PIO2_3 := LPC_IOCON.PIO2_3 OR $02;

          // Set out clock signal SCK

	  LPC_IOCON.SCK1_LOC := $00;
          LPC_IOCON.PIO2_1 := LPC_IOCON.PIO2_1 AND NOT $07;
          LPC_IOCON.PIO2_1 := LPC_IOCON.PIO2_1 OR $02;

          // Clear Rx buffer
          for i := 0 to FIFOSIZE do
              v := LPC_SSP1.DR;

          //Set DSS data to 8-bit, Frame format SPI, CPOL = 0, CPHA = 0, and SCR is 15
          LPC_SSP1.CR0 := $0707;
          //SSPCPSR clock prescale register, master mode, minimum divisor is 0x02
          LPC_SSP1.CPSR := 48;
          {$ifdef LOOPBACK_MODE}
             LPC_SSP1.CR1 := (1<<0) or (1<<1)
          {$else}
             LPC_SSP1.CR1 := (1 << 1);
          {$endif}
     end;
end;

procedure SPI_Write(port : byte; data : byte);
var
   Dummy : longword;
begin
     if(port = 0) then
     begin
          while (LPC_SSP0.SR AND (SSPSR_TNF OR SSPSR_BSY)) <> SSPSR_TNF do;
          LPC_SSP0.DR := data;
          {$ifndef LOOPBACK_MODE}
            while ( (LPC_SSP0.SR AND (SSPSR_BSY OR SSPSR_RNE)) <> SSPSR_RNE ) do;
            Dummy := LPC_SSP0.DR;
          {$else}
            while ( LPC_SSP0.SR AND SSPSR_BSY ) = SSPSR_BSY do;
          {$endif}
     end else if (port = 1) then
     begin
          while (LPC_SSP1.SR AND (SSPSR_TNF OR SSPSR_BSY)) <> SSPSR_TNF do;
          LPC_SSP1.DR := data;
          {$ifndef LOOPBACK_MODE}
            while ( (LPC_SSP1.SR AND (SSPSR_BSY OR SSPSR_RNE)) <> SSPSR_RNE ) do;
            Dummy := LPC_SSP1.DR;
          {$else}
            while ( LPC_SSP1.SR AND SSPSR_BSY ) = SSPSR_BSY do;
          {$endif}
     end;
     //Dummy := Dummy;
end;

function SPI_Read(port : byte) : byte;
begin
     if(port = 0) then
     begin
          {$ifndef LOOPBACK_MODE}
            LPC_SSP0.DR := $FF;
            while ( (LPC_SSP0.SR AND (SSPSR_BSY OR SSPSR_RNE)) <> SSPSR_RNE ) do;
          {$else}
            while ( (LPC_SSP0.SR AND SSPSR_RNE) <> SSPSR_RNE ) do;
          {$endif}
          Result := LPC_SSP0.DR;
     end else if (port = 1) then
     begin
          {$ifndef LOOPBACK_MODE}
            LPC_SSP1.DR := $FF;
            while ( (LPC_SSP1.SR AND (SSPSR_BSY OR SSPSR_RNE)) <> SSPSR_RNE ) do;
          {$else}
            while ( (LPC_SSP1.SR AND SSPSR_RNE) <> SSPSR_RNE ) do;
          {$endif}
          Result := LPC_SSP1.DR;
     end;
end;

end.

