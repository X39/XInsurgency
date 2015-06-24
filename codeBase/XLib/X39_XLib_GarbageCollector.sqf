#include "\X39_XLib_Modules\default.hpp"
if(!isServer) exitWith {};
_res = (_this select 0) spawn {
	private["_checkRate", "_checkDeadUnits", "_checkDroppedItems", "_checkEmptyGroups", "_deadUnits", "_droppedItems"];
	_checkRate			= (_this getVariable "checkRate");
	_checkDeadUnits		= (_this getVariable "checkDeadUnits") call X39_XLib_fnc_IntToBool;
	_checkDroppedItems	= (_this getVariable "checkDroppedItems") call X39_XLib_fnc_IntToBool;
	_checkEmptyGroups	= (_this getVariable "checkEmptyGroups") call X39_XLib_fnc_IntToBool;
	_deadUnits = [];
	_droppedItems = [];
	_keepGroups = [];
	if(!isNil "X39_GM_Insurgency_var_globalGroup") then
	{
		_keepGroups set[count _keepGroups, X39_GM_Insurgency_var_globalGroup];
	};
	while{true} do
	{
		if(_checkDeadUnits) then
		{ //remove dead units
			{
				if(typeName _x != "SCALAR") then
				{
					if(!isNull _x) then
					{
						deleteVehicle _x;
					};
				};
				false
			}count _deadUnits;
			{
				_index = _deadUnits find -1;
				if(_index == -1) then
				{
					_index = count _deadUnits;
				};
				_deadUnits set [_index, _x];
				false
			}count allDead;
		};
		if(_checkDroppedItems) then
		{ //remove dropped items
			{
				if(typeName _x != "SCALAR") then
				{
					if(!isNull _x) then
					{
						deleteVehicle _x;
					};
				};
				false
			}count _droppedItems;
			{
				_index = _droppedItems find -1;
				if(_index == -1) then
				{
					_index = count _droppedItems;
				};
				_droppedItems set [_index, _x];
				false
			}count (allMissionObjects "GroundWeaponHolder");
		};
		if(_checkEmptyGroups) then
		{ //remove empty groups
			{
				if(count (units _x) <= 0) then
				{
					if(!(_x in _keepGroups)) then
					{
						deleteGroup _x;
					};
				};
				false
			}count allGroups;
		};
		sleep _checkRate;
	};
};
