{

 Utility
 Created by Darek Kwiecinski 2019 - kwiecinskidarek@gmail.com

}
unit utils;

interface

type
  ArrayChar = array of char;

var
  time : longword = 1;

function Int_To_Str(buf : PChar; x : longint):word;

function IsDigital(c : char): boolean;
procedure ClearBit(var Value: longword; Index: Byte);
procedure SetBit(var Value: longword; Index: Byte);

function IntToStr (I : integer) : String;
function GetTime():longword;

// GPIO
procedure SetInputs(Port : byte; pins : word);
procedure SetOutputs(Port : byte; pins : word);
procedure SetPins(Port : byte; pin : word);
procedure ClrPins(Port : byte; pin : word);
procedure TogglePin(Port : byte; Index : word);


implementation

uses
  system_LPC1114;

function Int_To_Str(buf : PChar; x : longint):word;
var
  buff : array[0..5] of char;
  p : PChar;
  size : longint;
  value : Smallint;
begin
  Int_To_Str := 0;
  p := @buff;
  value := x;
  inc(buf);
  size := longint(buf);

  if(value < 0) then begin
    buf^ := '-';
    Inc(buf);
    value := -value;
  end;

  if(value = 0) then begin
    buf^ := '0';
    Inc(buf);
    exit;
  end;

  while(value > 0) do begin
    p^ := char(value mod 10 + Ord('0'));
    value := value div 10;
    inc(p);
  end;

  while p <> @buff do begin
    dec(p);
    buf^ := p^;
    inc(buf);
  end;

  size := longint(buf)- size;
  Int_To_Str := word(size);
end;

function IsDigital(c : char): boolean;
begin
 Result := False;
 if (c in ['0'..'9']) then Result := True;
end;

function GetTime() : longword;
begin
  GetTime := time;
end;

procedure ClearBit(var Value: longword; Index: Byte);
begin
  Value := Value and ((longword(1) shl Index) xor High(longword));
end;

procedure SetBit(var Value: longword; Index: Byte);
begin
  Value := Value or (longword(1) shl Index);
end;


function IntToStr (I : integer) : String;
var
   S : string;
begin
  Str (I, S);
  IntToStr := S;
end;

procedure SetInputs(Port : byte; pins : word);
begin
	case Port of
		0 : LPC_GPIO0.DIR := LPC_GPIO0.DIR and pins;
		1 : LPC_GPIO1.DIR := LPC_GPIO1.DIR and pins;
		2 : LPC_GPIO2.DIR := LPC_GPIO2.DIR and pins;
		3 : LPC_GPIO3.DIR := LPC_GPIO3.DIR and pins;
	end;		
end;

procedure SetOutputs(Port : byte; pins : word);
begin
	case Port of
		0 : LPC_GPIO0.DIR := LPC_GPIO0.DIR or pins;
		1 : begin
                      case pins of
                        GPIO_Pin_1 : LPC_IOCON.R_PIO1_1 := LPC_IOCON.R_PIO1_1 OR (1 << 0);
                        GPIO_Pin_2 : LPC_IOCON.R_PIO1_2 := LPC_IOCON.R_PIO1_2 OR (1 << 0);
                      end;
                      LPC_GPIO1.DIR := LPC_GPIO1.DIR or pins;
                    end;
                2 : begin
                      case pins of
                        GPIO_Pin_3 : LPC_IOCON.PIO2_3 := LPC_IOCON.PIO2_3 AND NOT $07;
                      end;
                      LPC_GPIO2.DIR := LPC_GPIO2.DIR or pins;
                    end;
                3 : begin
                      case pins of
                        GPIO_Pin_1 : LPC_IOCON.PIO3_1 := LPC_IOCON.PIO3_1 AND NOT $07;

                      end;
                      LPC_GPIO3.DIR := LPC_GPIO3.DIR or pins;
                    end;
        end;
end;

procedure SetPins(Port : byte; pin : word);
begin
	case Port of
		0 : LPC_GPIO0.MASKED_ACCESS[pin] := pin;
		1 : LPC_GPIO1.MASKED_ACCESS[pin] := pin;
		2 : LPC_GPIO2.MASKED_ACCESS[pin] := pin;
		3 : LPC_GPIO3.MASKED_ACCESS[pin] := pin;
	end;		
end;

procedure ClrPins(Port : byte; pin : word);
begin
	case Port of
		0 : LPC_GPIO0.MASKED_ACCESS[pin] := 0;
		1 : LPC_GPIO1.MASKED_ACCESS[pin] := 0;
		2 : LPC_GPIO2.MASKED_ACCESS[pin] := 0;
		3 : LPC_GPIO3.MASKED_ACCESS[pin] := 0;
	end;		
end;

procedure TogglePin(Port : byte; Index : word);
begin
	case Port of
		0 : LPC_GPIO0.DATA := LPC_GPIO0.DATA xor ((longword(1) shl Index)xor High(longword));
		1 : LPC_GPIO1.DATA := LPC_GPIO1.DATA xor ((longword(1) shl Index)xor High(longword));
		2 : LPC_GPIO2.DATA := LPC_GPIO2.DATA xor ((longword(1) shl Index)xor High(longword));
		3 : LPC_GPIO3.DATA := LPC_GPIO3.DATA xor ((longword(1) shl Index)xor High(longword));
	end;
end;

end.
