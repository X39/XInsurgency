#include "default.hpp"
/**
 *	updates marker etc. on an insurgencyObject
 *
 *	@ParamsCount 1
 *	@Param1 - OBJECT - insurgencyObject to update
 *	@Return - NA
 *	@Author - X39|Cpt. HM Murdock
 */
private ["_insurgencyObject", "_marker", "_objects"];

//initialize variables
_insurgencyObject = [_this, 0, objNull, [objNull]] call BIS_fnc_param;

//validatie parameters
if(isNull _insurgencyObject) exitWith {};//["No insurgency object provided!"] call BIS_fnc_halt;};
if(typeOf _insurgencyObject != "Land_HelipadEmpty_F" || !(_insurgencyObject getVariable["X39_GM_Insurgency", false])) exitWith {};//["provided object '%1' is not an insurgency object!", _insurgencyObject] call BIS_fnc_halt;};

//do something
_marker = _insurgencyObject getVariable "X39_GM_Insurgency_marker";
if(_insurgencyObject getVariable "X39_GM_Insurgency_unitsSpawned") then
{
	_objects = nearestObjects [position _insurgencyObject, X39_GM_Insurgency_var_classesToSpawn, X39_GM_Insurgency_var_spawnRange + 20];//, ((sqrt 2) * ((getMarkerSize _marker) select 0) / 2)];
	if({(alive _x && {(_x getVariable "X39_GM_Insurgency_InsurgencyObject") == _insurgencyObject})}count _objects > 0) then
	{
		if(!isMultiplayer) then
		{
			_marker setMarkerColor "ColorOrange";
		};
	}
	else
	{
		DEBUG_CODE(X39_GM_Insurgency_var_LastDisabled = _insurgencyObject)
		_insurgencyObject setVariable["X39_GM_Insurgency_enabled", false, true];
		_marker setMarkerColor "ColorGreen";
	};
}
else
{
	_marker setMarkerColor "ColorRed";
};