	scopeName "_FNCSCOPE_";
	params ["___obj___"];
	if(((___obj___ select 8))) then
	{
		true breakOut "_FNCSCOPE_";
	};
	if(((((player)) distance (((___obj___ select 7)))) > (GVAR_GVARS_DespawnDistance))) then
	{
		private "_localUnits";
		_localUnits = ([___obj___] call X39_Insurgency_Square_fnc_getLocalUnits);
		{
			private "_v";
			_v = _x;
			deleteVehicle _v;
			[___obj___, -1] call X39_Insurgency_Square_fnc_addUnitCount;
		} foreach _localUnits;
		[___obj___, ([ ])] call X39_Insurgency_Square_fnc_setLocalUnits;
		true breakOut "_FNCSCOPE_";
	}
	else
	{
		private ["_curUnitCount", "_quota", "_arr", "_anyAlive"];
		_curUnitCount = ([___obj___] call X39_Insurgency_Square_fnc_getUnitCount);
		_quota = (((___obj___ select 6)) * (GVAR_GVARS_HouseUnitQuota));
		if(((_quota) > (GVAR_GVARS_MaxUnitsPerSquare))) then
		{
			_quota = (GVAR_GVARS_MaxUnitsPerSquare);
		};
		if(((_curUnitCount) < (_quota))) then
		{
			[___obj___] call X39_Insurgency_Square_fnc_createUnit;
		};
		_arr = ([___obj___] call X39_Insurgency_Square_fnc_getLocalUnits);
		_anyAlive = false;
		{
			private "_it";
			_it = _x;
			if(!((alive _it))) then
			{
				private "_t";
				_t = (((_it)) getVariable ["KillTime", (time)]);
				if(((GVAR_GVARS_RespawnTimeout) < ((time) - (_t)))) then
				{
					[___obj___, -1] call X39_Insurgency_Square_fnc_addUnitCount;
					[___obj___, (_it)] call X39_Insurgency_Square_fnc_removeFromLocalUnits;
					deleteVehicle _it;
					if(([___obj___] call X39_Insurgency_Square_fnc_isValid)) then
					{
						[___obj___] call X39_Insurgency_Square_fnc_createUnit;
					};
				};
			}
			else
			{
				_anyAlive = true;
			};
		} foreach _arr;
		if((!((_anyAlive)) && {((count _arr) > 0)})) then
		{
			[___obj___, true] call X39_Insurgency_Square_fnc_setCleared;
			true breakOut "_FNCSCOPE_";
		};
		false breakOut "_FNCSCOPE_";
	};
