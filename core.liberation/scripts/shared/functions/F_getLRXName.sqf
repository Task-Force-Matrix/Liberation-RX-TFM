params ["_class"];

private _default = "Unknow";
if (isNil "_class") exitWith { _default };

private _text = "";
if (typeName _class == "STRING") then {
	_text = getText (configFile >> "cfgVehicles" >> _class >> "displayName");
	if (_text == "") then {
		_text = getText (configFile >> "CfgWeapons" >> _class >> "displayName");
	};
	if (_text == "") then {
		_text = getText (configFile >> "CfgMagazines" >> _class >> "displayName");
	};
	if (_text == "") then {
		_text = getText (configFile >> "CfgGlasses" >> _class >> "displayName");
	};
	if (_text == "") then { _text = _class };
};
if (typeName _class == "OBJECT") then {
	_text = getText (configOf _class >> "displayName");
	_class = typeOf _class;
};
if (_text == "") exitWith { diag_log format ["--- LRX Error: get LRX name for class:%1, not found!", _class]; _default };

if ( _class == FOB_box_typename ) then {
	_text = localize "STR_FOBBOX";
};
if ( _class == Arsenal_typename ) then {
	_text = localize "STR_ARSENAL_BOX";
};
if ( _class == FOB_truck_typename ) then {
	_text = localize "STR_FOBTRUCK";
};
if ( _class == Respawn_truck_typename ) then {
	_text = format ["%1 %2", localize "STR_RESPAWN_TRUCK", "(Truck)"];
};
if ( _class == mobile_respawn ) then {
	_text = format ["%1 %2", localize "STR_RESPAWN_TRUCK", "(Tent)"];
};
if ( _class == huron_typename ) then {
	_text = format ["%1 %2", localize "STR_RESPAWN_TRUCK", "(Heli)"];
};
if ( _class == canister_fuel_typename ) then {
	_text = "Fuel Jerican";
};
if ( _class == waterbarrel_typename ) then {
	_text = "Water Barrel";
};
if ( _class == fuelbarrel_typename ) then {
	_text = "Fuel Barrel";
};
if ( _class == foodbarrel_typename ) then {
	_text = "Food Pallet";
};
if ( _class == FOB_box_outpost ) then {
	_text = localize "STR_OUTPOSTBOX";
};
if ( _class == playerbox_typename ) then {
	_text = "Personal Player Box";
};
if ( _class == land_cutter_typename ) then {
	_text = "Magic Mower (Hide Terrain Objects)";
};
if ( _class == Warehouse_typename ) then {
	_text = "Global Warehouse";
};
if ( _class == basic_weapon_typename ) then {
	_text = "Basic Weapons";
};

_text;