#include "default.hpp"
/**
 *	checks created units for their players still being connected
 *
 *	@ParamsCount 1
 *	@Param1 - OBJECT - Insurgency object
 *	@Return - OBJECT - example return type
 *	@Author - X39|Cpt. HM Murdock
 */
private ["_unit"];
CALLSERVER;
[] spawn {
	{
		_x getVariable["X39_GM_Insurgency_Player", objNull];
		if(isNull _x) then
		{
			X39_GM_Insurgency_var_watchDog_Units set[X39_GM_Insurgency_var_watchDog_Units find _x, -1];
			_x call X39_GM_Insurgency_fnc_removeUnit;
		};
		sleep 0.0000001;
		false
	}count X39_GM_Insurgency_var_watchDog_Units;
	sleep 5;
};