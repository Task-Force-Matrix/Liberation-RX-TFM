params [ ["_type", "nil"] ];	// sector or patrol

private _vehicle_pool = (opfor_vehicles - opfor_troup_transports_truck);
private _selected = [];
private ["_prob_heli1", "_prob_heli2", "_prob_plane1", "_prob_plane2", "_prob_apc1", "_prob_apc2", "_prob_apc3", "_prob_tank1", "_prob_tank2"];


switch (_type) do {

	case "sector_capture": {
		_prob_apc1 = [ 15, 30, 70 ];
		_prob_apc2 = [ 2, 35, 45 ];
		_prob_apc3 = [ 0, 5, 20 ];
		
		_prob_heli1 = [ 5, 15, 30 ];
		_prob_heli2 = [ 0, 10, 20 ];
		
		_prob_plane1 = [ 0, 5, 10 ];
		_prob_plane2 = [ 0, 0, 10 ];
		
		_prob_tank1 = [ 0, 15, 30 ];
		_prob_tank2 = [ 5, 15, 30 ];
	};
	
	case "sector_town": {
		_prob_apc1 = [ 15, 30, 70 ];
		_prob_apc2 = [ 2, 35, 45 ];
		_prob_apc3 = [ 0, 5, 20 ];
		
		_prob_heli1 = [ 5, 15, 30 ];
		_prob_heli2 = [ 0, 10, 20 ];
		
		_prob_plane1 = [ 0, 5, 10 ];
		_prob_plane2 = [ 0, 0, 10 ];
		
		_prob_tank1 = [ 0, 15, 30 ];
		_prob_tank2 = [ 5, 15, 30 ];	
	};
	
	case "sector_mil": {
		_prob_apc1 = [ 30, 50, 95 ];
		_prob_apc2 = [ 15, 25, 45 ];
		_prob_apc3 = [ 8, 20, 25 ];
		
		_prob_heli1 = [ 30, 65, 95 ];
		_prob_heli2 = [ 15, 35, 40 ];
		
		_prob_plane1 = [ 15, 45, 70 ];
		_prob_plane2 = [ 5, 25, 35 ];
		
		_prob_tank1 = [ 15, 40, 90 ];
		_prob_tank2 = [ 15, 40, 40 ];	
	};
	
	case "sector_factory": {
		_prob_apc1 = [ 40, 65, 85 ];
		_prob_apc2 = [ 20, 30, 50 ];
		_prob_apc3 = [ 15, 15, 15 ];
		
		_prob_heli1 = [ 20, 40, 70 ];
		_prob_heli2 = [ 20, 40, 50 ];
		
		_prob_plane1 = [ 5, 15, 40 ];
		_prob_plane2 = [ 0, 15, 20 ];
		
		_prob_tank1 = [ 5, 30, 70 ];
		_prob_tank2 = [ 1, 20, 35 ];	
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
	
	if ( floor (random 100) <= (_prob_apc1 select 0)) then { _selected pushback (selectRandom (opfor_vehicles - _opfor_vehicles_tanks))};
	if ( floor (random 100) <= (_prob_apc2 select 0)) then { _selected pushback (selectRandom (opfor_vehicles - _opfor_vehicles_tanks))};
	if ( floor (random 100) <= (_prob_apc3 select 0)) then { _selected pushback (selectRandom (opfor_vehicles - _opfor_vehicles_tanks))};
	
	if ( floor (random 100) <= (_prob_heli1 select 0)) then { _selected pushback (selectRandom _opfor_air_heli)};
	if ( floor (random 100) <= (_prob_heli2 select 0)) then { _selected pushback (selectRandom _opfor_air_heli)};
	
	if ( floor (random 100) <= (_prob_plane1 select 0)) then { _selected pushback (selectRandom (opfor_air - _opfor_air_heli))};
	if ( floor (random 100) <= (_prob_plane2 select 0)) then { _selected pushback (selectRandom (opfor_air - _opfor_air_heli))};
	
	if ( floor (random 100) <= (_prob_tank1 select 0)) then { _selected pushback (selectRandom _opfor_vehicles_tanks)};
	if ( floor (random 100) <= (_prob_tank2 select 0)) then { _selected pushback (selectRandom _opfor_vehicles_tanks)};
	
};


if ( combat_readiness > 35 && combat_readiness <= 70) then {

	if ( floor (random 100) <= (_prob_apc1 select 1)) then { _selected pushback (selectRandom (opfor_vehicles - _opfor_vehicles_tanks))};
	if ( floor (random 100) <= (_prob_apc2 select 1)) then { _selected pushback (selectRandom (opfor_vehicles - _opfor_vehicles_tanks))};
	if ( floor (random 100) <= (_prob_apc3 select 1)) then { _selected pushback (selectRandom (opfor_vehicles - _opfor_vehicles_tanks))};
	
	if ( floor (random 100) <= (_prob_heli1 select 1)) then { _selected pushback (selectRandom _opfor_air_heli)};
	if ( floor (random 100) <= (_prob_heli2 select 1)) then { _selected pushback (selectRandom _opfor_air_heli)};
	
	if ( floor (random 100) <= (_prob_plane1 select 1)) then { _selected pushback (selectRandom (opfor_air - _opfor_air_heli))};
	if ( floor (random 100) <= (_prob_plane2 select 1)) then { _selected pushback (selectRandom (opfor_air - _opfor_air_heli))};
	
	if ( floor (random 100) <= (_prob_tank1 select 1)) then { _selected pushback (selectRandom _opfor_vehicles_tanks)};
	if ( floor (random 100) <= (_prob_tank2 select 1)) then { _selected pushback (selectRandom _opfor_vehicles_tanks)};	

};


if ( combat_readiness > 70) then {
	
	if ( floor (random 100) <= (_prob_apc1 select 2)) then { _selected pushback (selectRandom (opfor_vehicles - _opfor_vehicles_tanks))};
	if ( floor (random 100) <= (_prob_apc2 select 2)) then { _selected pushback (selectRandom (opfor_vehicles - _opfor_vehicles_tanks))};
	if ( floor (random 100) <= (_prob_apc3 select 2)) then { _selected pushback (selectRandom (opfor_vehicles - _opfor_vehicles_tanks))};
	
	if ( floor (random 100) <= (_prob_heli1 select 2)) then { _selected pushback (selectRandom _opfor_air_heli)};
	if ( floor (random 100) <= (_prob_heli2 select 2)) then { _selected pushback (selectRandom _opfor_air_heli)};
	
	if ( floor (random 100) <= (_prob_plane1 select 2)) then { _selected pushback (selectRandom (opfor_air - _opfor_air_heli))};
	if ( floor (random 100) <= (_prob_plane2 select 2)) then { _selected pushback (selectRandom (opfor_air - _opfor_air_heli))};
	
	if ( floor (random 100) <= (_prob_tank1 select 2)) then { _selected pushback (selectRandom _opfor_vehicles_tanks)};
	if ( floor (random 100) <= (_prob_tank2 select 2)) then { _selected pushback (selectRandom _opfor_vehicles_tanks)};	

};

_selected;

} else { _selected select 0 };


