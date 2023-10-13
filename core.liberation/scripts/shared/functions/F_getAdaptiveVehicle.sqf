params [ ["_type", "nil"] ];	// sector or patrol

private _vehicle_pool = (opfor_vehicles - opfor_troup_transports_truck);
private _selected = [];
private ["_prob_heli1", "_prob_heli2", "_prob_plane1", "_prob_plane2", "_prob_apc1", "_prob_apc2", "_prob_apc3", "_prob_tank1", "_prob_tank2"];
private _cnt_apc = 0;
private _cnt_heli = 0;
private _cnt_plane = 0;
private _cnt_tank = 0;


switch (_type) do {

	case "sector_capture": {
		_prob_apc1 = [ 20, 35, 80 ];
		_prob_apc2 = [ 12, 35, 50 ];
		_prob_apc3 = [ 0, 5, 20 ];
		
		_prob_heli1 = [ 10, 28, 50 ];
		_prob_heli2 = [ 0, 15, 20 ];
		
		_prob_plane1 = [ 0, 10, 30 ];
		_prob_plane2 = [ 0, 0, 10 ];
		
		_prob_tank1 = [ 0, 15, 25 ];
		_prob_tank2 = [ 5, 15, 10 ];
	};
	
	case "sector_town": {
		_prob_apc1 = [ 25, 50, 70 ];
		_prob_apc2 = [ 10, 25, 40 ];
		_prob_apc3 = [ 0, 5, 20 ];
		
		_prob_heli1 = [ 7, 18, 40 ];
		_prob_heli2 = [ 0, 10, 20 ];
		
		_prob_plane1 = [ 0, 6, 20 ];
		_prob_plane2 = [ 0, 0, 10 ];
		
		_prob_tank1 = [ 0, 15, 25 ];
		_prob_tank2 = [ 0, 15, 25 ];	
	};
	
	case "sector_mil": {
		_prob_apc1 = [ 60, 75, 90 ];
		_prob_apc2 = [ 20, 30, 40 ];
		_prob_apc3 = [ 5, 10, 20 ];
		
		_prob_heli1 = [ 35, 65, 95 ];
		_prob_heli2 = [ 10, 35, 40 ];
		
		_prob_plane1 = [ 15, 33, 80 ];
		_prob_plane2 = [ 5, 12, 30 ];
		
		_prob_tank1 = [ 25, 45, 90 ];
		_prob_tank2 = [ 12, 30, 45 ];	
	};
	
	case "sector_tower": {
		_prob_apc1 = [ 60, 75, 90 ];
		_prob_apc2 = [ 20, 25, 35 ];
		_prob_apc3 = [ 5, 10, 15 ];
		
		_prob_heli1 = [ 20, 40, 95 ];
		_prob_heli2 = [ 12, 20, 20 ];
		
		_prob_plane1 = [ 8, 24, 80 ];
		_prob_plane2 = [ 0, 10, 18 ];
		
		_prob_tank1 = [ 0, 20, 50 ];
		_prob_tank2 = [ 0, 5, 15 ];	
	};	
	
	case "sector_factory": {
		_prob_apc1 = [ 40, 70, 90 ];
		_prob_apc2 = [ 25, 35, 60 ];
		_prob_apc3 = [ 12, 15, 18 ];
		
		_prob_heli1 = [ 20, 40, 65 ];
		_prob_heli2 = [ 10, 18, 25 ];
		
		_prob_plane1 = [ 5, 15, 40 ];
		_prob_plane2 = [ 0, 15, 20 ];
		
		_prob_tank1 = [ 8, 20, 70 ];
		_prob_tank2 = [ 0, 15, 35 ];	
	};
	
	case "nil";
};


if ( combat_readiness < 35 ) then {
	_vehicle_pool = (opfor_vehicles_low_intensity - opfor_troup_transports_truck);	
};

_selected pushBack (selectRandom _vehicle_pool);


