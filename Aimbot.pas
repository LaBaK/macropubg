unit Aimbot;



interface

 uses
  Windows, Classes,Messages,FileCtrl,Forms,ComObj,Shellapi,SysUtils,

  Variants,  Graphics,
  Controls, MmSystem, Direct3D9,
  D3DX9,  Types,
  DxTypes, Math,Dialogs;


 Type
   Sold = Record
   isValid:integer;
   Pos:TD3DXVECTOR3;
   isAlive:integer;
   clientNum:integer;
   name:array [0..23] of AnsiChar;
   team:integer;
	 health:integer;
  End;

const
  //$00416C7B   Spread [75 -> 74]   // We should to patch only 1th byte of instruction JE->JNZ...
  //$0041A7BD   Recoil [74 -> 75]
  //$00417609   Ammo   [75 -> 74]   // no reload <> only for self hosted lan server with bots
  Eff:array[0..1] of byte  = ($0F, $84);   //$00457C79 - all weapons affects like sound, muzzle, bullets, hits and etc.
  B75:byte = $75;
  B74:byte = $74;
  NoEff:array[0..1] of byte = ($0F, $85);

var

  Scr:TD3DXVECTOR2;
  hWind: HWND;
  NOB, pID, hProc: Cardinal;
  rct:TRect;
  Entity:Sold;                    //our player
  pEntity:array [0..63] of Sold;  //other players
  SC:array [0..1] of Integer;     //center of the screen
  viewAngles:TD3DXVECTOR3;


 procedure ClampAngle(angle : TD3DXVECTOR3);
 function FOV(angle, myAngle : TD3DXVECTOR3) : real;
function currentViewAngle(vec1,vec2 : Single):real;


implementation

{
procedure CalcAngle(src, dst,angles: Single);
var
{deltaX = (src[0]) - (dst[0]);
 deltaY = (src[1]) - (dst[1]);

deltaX: array[0..0] of Single;
deltaY: array[0..1] of Single;

begin

 if ((dst[0]) > (src[0]) and (dst[1]) <= (src[1])) then
	begin
		angles[0] := atanf(deltaX / deltaY) * -180.0f / PI;

end;
    }

function FOV(angle, myAngle : TD3DXVECTOR3) : real;
begin
 //return fov from my crosshair to enemy head
      result := sqrt(Math.Power(angle.x - myAngle.x, 2) + Math.Power(angle.y - myAngle.y, 2));
end;


function RadianToDegree(radian: Single): Real;
begin
    result := radian * (180 / PI);
end;

function DegreeToRadian(degree: Single):Real;
begin
     result := degree * (PI / 180);
end;

function RadianToDegrees(radians : TD3DXVECTOR3): TD3DXVECTOR3;
var
degrees:TD3DXVECTOR3;
begin
    degrees.x := radians.x * (180 / PI);
    degrees.y := radians.y * (180 / PI);
    degrees.z := radians.z * (180 / PI);
    result := degrees;
end;

function DegreeToRadians(degrees :TD3DXVECTOR3 ):TD3DXVECTOR3;
var
    radians: TD3DXVECTOR3;
   begin
    radians.x := degrees.x * (PI / 180);
    radians.y := degrees.y * (PI / 180);
    radians.z := degrees.z * (PI / 180);
    result := radians;
end;

procedure ClampAngle(angle : TD3DXVECTOR3);
begin
    if (angle.x > 89.0) then
    angle.x := 89;
    if (angle.x < -89.0) then
    angle.x := -89;
    if (angle.y > 180) then
    angle.y := 180;
    if (angle.y < -180) then
     angle.y := -180;

    angle.z := 0.0;
end;

function currentViewAngle(vec1,vec2 : Single):real;
begin
    if (vec1 > 89.0) then
    vec1 := 180.0;
    if (vec1 < -89.0) then
    vec1 := +180.0;

    while (vec2 > 180) do
    vec2 := -360.0;
    while (vec2 < -180) do
    vec2 := +360.0;
    //result := vec1+vec2;
end;



function RotatePoint(pointToRotate, centerPoint: TD3DXVECTOR2; angle: Single; angleInRadians: boolean = false): Real;
var
cosTheta,sinTheta : Single;
returnVec :  TD3DXVECTOR3;
begin
{
	if (!angleInRadians)
		angle = (float)(angle * (PI / 180.f));
	float cosTheta = (float)cos(angle);
	float sinTheta = (float)sin(angle);
	Vector2 returnVec = Vector2(
		cosTheta * (pointToRotate.x - centerPoint.x) - sinTheta * (pointToRotate.y - centerPoint.y),
		sinTheta * (pointToRotate.x - centerPoint.x) + cosTheta * (pointToRotate.y - centerPoint.y)
	);
	returnVec += centerPoint;
	return returnVec;
}


if angleInRadians = true then
begin
    angle := (angle * (PI / 180.0));
   cosTheta := cos(angle);
	 sinTheta := sin(angle);
//   returnVec :=
//   (CosTheta * (pointToRotate.x - centerPoint.x) - sinTheta * (pointToRotate.y - centerPoint.y) and
//    sinTheta * (pointToRotate.x - centerPoint.x) + cosTheta * (pointToRotate.y - centerPoint.y));

//returnVec := +centerPoint;
end;
end;





end.
