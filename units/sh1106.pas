unit sh1106;

interface

uses
  utils, spi;
{$macro on}
{$define WIDTH   := 128}
{$define HEIGHT  := 64}
{$define NUM_PAGE := 8}

{$define SH1106_CS_PIN := (1<<2)}
{$define SH1106_CS_PORT := 0}
{$define SH1106_DC_PIN := (1<<3)}
{$define SH1106_DC_PORT := 0}
{$define SH1106_RST_PIN := (1<<11)}
{$define SH1106_RST_PORT := 1}


const
  SH1106_CMD = 0;
  SH1106_DAT = 1;

  Font1612 : array[0..10, 0..31] of byte = (
  ($00,$00,$3F,$FC,$3F,$FC,$30,$0C,$30,$0C,$30,$0C,$30,$0C,$30,$0C,
   $30,$0C,$30,$0C,$30,$0C,$30,$0C,$30,$0C,$3F,$FC,$3F,$FC,$00,$00),
  ($00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$30,$00,
   $30,$00,$3F,$FC,$3F,$FC,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00),
  ($00,$00,$39,$FC,$39,$FC,$31,$8C,$31,$8C,$31,$8C,$31,$8C,$31,$8C,
   $31,$8C,$31,$8C,$31,$8C,$31,$8C,$31,$8C,$3F,$8C,$3F,$8C,$00,$00),
  ($00,$00,$38,$1C,$38,$1C,$31,$8C,$31,$8C,$31,$8C,$31,$8C,$31,$8C,
   $31,$8C,$31,$8C,$31,$8C,$31,$8C,$31,$8C,$3F,$FC,$3F,$FC,$00,$00),
  ($00,$00,$3F,$80,$3F,$80,$01,$80,$01,$80,$01,$80,$01,$80,$01,$80,
   $01,$80,$01,$80,$01,$80,$01,$80,$01,$80,$3F,$FC,$3F,$FC,$00,$00),
  ($00,$00,$3F,$8C,$3F,$8C,$31,$8C,$31,$8C,$31,$8C,$31,$8C,$31,$8C,
   $31,$8C,$31,$8C,$31,$8C,$31,$8C,$31,$8C,$31,$FC,$31,$FC,$00,$00),
  ($00,$00,$3F,$FC,$3F,$FC,$31,$8C,$31,$8C,$31,$8C,$31,$8C,$31,$8C,
   $31,$8C,$31,$8C,$31,$8C,$31,$8C,$31,$8C,$31,$FC,$31,$FC,$00,$00),
  ($00,$00,$38,$00,$38,$00,$30,$00,$30,$00,$30,$00,$30,$00,$30,$00,
   $30,$00,$30,$00,$30,$00,$30,$00,$30,$00,$3F,$FC,$3F,$FC,$00,$00),
  ($00,$00,$3F,$FC,$3F,$FC,$31,$8C,$31,$8C,$31,$8C,$31,$8C,$31,$8C,
   $31,$8C,$31,$8C,$31,$8C,$31,$8C,$31,$8C,$3F,$FC,$3F,$FC,$00,$00),
  ($00,$00,$3F,$9C,$3F,$9C,$31,$8C,$31,$8C,$31,$8C,$31,$8C,$31,$8C,
   $31,$8C,$31,$8C,$31,$8C,$31,$8C,$31,$8C,$3F,$FC,$3F,$FC,$00,$00),
  ($00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$18,$30,
   $18,$30,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00)
  );

  Font1608 : array[0..94, 0..15] of byte = (
  ($00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00),//" ",0*/
  ($00,$00,$00,$00,$00,$00,$1F,$CC,$00,$0C,$00,$00,$00,$00,$00,$00),//"!",1*/
  ($00,$00,$08,$00,$30,$00,$60,$00,$08,$00,$30,$00,$60,$00,$00,$00),//""",2*/
  ($02,$20,$03,$FC,$1E,$20,$02,$20,$03,$FC,$1E,$20,$02,$20,$00,$00),//"#",3*/
  ($00,$00,$0E,$18,$11,$04,$3F,$FF,$10,$84,$0C,$78,$00,$00,$00,$00),//"$",4*/
  ($0F,$00,$10,$84,$0F,$38,$00,$C0,$07,$78,$18,$84,$00,$78,$00,$00),//"%",5*/
  ($00,$78,$0F,$84,$10,$C4,$11,$24,$0E,$98,$00,$E4,$00,$84,$00,$08),//"&",6*/
  ($08,$00,$68,$00,$70,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00),//"'",7*/
  ($00,$00,$00,$00,$00,$00,$07,$E0,$18,$18,$20,$04,$40,$02,$00,$00),//"(",8*/
  ($00,$00,$40,$02,$20,$04,$18,$18,$07,$E0,$00,$00,$00,$00,$00,$00),//")",9*/
  ($02,$40,$02,$40,$01,$80,$0F,$F0,$01,$80,$02,$40,$02,$40,$00,$00),//"*",10*/
  ($00,$80,$00,$80,$00,$80,$0F,$F8,$00,$80,$00,$80,$00,$80,$00,$00),//"+",11*/
  ($00,$01,$00,$0D,$00,$0E,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00),//",",12*/
  ($00,$00,$00,$80,$00,$80,$00,$80,$00,$80,$00,$80,$00,$80,$00,$80),//"-",13*/
  ($00,$00,$00,$0C,$00,$0C,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00),//".",14*/
  ($00,$00,$00,$06,$00,$18,$00,$60,$01,$80,$06,$00,$18,$00,$20,$00),//"/",15*/
  ($00,$00,$07,$F0,$08,$08,$10,$04,$10,$04,$08,$08,$07,$F0,$00,$00),//"0",16*/
  ($00,$00,$08,$04,$08,$04,$1F,$FC,$00,$04,$00,$04,$00,$00,$00,$00),//"1",17*/
  ($00,$00,$0E,$0C,$10,$14,$10,$24,$10,$44,$11,$84,$0E,$0C,$00,$00),//"2",18*/
  ($00,$00,$0C,$18,$10,$04,$11,$04,$11,$04,$12,$88,$0C,$70,$00,$00),//"3",19*/
  ($00,$00,$00,$E0,$03,$20,$04,$24,$08,$24,$1F,$FC,$00,$24,$00,$00),//"4",20*/
  ($00,$00,$1F,$98,$10,$84,$11,$04,$11,$04,$10,$88,$10,$70,$00,$00),//"5",21*/
  ($00,$00,$07,$F0,$08,$88,$11,$04,$11,$04,$18,$88,$00,$70,$00,$00),//"6",22*/
  ($00,$00,$1C,$00,$10,$00,$10,$FC,$13,$00,$1C,$00,$10,$00,$00,$00),//"7",23*/
  ($00,$00,$0E,$38,$11,$44,$10,$84,$10,$84,$11,$44,$0E,$38,$00,$00),//"8",24*/
  ($00,$00,$07,$00,$08,$8C,$10,$44,$10,$44,$08,$88,$07,$F0,$00,$00),//"9",25*/
  ($00,$00,$00,$00,$00,$00,$03,$0C,$03,$0C,$00,$00,$00,$00,$00,$00),//":",26*/
  ($00,$00,$00,$00,$00,$01,$01,$06,$00,$00,$00,$00,$00,$00,$00,$00),//";",27*/
  ($00,$00,$00,$80,$01,$40,$02,$20,$04,$10,$08,$08,$10,$04,$00,$00),//"<",28*/
  ($02,$20,$02,$20,$02,$20,$02,$20,$02,$20,$02,$20,$02,$20,$00,$00),//"=",29*/
  ($00,$00,$10,$04,$08,$08,$04,$10,$02,$20,$01,$40,$00,$80,$00,$00),//">",30*/
  ($00,$00,$0E,$00,$12,$00,$10,$0C,$10,$6C,$10,$80,$0F,$00,$00,$00),//"?",31*/
  ($03,$E0,$0C,$18,$13,$E4,$14,$24,$17,$C4,$08,$28,$07,$D0,$00,$00),//"@",32*/
  ($00,$04,$00,$3C,$03,$C4,$1C,$40,$07,$40,$00,$E4,$00,$1C,$00,$04),//"A",33*/
  ($10,$04,$1F,$FC,$11,$04,$11,$04,$11,$04,$0E,$88,$00,$70,$00,$00),//"B",34*/
  ($03,$E0,$0C,$18,$10,$04,$10,$04,$10,$04,$10,$08,$1C,$10,$00,$00),//"C",35*/
  ($10,$04,$1F,$FC,$10,$04,$10,$04,$10,$04,$08,$08,$07,$F0,$00,$00),//"D",36*/
  ($10,$04,$1F,$FC,$11,$04,$11,$04,$17,$C4,$10,$04,$08,$18,$00,$00),//"E",37*/
  ($10,$04,$1F,$FC,$11,$04,$11,$00,$17,$C0,$10,$00,$08,$00,$00,$00),//"F",38*/
  ($03,$E0,$0C,$18,$10,$04,$10,$04,$10,$44,$1C,$78,$00,$40,$00,$00),//"G",39*/
  ($10,$04,$1F,$FC,$10,$84,$00,$80,$00,$80,$10,$84,$1F,$FC,$10,$04),//"H",40*/
  ($00,$00,$10,$04,$10,$04,$1F,$FC,$10,$04,$10,$04,$00,$00,$00,$00),//"I",41*/
  ($00,$03,$00,$01,$10,$01,$10,$01,$1F,$FE,$10,$00,$10,$00,$00,$00),//"J",42*/
  ($10,$04,$1F,$FC,$11,$04,$03,$80,$14,$64,$18,$1C,$10,$04,$00,$00),//"K",43*/
  ($10,$04,$1F,$FC,$10,$04,$00,$04,$00,$04,$00,$04,$00,$0C,$00,$00),//"L",44*/
  ($10,$04,$1F,$FC,$1F,$00,$00,$FC,$1F,$00,$1F,$FC,$10,$04,$00,$00),//"M",45*/
  ($10,$04,$1F,$FC,$0C,$04,$03,$00,$00,$E0,$10,$18,$1F,$FC,$10,$00),//"N",46*/
  ($07,$F0,$08,$08,$10,$04,$10,$04,$10,$04,$08,$08,$07,$F0,$00,$00),//"O",47*/
  ($10,$04,$1F,$FC,$10,$84,$10,$80,$10,$80,$10,$80,$0F,$00,$00,$00),//"P",48*/
  ($07,$F0,$08,$18,$10,$24,$10,$24,$10,$1C,$08,$0A,$07,$F2,$00,$00),//"Q",49*/
  ($10,$04,$1F,$FC,$11,$04,$11,$00,$11,$C0,$11,$30,$0E,$0C,$00,$04),//"R",50*/
  ($00,$00,$0E,$1C,$11,$04,$10,$84,$10,$84,$10,$44,$1C,$38,$00,$00),//"S",51*/
  ($18,$00,$10,$00,$10,$04,$1F,$FC,$10,$04,$10,$00,$18,$00,$00,$00),//"T",52*/
  ($10,$00,$1F,$F8,$10,$04,$00,$04,$00,$04,$10,$04,$1F,$F8,$10,$00),//"U",53*/
  ($10,$00,$1E,$00,$11,$E0,$00,$1C,$00,$70,$13,$80,$1C,$00,$10,$00),//"V",54*/
  ($1F,$C0,$10,$3C,$00,$E0,$1F,$00,$00,$E0,$10,$3C,$1F,$C0,$00,$00),//"W",55*/
  ($10,$04,$18,$0C,$16,$34,$01,$C0,$01,$C0,$16,$34,$18,$0C,$10,$04),//"X",56*/
  ($10,$00,$1C,$00,$13,$04,$00,$FC,$13,$04,$1C,$00,$10,$00,$00,$00),//"Y",57*/
  ($08,$04,$10,$1C,$10,$64,$10,$84,$13,$04,$1C,$04,$10,$18,$00,$00),//"Z",58*/
  ($00,$00,$00,$00,$00,$00,$7F,$FE,$40,$02,$40,$02,$40,$02,$00,$00),//"[",59*/
  ($00,$00,$30,$00,$0C,$00,$03,$80,$00,$60,$00,$1C,$00,$03,$00,$00),//"\",60*/
  ($00,$00,$40,$02,$40,$02,$40,$02,$7F,$FE,$00,$00,$00,$00,$00,$00),//"]",61*/
  ($00,$00,$00,$00,$20,$00,$40,$00,$40,$00,$40,$00,$20,$00,$00,$00),//"^",62*/
  ($00,$01,$00,$01,$00,$01,$00,$01,$00,$01,$00,$01,$00,$01,$00,$01),//"_",63*/
  ($00,$00,$40,$00,$40,$00,$20,$00,$00,$00,$00,$00,$00,$00,$00,$00),//"`",64*/
  ($00,$00,$00,$98,$01,$24,$01,$44,$01,$44,$01,$44,$00,$FC,$00,$04),//"a",65*/
  ($10,$00,$1F,$FC,$00,$88,$01,$04,$01,$04,$00,$88,$00,$70,$00,$00),//"b",66*/
  ($00,$00,$00,$70,$00,$88,$01,$04,$01,$04,$01,$04,$00,$88,$00,$00),//"c",67*/
  ($00,$00,$00,$70,$00,$88,$01,$04,$01,$04,$11,$08,$1F,$FC,$00,$04),//"d",68*/
  ($00,$00,$00,$F8,$01,$44,$01,$44,$01,$44,$01,$44,$00,$C8,$00,$00),//"e",69*/
  ($00,$00,$01,$04,$01,$04,$0F,$FC,$11,$04,$11,$04,$11,$00,$18,$00),//"f",70*/
  ($00,$00,$00,$D6,$01,$29,$01,$29,$01,$29,$01,$C9,$01,$06,$00,$00),//"g",71*/
  ($10,$04,$1F,$FC,$00,$84,$01,$00,$01,$00,$01,$04,$00,$FC,$00,$04),//"h",72*/
  ($00,$00,$01,$04,$19,$04,$19,$FC,$00,$04,$00,$04,$00,$00,$00,$00),//"i",73*/
  ($00,$00,$00,$03,$00,$01,$01,$01,$19,$01,$19,$FE,$00,$00,$00,$00),//"j",74*/
  ($10,$04,$1F,$FC,$00,$24,$00,$40,$01,$B4,$01,$0C,$01,$04,$00,$00),//"k",75*/
  ($00,$00,$10,$04,$10,$04,$1F,$FC,$00,$04,$00,$04,$00,$00,$00,$00),//"l",76*/
  ($01,$04,$01,$FC,$01,$04,$01,$00,$01,$FC,$01,$04,$01,$00,$00,$FC),//"m",77*/
  ($01,$04,$01,$FC,$00,$84,$01,$00,$01,$00,$01,$04,$00,$FC,$00,$04),//"n",78*/
  ($00,$00,$00,$F8,$01,$04,$01,$04,$01,$04,$01,$04,$00,$F8,$00,$00),//"o",79*/
  ($01,$01,$01,$FF,$00,$85,$01,$04,$01,$04,$00,$88,$00,$70,$00,$00),//"p",80*/
  ($00,$00,$00,$70,$00,$88,$01,$04,$01,$04,$01,$05,$01,$FF,$00,$01),//"q",81*/
  ($01,$04,$01,$04,$01,$FC,$00,$84,$01,$04,$01,$00,$01,$80,$00,$00),//"r",82*/
  ($00,$00,$00,$CC,$01,$24,$01,$24,$01,$24,$01,$24,$01,$98,$00,$00),//"s",83*/
  ($00,$00,$01,$00,$01,$00,$07,$F8,$01,$04,$01,$04,$00,$00,$00,$00),//"t",84*/
  ($01,$00,$01,$F8,$00,$04,$00,$04,$00,$04,$01,$08,$01,$FC,$00,$04),//"u",85*/
  ($01,$00,$01,$80,$01,$70,$00,$0C,$00,$10,$01,$60,$01,$80,$01,$00),//"v",86*/
  ($01,$F0,$01,$0C,$00,$30,$01,$C0,$00,$30,$01,$0C,$01,$F0,$01,$00),//"w",87*/
  ($00,$00,$01,$04,$01,$8C,$00,$74,$01,$70,$01,$8C,$01,$04,$00,$00),//"x",88*/
  ($01,$01,$01,$81,$01,$71,$00,$0E,$00,$18,$01,$60,$01,$80,$01,$00),//"y",89*/
  ($00,$00,$01,$84,$01,$0C,$01,$34,$01,$44,$01,$84,$01,$0C,$00,$00),//"z",90*/
  ($00,$00,$00,$00,$00,$00,$00,$00,$01,$00,$3E,$FC,$40,$02,$40,$02),//"(",91*/
  ($00,$00,$00,$00,$00,$00,$00,$00,$FF,$FF,$00,$00,$00,$00,$00,$00),//"|",92*/
  ($00,$00,$40,$02,$40,$02,$3E,$FC,$01,$00,$00,$00,$00,$00,$00,$00),//")",93*/
  ($00,$00,$60,$00,$80,$00,$80,$00,$40,$00,$40,$00,$20,$00,$20,$00)//"~",94*/
  );

  Font1206 : array[0..94, 0..11] of byte = (
  ($00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00),//" ",0*/
    ($00,$00,$00,$00,$3F,$40,$00,$00,$00,$00,$00,$00),//"!",1*/
    ($00,$00,$30,$00,$40,$00,$30,$00,$40,$00,$00,$00),//""",2*/
    ($09,$00,$0B,$C0,$3D,$00,$0B,$C0,$3D,$00,$09,$00),//"#",3*/
    ($18,$C0,$24,$40,$7F,$E0,$22,$40,$31,$80,$00,$00),//"$",4*/
    ($18,$00,$24,$C0,$1B,$00,$0D,$80,$32,$40,$01,$80),//"%",5*/
    ($03,$80,$1C,$40,$27,$40,$1C,$80,$07,$40,$00,$40),//"&",6*/
    ($10,$00,$60,$00,$00,$00,$00,$00,$00,$00,$00,$00),//"'",7*/
    ($00,$00,$00,$00,$00,$00,$1F,$80,$20,$40,$40,$20),//"(",8*/
    ($00,$00,$40,$20,$20,$40,$1F,$80,$00,$00,$00,$00),//")",9*/
    ($09,$00,$06,$00,$1F,$80,$06,$00,$09,$00,$00,$00),//"*",10*/
    ($04,$00,$04,$00,$3F,$80,$04,$00,$04,$00,$00,$00),//"+",11*/
    ($00,$10,$00,$60,$00,$00,$00,$00,$00,$00,$00,$00),//",",12*/
    ($04,$00,$04,$00,$04,$00,$04,$00,$04,$00,$00,$00),//"-",13*/
    ($00,$00,$00,$40,$00,$00,$00,$00,$00,$00,$00,$00),//".",14*/
    ($00,$20,$01,$C0,$06,$00,$38,$00,$40,$00,$00,$00),//"/",15*/
    ($1F,$80,$20,$40,$20,$40,$20,$40,$1F,$80,$00,$00),//"0",16*/
    ($00,$00,$10,$40,$3F,$C0,$00,$40,$00,$00,$00,$00),//"1",17*/
    ($18,$C0,$21,$40,$22,$40,$24,$40,$18,$40,$00,$00),//"2",18*/
    ($10,$80,$20,$40,$24,$40,$24,$40,$1B,$80,$00,$00),//"3",19*/
    ($02,$00,$0D,$00,$11,$00,$3F,$C0,$01,$40,$00,$00),//"4",20*/
    ($3C,$80,$24,$40,$24,$40,$24,$40,$23,$80,$00,$00),//"5",21*/
    ($1F,$80,$24,$40,$24,$40,$34,$40,$03,$80,$00,$00),//"6",22*/
    ($30,$00,$20,$00,$27,$C0,$38,$00,$20,$00,$00,$00),//"7",23*/
    ($1B,$80,$24,$40,$24,$40,$24,$40,$1B,$80,$00,$00),//"8",24*/
    ($1C,$00,$22,$C0,$22,$40,$22,$40,$1F,$80,$00,$00),//"9",25*/
    ($00,$00,$00,$00,$08,$40,$00,$00,$00,$00,$00,$00),//":",26*/
    ($00,$00,$00,$00,$04,$60,$00,$00,$00,$00,$00,$00),//";",27*/
    ($00,$00,$04,$00,$0A,$00,$11,$00,$20,$80,$40,$40),//"<",28*/
    ($09,$00,$09,$00,$09,$00,$09,$00,$09,$00,$00,$00),//"=",29*/
    ($00,$00,$40,$40,$20,$80,$11,$00,$0A,$00,$04,$00),//">",30*/
    ($18,$00,$20,$00,$23,$40,$24,$00,$18,$00,$00,$00),//"?",31*/
    ($1F,$80,$20,$40,$27,$40,$29,$40,$1F,$40,$00,$00),//"@",32*/
    ($00,$40,$07,$C0,$39,$00,$0F,$00,$01,$C0,$00,$40),//"A",33*/
    ($20,$40,$3F,$C0,$24,$40,$24,$40,$1B,$80,$00,$00),//"B",34*/
    ($1F,$80,$20,$40,$20,$40,$20,$40,$30,$80,$00,$00),//"C",35*/
    ($20,$40,$3F,$C0,$20,$40,$20,$40,$1F,$80,$00,$00),//"D",36*/
    ($20,$40,$3F,$C0,$24,$40,$2E,$40,$30,$C0,$00,$00),//"E",37*/
    ($20,$40,$3F,$C0,$24,$40,$2E,$00,$30,$00,$00,$00),//"F",38*/
    ($0F,$00,$10,$80,$20,$40,$22,$40,$33,$80,$02,$00),//"G",39*/
    ($20,$40,$3F,$C0,$04,$00,$04,$00,$3F,$C0,$20,$40),//"H",40*/
    ($20,$40,$20,$40,$3F,$C0,$20,$40,$20,$40,$00,$00),//"I",41*/
    ($00,$60,$20,$20,$20,$20,$3F,$C0,$20,$00,$20,$00),//"J",42*/
    ($20,$40,$3F,$C0,$24,$40,$0B,$00,$30,$C0,$20,$40),//"K",43*/
    ($20,$40,$3F,$C0,$20,$40,$00,$40,$00,$40,$00,$C0),//"L",44*/
    ($3F,$C0,$3C,$00,$03,$C0,$3C,$00,$3F,$C0,$00,$00),//"M",45*/
    ($20,$40,$3F,$C0,$0C,$40,$23,$00,$3F,$C0,$20,$00),//"N",46*/
    ($1F,$80,$20,$40,$20,$40,$20,$40,$1F,$80,$00,$00),//"O",47*/
    ($20,$40,$3F,$C0,$24,$40,$24,$00,$18,$00,$00,$00),//"P",48*/
    ($1F,$80,$21,$40,$21,$40,$20,$E0,$1F,$A0,$00,$00),//"Q",49*/
    ($20,$40,$3F,$C0,$24,$40,$26,$00,$19,$C0,$00,$40),//"R",50*/
    ($18,$C0,$24,$40,$24,$40,$22,$40,$31,$80,$00,$00),//"S",51*/
    ($30,$00,$20,$40,$3F,$C0,$20,$40,$30,$00,$00,$00),//"T",52*/
    ($20,$00,$3F,$80,$00,$40,$00,$40,$3F,$80,$20,$00),//"U",53*/
    ($20,$00,$3E,$00,$01,$C0,$07,$00,$38,$00,$20,$00),//"V",54*/
    ($38,$00,$07,$C0,$3C,$00,$07,$C0,$38,$00,$00,$00),//"W",55*/
    ($20,$40,$39,$C0,$06,$00,$39,$C0,$20,$40,$00,$00),//"X",56*/
    ($20,$00,$38,$40,$07,$C0,$38,$40,$20,$00,$00,$00),//"Y",57*/
    ($30,$40,$21,$C0,$26,$40,$38,$40,$20,$C0,$00,$00),//"Z",58*/
    ($00,$00,$00,$00,$7F,$E0,$40,$20,$40,$20,$00,$00),//"[",59*/
    ($00,$00,$70,$00,$0C,$00,$03,$80,$00,$40,$00,$00),//"\",60*/
    ($00,$00,$40,$20,$40,$20,$7F,$E0,$00,$00,$00,$00),//"]",61*/
    ($00,$00,$20,$00,$40,$00,$20,$00,$00,$00,$00,$00),//"^",62*/
    ($00,$10,$00,$10,$00,$10,$00,$10,$00,$10,$00,$10),//"_",63*/
    ($00,$00,$00,$00,$40,$00,$00,$00,$00,$00,$00,$00),//"`",64*/
    ($00,$00,$02,$80,$05,$40,$05,$40,$03,$C0,$00,$40),//"a",65*/
    ($20,$00,$3F,$C0,$04,$40,$04,$40,$03,$80,$00,$00),//"b",66*/
    ($00,$00,$03,$80,$04,$40,$04,$40,$06,$40,$00,$00),//"c",67*/
    ($00,$00,$03,$80,$04,$40,$24,$40,$3F,$C0,$00,$40),//"d",68*/
    ($00,$00,$03,$80,$05,$40,$05,$40,$03,$40,$00,$00),//"e",69*/
    ($00,$00,$04,$40,$1F,$C0,$24,$40,$24,$40,$20,$00),//"f",70*/
    ($00,$00,$02,$E0,$05,$50,$05,$50,$06,$50,$04,$20),//"g",71*/
    ($20,$40,$3F,$C0,$04,$40,$04,$00,$03,$C0,$00,$40),//"h",72*/
    ($00,$00,$04,$40,$27,$C0,$00,$40,$00,$00,$00,$00),//"i",73*/
    ($00,$10,$00,$10,$04,$10,$27,$E0,$00,$00,$00,$00),//"j",74*/
    ($20,$40,$3F,$C0,$01,$40,$07,$00,$04,$C0,$04,$40),//"k",75*/
    ($20,$40,$20,$40,$3F,$C0,$00,$40,$00,$40,$00,$00),//"l",76*/
    ($07,$C0,$04,$00,$07,$C0,$04,$00,$03,$C0,$00,$00),//"m",77*/
    ($04,$40,$07,$C0,$04,$40,$04,$00,$03,$C0,$00,$40),//"n",78*/
    ($00,$00,$03,$80,$04,$40,$04,$40,$03,$80,$00,$00),//"o",79*/
    ($04,$10,$07,$F0,$04,$50,$04,$40,$03,$80,$00,$00),//"p",80*/
    ($00,$00,$03,$80,$04,$40,$04,$50,$07,$F0,$00,$10),//"q",81*/
    ($04,$40,$07,$C0,$02,$40,$04,$00,$04,$00,$00,$00),//"r",82*/
    ($00,$00,$06,$40,$05,$40,$05,$40,$04,$C0,$00,$00),//"s",83*/
    ($00,$00,$04,$00,$1F,$80,$04,$40,$00,$40,$00,$00),//"t",84*/
    ($04,$00,$07,$80,$00,$40,$04,$40,$07,$C0,$00,$40),//"u",85*/
    ($04,$00,$07,$00,$04,$C0,$01,$80,$06,$00,$04,$00),//"v",86*/
    ($06,$00,$01,$C0,$07,$00,$01,$C0,$06,$00,$00,$00),//"w",87*/
    ($04,$40,$06,$C0,$01,$00,$06,$C0,$04,$40,$00,$00),//"x",88*/
    ($04,$10,$07,$10,$04,$E0,$01,$80,$06,$00,$04,$00),//"y",89*/
    ($00,$00,$04,$40,$05,$C0,$06,$40,$04,$40,$00,$00),//"z",90*/
    ($00,$00,$00,$00,$04,$00,$7B,$E0,$40,$20,$00,$00),//"(",91*/
    ($00,$00,$00,$00,$00,$00,$FF,$F0,$00,$00,$00,$00),//"|",92*/
    ($00,$00,$40,$20,$7B,$E0,$04,$00,$00,$00,$00,$00),//")",93*/
    ($40,$00,$80,$00,$40,$00,$20,$00,$20,$00,$40,$00)//"~",94*/
    );

  Font3216 : array[0..10, 0..63] of byte = (
    ($00,$00,$00,$00,$00,$00,$00,$00,$3F,$FF,$FF,$FC,$3F,$FF,$FF,$FC,    //"0",0*/
    $30,$00,$00,$0C,$30,$00,$00,$0C,$30,$00,$00,$0C,$30,$00,$00,$0C,
    $30,$00,$00,$0C,$30,$00,$00,$0C,$30,$00,$00,$0C,$30,$00,$00,$0C,
    $3F,$FF,$FF,$FC,$3F,$FF,$FF,$FC,$00,$00,$00,$00,$00,$00,$00,$00),

    ($00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,   //"1",1*/
    $00,$00,$00,$00,$00,$00,$00,$00,$30,$00,$00,$00,$30,$00,$00,$00,
    $3F,$FF,$FF,$FC,$3F,$FF,$FF,$FC,$00,$00,$00,$00,$00,$00,$00,$00,
    $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00),

    ($00,$00,$00,$00,$00,$00,$00,$00,$3C,$01,$FF,$FC,$3C,$01,$FF,$FC,   //"2",2*/
    $30,$01,$80,$0C,$30,$01,$80,$0C,$30,$01,$80,$0C,$30,$01,$80,$0C,
    $30,$01,$80,$0C,$30,$01,$80,$0C,$30,$01,$80,$0C,$30,$01,$80,$0C,
    $3F,$FF,$80,$0C,$3F,$FF,$80,$0C,$00,$00,$00,$00,$00,$00,$00,$00),

    ($00,$00,$00,$00,$00,$00,$00,$00,$38,$00,$00,$3C,$38,$00,$00,$3C,   //"3",3*/
    $30,$01,$80,$0C,$30,$01,$80,$0C,$30,$01,$80,$0C,$30,$01,$80,$0C,
    $30,$01,$80,$0C,$30,$01,$80,$0C,$30,$01,$80,$0C,$30,$01,$80,$0C,
    $3F,$FF,$FF,$FC,$3F,$FF,$FF,$FC,$00,$00,$00,$00,$00,$00,$00,$00),

    ($00,$00,$00,$00,$00,$00,$00,$00,$3F,$FF,$80,$00,$3F,$FF,$80,$00,  //"4",4*/
    $00,$01,$80,$00,$00,$01,$80,$00,$00,$01,$80,$00,$00,$01,$80,$00,
    $00,$01,$80,$00,$00,$01,$80,$00,$00,$01,$80,$00,$00,$01,$80,$00,
    $3F,$FF,$FF,$FC,$3F,$FF,$FF,$FC,$00,$00,$00,$00,$00,$00,$00,$00),

    ($00,$00,$00,$00,$00,$00,$00,$00,$3F,$FF,$80,$3C,$3F,$FF,$80,$3C,  //"5",5*/
    $30,$01,$80,$0C,$30,$01,$80,$0C,$30,$01,$80,$0C,$30,$01,$80,$0C,
    $30,$01,$80,$0C,$30,$01,$80,$0C,$30,$01,$80,$0C,$30,$01,$80,$0C,
    $30,$01,$FF,$FC,$30,$01,$FF,$FC,$00,$00,$00,$00,$00,$00,$00,$00),

    ($00,$00,$00,$00,$00,$00,$00,$00,$3F,$FF,$FF,$FC,$3F,$FF,$FF,$FC,  //"6",6*/
    $30,$01,$80,$0C,$30,$01,$80,$0C,$30,$01,$80,$0C,$30,$01,$80,$0C,
    $30,$01,$80,$0C,$30,$01,$80,$0C,$30,$01,$80,$0C,$30,$01,$80,$0C,
    $3C,$01,$FF,$FC,$3C,$01,$FF,$FC,$00,$00,$00,$00,$00,$00,$00,$00),

    ($00,$00,$00,$00,$00,$00,$00,$00,$3C,$00,$00,$00,$3C,$00,$00,$00,  //"7",7*/
    $30,$00,$00,$00,$30,$00,$00,$00,$30,$00,$00,$00,$30,$00,$00,$00,
    $30,$00,$00,$00,$30,$00,$00,$00,$30,$00,$00,$00,$30,$00,$00,$00,
    $3F,$FF,$FF,$FC,$3F,$FF,$FF,$FC,$00,$00,$00,$00,$00,$00,$00,$00),

    ($00,$00,$00,$00,$00,$00,$00,$00,$3F,$FF,$FF,$FC,$3F,$FF,$FF,$FC,  //"8",8*/
    $30,$01,$80,$0C,$30,$01,$80,$0C,$30,$01,$80,$0C,$30,$01,$80,$0C,
    $30,$01,$80,$0C,$30,$01,$80,$0C,$30,$01,$80,$0C,$30,$01,$80,$0C,
    $3F,$FF,$FF,$FC,$3F,$FF,$FF,$FC,$00,$00,$00,$00,$00,$00,$00,$00),

    ($00,$00,$00,$00,$00,$00,$00,$00,$3F,$FF,$80,$3C,$3F,$FF,$80,$3C,  //"9",9*/
    $30,$01,$80,$0C,$30,$01,$80,$0C,$30,$01,$80,$0C,$30,$01,$80,$0C,
    $30,$01,$80,$0C,$30,$01,$80,$0C,$30,$01,$80,$0C,$30,$01,$80,$0C,
    $3F,$FF,$FF,$FC,$3F,$FF,$FF,$FC,$00,$00,$00,$00,$00,$00,$00,$00),

    ($00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,  //":",10*/
    $00,$00,$00,$00,$0F,$F0,$0F,$F0,$0F,$F0,$0F,$F0,$0C,$00,$00,$30,
    $0C,$00,$00,$30,$0F,$F0,$0F,$F0,$0F,$F0,$0F,$F0,$00,$00,$00,$00,
    $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00)
   );

   // battery
   Bat816 : array[0..15] of byte = (
    $0F,$FE,$30,$02,$26,$DA,$26,$DA,$26,$DA,$26,$DA,$30,$02,$0F,$FE
   );
   // bluetooth
   Bluetooth88 : array[0..7] of byte = (
    $18,$54,$32,$1C,$1C,$32,$54,$18
   );
   // message
   Msg816: array[0..15] of byte = (
    $1F,$F8,$10,$08,$18,$18,$14,$28,$13,$C8,$10,$08,$10,$08,$1F,$F8
   );

