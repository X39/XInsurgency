#include "default.hpp"
/**
 *	create a new unit for insurgency
 *
 *	@ParamsCount 1
 *	@Param1 - OBJECT - Insurgency object
 *	@Return - OBJECT - example return type
 *	@Author - X39|Cpt. HM Murdock
 */
private ["_unit"];
CALLSERVER;
_unit = [_this, 0, objNull, [objNull]] call BIS_fnc_param;
//replaced by setGroupOwner
//_unit setOwner X39_GM_Insurgency_var_HeadlessClientID;
group _unit setGroupOwner X39_GM_Insurgency_var_HeadlessClientID;
_index = X39_GM_Insurgency_var_watchDog_Units find -1;
if(_index == -1) then
{
	_index = count X39_GM_Insurgency_var_watchDog_Units;
};
X39_GM_Insurgency_var_watchDog_Units set [_index, _unit];