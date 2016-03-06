	scopeName "_FNCSCOPE_";
	systemChat ((format ["%1/%2 caches remaining", (count GVAR_GVARS_AmmoCaches), (GVAR_GVARS_AmmoCachesInitialCount)]));
	if(((count GVAR_GVARS_AmmoCaches) isEqualTo 0)) then
	{
		["END1"] call BIS_fnc_endMission;
	};
