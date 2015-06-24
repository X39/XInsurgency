#include "default.hpp"
/**
 *	Returns all houses on a map sorted by grids
 *		ArrayStructure:
 *			[[(X0|Y0) array, (X0|Y1) array, (X0|Yn) array], [(X1|Y0) array, (X1|Y1) array, (X1|Yn) array], [(Xn|Y0) array, (Xn|Y1) array, (Xn|Yn) array]]
 *
 *	@ParamsCount 0 to 5
 *	@Param1 - SCALAR	- default: -1, overrides automatic receive of map size (required for older maps or unsupported ones)
 *	@Param2 - SCALAR	- default: 1000, grid size (can slow/speed up calculation speed)
 *	@Param3 - BOOL		- default: false, defines if the entire grid should be covered by a single search or not (has impact on speed) if false there can still be duplicates but will reduce the chance for them greatly!
 *	@Param4 - SCALAR	- default: 0, min spawn positions a building needs to be added to the return value
 *	@Param5 - BOOL		- default: false, include position of given grid as POS3D array ([X,Y,Z])
 *	@Param6 - BOOL		- default: false, exclude empty house objects
 *	@Return - ARRAY	- array containing all objects innerhiting from "house" class
 *	@Author - X39|Cpt. HM Murdock
 */
private ["_worldPath", "_tmpArray", "_mapSize", "_mapSize", "_returnValue", "_gridSize", "_searchRadius", "_coverEntireGrid", "_fnc_searchGrids", "_scriptHandles", "_i", "_minSpawnPositions", "_includeGridCoords", "_excludeEmptyHouseArrays"];
_fnc_searchGrids = {// _this = SCALAR (XOffset)
	private["_i", "_array", "_tmpArray", "_tmpArrayCount"];
	_array = [];
	for "_i" from 0 to (_mapSize / _gridSize) do
	{
		if(_includeGridCoords) then
		{
			_tmpArray = [[_this + (_gridSize / 2), _i * _gridSize + (_gridSize / 2), 0]];
		}
		else
		{
			_tmpArray = [];
		};
		{
			if(_minSpawnPositions <= 0 || {str (_x buildingPos (_minSpawnPositions - 1)) != "[0,0,0]"}) then
			{
				_tmpArray set [count _tmpArray, _x];
			};
			false
		}count nearestObjects[[_this + (_gridSize / 2), _i * _gridSize + (_gridSize / 2), 0], ["house"], _searchRadius];
		_tmpArrayCount = count _tmpArray;
		if(!_excludeEmptyHouseArrays || {_tmpArrayCount > 0})  then
		{
			if(_includeGridCoords && {_tmpArrayCount > 1} || !_includeGridCoords) then
			{
				_array set[count _array, _tmpArray];
			};
		};
	};
	sleep 0.00001;
	_array
};
_mapSize					= [_this, 0, -1,	[0]]		call BIS_fnc_param;
_gridSize					= [_this, 1, 1000,	[0]]		call BIS_fnc_param;
_coverEntireGrid			= [_this, 2, false, [false]]	call BIS_fnc_param;
_minSpawnPositions			= [_this, 3, -1,	[0]]		call BIS_fnc_param;
_includeGridCoords			= [_this, 4, false, [false]]	call BIS_fnc_param;
_excludeEmptyHouseArrays	= [_this, 5, false, [false]]	call BIS_fnc_param;
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
//√2 * a <-- get diag. of square
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
	_tmpArray = (_i * _gridSize) call _fnc_searchGrids;
	if(!_excludeEmptyHouseArrays || {count _tmpArray > 0})  then
	{
		_returnValue set[count _returnValue, _tmpArray];
	};
};
{
	waitUntil{sleep 0.00001;scriptDone _x};
	false
}count _scriptHandles;
return _returnValue