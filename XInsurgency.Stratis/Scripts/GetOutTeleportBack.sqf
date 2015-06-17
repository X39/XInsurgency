_this allowDamage false;
if (!isServer) exitWith {};
_this setVariable["OriginalPosition", position _this];
_this respawnVehicle[0, 0];
_this setVariable ["EH_GetOut", _this addEventHandler ["GetOut", 
{
	_veh = _this select 0;
	if((count (units _veh)) == 0) then 
	{
		_veh setPos (_veh getVariable "OriginalPosition");
		_veh setFuel 1;
		_veh engineOn false;
		_veh setDamage 0;
	};
}]];