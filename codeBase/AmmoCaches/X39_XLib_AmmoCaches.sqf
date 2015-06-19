#include "default.hpp"
#define MIN_CACHE_DISTANCE 800
#define MAX_BUILDING_POS 10
if(!isDedicated) then
{
	[] spawn {
		waitUntil{!isNull player};
		while{true} do
		{
			waitUntil{sleep 0.1; alive player};
			_arr = nearestObjects[player, ["Land_File1_F"], 2];
			{
				if(_x getVariable["isIntel", false]) then
				{
					deleteVehicle _x;
					
					_smallestDistance = player distance (X39_XLib_Modules_var_X39_XLib_AmmoCaches_ammoCaches select 0);
					_cache = (X39_XLib_Modules_var_X39_XLib_AmmoCaches_ammoCaches select 0);
					{
						if(player distance _x < _smallestDistance) then
						{
							_smallestDistance = player distance _x;
							_cache = _x;
						};
						false
					}count X39_XLib_Modules_var_X39_XLib_AmmoCaches_ammoCaches;
					_markers = _cache getVariable["X39_XLib_Modules_var_X39_XLib_AmmoCaches_markers", []];
					_i = count _markers;
					
					if(_i >= count X39_XLib_Modules_var_X39_XLib_AmmoCaches_MarkerDistances) then
					{
						_i = (count X39_XLib_Modules_var_X39_XLib_AmmoCaches_MarkerDistances) - 1;
					};
					
					_distance = X39_XLib_Modules_var_X39_XLib_AmmoCaches_MarkerDistances select _i;
					_marker = createMarker [format["%1%2", position _cache, count _markers], [((((random (_distance / 2)) + (_distance / 2)) - (_distance / 2)) * 2) * (if(floor random 2 == 0) then { -1 } else { 1 }) + (position _cache select 0), ((((random (_distance / 2)) + (_distance / 2)) - (_distance / 2)) * 2) * (if(floor random 2 == 0) then { -1 } else { 1 }) + (position _cache select 1)]];
					_marker setMarkerShape "ICON";
					_marker setMarkerType "mil_unknown";
					_marker setMarkerSize [0.5 , 0.5];
					_marker setMarkerColor "ColorRed";
					_marker setMarkerAlpha 1;
					_marker setMarkerText str _distance;
					_markers set[count _markers, _marker];
					_cache setVariable["X39_XLib_Modules_var_X39_XLib_AmmoCaches_markers", _markers, true];
					["intelAdded",["New Intel found","mil_warning" call bis_fnc_textureMarker]] call bis_fnc_showNotification;
				};
			}count _arr;
		};
	};
};
if(isServer) then
{
	_this spawn {
		_logic = _this select 0;
		_mapSize = _logic getVariable ["overrideMapSize", -1];
		X39_XLib_Modules_var_X39_XLib_AmmoCaches_EndMission = _logic getVariable ["EndMission", ""];
		_intelRate = [] call compile (_logic getVariable ["IntelRate", 1]);
		if(_intelRate > 1) exitWith {["_intelRate needs to be < 1!"] call BIS_fnc_halt;};
		_intelRate = 100 * _intelRate;
		_houses = [_mapSize, 100, false, 3, true, true] call X39_XLib_fnc_getAllHousesOnMapPerGrid;
		if(_mapSize == -1) then
		{
			_mapSize = [true] call X39_XLib_fnc_getMapSize;
			if(_mapSize == -1) exitWith
			{
				_returnValue;
			};
		};
		_enemySide = RESISTANCE;
		_enemySideTypeOfPrefix = toArray "I_";
		switch(_logic getVariable "DropIntelSide") do
		{
			case 1:{_enemySide = WEST;			_enemySideTypeOfPrefix = toArray "B_";};
			case 2:{_enemySide = EAST;			_enemySideTypeOfPrefix = toArray "O_";};
			case 3:{_enemySide = RESISTANCE;	_enemySideTypeOfPrefix = toArray "I_";};
			case 4:{_enemySide = CIVILIAN;		_enemySideTypeOfPrefix = toArray "C_";};
			default{_enemySide = RESISTANCE;	_enemySideTypeOfPrefix = toArray "I_";};
		};
		X39_XLib_Modules_var_X39_XLib_AmmoCaches_ammoCacheCountTarget = [] call compile (_logic getVariable ["Count", 10]);
		_dropIntelType = _logic getVariable ["DropIntelType", 0];
		_ammoCacheCount = 0;
		X39_XLib_Modules_var_X39_XLib_AmmoCaches_ammoCaches = [];
		X39_XLib_Modules_var_X39_XLib_AmmoCaches_MarkerDistances = [900, 700, 500, 400, 300, 200, 100, 50];
		publicVariable "X39_XLib_Modules_var_X39_XLib_AmmoCaches_MarkerDistances";
		publicVariable "X39_XLib_Modules_var_X39_XLib_AmmoCaches_ammoCacheCountTarget";
		while{_ammoCacheCount < X39_XLib_Modules_var_X39_XLib_AmmoCaches_ammoCacheCountTarget} do
		{
			_cache = "O_supplyCrate_F" createVehicle [0, 0, 0];
			_cache addEventHandler["HandleDamage", {
					_veh = _this select 0;
					if(_this select 4 == "SatchelCharge_Remote_Ammo") then
					{
						X39_XLib_Modules_var_X39_XLib_AmmoCaches_ammoCaches set[X39_XLib_Modules_var_X39_XLib_AmmoCaches_ammoCaches find _veh, -1];
						X39_XLib_Modules_var_X39_XLib_AmmoCaches_ammoCaches = X39_XLib_Modules_var_X39_XLib_AmmoCaches_ammoCaches - [-1];
						publicVariable "X39_XLib_Modules_var_X39_XLib_AmmoCaches_ammoCaches";
						_explosives = [
							"Bo_GBU12_LGB_MI10",
							"Sh_120_HE",
							"HelicopterExploBig",
							"Bo_GBU12_LGB",
							"Bo_Mk82",
							"HelicopterExploBig",
							"Bo_Mk82",
							"Bo_Mk82",
							"Bo_GBU12_LGB_MI10",
							"Sh_120_HE",
							"HelicopterExploBig",
							"Bo_GBU12_LGB"
						];

						for "_i" from 0 to ((count _explosives) - 1) do {
							_explosive = (_explosives select _i);
							_xVel = random 10;
							_yVel = random 10;
							_zVel = random 20;
							_xCoord = random 15;
							_yCoord = random 15;
							_zCoord = random 5;
							_bomb = _explosive createVehicle position _veh;
							_bomb setPos [((position _bomb) select 0) + (_xCoord - (_xCoord / 2)), ((position _bomb) select 1) + (_yCoord - (_yCoord / 2)), _zCoord * _i];
							_bomb setVelocity [_xVel,_yVel,_zVel - 50]; 
						};
						{
							deleteMarker _x;
							false
						}count (_veh getVariable ["X39_XLib_Modules_var_X39_XLib_AmmoCaches_markers", []]);
						deleteVehicle _veh;
						[[], "X39_XLib_Modules_fnc_X39_XLib_AmmoCaches_boxDestroyed", true, false] spawn BIS_fnc_MP;
					};
					0
				}];
			_cache setDamage 0;
			_flag = false;
			while{!_flag} do
			{
				_cache setPos [random _mapSize, random _mapSize, 0];
				_building = nearestBuilding _cache;
				if(str (_building buildingPos 2) != str [0,0,0]) then
				{
					_exactPos = [0,0,0];
					while{str _exactPos == str [0,0,0]} do
					{
						_exactPos = _building buildingPos floor random MAX_BUILDING_POS;
					};
					_cache setPos _exactPos;
					if({((position _x) distance (position _cache) < MIN_CACHE_DISTANCE)}count X39_XLib_Modules_var_X39_XLib_AmmoCaches_ammoCaches == 0) then
					{
						DEBUG_CODE(private["_marker"])
						_flag = true;
						_ammoCacheCount = _ammoCacheCount + 1;
						X39_XLib_Modules_var_X39_XLib_AmmoCaches_ammoCaches set[count X39_XLib_Modules_var_X39_XLib_AmmoCaches_ammoCaches, _cache];
						if(!isMultiplayer) then
						{
							_marker = createMarker[str _exactPos, _exactPos];
							_marker setMarkerShape "ICON";
							_marker setMarkerType "mil_destroy";
							_marker setMarkerSize [0.5, 0.5];
							_marker setMarkerColor "ColorRed";
							_marker setMarkerAlpha 1;
							_marker setMarkerText format["Cache %1", _ammoCacheCount];
						};
					};
				};
			};
		};
		publicVariable "X39_XLib_Modules_var_X39_XLib_AmmoCaches_ammoCaches";
		
		switch (_dropIntelType) do {
			case 0: { //Dropped by Enemies
				private["_deadUnits"];
				_deadUnits = [];
				while{true} do
				{
					{
						_cArr = toArray (typeOf _x);
						if(_enemySideTypeOfPrefix select 0 == _cArr select 0 && {_enemySideTypeOfPrefix select 1 == _cArr select 1}) then
						{
							if(! (_x in _deadUnits)) then
							{
								_index = _deadUnits find -1;
								if(_index == -1) then
								{
									_index = count _deadUnits;
								};
								_deadUnits set[_index, _x];
								if(random 100 < _intelRate) then
								{
									private "_obj";
									_obj = "Land_File1_F" createVehicle position _x;
									_obj setVariable ["isIntel", true, true];
								};
							};
						};
						false
					}count allDead;
					{
						if(typeName _x == "OBJECT" && {isNull _x}) then
						{
							_deadUnits set[_forEachIndex, -1];
						};
					}forEach _deadUnits;
					sleep 0.5;
				};
			};
			case 1: { //Placed randomly in buildings
				private["_exactPos", "_houses"];
				_houses = [_mapSize, 1000, true, true] call X39_XLib_fnc_getAllHousesOnMap;
				{
					if(random 100 < _intelRate) then
					{
						if(str (_x buildingPos 0) != str [0,0,0]) then
						{
							private "_obj";
							_exactPos = [0,0,0];
							while{str _exactPos == str [0,0,0]} do
							{
								_exactPos = _x buildingPos floor random MAX_BUILDING_POS;
							};
							_obj = ("Land_File1_F" createVehicle position _x) setPos _exactPos;
							_obj setVariable ["isIntel", true, true];
							if(!isMultiplayer) then
							{
								private "_marker";
								_marker = createMarker[str _exactPos, _exactPos];
								_marker setMarkerShape "ICON";
								_marker setMarkerType "mil_triangle";
								_marker setMarkerSize [0.5, 0.5];
								_marker setMarkerColor "ColorYellow";
								_marker setMarkerAlpha 1;
							};
						};
					};
					false;
				}count _houses;
			};
			default {diag_log format["_dropIntelType %1 not available", _dropIntelType]};
		};
	};
};