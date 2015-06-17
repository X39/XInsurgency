#include "default.hpp"
/**
 *	creates insurgency gameplay object at desired position
 *
 *	@ParamsCount 2 to 4
 *	@Param1 - ARRAY - POS3D array containing the position
 *	@Param2 - ARRAY - houses for this insurgencyObject
 *	@Param3 - SCALAR - default: 100; Gridsize X
 *	@Param4 - SCALAR - default: 100; Gridsize Y
 *	@Return - OBJECT - insurgencyObject created
 *	@Author - X39|Cpt. HM Murdock
 */
CALLSERVER;
private ["_veh", "_position", "_houses", "_marker", "_gridX", "_gridY"];
//initialize variables
_veh = objNull;
_position = [_this, 0, [], [[]]] call BIS_fnc_param;
_houses = [_this, 1, [], [[]]] call BIS_fnc_param;
_gridX = [_this, 2, 50, [0]] call BIS_fnc_param;
_gridY = [_this, 3, 50, [0]] call BIS_fnc_param;

//validatie parameters
if(count _position != 3) exitWith {diag_log format["position '%1' is not a valid POS3D!", _position]; return _veh};
if(count _houses <= 0) exitWith {diag_log "InsurgencyObject requires at least a single house!"; return _veh};

//do something
_veh = "Land_HelipadEmpty_F" createVehicle _position;
_veh setVariable ["X39_GM_Insurgency", true, true];
//_veh enableSimulationGlobal false;
//_veh = createVehicle ["Land_X39_GM_Insurgency_Module", _position, [], 0, "CAN_COLLIDE"];
_veh setVariable["X39_GM_Insurgency_houses", _houses, true];
_veh setVariable["X39_GM_Insurgency_spawnedUnitsCount", 0];

_marker = createMarker[format["X39_GM_Insurgency_Marker_%1", str _position], _position];
_marker setMarkerShape "RECTANGLE";
_marker setMarkerSize [_gridX, _gridY];
_marker setMarkerColor "ColorRed";
_marker setMarkerAlpha 0.5;
_marker setMarkerBrush "Solid";
_veh setVariable["X39_GM_Insurgency_marker", _marker, true];
_veh setVariable["X39_GM_Insurgency_unitsSpawned", false, true];
_veh setVariable["X39_GM_Insurgency_enabled", true, true];

return _veh