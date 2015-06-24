systemChat "XInsurgency - Version 1.2";
hint "Welcome to X39s Insurgency! Mission Start could have large delays depending on map size.";
[Insurgency_Base] call X39_GM_Insurgency_fnc_module_X39_GM_Insurgency;

X39_XLib_ShowFactionNamesAndRank_EH_Draw3D = addMissionEventHandler ["Draw3D", {
	_x = cursorTarget;
	if(isNull _x) exitWith {};
	if(_x distance player > 100) exitWith {};
	if(side _x == playerSide) then
	{
		_dst = (cursorTarget distance player);
		_size = 1 - (_dst / 100);
		_pos = position _x;
		_pos set[2, (_pos select 2) + 2.25];
		if(_dst < 50) then
		{
			drawIcon3D [format["\A3\Ui_f\data\GUI\Cfg\Ranks\%1_gs.paa", rank _x], [1,1,1,1], _pos, abs sin (time * 100) * _size, _size, 0, name _x, 0, 0.1 * (_size * 0.5), "PuristaSemibold"];
		}
		else
		{
			drawIcon3D [format["\A3\Ui_f\data\GUI\Cfg\Ranks\%1_gs.paa", rank _x], [1,1,1,1], _pos, abs sin (time * 100) * _size, _size, 0, "", 0, 0, "PuristaSemibold"];
		};
	};
	false
}];

systemChat "It could happen that AMMO-CACHES spawn inside of the base";

Mission_var_VehicleSpawnerEnabled = (paramsArray select 0) > 0;

//Auto-Load saved inventory
if(!isDedicated) then {
	[] spawn {
		waitUntil{!isNil {player}};
		waitUntil{!isNull player};
		waitUntil{alive player};
		player addEventHandler["Respawn", {if(!isNil "Mission_var_SavedInventory") then {[_this select 0, missionNamespace, Mission_var_SavedInventory] call BIS_fnc_loadInventory;};}];
	};
};