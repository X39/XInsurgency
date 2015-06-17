#include "default.hpp"
private["_logic", "_houses", "_pos", "_overrideMapSize", "_minSpawnPositionsForBuildings", "_enemiesSide", "_typeOfX", "_avoidAreas", "_arr", "_maxUnitsPerPlayer", "_maxUnitsPerSquare", "_deathTimeout", "_minDistanceToPlayableUnitsForSpawn", "_maxDistanceToUnitGrid", "_maxDistanceToOwner"];
_logic = _this select 0;

_overrideMapSize = _logic getVariable ["overrideMapSize", 0];
if(_overrideMapSize <= 0) then
{
	_overrideMapSize = -1;
};
_minSpawnPositionsForBuildings = _logic getVariable "minSpawnPositionsForBuildings";
_enemiesSide = _logic getVariable "enemiesSide";
_maxUnitsPerPlayer = _logic getVariable "maxUnitsPerPlayer";
_maxUnitsPerSquare = _logic getVariable "maxUnitsPerSquare";
_spawnrange = _logic getVariable "spawnrange";
_deathTimeout = _logic getVariable "deathTimeout";
_minDistanceToPlayableUnitsForSpawn = _logic getVariable "minDistanceToPlayableUnitsForSpawn";
_maxDistanceToUnitGrid = _logic getVariable "maxDistanceToUnitGrid";
_maxDistanceToOwner = _logic getVariable "maxDistanceToOwner";
_enemySideSpawning = (_logic getVariable ["enemySideSpawning", 1]) call X39_XLib_fnc_ScalarToBool;

switch(_enemiesSide) do
{
	case 1:{X39_GM_Insurgency_var_Side = WEST;};
	case 2:{X39_GM_Insurgency_var_Side = EAST;};
	case 3:{X39_GM_Insurgency_var_Side = RESISTANCE;};
	case 4:{X39_GM_Insurgency_var_Side = CIVILIAN;};
};

assignVariable(X39_GM_Insurgency_var_classesToSpawn, [])
assignVariable(X39_GM_Insurgency_var_SpawnedUnits, [])
assignVariable(X39_GM_Insurgency_var_DeathTimeOut, _deathTimeout)
assignVariable(X39_GM_Insurgency_var_MaxUnitsPerPlayer, _maxUnitsPerPlayer)
assignVariable(X39_GM_Insurgency_var_MaxUnitsPerSquare, _maxUnitsPerSquare)
assignVariable(X39_GM_Insurgency_var_spawnRange, _spawnrange)
assignVariable(X39_GM_Insurgency_var_minDistanceToPlayableUnitsForSpawn, _minDistanceToPlayableUnitsForSpawn)
assignVariable(X39_GM_Insurgency_var_maxDistanceToUnitGrid, _maxDistanceToUnitGrid)
assignVariable(X39_GM_Insurgency_var_maxDistanceToOwner, _maxDistanceToOwner)
assignVariable(X39_GM_Insurgency_var_enemySideSpawning, _enemySideSpawning)
assignVariable(X39_GM_Insurgency_var_serverDone, false)
assignVariable(X39_GM_Insurgency_var_globalGroup, grpNull)

if(isServer) then
{
	X39_GM_Insurgency_var_classesToSpawn = [];
	X39_GM_Insurgency_var_watchDog_Units = [];
	X39_GM_Insurgency_var_SpawnedUnits = [];
	X39_GM_Insurgency_var_DeathTimeOut = _deathTimeout;
	X39_GM_Insurgency_var_MaxUnitsPerPlayer = _maxUnitsPerPlayer;
	X39_GM_Insurgency_var_MaxUnitsPerSquare = _maxUnitsPerSquare;
	X39_GM_Insurgency_var_spawnRange = _spawnrange;
	X39_GM_Insurgency_var_globalGroup = createGroup X39_GM_Insurgency_var_Side;
	X39_GM_Insurgency_var_globalGroup setCombatMode "RED";
	X39_GM_Insurgency_var_globalGroup setBehaviour "COMBAT";
	_avoidAreas = [];
	if({
		_typeOfX = typeOf _x;
		if(_x getVariable["isInsAvoid", false]) then
		{
			_avoidAreas set [count _avoidAreas, _x];
		}
		else
		{
			X39_GM_Insurgency_var_classesToSpawn set [count X39_GM_Insurgency_var_classesToSpawn, _typeOfX];
			deleteVehicle _x;
		};
		true
	} count synchronizedObjects _logic <= 0) exitWith { ["No units to spawn are synched!"] call BIS_fnc_HALT;};

	_houses = [_overrideMapSize, 100, false, _minSpawnPositionsForBuildings, true, true] call X39_XLib_fnc_getAllHousesOnMapPerGrid;
	X39_GM_Insurgency_var_HeadlessClientID = _logic getVariable ["hcUnitName", ""];
	if(isNil{missionNamespace getVariable X39_GM_Insurgency_var_HeadlessClientID}) then
	{
		X39_GM_Insurgency_var_HeadlessClientID = 1;
	}
	else
	{
		X39_GM_Insurgency_var_HeadlessClientID = owner (missionNamespace getVariable X39_GM_Insurgency_var_HeadlessClientID);
	};
	publicVariable "X39_GM_Insurgency_var_HeadlessClientID";
	{
		_x call {
			{
				DEBUG_LOG(format["%1: Handling '%2'" COMMA _fnc_scriptName COMMA _x])
				_pos = _x select 0;
				_x set [0, -1];
				[_pos, _x - [-1]] call X39_GM_Insurgency_fnc_createInsurgencyObject;
				false
			}count _this;
		};
		false
	}count _houses;
	{
		nearestObjects[position _x, ["Land_HelipadEmpty_F"], _x getVariable "avoidRange"] call {
			private["_x"];
			{
				if(_x getVariable ["X39_GM_Insurgency", false]) then
				{
					[_x] call X39_GM_Insurgency_fnc_deleteInsurgencyObject;
				};
				false
			} count _this;
		};
		false
	} count _avoidAreas;
	[] call X39_GM_Insurgency_fnc_watchDog;
	X39_GM_Insurgency_var_serverDone = true;
	publicVariable "X39_GM_Insurgency_var_classesToSpawn";
	publicVariable "X39_GM_Insurgency_var_SpawnedUnits";
	publicVariable "X39_GM_Insurgency_var_DeathTimeOut";
	publicVariable "X39_GM_Insurgency_var_MaxUnitsPerPlayer";
	publicVariable "X39_GM_Insurgency_var_MaxUnitsPerSquare";
	publicVariable "X39_GM_Insurgency_var_spawnRange";
	publicVariable "X39_GM_Insurgency_var_globalGroup";
	publicVariable "X39_GM_Insurgency_var_minDistanceToPlayableUnitsForSpawn";
	publicVariable "X39_GM_Insurgency_var_maxDistanceToUnitGrid";
	publicVariable "X39_GM_Insurgency_var_maxDistanceToOwner";
	publicVariable "X39_GM_Insurgency_var_serverDone";
};
if(!isDedicated) then
{
	
	[] call X39_GM_Insurgency_fnc_startInsurgencyWorker;
};