procedure SH1106_Init();
procedure SH1106_Clear(buffer : PByte);
procedure SH1106_Pixel(x : byte; y : byte; color : byte; buffer : PByte);
procedure SH1106_Char1616(x : byte; y : byte; chChar : Char; buffer : PByte);
procedure SH1106_Char3216(x, y: Byte; chChar : Char; buffer : PByte);
procedure SH1106_Char(x : byte; y : byte; acsii : Char; size : byte; mode : byte; buffer : PByte);
procedure SH1106_String(x, y : byte; pString : PChar; Size, Mode : byte; buffer : PByte);
procedure SH1106_Bitmap(x, y : byte; pBmp : PByte; chWidth, chHeight : byte; buffer : PByte);
procedure SH1106_Display(buffer : PByte);

implementation

uses
  delay, system_LPC1114;

procedure SH1106_Write(data : byte; data_type : byte);
begin
 if(data_type = 0) then
     ClrPins(SH1106_DC_PORT, SH1106_DC_PIN)
 else
     SetPins(SH1106_DC_PORT, SH1106_DC_PIN);
 SPI_Write(SPI0, data);
end;

procedure SH1106_Init();
begin
 SetOutputs(SH1106_CS_PORT, SH1106_CS_PIN);
 SetOutputs(SH1106_DC_PORT, SH1106_DC_PIN);
 SetOutputs(SH1106_RST_PORT, SH1106_RST_PIN);

 ClrPins(SH1106_CS_PORT, SH1106_CS_PIN);

 SetPins(1, GPIO_Pin_11);         // reset up
 Delay_MS(10);
 ClrPins(1, GPIO_Pin_11);         // reset up
 Delay_MS(10);
 SetPins(1, GPIO_Pin_11);         // reset up

 SH1106_Write($AE, SH1106_CMD);//--turn off oled panel
 SH1106_Write($02, SH1106_CMD);//---set low column address
 SH1106_Write($10, SH1106_CMD);//---set high column address
 SH1106_Write($40, SH1106_CMD);//--set start line address  Set Mapping RAM Display Start Line ($00~$3F)
 SH1106_Write($81, SH1106_CMD);//--set contrast control register
 SH1106_Write($A0, SH1106_CMD);// Set SEG Output Current Brightness
 SH1106_Write($C0, SH1106_CMD);//--Set SEG/Column Mapping
 SH1106_Write($A6, SH1106_CMD);//--set normal display
 SH1106_Write($A8, SH1106_CMD);//--set multiplex ratio(1 to 64)
 SH1106_Write($3f, SH1106_CMD);//--1/64 duty
 SH1106_Write($D3, SH1106_CMD);//-set display offset	Shift Mapping RAM Counter ($00~$3F)
 SH1106_Write($00, SH1106_CMD);//-not offset
 SH1106_Write($d5, SH1106_CMD);//--set display clock divide ratio/oscillator frequency
 SH1106_Write($80, SH1106_CMD);//--set divide ratio, Set Clock as 100 Frames/Sec
 SH1106_Write($D9, SH1106_CMD);//--set pre-charge period
 SH1106_Write($F1, SH1106_CMD);//Set Pre-Charge as 15 Clocks & Discharge as 1 Clock
 SH1106_Write($DA, SH1106_CMD);//--set com pins hardware configuration
 SH1106_Write($12, SH1106_CMD);
 SH1106_Write($DB, SH1106_CMD);//--set vcomh
 SH1106_Write($40, SH1106_CMD);//Set VCOM Deselect Level
 SH1106_Write($20, SH1106_CMD);//-Set Page Addressing Mode ($00/$01/$02)
 SH1106_Write($02, SH1106_CMD);//
 SH1106_Write($A4, SH1106_CMD);// Disable Entire Display On ($a4/$a5)
 SH1106_Write($A6, SH1106_CMD);// Disable Inverse Display On ($a6/a7)
 SH1106_Write($AF, SH1106_CMD);//--turn on oled panel
