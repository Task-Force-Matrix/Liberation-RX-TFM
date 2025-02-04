// Automatic Parachute System for LRX
params ["_vehicle", ["_source", objNull]];
if (isNil "_vehicle") exitWith {};

private _shell_smoke_code = ["Withe", "Red", "Green", "Yellow", "Purple", "Blue", "Orange"];
private _shell_smoke = ["SmokeShell", "SmokeShellRed", "SmokeShellGreen", "SmokeShellYellow", "SmokeShellPurple", "SmokeShellBlue", "SmokeShellOrange"];
private _open_parachute = 270;
private _start_smoke = 80;
private _one = floor (random (count _shell_smoke_code));
private _two = floor (random (count _shell_smoke_code));

private _text = format ["Air Drop %1 - Code %2 on %3", ([typeOf _vehicle] call F_getLRXName), (_shell_smoke_code select _one), (_shell_smoke_code select _two)];
[gamelogic, _text] remoteExec ["globalChat", 0];

_vehicle allowDamage false;

private	_lst_grl = [];
{
	_lst_grl pushback (typeOf _x);
	deleteVehicle _x;
} forEach (_vehicle getVariable ["GRLIB_ammo_truck_load", []]);
_vehicle setVariable ["GRLIB_ammo_truck_load", [], true];

waitUntil {sleep 0.1; (getPosATL _vehicle select 2) <= _open_parachute};

private _pos = getPosATL _vehicle;
private _parachute = createVehicle ["B_Parachute_02_F", _pos, [], 0, "CAN_COLLIDE"];
_parachute disableCollisionWith _vehicle;
_parachute disableCollisionWith _source;
_parachute setvelocity (velocity _vehicle);
_vehicle attachTo [_parachute,[0,0,0.6]];

private _timeout = time + 150;
waitUntil {sleep 0.1;((getPosATL _vehicle select 2) < _start_smoke || time > _timeout)};
private _smoke1 = (_shell_smoke select _one) createVehicle _pos;
_smoke1 attachTo [_vehicle,[0,0,0.6]];
private _smoke2 = (_shell_smoke select _two) createVehicle _pos;
_smoke2 attachTo [_vehicle,[0,0,0.6]];

waitUntil {sleep 0.1;((getPosATL _vehicle select 2) < 7 || time > _timeout)};
detach _vehicle;
detach _smoke1;
detach _smoke2;
sleep 4;
deleteVehicle _parachute;

{ [_vehicle, _x] call attach_object_direct } forEach _lst_grl;

if ((vectorUp _vehicle) select 2 < 0.70) then {
	_vehicle setpos [(getPosATL _vehicle) select 0,(getPosATL _vehicle) select 1, 0.5];
	_vehicle setVectorUp surfaceNormal position _vehicle;
};
sleep 3;
_vehicle allowDamage true;

if (underwater _vehicle) then { [_vehicle] spawn clean_vehicle };
