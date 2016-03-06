	scopeName "_FNCSCOPE_";
	params ["_x", "_y", "_z"];
	private ["___obj___fnctoString", "___obj___fncequals"];
	___obj___fnctoString = {
		scopeName "_FNCSCOPE_";
		params ["___obj___"];
	(str ((___obj___))) breakOut "_FNCSCOPE_";
	};
	___obj___fncequals = {
		scopeName "_FNCSCOPE_";
		params ["___obj___", "_obj"];
			private "_obj";
	(((___obj___)) isEqualTo ((_obj))) breakOut "_FNCSCOPE_";
	};
	___obj___ = [["object", "X39::Insurgency::AmmoCache"], ["toString", "equals", "veh", "index"], ___obj___fnctoString, ___obj___fncequals, nil, nil];
		private ["_x", "_y", "_z"];
	___obj___ set [4, ("O_supplyCrate_F" createVehicle [ (_x) , (_y) , ((_z) + 0.001) ])];
		(___obj___ select 4) setPos [ (_x) , (_y) , (_z) ];
	(((___obj___ select 4))) addEventHandler ["HandleDamage", (((missionNamespace)) getVariable (("X39_Insurgency_AmmoCache_fnc_EH_HandleDamage")))];
		[___obj___, ([ ])] call X39_Insurgency_AmmoCache_fnc_setMarkers;
	___obj___