end;

procedure SH1106_Clear(buffer : PByte);
var
 i : word;
begin
    for i := 0 to (WIDTH * HEIGHT div 8)-1 do
     buffer[i] := 0;
end;

procedure SH1106_Pixel(x : byte; y : byte; color : byte; buffer : PByte);
begin
    if((x > WIDTH) OR (y > HEIGHT)) then exit;
    if(color > 0) then
        // y shr 3 = y div 8
        (buffer+(x+(y shr 3)*WIDTH))^ :=  (buffer+(x+(y shr 3)*WIDTH))^ OR (1<<(y mod 8))
    else
        (buffer+(x+(y shr 3)*WIDTH))^ :=  (buffer+(x+(y shr 3)*WIDTH))^ and not (1<<(y mod 8));
end;

procedure SH1106_Display(buffer : PByte);
var
  page : byte;
  w : word;
  pBuf : PByte;
begin
 pBuf := buffer;
 for page:= 0 to NUM_PAGE-1 do
 begin
  w := 0;
  SH1106_Write($B0 + page, SH1106_CMD);
  //* set low column address */
  SH1106_Write($02, SH1106_CMD);
  //* set high column address */
  SH1106_Write($10, SH1106_CMD);

  while w < WIDTH do
  begin
  SH1106_Write(pBuf^, SH1106_DAT);
  pBuf := pBuf + 1;
  inc(w);
  end;
 end;
