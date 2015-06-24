#include "default.hpp"
/**
 *	create a new unit for insurgency
 *
 *	@ParamsCount 1
 *	@Param1 - OBJECT - Unit
 *	@Return - NA
 *	@Author - X39|Cpt. HM Murdock
 */
private ["_unit", "_group", "_insObj"];

_unit = [_this, 0, objNull, [objNull]] call BIS_fnc_param;

_group = _unit getVariable["X39_GM_Insurgency_Group", -1];
_insObj = _x getVariable ["X39_GM_Insurgency_InsurgencyObject", objNull];
DEBUG_CODE(if(typeName _group == "SCALAR") then {DEBUG_LOG(format["unit '%1's group is invalid!" COMMA _unit])};)
if(!isNull _unit) then
{
	deleteVehicle _unit;
};
sleep 0.000001;
if(typeName _group != "SCALAR" && {!isNull _group}) then
{
	deleteGroup _group;
};
_insObj setVariable["X39_GM_Insurgency_spawnedUnitsCount", (_insObj getVariable["X39_GM_Insurgency_spawnedUnitsCount", 0]) - 1];