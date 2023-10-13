if (GRLIB_patrols_activity == 0) exitWith {};
waitUntil {sleep 1; !isNil "GRLIB_A3W_Init"};
diag_log "--- LRX Starting Patrols Manager";
sleep 400;

[30] execVM "scripts\server\patrols\manage_one_enemy_patrol.sqf";
[60] execVM "scripts\server\patrols\manage_one_enemy_patrol.sqf";
[90] execVM "scripts\server\patrols\manage_one_enemy_patrol.sqf";
// [100] execVM "scripts\server\patrols\manage_one_enemy_patrol.sqf";
// [90] execVM "scripts\server\patrols\manage_one_enemy_patrol.sqf";
