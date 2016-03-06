	scopeName "_FNCSCOPE_";
	params ["_obj", "_sectionName", "_dmgRcvt", "_sourceUnit", "_projectile"];
		private ["_obj", "_sectionName", "_dmgRcvt", "_sourceUnit", "_projectile", "_allowedCharges", "_explosives"];
	_allowedCharges = ([ ]);
		_allowedCharges pushBack ( "SatchelCharge_Remote_Ammo" );
		_allowedCharges pushBack ( "SatchelCharge_Remote_Ammo_Scripted" );
		_allowedCharges pushBack ( "DemoCharge_Remote_Ammo_Scripted" );
	_explosives = ([ ]);
		_explosives pushBack ( "Bo_GBU12_LGB_MI10" );
		_explosives pushBack ( "Sh_120_HE" );
		_explosives pushBack ( "HelicopterExploBig" );
		_explosives pushBack ( "Bo_GBU12_LGB" );
		_explosives pushBack ( "Bo_Mk82" );
		_explosives pushBack ( "HelicopterExploBig" );
		_explosives pushBack ( "Bo_Mk82" );
		_explosives pushBack ( "Bo_Mk82" );
		_explosives pushBack ( "Bo_GBU12_LGB_MI10" );
		_explosives pushBack ( "Sh_120_HE" );
		_explosives pushBack ( "HelicopterExploBig" );
		_explosives pushBack ( "Bo_GBU12_LGB" );
	if(((_projectile) in _allowedCharges)) then
	{
		private ["_cachePos", "_markers", "_index"];
		_cachePos = (position _obj);
		{
			private ["_it", "_bomb"];
			_it = _x;
			_bomb = ((_it) createVehicle [ ((_cachePos select ( 0 )) + (random ( 10 )) - 5) , ((_cachePos select ( 1 )) + (random ( 10 )) - 5) , ((_cachePos select ( 2 )) + (random ( 10 )) - 5) ]);
			_bomb setPos [ ((_cachePos select ( 0 )) + (random ( 10 )) - 5) , ((_cachePos select ( 1 )) + (random ( 10 )) - 5) , ((_cachePos select ( 2 )) + (random ( 10 )) - 5) ];
			_bomb setVelocity [ ((random ( 10 )) - 5) , ((random ( 10 )) - 5) , ((random ( 20 )) - 60) ];
		} foreach _explosives;
		(([ ])) remoteExec [("X39_Insurgency_AmmoCache_fnc_MP_BoxDestroyed"), true, false];
		_markers = ([] call {private "___tmp___"; ___tmp___ = (_obj); ___tmp___ = (___tmp___ getVariable ( "markers" )); ___tmp___});
		{
			private "_marker";
			_marker = _x;
			deleteMarker _marker;
		} foreach _markers;
		_index = 0;
		{
			private "_cache";
			scopeName "_LOOPSCOPE_";
			_cache = _x;
			if((((_cache select 4)) isEqualTo (_obj))) then
			{
				breakOut "_LOOPSCOPE_";
			};
			5 set [5, (5) + 1];
		} foreach GVAR_GVARS_AmmoCaches;
		GVAR_GVARS_AmmoCaches deleteAt ( (_index) );
		publicVariable (("GVAR_GVARS_AmmoCaches"));
		deleteVehicle _obj;
	};
	0 breakOut "_FNCSCOPE_";
