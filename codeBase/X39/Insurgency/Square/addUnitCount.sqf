	scopeName "_FNCSCOPE_";
	params ["___obj___", "_i"];
		private "_i";
		[___obj___, (([___obj___] call X39_Insurgency_Square_fnc_getUnitCount) + (_i))] call X39_Insurgency_Square_fnc_setUnitCount;
