private _box = cursorObject;

sleep random 0.3;

//only one at time
if ((_box getVariable ["box_in_use", false])) exitWith {};
if ( count (GRLIB_all_fobs select {count (_x nearObjects [FOB_typename, 50]) > 0}) >= GRLIB_maximum_fobs && typeOf _box != FOB_box_outpost ) exitWith {
	hint format [ localize "STR_HINT_FOBS_EXCEEDED", GRLIB_maximum_fobs ];
};
_box setVariable ["box_in_use", true, true];

private _minfobdist = 1000;
private _minsectordist = GRLIB_capture_size + GRLIB_fob_range;
private _distfob = 1;
private _clearedtobuildfob = true;
private _distsector = 1;
private _clearedtobuildsector = true;

private _idx = 0;
while { (_idx < (count GRLIB_all_fobs)) && _clearedtobuildfob } do {
	if ( player distance (GRLIB_all_fobs select _idx) < _minfobdist ) then {
		_clearedtobuildfob = false;
		_distfob = player distance (GRLIB_all_fobs select _idx);
	};
	_idx = _idx + 1;
};

_idx = 0;
if(_clearedtobuildfob) then {
	while { (_idx < (count sectors_allSectors)) && _clearedtobuildsector } do {
		if ( player distance (getmarkerpos (sectors_allSectors select _idx)) < _minsectordist ) then {
			_clearedtobuildsector = false;
			_distsector = player distance (getmarkerpos (sectors_allSectors select _idx));
		};
		_idx = _idx + 1;
	};
};

if (!_clearedtobuildfob) then {
	hint format [localize "STR_FOB_BUILDING_IMPOSSIBLE",floor _minfobdist,floor _distfob];
} else {
	if ( !_clearedtobuildsector ) then {
		hint format [localize "STR_FOB_BUILDING_IMPOSSIBLE_SECTOR",floor _minsectordist,floor _distsector];
	} else {
		if (typeOf _box == FOB_box_outpost) then {
			buildtype = 98;
			dobuild = 1;
		} else {
			buildtype = 99;
			dobuild = 1;
		};
		waitUntil { sleep 0.5; dobuild == 0};
		if (build_confirmed != 3) then { 
			deleteVehicle _box;
			sleep 2;
			playsound "Land_Carrier_01_blast_deflector_up_sound";			
		};
	};
};
_box setVariable ["box_in_use", false, true];