unit uPrincipal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, MmSystem, Forms, Direct3D9,  D3DX9, IniFiles, ComObj,
  DxTypes, math,Dialogs,  ExtCtrls, StdCtrls, ComCtrls,System.Math.Vectors,
  Vcl.AppEvnts;


const
PUBG = 'UnrealWindow'; // Class PUBG


type
  TfrmPrincipal = class(TForm)
    Recoil: TTimer;
    Status: TTimer;
    Label2: TLabel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Label1: TLabel;
    Label8: TLabel;
    EdtSensiX1: TEdit;
    EdtDelay1: TEdit;
    EdtSensiX2: TEdit;
    EdtSensiY1: TEdit;
    EdtSensiY2: TEdit;
    EdtDelay2: TEdit;
    Scope: TTimer;
    RapidFire: TTimer;
    GroupBox1: TGroupBox;
    Label3: TLabel;
    EdtScope: TEdit;
    Label4: TLabel;
    Label5: TLabel;
    ApplicationEvents1: TApplicationEvents;
    Label6: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure RecoilTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure RapidFireTimer(Sender: TObject);
    procedure StatusTimer(Sender: TObject);
    procedure ScopeTimer(Sender: TObject);
    procedure EdtScopeChange(Sender: TObject);
    procedure ApplicationEvents1Exception(Sender: TObject; E: Exception);

  private
    { Private declarations }

  public
    { Public declarations }

    procedure SaveSetting;
    procedure LoadSetting;


  end;

 function IsMouseButtonPressed: Boolean;


var
  frmPrincipal: TfrmPrincipal;
  wnd : Hwnd;
  rct:TRect;
  viewAngles:TD3DXVECTOR3;
  activeRapidFire : boolean = false;

  Timerid, i: UINT; // SetTimer

  voz: variant;
  paused: boolean;

implementation

{$R *.dfm}

uses hkEndScene;


procedure TfrmPrincipal.LoadSetting;
var
  Config: TIniFile;
begin
  Config := TIniFile.Create('..\Settings.ini');


  EdtSensiX1.Text := Config.ReadString('Settings', 'Sensix1', '');
  EdtDelay1.Text := Config.ReadString('Settings', 'Calibration1','' );
  EdtSensiY1.Text := Config.ReadString('Settings', 'Sensiy2','' );

  EdtSensiX2.Text := Config.ReadString('Settings', 'Sensix3', '');
  EdtDelay2.Text := Config.ReadString('Settings', 'Calibration2', '');
  EdtSensiY2.Text := Config.ReadString('Settings', 'Sensiy4', '');


  // Scope

 EdtScope.Text := Config.ReadString('Scope', 'Calibration1', '');
{ Edit6.Text := Config.ReadString('Scope', 'Sensix1', '');
 EdtDelay2.Text := Config.ReadString('Scope', 'Calibration3', '');
 Edit9.Text := Config.ReadString('Scope', 'Sensiy2', '');

 Edit10.Text := Config.ReadString('Scope', 'Sensix3', '');
 EdtDelay3.Text := Config.ReadString('Scope', 'Calibration4', '');
 Edit2.Text := Config.ReadString('Scope', 'Sensiy4', '');
   }
 Config.Free;

end;




procedure TfrmPrincipal.SaveSetting;
var
  Config: TIniFile;
begin
  Config := TIniFile.Create('..\Settings.ini');

  Config.WriteString('Settings', 'Sensix1', EdtSensiX1.Text);
  Config.WriteString('Settings', 'Calibration1', EdtDelay1.Text);
  Config.WriteString('Settings', 'Sensiy2', EdtSensiY1.Text);

  Config.WriteString('Settings', 'Sensix3', EdtSensiX2.Text);
  Config.WriteString('Settings', 'Calibration2', EdtDelay2.Text);
  Config.WriteString('Settings', 'Sensiy4', EdtSensiY2.Text);





 // Config.WriteString('', '','');

  // Configuração do Scope 3x
  Config.WriteString('Scope', 'Calibration1', EdtScope.Text);
  {Config.WriteString('Scope', 'Sensix5', Edit6.Text);
  Config.WriteString('Scope', 'Calibration3', EdtDelay2.Text);
  Config.WriteString('Scope', 'Sensiy6', Edit9.Text);

  Config.WriteString('Scope', 'Sensix7', Edit10.Text);
  Config.WriteString('Scope', 'Calibration4', EdtDelay3.Text);
  Config.WriteString('Scope', 'Sensiy8', Edit2.Text);
    }

  Config.Free;
  //ShowMessage('Mensagem armazenada com sucesso!');
