#include "default.hpp"
/**
 *	create a new unit for insurgency
 *
 *	@ParamsCount 1
 *	@Param1 - OBJECT - Insurgency object
 *	@Return - OBJECT - example return type
 *	@Author - X39|Cpt. HM Murdock
 */
private ["_unit", "_insObj", "_class", "_group", "_house", "_unitCount", "_wp"];
//initialize variables
_unit = objNull;
_insObj = [_this, 0, objNull, [objNull]] call BIS_fnc_param;

//validatie parameters
if(isNull _insObj) exitWith {return objNull};
_insObj setVariable ["X39_GM_Insurgency_unitsSpawned", true, true];
_unitCount = (_insObj getVariable["X39_GM_Insurgency_spawnedUnitsCount", 0]) + 1;
if(_unitCount > X39_GM_Insurgency_var_MaxUnitsPerSquare) exitWith {return objNull};
_class = X39_GM_Insurgency_var_classesToSpawn select (floor (random (count X39_GM_Insurgency_var_classesToSpawn)));
_house = _insObj getVariable "X39_GM_Insurgency_houses";
_house = _house select (floor (random (count _house)));
_buildingPos = [0,0,0];
while{str _buildingPos == "[0,0,0]"} do
{
	_buildingPos = _house buildingPos (random 7);
};
if(isNull X39_GM_Insurgency_var_globalGroup) then
{
	X39_GM_Insurgency_var_globalGroup = createGroup X39_GM_Insurgency_var_Side;
	X39_GM_Insurgency_var_globalGroup setCombatMode "RED";
	X39_GM_Insurgency_var_globalGroup setBehaviour "COMBAT";
	publicVariable "X39_GM_Insurgency_var_globalGroup";
};
_group = X39_GM_Insurgency_var_globalGroup;

//TODO: change position finding of units
if(isNil "_class" || {isNil "_house"}) exitWith {return objNull};
DEBUG_CODE(diag_log format["Trying to create unit: '%1 createUnit %2'" COMMA _group COMMA [_class COMMA _buildingPos COMMA [] COMMA 5 COMMA "NONE"]])
if({(_x distance _buildingPos < X39_GM_Insurgency_var_minDistanceToPlayableUnitsForSpawn)}count playableUnits > 0) exitWith {objNull};
_unit = _group createUnit [_class, _buildingPos, [], 5, "NONE"];
_pos = position _unit;
if(_pos select 2 < 1) then
{
	_unit setPos [_pos select 0, _pos select 1, 0];
};
if(isNull _unit) exitWith {return objNull};
DEBUG_CODE(systemChat format["Created unit '%1' at '%2'" COMMA _class COMMA position _unit])
_unit setVariable ["X39_GM_Insurgency_InsurgencyObject", _insObj, true];
_unit setVariable ["X39_GM_Insurgency_Group", _group, true];
_unit setVariable ["X39_GM_Insurgency_Player", player, true];
_insObj setVariable ["X39_GM_Insurgency_spawnedUnitsCount", _unitCount];
_unit call X39_GM_Insurgency_fnc_setOwnerToCalculator;
return _unit