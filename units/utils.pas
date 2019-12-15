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

procedure ClearBit(var Value: longword; Index: Byte);
procedure SetBit(var Value: longword; Index: Byte);

function IntToStr (I : integer) : String;
function ArrayCharToString(A: ArrayChar): String;
function GetTime():longword;

// GPIO
procedure SetInputs(Port : byte; pins : word);
procedure SetOutputs(Port : byte; pins : word);
procedure SetPins(Port : byte; pin : word);
procedure ClrPins(Port : byte; pin : word);
procedure TogglePin(Port : byte; Index : word);


implementation

function GetTime() : longword;
begin
  Result := time;
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
  result := S;
end;

function ArrayCharToString(A: ArrayChar): String;
var
   i: integer;
begin
  result := '';
  for i := 0 to High(A) do
    result := result + A[i];
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
		1 : LPC_GPIO1.DIR := LPC_GPIO1.DIR or pins;
		2 : LPC_GPIO2.DIR := LPC_GPIO2.DIR or pins;
		3 : LPC_GPIO3.DIR := LPC_GPIO3.DIR or pins;
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