end;


//function FOVs(Angle, myAngle:TD3DXVector3):TD3DXVector3;
function FOV(angle,myAngle : TD3DXVector3 ) : Real;
begin
 //return fov from my crosshair to enemy head
      result := sqrt(Math.Power(Angle.x - myAngle.x, 2) + Math.Power(Angle.y - myAngle.y, 2));
///       return sqrt(pow(angle.x - myAngle.x, 2) + pow(angle.y - myAngle.y, 2));
end;


function IsMouseButtonPressed: Boolean;
begin
Result := not (((GetAsyncKeyState(VK_LBUTTON)and $8000)=0) and
    ((GetAsyncKeyState(VK_LBUTTON)and $8000)=0));

end;

function IsMouseButtonPressedss: Boolean;
begin
Result := not (((GetAsyncKeyState(VK_SHIFT)and $8000)=0) and
    ((GetAsyncKeyState(VK_SHIFT)and $8000)=0));

end;


procedure MouseXY(angleX,angleY : Single);
var
angle: TD3DXVector3;
dist,dZ : Single;
AimSpeed : Integer;
fovs : Real;
TickCount : DWORD;
begin
AimSpeed := 5;
 AimBots;

 if (angle.x > angley) and (angle.x <= angley) then
  //math.atan2(dst.x - src.x, dst.y - src.y)) / math.pi * 180 + 180

   angle.y :=  89.0 +ArcTan(angle.x / angley) / PI * -180.0+180.0;

  if (angle.x < angley) and (angle.y > angley) then

   angle.y := -89.0+ArcTan(angle.x / angley) / -180.0 / PI*180.0;

  if (angle.x > angley) and (angle.y > angley) then

   angle.y := 89.0+ArcTan(angle.x / angley) / -180.0 / PI*180.0;

  if (angle.x < anglex) and (angle.y > angley) then

    angle.y := -89.0+(ArcTan(angle.x / angley) /  PI*180)*180.0;

    if (angle.x > -89.0) then
//    * -180.0f / PI + c;
    angle.y :=  89.0+ArcTan(angle.x / angley) * -180 / PI;

    if (angle.x < 89.0) then
//     * -180.0f / PI - 180.0f;
		angle.y := 89.0+ArcTan(angle.x / angley) * -180 / PI-180.0;

    if (angle.x < 89.0)  then
//    * -180.0f / PI + 360.0f;
		angle.y := +360.0+ArcTan(angle.x / angley)  -180 / PI+360.0;

    if(angle.y < 800.0) then
     angle.y := +360.0;

    if(angle.y < 800.0) then
    angle.y := -360.0;

    if ( angle.x > 89.0)  and  (Angle.y < 180.0) then
    AimBots;

    angle.x := ((ArcSin( Angle.z / angle.x ) / PI)  * 180.0 ) / 180.0;
    angle.y := ((ArcTanh(angle.x / angle.y ) * 180.0 /PI));
    AimBots;
    //PixelMove(Angle,Angle);

   angle.y := (Cos(ArcTan2(angle.z-180 , (angle.x +90.0)) - PI/2.0));
   Angle.y := (Sin(ArcTan2(angle.x - 180.0 , (angle.y + 90.0))) - PI/2.0);


    mouse_event(MOUSEEVENTF_MOVE, Round(AngleX), Round(AngleY),0, GetMessageExtraInfo());
    mouse_event(MOUSEEVENTF_ABSOLUTE, Round(AngleX), Round(AngleY),0, GetMessageExtraInfo());
    mouse_event(MOUSEEVENTF_MOVE_NOCOALESCE, Round(AngleX), Round(AngleY),0, GetMessageExtraInfo());

    AimBots;
    CalcAngle(anglex, AngleY);
    AimBots;
    Angle := Clamps(Angle);
    Norm(angle);
    ClampAngle(Angle);

    fovs := FOV(Angle, Angle); //find field of view from player to my view angle
    Angle :=  GetDistanceToAngle(Angle,Angle);
    setViewAngle(angle,AimSpeed);
    AimBots;
      if(angle.x < 800.0) then
     angle.y := +90.0;
    if(angle.y >= 90.0) then
    angle.y := +fovs;
    AimBots;

 //   if (fovs < 103) and ((GetAsyncKeyState(VK_LBUTTON)and $8000)=0) then { //check ok


    AimBots;
    angle.z := 0.0;


