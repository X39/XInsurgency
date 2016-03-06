	scopeName "_FNCSCOPE_";
	params ["___obj___", "_man"];
		private ["_man", "_arr"];
	_arr = ([___obj___] call X39_Insurgency_Square_fnc_getLocalUnits);
		_arr pushBack ( (_man) );
		[___obj___, (_arr)] call X39_Insurgency_Square_fnc_setLocalUnits;
