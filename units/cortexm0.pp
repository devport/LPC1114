{
 System register definitions and utility code for Cortex-M0
 Created by Jeppe Johansen 2012 - jeppe@j-software.dk
 Modified for M0 by Michael Ring 2013 - mail@michael-ring.org
 Modified for M0 by Darek Kwiecinski 2019 - kwiecinskidarek@gmail.com
}
unit cortexm0;

interface

{$PACKRECORDS 2}
const
 SCS_BASE   = $E000E000;
 SysTick_BASE = SCS_BASE+$0010;
 NVIC_BASE = SCS_BASE+$0100;
 SCB_BASE = SCS_BASE+$0D00;

 DWT_BASE   = $E0001000;
 FP_BASE    = $E0002000;
 ITM_BASE   = $E0000000;
 TPIU_BASE  = $E0040000;
 ETM_BASE   = $E0041000;

 { SysTick Control / Status Register Definitions }
 SysTick_CTRL_CLKSOURCE_Pos = $02;
 SysTick_CTRL_CLKSOURCE_Msk = $04;
 SysTick_CTRL_TICKINT_Pos   = $01;
 SysTick_CTRL_TICKINT_Msk   = $02;
 SysTick_CTRL_ENABLE_Pos    = $00;
 SysTick_CTRL_ENABLE_Msk    = $01;
 SysTick_CTRL_COUNTFLAG_Pos = $10;
 SysTick_CTRL_COUNTFLAG_Msk = $10000;
 { SysTick Reload Register Definitions }
 SysTick_LOAD_RELOAD_Pos    = $00;
 SysTick_LOAD_RELOAD_Msk    = $1000000;
 { SysTick Current Register Definitions }
 SysTick_VAL_CURRENT_Pos    = $00;
 SysTick_VAL_CURRENT_Msk    = $1000000;
 { SysTick Calibration Register Definitions }
 SysTick_CALIB_NOREF_Pos    = $1f;
 SysTick_CALIB_NOREF_Msk    = $80000000;
 SysTick_CALIB_SKEW_Pos     = $1e;
 SysTick_CALIB_SKEW_Msk     = $40000000;
 SysTick_CALIB_TENMS_Pos    = $00;
 SysTick_CALIB_TENMS_Msk    = $ffffff;


type

 TNVICRegisters = record
   ISER : dword;
   RESERVED0 : array[0..30] of dword;
   ICER : dword;
   RSERVED1 : array[0..30] of dword;
   ISPR : dword;
   RESERVED2 : array[0..30] of dword;
   ICPR : dword;
   RESERVED3 : array[0..30] of dword;
   RESERVED4 : array[0..63] of dword;
   IPR : array[0..7] of dword;
 end;

 TSCBRegisters = record
  CPUID,                            {!< CPU ID Base Register                                     }
  ICSR,                             {!< Interrupt Control State Register                         }
  RESERVED0,
  AIRCR,                            {!< Application Interrupt / Reset Control Register           }
  SCR,                              {!< System Control Register                                  }
  CCR: dword;                       {!< Configuration Control Register                           }
  RESERVED1 : dword;
  SHP: array[0..1] of dword;        {!< System Handlers Priority Registers (4-7, 8-11, 12-15)    }
 end;

 TSysTickRegisters = record
  Ctrl,
  Load,
  Val,
  Calib: dword;
 end;

 TCoreDebugRegisters = record
  DHCSR,
  DCRSR,
  DCRDR,
  DEMCR: longword;
 end;


var
 // System Control
 InterruptControlType: longword     absolute (SCS_BASE+$0004);
 SCB: TSCBRegisters                 absolute (SCS_BASE+$0D00);
 SysTick: TSysTickRegisters         absolute (SCS_BASE+$0010);
 NVIC: TNVICRegisters               absolute (SCS_BASE+$0100);
 SoftwareTriggerInterrupt: longword absolute (SCS_BASE+$0000);

 // Core Debug
 CoreDebug: TCoreDebugRegisters     absolute (SCS_BASE+$0DF0);




 function SysTick_Config(ticks : longword) : longword;

implementation

// System Tick Configuration
//
//  param - Number of ticks between two interrupts.
//  return - 0  Function succeeded.
//  return - 1  Function failed.

function SysTick_Config(ticks : longword) : longword;
begin
 // Reload value impossible
 if ((ticks - 1) > SysTick_LOAD_RELOAD_Msk) then
    Result := 1;

 SysTick.Load :=  ticks - 1;
 SysTick.Val := 0;
 Systick.Ctrl := SysTick_CTRL_CLKSOURCE_Msk or
                 SysTick_CTRL_TICKINT_Msk or
                 SysTick_CTRL_ENABLE_Msk;
 Result := 0;
end;

end.
