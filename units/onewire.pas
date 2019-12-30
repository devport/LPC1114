{

 OneWire Driver
 Created by Darek Kwiecinski 2019 - kwiecinskidarek@gmail.com

}
unit onewire;

interface

{$Macro ON}
{$define OW_PIN := (1<<8)}
{$define OW_OUTPUT := LPC_GPIO1.DIR := LPC_GPIO1.DIR OR OW_PIN; }
{$define OW_INPUT := LPC_GPIO1.DIR := LPC_GPIO1.DIR AND NOT OW_PIN; }
{$define OW_LOW := LPC_GPIO1.MASKED_ACCESS[OW_PIN] := 0;}
{$define OW_HIGH := LPC_GPIO1.MASKED_ACCESS[OW_PIN] := OW_PIN;}
{$define OW_SENSE := (LPC_GPIO1.MASKED_ACCESS[OW_PIN] AND OW_PIN) = OW_PIN }


type
  TSearchState = record
   address : array[0..7] of byte;
   done : boolean;
   lastZeroBranch : ShortInt;
  end;


var
  ROM_NO : array[0..7] of byte;

function OW_Reset() : byte;
procedure OW_Write(val : byte);
function OW_Read() : byte;
function OW_Search_Device( var state : TSearchState) : boolean;
function OW_Search( var state : TSearchState) : boolean;

implementation

uses
 delay;

const
  bConflict = $00;
  bZero = $02;
  bOne = $01;


var
  presence : byte = 0;

function OW_Reset() : byte;
begin
 presence := 0;
 OW_OUTPUT;
 OW_LOW;
 Delay_US(480);
 OW_INPUT;
 Delay_US(70);
 if(OW_SENSE = false) then
  presence := 1;
 Delay_US(460);
 Result := presence;
end;

procedure OW_Write_Bit(b : byte);
begin
 if (b = 1) then
 begin
  // Write '1' bit
  OW_OUTPUT;
  OW_LOW;
  Delay_US(5);
  OW_INPUT;
  Delay_US(55);
 end else
 begin
  // Write '0' bit
  OW_OUTPUT;
  OW_LOW;
  Delay_US(55);
  OW_INPUT;
  Delay_US(5);
 end;
end;


function OW_Read_Bit() : byte;
begin
 OW_OUTPUT;
 OW_LOW;
 Delay_US(1);
 OW_INPUT;
 Delay_US(10);
 if (OW_SENSE) then
  result := 1
 else
  result := 0;
 Delay_US(50);
end;


procedure OW_Write(val : byte);
var
  i, temp : byte;
begin
 for i:= 0 to 7 do
 begin
  temp := val >> i;
  temp := temp AND $01;
  OW_Write_Bit(temp);
 end;
end;

function OW_Read() : byte;
var
  i, mask, res : byte;
begin
 res := 0;
 mask := $01;
 for i:= 0 to 7 do
 begin
  if (OW_Read_Bit() = 1 ) then
   res := res OR mask;

  mask := mask << 1;
 end;
  result := res;
end;

function OW_Search_Device( var state : TSearchState) : boolean;
begin
  if(OW_Reset() = 0) then
  begin
    result := false;
    exit;
  end;
    OW_Write($F0);
    result := OW_Search(state);
end;

function OW_Search( var state : TSearchState) : boolean;
var
 bitPosition, reading, bitValue, byteIndex, bitIndex : byte;
 localLastZeroBranch : ShortInt;
begin


 localLastZeroBranch := -1;

 for bitPosition:= 0 to 63 do begin
     byteIndex := bitPosition div 8;
     bitIndex := bitPosition mod 8;

     reading := 0;
     reading := OW_Read_Bit();
     reading := reading or (OW_Read_Bit() << 1);

     case reading of
       bZero, bOne: begin
                     // Bit was the same on all responding devices: it is a known value
                     // The first bit is the value we want to write (rather than its complement)
                     bitValue := (reading AND $01);
                    end;

       bConflict: begin
                  // Both 0 and 1 were written to the bus
                  // Use the search state to continue walking through devices
                  if (bitPosition = state.lastZeroBranch) then
                    // Current bit is the last position the previous search chose a zero: send one
                    bitValue := 1
                  else if (bitPosition < state.lastZeroBranch) then
                    // Before the lastZeroBranch position, repeat the same choices as the previous search
                    bitValue := state.address[byteIndex] AND (1 << bitIndex)
                  else
                    // Current bit is past the lastZeroBranch in the previous search: send zero
                    bitValue := 0;


                  // Remember the last branch where a zero was written for the next search
                  if (bitValue = 0) then
                     localLastZeroBranch := bitPosition;
                  end;

       else begin
         result := false;
         exit;
       end;

     end;
     // Write bit into address
     if (bitValue = 0) then
       state.address[byteIndex] := state.address[byteIndex] AND NOT (1 << bitIndex)
     else
       state.address[byteIndex] := state.address[byteIndex] OR (bitValue << bitIndex);

     OW_Write_Bit(bitValue);
 end;
 // If the no branch points were found, mark the search as done.
 // Otherwise, mark the last zero branch we found for the next search
 if (localLastZeroBranch = -1) then
   state.done := true
 else
   state.lastZeroBranch := localLastZeroBranch;

 result := true;
end;

end.
