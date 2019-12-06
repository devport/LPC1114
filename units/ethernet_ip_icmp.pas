unit ethernet_ip_icmp;

interface

const
  ICMP_TYPE_REPLY = 0;
  ICMP_TYPE_REQUEST = 8;

type
  PHDR_ICMP = ^THDR_ICMP;
  THDR_ICMP = packed record
    hdr_type : byte;
    code : byte;
    checksum : word;
    identifier : array[0..1] of byte;
    sequence : array[0..1] of byte;
    data : array[0..31] of byte;
  end;


  function ETH_Protocol_IP_ICMP(ip_hdr, icmp_hdr : PBYTE; size : word) : word;

implementation

uses
    ethernet_ip;

function ETH_Protocol_IP_ICMP(ip_hdr, icmp_hdr : PBYTE; size : word) : word;
var
  ICMP_Header : PHDR_ICMP;
  checksum, checksum_size : word;
begin
  Result := 0;
  ICMP_Header := @icmp_hdr[0];
  checksum_size := size;
  if (checksum_size AND $01) = $01 then begin
    icmp_hdr[checksum_size] := 0;
    Inc(checksum_size);
  end;

  checksum := Calc_Checksum(PWORD(ICMP_Header), checksum_size>>1, 0);
  if (checksum <> $FFFF) then exit;


  if ((ICMP_Header^).hdr_type = ICMP_TYPE_REQUEST) then begin
  //* echo request (PING)*/
  //* basically just change type to 0 (echo reply), recalculate checksum... */
  //* and send all other fields back the same */
  //* but if incoming ip hdr contained options filed... */
  //* need to copy data to an earlier point in buffer seeing as */
  //* reply will be sent with no ip hdr options */


    (ICMP_Header^).hdr_type := ICMP_TYPE_REPLY;	//* change to echo reply */
    (ICMP_Header^).code := 0;
    (ICMP_Header^).checksum := 0;	//* clear and recalculate checksum */

    checksum := calc_checksum(PWORD(icmp_hdr), checksum_size>>1, 0);
    checksum := NOT checksum;
    (ICMP_Header^).checksum := checksum;

    Result := size;
  end;
end;

end.
