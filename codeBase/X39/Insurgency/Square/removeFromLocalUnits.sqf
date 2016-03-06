	scopeName "_FNCSCOPE_";
	params ["___obj___", "_man"];
		private ["_man", "_arr", "_index"];
	_arr = ([___obj___] call X39_Insurgency_Square_fnc_getLocalUnits);
	_index = (_arr find ( (_man) ));
	if(((_index) < 0)) then
	{
		throw (["UnitNotFound"] call {
		scopeName "_FNCSCOPE_";
		params ["_message"];
		private ["___obj___fnctoString1", "___obj___fncequals1"];
		___obj___fnctoString1 = {
		scopeName "_FNCSCOPE_";
		params ["___obj___"];
	(str ((___obj___))) breakOut "_FNCSCOPE_";
		};
		___obj___fncequals1 = {
		scopeName "_FNCSCOPE_";
		params ["___obj___", "_obj"];
			private "_obj";
	(((___obj___)) isEqualTo ((_obj))) breakOut "_FNCSCOPE_";
		};
		___obj___ = [["object", "Exception"], ["toString", "equals", "Message"], ___obj___fnctoString1, ___obj___fncequals1, nil];
			private "_message";
	___obj___ set [4, (_message)];
		___obj___
});
	};
		_arr deleteAt ( (_index) );
		[___obj___, (_arr)] call X39_Insurgency_Square_fnc_setLocalUnits;
