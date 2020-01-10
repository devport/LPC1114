{
  Unit name: Simple Instruction List implementation
  Author: Dariusz Kwiecinski ( kwiecinskidarek@gmail.com )
  Date: 08.01.2020r;
}
unit il_interpreter;

interface

type
  TInputPins = array[0..3] of byte;
  TOutputPins = array[0..3] of byte;

const
 MAX_SCRIPT_SIZE = 1024;
 MAX_PROGRAM_SIZE = 512;

 i_LINE     = 0;
 i_LD       = 1;
 i_ST       = 2;
 i_AND      = 3;
 i_ANDN     = 4;
 i_OR       = 5;
 i_ORN      = 6;
 i_XOR      = 7;
 i_XORN     = 8;

 i_S        = 10;
 i_R        = 11;

 i_SET      = 12;
 i_CLR      = 13;
//Addressing

 i_I        = 100; // 'I' input
 i_Q        = 101; // 'Q' output
 i_M        = 102; // 'M' memory
 i_OP       = 103; // '('
 i_CP       = 104; // ')'

 SR_FIRST_INSTRUCTION = 0; // First Instruction
 SR_STATE             = 1; // state of memory
 SR_RESULT            = 2; // Result of logic

 var
   Interpreter_Run : Boolean;
   UserSript : array[0..MAX_SCRIPT_SIZE] of Char;
   UserSript_Size : word;
   ilProgram : array[0..MAX_PROGRAM_SIZE] of Byte;
   ilProgram_Size : word;
   Script_ErrorCode : word = 0;

procedure Script_Scanner(Script : PChar; Script_Size : Word; Code : PByte; var Code_Size : Word);

procedure Set_Inputs(inputs : PByte);
procedure Set_Outputs(outputs : PByte);
procedure Interpreter_Loop();

implementation

var
  iIn : PByte;
  iOut : PByte;

  pPtr : word;
  vm_r1, vm_r2 : byte;
  status_register : byte;
{  Not yet
  vm_stack : array[0..32] of byte;
  vm_stack_ptr : byte;
 }
procedure Script_EmitCode(Inst : Byte; Code : PByte; Code_Size : PWord);
begin
  Code[Code_Size^] := Inst;
  Inc(Code_Size^);
end;

procedure Script_Scanner_Addr(Instr : Byte; var Script : PChar; var Code : PByte; var sPtr, cPtr : word);
begin
  while(Script[sPtr] = ' ') do Inc(sPtr);
              Script_EmitCode(Instr, Code, @cPtr);
              case Script[sPtr] of
                   'I' : begin
                          Script_EmitCode(i_I, Code, @cPtr);
                          Inc(sPtr);
                          while(Script[sPtr] = ' ') do Inc(sPtr);
                          Script_EmitCode(Ord(Script[sPtr])-48, Code, @cPtr);
                        end;
                   'Q' : begin
                          Script_EmitCode(i_Q, Code, @cPtr);
                          Inc(sPtr);
                          while(Script[sPtr] = ' ') do Inc(sPtr);
                          Script_EmitCode(Ord(Script[sPtr])-48, Code, @cPtr);
                       end;
              end;
end;

procedure Script_Scanner(Script : PChar; Script_Size : Word; Code : PByte; var Code_Size : Word);
var
  sPtr, cPtr : word;
