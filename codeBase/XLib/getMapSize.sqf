#include "default.hpp"
/**
 *	returns map size (X/Y) as SCALAR value or -1 if not possible
 *	(also BIS_fnc_HALT can be callen if optional bool is set to true)
 *	-1 will only be returned if map is not made ArmA 3 conform!
 *
 *	@ParamsCount 1
 *	@Param1 - BOOL - default: false, if true BIS_fnc_HALT will be callen instead of -1 being returned
 *	@Return - SCALAR - actual map size (X/Y) or -1 if not possible
 *	@Author - X39|Cpt. HM Murdock
 */
private ["_worldPath", "_mapSize", "_callHALT"];

_callHALT = [_this, 0, true, [false]] call BIS_fnc_param;
_worldPath = configfile >> "cfgworlds" >> worldname;
_mapSize = getnumber (_worldPath >> "mapSize");

if(_mapSize == 0) exitWith
{
	if(_callHALT) then
		{["mapSize param not defined for '%1'", worldname] call BIS_fnc_HALT;};
	-1
};
_mapSize