{
  Unit name: Utils for LPC1114
  Author: Dariusz Kwiecinski ( kwiecinskidarek@gmail.com )
  Date: 01.01.2020r;
}
unit Utils;

interface

type
  ArrayChar = array of char;

function IsDigital(c : char): boolean;
function GetTime():longword;

procedure ClearBit(var Value: longword; Index: Byte);
procedure SetBit(var Value: longword; Index: Byte);

function IntToStr (I : integer) : String;

// GPIO
procedure SetInputs(Port : byte; pins : word);
procedure SetOutputs(Port : byte; pins : word);
procedure SetPins(Port : byte; pin : word);
procedure ClrPins(Port : byte; pin : word);
function PinSense(Port : byte; pin : word) : boolean;
//procedure TogglePin(Port : byte; Index : word);

var
  time : longword = 1;

implementation

uses
  system_LPC1114;

function IsDigital(c : char): boolean;
begin
 Result := False;
 if (c in ['0'..'9']) then Result := True;
end;

function GetTime() : longword;
begin
  GetTime := time;
end;

procedure ClearBit(var Value: longword; Index: Byte); inline;
begin
  Value := Value and ((longword(1) shl Index) xor High(longword));
end;

procedure SetBit(var Value: longword; Index: Byte); inline;
begin
  Value := Value or (longword(1) shl Index);
end;


function IntToStr (I : integer) : String;
var
   S : string;
begin
  Str (I, S);
  Result := S;
end;

procedure SetInputs(Port : byte; pins : word);
begin
	case Port of
		0 : begin
                      case pins of
                        GPIO_Pin_11 : LPC_IOCON.R_PIO0_11 := LPC_IOCON.R_PIO0_11 OR (1 << 0);
                      end;
                      LPC_GPIO0.DIR := LPC_GPIO0.DIR and not pins;
                    end;
                1 : LPC_GPIO1.DIR := LPC_GPIO1.DIR and not pins;
		2 : LPC_GPIO2.DIR := LPC_GPIO2.DIR and not pins;
		3 : LPC_GPIO3.DIR := LPC_GPIO3.DIR and not pins;
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

function PinSense(Port : byte; pin : word) : boolean;
begin
     Result := False;
	case Port of
		0 : Result := (LPC_GPIO0.MASKED_ACCESS[pin] AND pin) = pin;
		1 : Result := (LPC_GPIO1.MASKED_ACCESS[pin] AND pin) = pin;
		2 : Result := (LPC_GPIO2.MASKED_ACCESS[pin] AND pin) = pin;
		3 : Result := (LPC_GPIO3.MASKED_ACCESS[pin] AND pin) = pin;
	end;
end;
{
procedure TogglePin(Port : byte; Index : word);
begin
	case Port of
		0 : LPC_GPIO0.DATA := LPC_GPIO0.DATA xor ((longword(1) shl Index)xor High(longword));
		1 : LPC_GPIO1.DATA := LPC_GPIO1.DATA xor ((longword(1) shl Index)xor High(longword));
		2 : LPC_GPIO2.DATA := LPC_GPIO2.DATA xor ((longword(1) shl Index)xor High(longword));
		3 : LPC_GPIO3.DATA := LPC_GPIO3.DATA xor ((longword(1) shl Index)xor High(longword));
	end;
end;
}
end.