end;


procedure TfrmPrincipal.ScopeTimer(Sender: TObject);
var
i : Byte;
dx, dy : Float32;
begin
wnd := GetForegroundWindow;
SetForegroundWindow(wnd);

if (wnd = FindWindow(PChar(PUBG),nil)) then
{Move o mouse}
repeat

if IsMouseButtonPressed then

for I := 0 to 14 do
begin
AimBots;

  case i of
  0: begin
  dx := StrToInt(EdtSensiX1.Text);
  dy := StrToInt(EdtSensiY1.Text);
  //Sleep(StrToInt(EdtDelay1.Text));
  end;

  1: begin
  dx := StrToInt(EdtSensiX1.Text);
  dy := StrToInt(EdtSensiY1.Text);
  //Sleep(StrToInt(EdtDelay2.Text));
  end;
    2: begin
  dx := StrToInt(EdtSensiX1.Text);
  dy := StrToInt(EdtSensiY1.Text);
  //Sleep(StrToInt(EdtDelay2.Text));
  end;
    3: begin
  dx := StrToInt(EdtSensiX1.Text);
  dy := StrToInt(EdtSensiY1.Text);
  //Sleep(StrToInt(EdtDelay2.Text));
  end;
  end;
  AimBots;
  MouseXY(Round(dx), (Round(dy)));
  mouse_event(MOUSEEVENTF_ABSOLUTE, Round(dx), Round(dy),0, GetMessageExtraInfo());
  mouse_event(MOUSEEVENTF_MOVE_NOCOALESCE, Round(dx), Round(dy),0, GetMessageExtraInfo());
  break;
  end;
   until not IsMouseButtonPressed = true;
end;

procedure TfrmPrincipal.StatusTimer(Sender: TObject);
begin
// kEYS ENABLED AND DISABLED

wnd := GetForegroundWindow;
SetForegroundWindow(wnd);
Application.ProcessMessages;
if (wnd = FindWindow(PChar(PUBG),nil)) then
while True do begin
if GetAsyncKeyState(Ord('1')) <> 0 then  begin    // key on macro
Recoil.enabled := true;
Scope.enabled := false;
end
else
if GetAsyncKeyState(Ord('2')) <> 0 then begin    // key on macro 3x
Recoil.enabled := false; // off macro
Scope.enabled := true;

end
else
if (GetAsyncKeyState(Ord('G')) <> 0) then begin  // key granad
  Recoil.Enabled := false;
  Scope.Enabled := false;
  end
else
if GetAsyncKeyState(Ord('H')) <> 0 then begin
  Recoil.enabled := false ;
  Scope.Enabled := false;
  end
else

if GetAsyncKeyState(Ord('J')) <> 0 then begin    // key mlotov

  Recoil.enabled := false;
  Scope.Enabled := false;
  end
  else
  if GetAsyncKeyState(Ord('K')) <> 0 then begin

  Recoil.enabled := false;
  Scope.Enabled := false;
  end
  else