end;

procedure SH1106_Char1616(x : byte; y : byte; chChar : Char; buffer : PByte);
var
  i, j : byte;
  chTemp, y0, chMode : byte;
begin
 chTemp := 0;
 y0 := y;
 chMode := 0;
 for  i := 0 to 31 do
 begin
  chTemp := Font1612[byte(chChar) - $30][i];
  for j := 0 to 7 do
  begin
   if (chTemp AND $80) = $80 then
    chMode := 1
   else
    chMode := 0;
   SH1106_pixel(x, y, chMode, buffer);
   chTemp := chTemp shl 1;
   Inc(y);
   if ((y - y0) = 16) then
   begin
    y := y0;
    Inc(x);
    break;
   end;
  end;
 end;
end;

procedure SH1106_Char(x : byte; y : byte; acsii : Char; size : byte; mode : byte; buffer : PByte);
var
 i, j, y0, ch, temp : byte;
begin
 temp := 0;
 y0 := y;
 ch := ord(acsii) - $20;
 for i := 0 to size-1 do
 begin
        if(size = 12) then
        begin
           if(mode = 1) then
             temp := Font1206[ch][i]
            else
             temp := not Font1206[ch][i];
        end else begin
            if(mode = 1) then
             temp := Font1608[ch][i]
            else
             temp := not Font1608[ch][i];
        end;

        for j :=0 to 7 do
        begin
            if(temp AND $80) = $80  then
             SH1106_pixel(x, y, 1, buffer)
            else
             SH1106_pixel(x, y, 0, buffer);
            temp := temp shl 1;
            Inc(y);
            if((y-y0) = size) then
            begin
                y := y0;
                Inc(x);
                break;
            end;

        end;
 end;
