#include "\X39_XLib_Core\default.hpp"
/**
 *	Returns all houses on a map
 *
 *	@ParamsCount 0 to 5
 *	@Param1 - SCALAR	- default: -1, overrides automatic receive of map size (required for older maps or unsupported ones)
 *	@Param2 - SCALAR	- default: 1000, grid size (can slow/speed up calculation speed)
 *	@Param3 - BOOL		- default: true, defines if the entire grid should be covered by a single search or not (has impact on speed) if false there can still be duplicates but will reduce the chance for them greatly!
 *	@Param4 - BOOL		- default: false, defines if a duplication check should be performed (will slow calculation speed with 'n^2 * timePerGrid')
 *	@Return - ARRAY	- array containing all objects innerhiting from "house" class
 *	@Author - X39|Cpt. HM Murdock
 */
private ["_worldPath", "_mapSize", "_mapSize", "_returnValue", "_gridSize", "_searchRadius", "_coverEntireGrid", "_checkForDuplicates", "_fnc_searchGrids", "_scriptHandles", "_i"];
_fnc_searchGrids = {// _this = SCALAR (XOffset)
	private["_i", "_array"];
	_array = [];
	for "_i" from 0 to (_mapSize / _gridSize) do
	{
		_array = _array + nearestObjects[[_this, _i * _gridSize, 0], ["house"], _searchRadius];
	};
	sleep 0.00001;
	if(_checkForDuplicates) then
	{
		{
			if(_returnValue find _x == -1) then
			{
				_returnValue set [count _returnValue, _x];
			};
			false
		}count _array;
	}
	else
	{
		_returnValue = _returnValue + _array;
	};
};
_mapSize = [_this, 0, -1, [0]] call BIS_fnc_param;
_gridSize = [_this, 1, 1000, [0]] call BIS_fnc_param;
_coverEntireGrid = [_this, 2, true, [false]] call BIS_fnc_param;
_checkForDuplicates = [_this, 3, false, [false]] call BIS_fnc_Param;
_returnValue = [];
_scriptHandles = [];


if(_mapSize == -1) then
{
	_mapSize = [true] call X39_XLib_fnc_getMapSize;
	if(_mapSize == -1) exitWith
	{
		return _returnValue;
	};
};
if(_gridSize < 0) exitWith { ["Gridsize is not allowed to be negative!"] call BIS_fnc_HALT; return _returnValue };
//v2 * a <-- get diag. of square
if(_coverEntireGrid) then
{
	_searchRadius = ((sqrt 2) * _gridSize) / 2;
}
else
{
	_searchRadius = _gridSize / 2;
};

/*************
* Run search *
*************/
for "_i" from 0 to (_mapSize / _gridSize) do
{
	(_i * _gridSize) call _fnc_searchGrids;
};
{
	waitUntil{sleep 0.00001;scriptDone _x};
	false
}count _scriptHandles;
return _returnValue