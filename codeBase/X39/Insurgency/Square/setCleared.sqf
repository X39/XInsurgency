	scopeName "_FNCSCOPE_";
	params ["___obj___", "_flag"];
		private "_flag";
	if((_flag)) then
	{
		___obj___ set [8, true];
		(___obj___ select 4) setMarkerColor ( ("ColorGreen") );
	}
	else
	{
		___obj___ set [8, false];
		(___obj___ select 4) setMarkerColor ( ("ColorRed") );
	};
		[___obj___] call X39_Insurgency_Square_fnc_publish;