end;

procedure SH1106_Char3216(x, y: Byte; chChar : Char; buffer : PByte);
var
 i, j, chTemp, y0, chMode : byte;
begin
 chTemp := 0;
 y0 := y;
 chMode := 0;
    for i := 0 to 63 do
    begin
        chTemp := Font3216[ord(chChar) - $30][i];
        for j := 0 to 7 do
        begin
         if (chTemp AND $80) = $80 then
          chMode := 1
         else
          chMode := 0;

         SH1106_pixel(x, y, chMode, buffer);
         chTemp := chTemp shl 1;
         Inc(y);
         if ((y - y0) = 32) then
         begin
          y := y0;
          Inc(x);
          break;
         end;
        end;
    end;
end;


procedure SH1106_String(x, y : byte; pstring : PChar; size, mode : byte; buffer : PByte);
var
 idx : byte;
begin
 idx := 0;
    while ( pstring[idx] <> #00 ) do
    begin
        if (x > (WIDTH - size div 2)) then
        begin
            x := 0;
            y := y + size;
            if (y > (HEIGHT - size)) then
            begin
                y := 0;
                x := 0;
            end;
        end;

        SH1106_char(x, y, pstring[idx], size, mode, buffer);
        x := x + (size div 2);
        Inc(idx);
    end;
end;

procedure SH1106_Bitmap(x, y : byte; pBmp : PByte; chWidth, chHeight : byte; buffer : PByte);
var
 i, j, byteWidth : byte;
begin
    byteWidth := (chWidth + 7) shr 3;
    for j:= 0 to chHeight-1 do
    begin
        for i:= 0 to chWidth-1 do
        begin
            if (((pBmp + j*byteWidth+i shr 3)^ AND (128 >> (i AND 7)))) = (128 >> (i AND 7)) then
            begin
                SH1106_pixel(x+i,y+j,1,buffer);
            end;
        end;
    end;
end;


end.

