	scopeName "_FNCSCOPE_";
	params ["___obj___"];
		private ["_hasPos", "_housesWithPos", "_tmpfix", "_context", "_tmp"];
	_hasPos = false;
	_housesWithPos = ([ ]);
	{
		private ["_it", "_var"];
		_it = _x;
		_var = ([(_it)] call {private [ "_arr" , "_i" , "_ref" ]; _arr = [ ]; _ref = [ 0 , 0 , 0 ]; _i = 0; while { ! ( ( (_this select 0) buildingPos _i ) isEqualTo _ref ) } do { _arr pushBack ( (_this select 0) buildingPos _i ); _i = _i + 1; }; _arr});
		if(((count _var) > 0)) then
		{
			_hasPos = true;
			_housesWithPos pushBack ( (_it) );
		};
		[] call {private "___tmp___"; ___tmp___ = (_it); ___tmp___ = (___tmp___ setVariable [ "positions" , (_var) , true ]);};
	} foreach (___obj___ select 5);
	_tmpfix = ((((___obj___ select 5))) arrayIntersect ((_housesWithPos)));
	___obj___ set [5, (_tmpfix)];
	if(!((_hasPos))) then
	{
		deleteVehicle (___obj___ select 7);
		deleteMarker (___obj___ select 4);
		false breakOut "_FNCSCOPE_";
	};
	_context = ((___obj___ select 7));
		_context setVariable [ "unitCount" , 0 , true ];
	_tmp = ([ ]);
	___obj___ set [6, (count (___obj___ select 5))];
	{
		private "_it2";
		_it2 = _x;
		[] call {private "___tmp___"; ___tmp___ = (_it2); ___tmp___ = (___tmp___ setVariable [ "square" , (___obj___) , true ]);};
	} foreach (___obj___ select 5);
		[___obj___] call X39_Insurgency_Square_fnc_publish;
	true breakOut "_FNCSCOPE_";
