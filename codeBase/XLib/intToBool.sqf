/**
 *	Converts input int to bool
 *	NOTE:
 *	0 = false
 *	>0 = true
 *	
 *	Example:
 *		1 call X39_XLib_fnc_intToBool;
 *
 *	@ParamsCount - 1
 *	@Param1 - int - N/A
 *	@Return - boolean - returns true if Param1 >= 1. If input is invalid could be returned (or false its unexpected behaviour)!
 *	@Author - X39|Cpt. HM Murdock
 */
private["_res"];
_res = false;
if(_this > 0) then
{
	_res = true;
};
_res