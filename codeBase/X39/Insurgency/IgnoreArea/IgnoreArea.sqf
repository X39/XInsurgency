	scopeName "_FNCSCOPE_";
	params ["_topLeftVec", "_bottomRightVec"];
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
	___obj___ = [["object", "X39::Insurgency::IgnoreArea"], ["toString", "equals", "topLeft", "botRight"], ___obj___fnctoString, ___obj___fncequals, nil, nil];
		private ["_topLeftVec", "_bottomRightVec"];
	___obj___ set [4, (_topLeftVec)];
	___obj___ set [5, (_bottomRightVec)];
	___obj___