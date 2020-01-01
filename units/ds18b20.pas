{
  Unit name: DS18B20 driver for LPC1114
  Author: Dariusz Kwiecinski ( kwiecinskidarek@gmail.com )
  Date: 01.01.2020r;
}
unit ds18b20;

interface

procedure DS18B20_Start_Convert();
function DS18B20_Read_Temperature() : integer;

var
 owdata : byte;

implementation

uses
 onewire;

procedure DS18B20_Start_Convert();
begin
  if (OW_Reset() = 1) then
  begin
    OW_Write($CC);
    OW_Write($44);
  end;
end;

function DS18B20_Read_Temperature() : integer;
var
 t1, t2 : byte;
begin
 if(OW_Reset() = 1) then
 begin
  OW_Write($CC);
  //for i:= 0 to  7 do
//	OW_Write(adr[i]);
			
	OW_Write($BE);
	t1 := OW_Read();
	t2 := OW_Read();
	OW_Reset();
        owdata := t1;
 end;
 result := (t1+(t2*255)) div 16;
end;


end.