if GetAsyncKeyState(Ord('X')) <> 0 then begin   // off macro

  Recoil.enabled := false;
  Scope.Enabled := false;
end
else

// RapidFire  on
if (GetAsyncKeyState(VK_F1) <> 0) then  begin

    RapidFire.Enabled := true;
    end
else
// RapidFire off
if (GetAsyncKeyState(VK_F2) <> 0) then
RapidFire.Enabled := false;

// Scope 3x
if  (GetAsyncKeyState(VK_F3) <> 0) then
Scope.Enabled := true
else
if (GetAsyncKeyState(VK_F4) <> 0) then
Scope.Enabled := false;

if GetAsyncKeyState(VK_INSERT) <> 0 then
 begin
   SaveSetting;
end;

if GetAsyncKeyState(VK_END) <> 0 then   // Key panic
begin
   Application.Terminate;
 end;
 break
end;
//while GetKeyState(VK_TAB) = 0  do
//begin
//Recoil.enabled := false;
//Scope.enabled := false;
//Break
//end;
end;




procedure TfrmPrincipal.FormShow(Sender: TObject);
begin
LoadSetting;

Status.Enabled := true;
end;

procedure TfrmPrincipal.RecoilTimer(Sender: TObject);
var
i : Byte;
dx, dy : Float32;
begin
wnd := GetForegroundWindow;
SetForegroundWindow(wnd);
if (wnd = FindWindow(PChar(PUBG),nil)) then
{Move o mouse}
repeat
AimBots;
if IsMouseButtonPressed then
for I := 0 to 14 do
begin
AimBots;
  case i of
  0: begin
  dx := StrToInt(EdtSensiX1.Text);
  dy := StrToInt(EdtSensiY1.Text);
  //Sleep(StrToInt(EdtDelay1.Text));
  end;

  1: begin
  dx := StrToInt(EdtSensiX1.Text);
  dy := StrToInt(EdtSensiY1.Text);
  //Sleep(StrToInt(EdtDelay2.Text));
  end;
  2: begin
  dx := StrToInt(EdtSensiX2.Text);
  dy := StrToInt(EdtSensiY2.Text);
  //Sleep(StrToInt(EdtDelay2.Text));
  end;
  3: begin
  dx := StrToInt(EdtSensiX2.Text);
  dy := StrToInt(EdtSensiY2.Text);
  //Sleep(StrToInt(EdtDelay2.Text));
  end;
  4: begin
  dx := StrToInt(EdtSensiX2.Text);
  dy := StrToInt(EdtSensiY2.Text);
  //Sleep(StrToInt(EdtDelay2.Text));
  end;
  end;
  AimBots;

  MouseXY(Round(dx), (Round(dy)));
  CalcAngle(Round(dx), (Round(dy)));
  mouse_event(MOUSEEVENTF_ABSOLUTE, Round(dx), Round(dy),0, GetMessageExtraInfo());
  mouse_event(MOUSEEVENTF_MOVE_NOCOALESCE, Round(dx), Round(dy),0, GetMessageExtraInfo());
  AimBots;
  break;
  end;
   until not IsMouseButtonPressed = false;
end;


procedure TfrmPrincipal.ApplicationEvents1Exception(Sender: TObject;
  E: Exception);
begin
//a/aa
end;

procedure TfrmPrincipal.EdtScopeChange(Sender: TObject);
begin
Scope.Interval := StrToInt(EdtScope.Text);
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin

//Application.ShowMainForm := false;

end;

procedure TfrmPrincipal.RapidFireTimer(Sender: TObject);
begin
// RapidFire
wnd := GetForegroundWindow;
SetForegroundWindow(wnd);
if (wnd = FindWindow(PChar(PUBG),nil)) then
{Move o mouse}

if IsMouseButtonPressed then


repeat
begin
     AimBots;
     mouse_event(MOUSEEVENTF_LEFTDOWN,0, 0,0, GetMessageExtraInfo());
     AimBots;
     CalcAngle(Round(0), (Round(10)));
     break;
end;
until not IsMouseButtonPressed = false;
end;

end.
