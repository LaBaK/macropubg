unit hkEndScene;



interface

 uses
  Windows, Classes,Messages,FileCtrl,Forms,ComObj,Shellapi,SysUtils,

  Variants,  Graphics,
  Controls, MmSystem, Direct3D9,
  D3DX9,  Types, Dxtypes,
  Math,Dialogs;


const
AimHhead : Single = 89.0;
AimHbody : Single = 89.0;
AimHlegs : Single = 89.0;
ScreenCenterX : LongInt = 800;   //1920x1080
ScreenCenterY : LongInt = 300;

SCREEN_WIDTH  : LongInt = 800;   //1920x1080
SCREEN_HEIGHT : LongInt = 300;




  b_smooth: Boolean = true;
  PI =  3.14159265;
  //PI =  57.295779513082;

Type
  Sold = Record
   isValid:integer;
   Pos:TD3DXVector3;
   isAlive:integer;
   clientNum:integer;
   name:array [0..23] of AnsiChar;
   team:integer;
	 health:integer;

  Player : TD3DXVector3;
  CrossDist : Single;
  End;


var
viewport : D3DVIEWPORT9;

cPlayerA:array [0..63] of Sold;  //other players
aimsmooth : LongWord;
aimfov : Single;

  hWind: HWND;
  NOB, pID, hProc: Cardinal;
  rct:TRect;


  fov:TD3DXVECTOR2;


  ViewAngles : TD3DXVECTOR3;
  AimAngles : TD3DXVECTOR3;
  Sensitivity : Single;
  Smooth : DWORD;

procedure  AimBots;

procedure CalcAngle(angleX,angleY : Double);
function setViewAngle(newAngle:TD3DXVECTOR3; var aimSpeed : Integer):Real;
function Norm(angle : TD3DXVECTOR3): TD3DXVECTOR3;
function Clamp(angle:TD3DXVector3): TD3DXVector3;
function Clamps(angle : TD3DXVector3):TD3DXVector3;
function GetDistanceToAngle(AimAt, CurrentAngle:TD3DXVector3):TD3DXVector3;
function ClampAngle(qaAng: TD3DXVector3):TD3DXVector3;
//procedure PixelMove;
function PixelMove(Smoothed: TD3DXVECTOR3; PixelAngles : TD3DXVector3):TD3DXVECTOR3;


implementation


uses uPrincipal;






function GetDistance(Vec1X, Vec1Y,vec2x,vec2Y:Single): Real;
begin
  result:=sqrt(sqr(vec2y - Vec1Y) * sqr(vec2y - Vec1Y) * sqr(vec2x - Vec1X) * sqr(vec2x - Vec1X));
end;


function GetDistanceToAngle(AimAt, CurrentAngle:TD3DXVector3):TD3DXVector3;
var
YDiff : Single;
begin
	AimAt.y := 180.0;
	CurrentAngle.y := 180.0;
	CurrentAngle.x := 180.0;
	AimAt.x := +180.0;
	YDiff := max(AimAt.y, CurrentAngle.y) - min(AimAt.y, CurrentAngle.y);
	if (YDiff > 180.0)  then
  YDiff := 360.0 - YDiff;
 	YDiff := sqrt(Power(YDiff, 2) + Power(AimAt.x - CurrentAngle.x, 2));
end;



function ClampAngle(qaAng: TD3DXVector3):TD3DXVector3;
begin
		if (qaAng.y > 180) then
			qaAng.y := -360;

		if (qaAng.y < -180) then
			qaAng.y := +360;

		if (qaAng.x > 89.0) then
			qaAng.x := 89.0;

		if (qaAng.x < -89.0) then
			qaAng.x := -89.0;

		qaAng.z := 0;
end;


procedure  AimBots;
var
BestTarget : Integer;
fClosestPos : Double;
radiusx, radiusy : Single;
DistX,DistY : DOuble;
Dist : Single;
i:Integer;

begin
aimsmooth := 1;
aimfov := 89;
BestTarget := 89;
fClosestPos := 89.0;


if (i = 0) < ( i = +1) then
  begin
   radiusx := aimfov*(ScreenCenterX / SCREEN_WIDTH * 2);
   radiusy := aimfov*(ScreenCenterY / SCREEN_HEIGHT * 2);