begin
  sPtr := 1;
  cPtr := 0;
  Script_ErrorCode := 0;
  while true do begin
    // white chars
    while ((Script[sPtr] = #10) OR (Script[sPtr] = #13) OR (Script[sPtr] = #32) OR (Script[sPtr] = #9)) do Inc(sPtr);
    // check end script
    if sPtr >= Script_Size then break;

    case Script[sPtr] of
      '/' : begin
            if(Script[sPtr+1] = '/') then
              while (Script[sPtr] <> #10) do Inc(sPtr);
            Inc(sPtr);
          end;

      'L' : begin
            Inc(sPtr);
            if(Script[sPtr] = 'D') then begin
              Inc(sPtr);
              Script_EmitCode(i_LD, Code, @cPtr);
              while(Script[sPtr] = ' ') do Inc(sPtr);
              case Script[sPtr] of
                   'I' : begin
                          Script_EmitCode(i_I, Code, @cPtr);
                          Inc(sPtr);
                          while(Script[sPtr] = ' ') do Inc(sPtr);
                          Script_EmitCode(Ord(Script[sPtr])-48, Code, @cPtr);
                        end;
                   'Q' : begin
                          Script_EmitCode(i_Q, Code, @cPtr);
                          Inc(sPtr);
                          while(Script[sPtr] = ' ') do Inc(sPtr);
                          Script_EmitCode(Ord(Script[sPtr])-48, Code, @cPtr);
                       end;
              end;
            end;
            while (Script[sPtr] <> #10) do Inc(sPtr);
            Inc(sPtr);
          end;

      '=' : begin
            Inc(sPtr);
            while(Script[sPtr] = ' ') do Inc(sPtr);
            Script_EmitCode(i_ST, Code, @cPtr);
	    if (Script[sPtr] = 'Q') then begin
              Inc(sPtr);
              while(Script[sPtr] = ' ' ) do Inc(sPtr);
	      Script_EmitCode(i_Q, Code, @cPtr);
	      Script_EmitCode(Ord(Script[sPtr])-48, Code, @cPtr);
	    end else begin
               Script_ErrorCode := sPtr;
               Script[sPtr] := '!';
               exit;
             end;
            while (Script[sPtr] <> #10) do Inc(sPtr);
            Inc(sPtr);
          end;
      'S' : begin
              Inc(sPtr);
              case Script[sPtr] of
	        'E' : begin
                      Inc(sPtr);
                      if(Script[sPtr] = 'T') then begin
                        Script_EmitCode(i_SET, Code, @cPtr);
                      end else begin
                       Script_ErrorCode := sPtr;
                       Script[sPtr] := '!';
                       exit;
                      end;
	             end;
                'T' : begin
                      Inc(sPtr);
                      while(Script[sPtr] = ' ') do Inc(sPtr);
                      Script_EmitCode(i_ST, Code, @cPtr);
                      if (Script[sPtr] = 'Q') then begin
                        Inc(sPtr);
                        while(Script[sPtr] = ' ' ) do Inc(sPtr);
	                Script_EmitCode(i_Q, Code, @cPtr);
	                Script_EmitCode(Ord(Script[sPtr])-48, Code, @cPtr);
	              end else begin
                       Script_ErrorCode := sPtr;
                       Script[sPtr] := '!';
                       exit;
                      end;
                    end;
              end;
              while (Script[sPtr] <> #10) do Inc(sPtr);
              Inc(sPtr);
            end;
      'C' : begin
             Inc(sPtr);
             if(Script[sPtr] = 'L') and (Script[sPtr+1] = 'R') AND (Script[sPtr+2] = ' ') then begin
              Inc(sPtr, 2);
              Script_EmitCode(i_CLR, Code, @cPtr);
             end else begin
               Script_ErrorCode := sPtr;
               Script[sPtr] := '!';
               exit;
             end;
             while (Script[sPtr] <> #10) do Inc(sPtr);
             Inc(sPtr);
          end;
      'A' : begin
             Inc(sPtr);
             if(Script[sPtr] = 'N') AND (Script[sPtr+1] = 'D') AND (Script[sPtr+2] = 'N') AND (Script[sPtr+3] = ' ') then begin
              Inc(sPtr, 3);
              Script_Scanner_Addr(i_ANDN, Script, Code, sPtr, cPtr);
             end else if (Script[sPtr] = 'N') AND (Script[sPtr+1] = 'D') AND (Script[sPtr+2] = ' ') then begin
               Inc(sPtr, 2);
               Script_Scanner_Addr(i_AND, Script, Code, sPtr, cPtr);
             end else begin
               Script_ErrorCode := sPtr;
               Script[sPtr] := '!';
               exit;
             end;
             while (Script[sPtr] <> #10) do Inc(sPtr);
             Inc(sPtr);
          end;
      'O' : begin
             Inc(sPtr);
             if (Script[sPtr] = 'R') AND (Script[sPtr+1] = 'N') AND (Script[sPtr+2] = ' ') then begin
              Inc(sPtr, 2);
              Script_Scanner_Addr(i_ORN, Script, Code, sPtr, cPtr);
             end else if (Script[sPtr] = 'R') AND (Script[sPtr+1] = ' ') then begin
              Inc(sPtr);
              Script_Scanner_Addr(i_OR, Script, Code, sPtr, cPtr);
             end else begin
               Script_ErrorCode := sPtr;
               Script[sPtr] := '!';
               exit;
             end;
             while (Script[sPtr] <> #10) do Inc(sPtr);
             Inc(sPtr);
          end

    else
      Inc(sPtr);
    end;
  end;
  Code_Size := cPtr;
end;

//------------------------------------------------------------------------------

procedure Set_Inputs(inputs : PByte);
begin
  iIn := inputs;
end;

procedure Set_Outputs(outputs : PByte);
begin
  iOut := outputs;
end;

function Get_Value(pProgram : PByte) : byte;
begin
  Result := pProgram[pPtr];
end;

function Get_Addressing(pProgram : PByte) : Byte;
begin
  Result := 0;
  case pProgram[pPtr] of
    i_I : begin
          Inc(pPtr);
          vm_r2 := iIn[Get_Value(pProgram)];
	  if(vm_r2 = 1) then
	    status_register := status_register OR ( 1 << SR_STATE)
	  else
	    status_register := status_register AND NOT ( 1 << SR_STATE);
        end;
    i_Q : begin
          Inc(pPtr);
          vm_r2 := iOut[Get_Value(pProgram)];
	  if(vm_r2 = 1) then
	    status_register := status_register OR ( 1 << SR_STATE)
	  else
	    status_register := status_register AND NOT ( 1 << SR_STATE);
        end;
  end;
  Result := vm_r2;
end;

procedure Put_Addressing(pProgram : PByte);
var
  val : byte;
begin
  case pProgram[pPtr] of
  // Q
    i_Q : begin
	   Inc(pPtr);
	   val := Get_Value(pProgram);
	   iOut[val] := vm_r1;
         end;
  end;
end;


procedure Interpreter_Get_Instruction(pProgram : PByte);
begin
  case pProgram[pPtr] of
    i_LD : begin
           Inc(pPtr);
           vm_r1 := Get_Addressing(pProgram);
         end;

    i_ST : begin
            Inc(pPtr);
            Put_Addressing(pProgram);
           end;
    i_AND : begin
            Inc(pPtr);
            vm_r1 := vm_r1 AND Get_Addressing(pProgram);
          end;
    i_ANDN : begin
            Inc(pPtr);
            vm_r1 := (vm_r1 AND NOT Get_Addressing(pProgram));
          end;
    i_OR : begin
            Inc(pPtr);
            vm_r1 := vm_r1 OR Get_Addressing(pProgram);
          end;
    i_ORN : begin
            Inc(pPtr);
            vm_r1 := vm_r1 OR NOT Get_Addressing(pProgram);
          end;

    i_SET: vm_r1 := 1;
    i_CLR: vm_r1 := 0;

  end;
  if(vm_r1 = 1) then
    status_register := status_register OR ( 1 << SR_RESULT)
  else
    status_register := status_register AND NOT( 1 << SR_RESULT);
end;

procedure Interpreter_Loop();
begin
  if(Interpreter_Run = True) then begin
    pPtr := 0;
    while(pPtr < ilProgram_Size) do begin
      Interpreter_Get_Instruction(ilProgram);
      Inc(pPtr);
    end;
  end;
end;

end.
