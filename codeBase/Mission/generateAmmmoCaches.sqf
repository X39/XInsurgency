	scopeName "_FNCSCOPE_";
	params ["_count", "_range"];
		private ["_count", "_range", "_mapSize", "_curRange", "_i"];
	_mapSize = (worldSize);
	GVAR_GVARS_AmmoCaches = ([ ]);
	GVAR_GVARS_AmmoCachesInitialCount = (_count);
		_i = 0;
	while {((_i) < (_count))} do
	{
		private "_tmpToFind";
		scopeName "_LOOPSCOPE_";
		_curRange = (_range);
		_tmpToFind = ([ ]);
		_tmpToFind pushBack ( "house" );
		while {true} do
		{
			private ["_tmpArray", "_house", "_flag"];
			scopeName "_LOOPSCOPE_";
			_tmpArray = ([ ]);
			while {((count _tmpArray) isEqualTo 0)} do
			{
				_tmpArray = (nearestObjects [([ (random ( (_mapSize) )) , (random ( (_mapSize) )) , 0 ]), (_tmpToFind), 100]);
			};
			_house = (_tmpArray select ( (floor ( (random ( (count _tmpArray) )) )) ));
			_flag = false;
			{
				private "_it";
				_it = _x;
				if((((((_it select 4))) distance ((_house))) < (_curRange))) then
				{
					_flag = true;
					_curRange = (_curRange) - 1;
				};
			} foreach GVAR_GVARS_AmmoCaches;
			if(!((_flag))) then
			{
				private "_positions";
				_positions = ([(_house)] call {private [ "_arr" , "_i" , "_ref" ]; _arr = [ ]; _ref = [ 0 , 0 , 0 ]; _i = 0; while { ! ( ( (_this select 0) buildingPos _i ) isEqualTo _ref ) } do { _arr pushBack ( (_this select 0) buildingPos _i ); _i = _i + 1; }; _arr});
				if(((count _positions) > 0)) then
				{
					private ["_position", "_cache"];
					_position = (_positions select ( (floor ( (random ( (count _positions) )) )) ));
					_cache = ([(_position select 0), (_position select 1), ((_position select 2) + 0.001)] call X39_Insurgency_AmmoCache_fnc_AmmoCache);
					GVAR_GVARS_AmmoCaches pushBack ( (_cache) );
					breakOut "_LOOPSCOPE_";
				};
			};
		};
		_i = (_i) + 1;
	};
	publicVariable (("GVAR_GVARS_AmmoCaches"));
	publicVariable (("GVAR_GVARS_AmmoCachesInitialCount"));