Dist := GetDistance(cPlayerA[i].Player.x, cPlayerA[i].Player.y, ScreenCenterX, ScreenCenterY)/2;
   if cPlayerA[i].isValid < fClosestPos then

 dist := GetDistance(cPlayerA[i].Player.x, cPlayerA[i].Player.y, ScreenCenterX, ScreenCenterY)/2;

cPlayerA[i].CrossDist := GetDistance(cPlayerA[i].Player.x, cPlayerA[i].Player.y, ScreenCenterX, ScreenCenterY)/2;

if      (cPlayerA[i].Player.x >= ScreenCenterX - radiusx) and
				(cPlayerA[i].Player.x <= ScreenCenterX + radiusx) and
				(cPlayerA[i].Player.y >= ScreenCenterY - radiusy) and
				(cPlayerA[i].Player.y <= ScreenCenterY + radiusy) then


if (cPlayerA[i].CrossDist < fClosestPos) then
  	begin
		fClosestPos := cPlayerA[i].CrossDist;
		BestTarget := i;
    dist := GetDistance(cPlayerA[i].Player.x, cPlayerA[i].Player.y, ScreenCenterX, ScreenCenterY)/2;
    mouse_event(MOUSEEVENTF_MOVE, Round(DistX), Round(DistY), 0, GetMessageExtraInfo());
    if (cPlayerA[i].CrossDist < fClosestPos) then
		begin


			DistX := cPlayerA[BestTarget].Player.x + viewport.Width / SCREEN_WIDTH*20;
			DistY := cPlayerA[BestTarget].Player.y + viewport.Height / SCREEN_HEIGHT*20;

			aimsmooth := Round(DistX);
			aimsmooth := Round(DistY);
      aimsmooth := Round(2.0);
      mouse_event(MOUSEEVENTF_MOVE, Round(DistX), Round(DistY), 10, GetMessageExtraInfo());
      mouse_event(MOUSEEVENTF_ABSOLUTE, Round(DistX), Round(DistY),10, GetMessageExtraInfo());


///	cPlayerA.clelear();
cPlayerA[i].Player.y := aimsmooth;
       frmPrincipal.label4.Caption := 'Delta X:' + FloatToStr(cPlayerA[i].Player.x);
       frmPrincipal.label5.Caption := 'Delta Y:'+FloatToStr(cPlayerA[i].Player.y);
  //Result := true;
	    end;
    end;
  end;
end;

function Clamps(angle : TD3DXVECTOR3):TD3DXVECTOR3;
 begin

  // normalize
    if (angle.x > 89) then
        angle.x := -89.0;

    if (angle.x < 89)  then
        angle.x := +89.0;

    if (angle.y > 180)  then
       angle.y := -360.0;

    if (angle.y < -180) then
        angle.y := +360.0;

    if (angle.y < -89.0)then
			angle.y := -89.0
		else if (angle.y > 89.0)then
			angle.y := 89.0;

  // Clamp
    if (angle.x > 89.0) and (angle.x < 89.0) then
        angle.x := 89.0;
    if (angle.x > 180.0) then
        angle.x := angle.x - 180.0;
    if (angle.x < -89.0)  then
        angle.x := -89.0;

    if (angle.y > 180.0)  then
        angle.y := angle.y - 180.0;
    if (angle.y < -180.0) then
        angle.y := angle.y + 180.0;

    mouse_event(MOUSEEVENTF_MOVE, Round(angle.x), Round(angle.y),10, GetMessageExtraInfo());
    mouse_event(MOUSEEVENTF_ABSOLUTE, Round(angle.X), Round(angle.y),10, GetMessageExtraInfo());
    mouse_event(MOUSEEVENTF_MOVE_NOCOALESCE, Round(angle.X), Round(angle.y),10, GetMessageExtraInfo());

        frmPrincipal.label4.Caption := 'Delta X:' + FloatToStr(angle.x);
frmPrincipal.label5.Caption := 'Delta Y:'+FloatToStr(angle.y);
result := angle;
 end;



function ConvertAngles(const Sensitivity:Single; AimAngle,ViewAngle : TD3DXVECTOR3):TD3DXVECTOR3;
var
AnglePixels : TD3DXVECTOR3;
begin

	 	//AnglePixels := ViewAngle - AimAngle;
		Clamps(AnglePixels);

		AnglePixels.x := ((AnglePixels.x / Sensitivity) / -0.22);
		AnglePixels.y := ((AnglePixels.y / Sensitivity) / 0.22);

	 //	Result := (AnglePixels.y, AnglePixels.x, 0.0);