if ( _type != "nil" ) then {

private _opfor_vehicles_tanks = opfor_vehicles select { _x isKindOf "Tank"};
private _opfor_air_heli = opfor_air select { _x isKindOf "Helicopter"};

// added chance randomized more complex troups
if ( combat_readiness <= 35 ) then {
	
	if ( floor (random 100) <= (_prob_apc1 select 0)) then { _selected pushback (selectRandom (opfor_vehicles - _opfor_vehicles_tanks)); _cnt_apc = _cnt_apc+1};
	if ((_cnt_apc == 1) && (floor (random 100) <= (_prob_apc2 select 0))) then { _selected pushback (selectRandom (opfor_vehicles - _opfor_vehicles_tanks)); _cnt_apc = _cnt_apc+1};
	if ((_cnt_apc == 2) && (floor (random 100) <= (_prob_apc3 select 0))) then { _selected pushback (selectRandom (opfor_vehicles - _opfor_vehicles_tanks))};
	
	if ( floor (random 100) <= (_prob_heli1 select 0)) then { _selected pushback (selectRandom _opfor_air_heli); _cnt_heli = _cnt_heli+1};
	if ((_cnt_heli == 1) && (floor (random 100) <= (_prob_heli2 select 0))) then { _selected pushback (selectRandom _opfor_air_heli)};
	
	if ( floor (random 100) <= (_prob_plane1 select 0)) then { _selected pushback (selectRandom (opfor_air - _opfor_air_heli)); _cnt_plane = _cnt_plane+1};
	if ((_cnt_plane == 1) && (floor (random 100) <= (_prob_plane2 select 0))) then { _selected pushback (selectRandom (opfor_air - _opfor_air_heli))};
	
	if ( floor (random 100) <= (_prob_tank1 select 0)) then { _selected pushback (selectRandom _opfor_vehicles_tanks); _cnt_tank = _cnt_tank+1};
	if ((_cnt_tank == 1) && (floor (random 100) <= (_prob_tank2 select 0))) then { _selected pushback (selectRandom _opfor_vehicles_tanks)};
	
};


if ( combat_readiness > 35 && combat_readiness <= 70) then {

	if ( floor (random 100) <= (_prob_apc1 select 1)) then { _selected pushback (selectRandom (opfor_vehicles - _opfor_vehicles_tanks)); _cnt_apc = _cnt_apc+1};
	if ((_cnt_apc == 1) && (floor (random 100) <= (_prob_apc2 select 1))) then { _selected pushback (selectRandom (opfor_vehicles - _opfor_vehicles_tanks)); _cnt_apc = _cnt_apc+1};
	if ((_cnt_apc == 2) && (floor (random 100) <= (_prob_apc3 select 1))) then { _selected pushback (selectRandom (opfor_vehicles - _opfor_vehicles_tanks))};
	
	if ( floor (random 100) <= (_prob_heli1 select 1)) then { _selected pushback (selectRandom _opfor_air_heli); _cnt_heli = _cnt_heli +1};
	if ((_cnt_heli == 1) && (floor (random 100) <= (_prob_heli2 select 1))) then { _selected pushback (selectRandom _opfor_air_heli)};
	
	if ( floor (random 100) <= (_prob_plane1 select 1)) then { _selected pushback (selectRandom (opfor_air - _opfor_air_heli)); _cnt_plane = _cnt_plane+1};
	if ((_cnt_plane == 1) && (floor (random 100) <= (_prob_plane2 select 1))) then { _selected pushback (selectRandom (opfor_air - _opfor_air_heli))};
	
	if ( floor (random 100) <= (_prob_tank1 select 1)) then { _selected pushback (selectRandom _opfor_vehicles_tanks); _cnt_tank = _cnt_tank+1};
	if ((_cnt_tank == 1) && (floor (random 100) <= (_prob_tank2 select 1))) then { _selected pushback (selectRandom _opfor_vehicles_tanks)};

};


if ( combat_readiness > 70) then {
	
	
	if ( floor (random 100) <= (_prob_apc1 select 2)) then { _selected pushback (selectRandom (opfor_vehicles - _opfor_vehicles_tanks)); _cnt_apc = _cnt_apc + 1};
	if ((_cnt_apc == 1) && (floor (random 100) <= (_prob_apc2 select 2))) then { _selected pushback (selectRandom (opfor_vehicles - _opfor_vehicles_tanks)); _cnt_apc = _cnt_apc+1};
	if ((_cnt_apc == 2) && (floor (random 100) <= (_prob_apc3 select 2))) then { _selected pushback (selectRandom (opfor_vehicles - _opfor_vehicles_tanks))};
	
	if ( floor (random 100) <= (_prob_heli1 select 2)) then { _selected pushback (selectRandom _opfor_air_heli); _cnt_heli = _cnt_heli +1};
	if ((_cnt_heli == 1) && (floor (random 100) <= (_prob_heli2 select 2))) then { _selected pushback (selectRandom _opfor_air_heli)};
	
	if ( floor (random 100) <= (_prob_plane1 select 2)) then { _selected pushback (selectRandom (opfor_air - _opfor_air_heli)); _cnt_plane = _cnt_plane+1};
	if ((_cnt_plane == 1) && (floor (random 100) <= (_prob_plane2 select 2))) then { _selected pushback (selectRandom (opfor_air - _opfor_air_heli))};
	
	if ( floor (random 100) <= (_prob_tank1 select 2)) then { _selected pushback (selectRandom _opfor_vehicles_tanks); _cnt_tank = _cnt_tank+1};
	if ((_cnt_tank == 1) && (floor (random 100) <= (_prob_tank2 select 2))) then { _selected pushback (selectRandom _opfor_vehicles_tanks)};	

};

_selected;

} else { _selected select 0 };


