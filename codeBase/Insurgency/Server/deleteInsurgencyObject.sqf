#include "default.hpp"
/**
 *	removes insurgency gameplay object correctly
 *
 *	@ParamsCount 2 to 4
 *	@Param1 - OBJECT - InsurgencyObject to delete
 *	@Return - NA
 *	@Author - X39|Cpt. HM Murdock
 */
CALLSERVER;
private ["_veh", "_marker"];
_veh = [_this, 0, objNull, [objNull]] call BIS_fnc_param;

if(typeOf _veh != "Land_HelipadEmpty_F" || !(_veh getVariable["X39_GM_Insurgency", false])) exitWith {diag_log format["'%1' is not a valid InsurgencyObject!", _veh];};

deleteMarker (_veh getVariable "X39_GM_Insurgency_marker");
deleteVehicle _veh;