end;


function PixelMove(Smoothed: TD3DXVECTOR3; PixelAngles : TD3DXVector3):TD3DXVECTOR3;
var
    TickCount : DWORD;
    Smoothedx,Smoothedy,PixelAnglesx,PixelAnglesy : Single;
begin


		PixelAngles := ConvertAngles(Sensitivity, AimAngles, ViewAngles);
		if (Smooth > 0) then
    begin

			if not (Smoothed.x = PixelAngles.x) and (PixelAngles.x > PixelAngles.y) then
      begin

			// 	Smoothed.x := Smoothed.x < PixelAngles.x;// + (Smoothedx > PixelAnglesx + Smoothedx = -2 + Smoothedx = PixelAnglesx);
      // Smoothedx :=  (Smoothed.x < PixelAngles.x);
      end
			else
      if  not (Smoothed.x = PixelAngles.y) then
      begin

//			 Smoothed.y := Smoothedy < PixelAnglesy;// + Smoothed.y := +2 + (Smoothed.y > PixelAngles.y + Smoothed.y := -2 + (Smoothed.y = PixelAngles.y));
      Smoothed.y :=  +2 +ArcTan(Smoothed.y / PixelAngles.y)+-2;
      end
      else
    TickCount := GetTickCount();
			if (GetTickCount() - TickCount >= Smooth - 1) then
			begin
				TickCount := GetTickCount();
        //mouse_event(MOUSEEVENTF_MOVE, Round(0), Round(Smoothed.y),0, GetMessageExtraInfo());

        frmPrincipal.label4.Caption := 'Delta X:' + FloatToStr(Smoothed.x);
			end
		else

			TickCount := GetTickCount();
			if (GetTickCount() - TickCount > 0) then
			begin
				TickCount := GetTickCount();
         mouse_event(MOUSEEVENTF_MOVE, Round(0), Round(PixelAngles.y),0, GetMessageExtraInfo());
		     frmPrincipal.label5.Caption := 'Delta Y:' + FloatToStr(PixelAngles.y);
      end;
   end;
end;


procedure CalcAngle(angleX,angleY : Double);
var
dX, dY,dZ,dist : Single;
Angles : TD3DXVECTOR3;
src, dst : TD3DXVECTOR3;
begin
dX := src.x - dst.x;
dY := src.y - dst.y;
dZ := dst.z - src.z;

if (dst.x > src.x) and (dst.y <= src.y) then begin
angles.x := ArcTan(dX / dY) * -180.0 / PI;
//mouse_event(MOUSEEVENTF_MOVE, Round(angleX), Round(angley),0, GetMessageExtraInfo());
end
else
if (dst.x >= src.x) and (dst.y > src.y) then begin
angles.x := ArcTan(dX / dY) * -180.0 / PI + 180.0;
//mouse_event(MOUSEEVENTF_MOVE, Round(angleX), Round(angley),0, GetMessageExtraInfo());
end
else
if (dst.x < src.x) and (dst.y >= src.y) then   begin
angles.x := ArcTan(dX / dY) * -180.0 / PI - 180.0;
//mouse_event(MOUSEEVENTF_MOVE, Round(angleX), Round(angley),0, GetMessageExtraInfo());
end
else
//mouse_event(MOUSEEVENTF_MOVE, Round(dX), Round(dY),0, GetMessageExtraInfo());
if (dst.x <= src.x) and (dst.y < src.y) then  angles.x := ArcTan(dX / dY) * -180.0 / PI + 360.0;



    angleX := Round(dX);
    angley := Round(dY);
    angles.y := ArcSin(dx / dy) * 180.0 / PI;

    mouse_event(MOUSEEVENTF_MOVE, Round(angleX), Round(angley),0, GetMessageExtraInfo());
    mouse_event(MOUSEEVENTF_ABSOLUTE, Round(angleX), Round(angley),0, GetMessageExtraInfo());
    mouse_event(MOUSEEVENTF_MOVE_NOCOALESCE, Round(angleX), Round(angley),0, GetMessageExtraInfo());
    angles.z := 0.0;
    //ShowMessage('teste');
    frmPrincipal.label4.Caption := 'Delta X:' + FloatToStr(angley);
