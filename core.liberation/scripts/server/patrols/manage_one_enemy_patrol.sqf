if ( isNil "active_sectors" ) then { active_sectors = [] };
private [
	"_usable_sectors",
	"_spawnsector",
	"_opfor_veh",
	"_opfor_grp",
	"_unit_ttl"
];

while { GRLIB_endgame == 0 && GRLIB_global_stop == 0 } do {
	sleep (30 + floor(random 30));
	while { [] call F_opforCap > GRLIB_patrol_cap || (diag_fps < 35.0) || combat_readiness < 30 } do {
		sleep (30 + floor(random 30));
	};

	_opfor_veh = objNull;
	_usable_sectors = [];
	{
		if ( (count ([getmarkerpos _x, 3500] call F_getNearbyPlayers) > 0) && (count ([getmarkerpos _x, GRLIB_sector_size] call F_getNearbyPlayers) == 0) ) then {
			_usable_sectors pushback _x;
		};
	} foreach (sectors_bigtown + sectors_capture + sectors_factory - active_sectors);

	if ( count _usable_sectors > 0 ) then {
		_spawnsector = selectRandom _usable_sectors;

		// 50% in vehicles
		if ( floor(random 100) >= 50 ) then {
			_opfor_veh = [markerPos _spawnsector, (selectRandom (militia_vehicles)), false, false, GRLIB_side_enemy] call F_libSpawnVehicle;
			_opfor_veh setVariable ["GRLIB_mission_AI", true, true];
			_opfor_grp = group (driver _opfor_veh);
			_opfor_veh addEventHandler ["Fuel", { if (!(_this select 1)) then {(_this select 0) setFuel 1}}];
			[_opfor_veh] spawn {
				params ["_vehicle"];
				if (typeOf _vehicle isKindOf "Air") exitWith {};
				while { alive _vehicle } do {
					// Correct static position
					if ((vectorUp _vehicle) select 2 < 0.70) then {
						_vehicle setpos [(getposATL _vehicle) select 0, (getposATL _vehicle) select 1, 0.5];
						_vehicle setVectorUp surfaceNormal position _vehicle;
					};
					sleep 5;
				};
			};
		} else {
			_opfor_grp = [_spawnsector, "militia", ([] call F_getAdaptiveSquadComp)] call F_spawnRegularSquad;
		};

		{ _x setVariable ["GRLIB_mission_AI", true, true] } forEach (units _opfor_grp);
		[_opfor_grp] spawn add_patrol_waypoints;

		if ( local _opfor_grp ) then {
			_headless_client = [] call F_lessLoadedHC;
			if (!isNull _headless_client) then {
				_opfor_grp setGroupOwner (owner _headless_client);
			};
		};

		_unit_ttl = round (time + 1800);
		waitUntil {
			sleep 30;
			( GRLIB_global_stop == 1 || (diag_fps < 25) || ({alive _x} count (units _opfor_grp) == 0) || (count ([getPos (leader _opfor_grp), 4000] call F_getNearbyPlayers) == 0) || (time > _unit_ttl) )
		};

		// Cleanup
		waitUntil { sleep 10; GRLIB_global_stop == 1 || [markerpos _spawnsector, GRLIB_sector_size, GRLIB_side_friendly] call F_getUnitsCount == 0 };
		{ 
			if (!isNull objectParent _x) then { [vehicle _x] call clean_vehicle };
			deleteVehicle _x 
			sleep 0.1;
		} forEach (units _opfor_grp);
		deleteGroup _opfor_grp;
	};
};