frmPrincipal.label5.Caption := 'Delta Y:'+FloatToStr(angley);

end;






function Clamp(angle:TD3DXVECTOR3): TD3DXVECTOR3;
begin
  if (angle.x > 89.0) and (angle.x <= 180.0) then
angle.x := 89.0;
if (angle.x > 180.0) then
angle.x := angle.x - 360.0;
if (angle.x < -89.0) then
angle.x := -89.0;
if (angle.y > 180.0) then
angle.y := angle.y - 360.0;
if (angle.y < -180.0) then
angle.y := angle.y + 360.0;

end;

function Norm(angle : TD3DXVECTOR3): TD3DXVECTOR3;
begin
{
  while (angle.y <= -180) do angle.y := +360;
	while (angle.y > 180)   do angle.y := -360;
	while (angle.x <= -180) do angle.x := +360;
	while (angle.x > 180)   do angle.x := -360;
 }
if (angle.x > 89)   then  angle.x := -89;
if (angle.x < -180) then  angle.x := -89;
if (angle.y < -180) then  angle.y := -179.999;
if (angle.y > 180)  then  angle.y := 179.999;


    AimBots;
    Angle := Clamps(Angle);

    ClampAngle(Angle);


    Angle :=  GetDistanceToAngle(Angle,Angle);


angle.z := 0;
result := angle;
end;

function setViewAngle(newAngle:TD3DXVECTOR3; var aimSpeed : Integer):Real;
var
currentAngle : TD3DXVECTOR3;
diff         : TD3DXVECTOR3;
angle        : TD3DXVECTOR3;
begin
currentAngle := GetDistanceToAngle(angle,diff);
CurrentAngle.x := +SCREEN_WIDTH;
CurrentAngle.y := +SCREEN_HEIGHT;

angle.x := ((angle.x + currentAngle.x) - (diff.x*2));
angle.y := ((angle.y + currentAngle.y) - (diff.y*2));


diff.z := 0;

 { Vector2 CurrentViewAngles;
    Vector2 vPunch;
    Vector2 NewViewAngles;
    Vector2 OldAimPunch;
       }
        currentAngle.x := ((angle.x + diff.x) - (angle.x * 2.0));        //Get The AimPunch Angle Relative To Previous (Otherwise To Current vAngle)
        currentAngle.y := ((angle.y + diff.y) - (angle.y * 2.0));


diff := Clamps(Norm(angle));


angle.x := currentAngle.x*20;
angle.y := currentAngle.y*20;

while (angle.y > 89.0) do
            angle.y := -89;

        while (angle.y < -180) do
            angle.y := +89;

        if (angle.x > 89.0)then
            angle.x := 89.0;

        if (angle.x < -89.0) then
            angle.x := -89.0;

            angle.x := diff.x * 2.0; //Set Previous Punch To Current
            angle.y := diff.y * 2.0;


if (angle.y > 800.0) then
angle.y := +360.0;
angle.x := +diff.x / RandomRange(aimSpeed, aimSpeed + 2);
angle.y := +diff.y / RandomRange(aimSpeed, aimSpeed + 2);


angle := Norm(diff);
angle := Clamp(diff);



mouse_event(MOUSEEVENTF_MOVE, Round(angle.x), Round(angle.Y),0, GetMessageExtraInfo());
mouse_event(MOUSEEVENTF_MOVE, Round(diff.x), Round(diff.Y),0, GetMessageExtraInfo());
mouse_event(MOUSEEVENTF_MOVE, Round(Angle.x), Round(Angle.Y),0, GetMessageExtraInfo());
mouse_event(MOUSEEVENTF_ABSOLUTE, Round(diff.X), Round(diff.Y),0, GetMessageExtraInfo());
mouse_event(MOUSEEVENTF_MOVE_NOCOALESCE, Round(diff.X), Round(diff.Y),0, GetMessageExtraInfo());
Angle := Angle;
frmPrincipal.label4.Caption := 'Delta X:' + FloatToStr(diff.x);
frmPrincipal.label5.Caption := 'Delta Y:'+FloatToStr(diff.y);
//*(vec3*)(variable.enginePointer + offset.vAngle) = angle;

  angle.z := 0;
 // Result := Angle;
end;



end.
