	scopeName "_FNCSCOPE_";
		private ["_arr", "_mapSize", "_i"];
	_arr = ([ ]);
	_mapSize = (worldSize);
		_i = 50;
	while {((_i) < (_mapSize))} do
	{
		private "_j";
		scopeName "_LOOPSCOPE_";
			_j = 50;
		while {((_j) < (_mapSize))} do
		{
			private "_flag";
			scopeName "_LOOPSCOPE_";
			_flag = false;
			{
				private "_it";
				scopeName "_LOOPSCOPE_";
				_it = _x;
				if(([_it, ([ (_i) , (_j) , 0 ])] call X39_Insurgency_IgnoreArea_fnc_contains)) then
				{
					_flag = true;
					breakOut "_LOOPSCOPE_";
				};
			} foreach GVAR_GVARS_IgnoreAreas;
			if(!((_flag))) then
			{
				private ["_tmpToFind", "_tmpArray"];
				_tmpToFind = ([ ]);
				_tmpToFind pushBack ( "house" );
				_tmpArray = (nearestObjects [([ (_i) , (_j) , 0 ]), (_tmpToFind), 70.7106781185]);
				if(((count _tmpArray) > 0)) then
				{
					private "_square";
					_square = ([(_i), (_j)] call X39_Insurgency_Square_fnc_Square);
					(_square select 5) append ( (_tmpArray) );
					if(([_square] call X39_Insurgency_Square_fnc_prepare)) then
					{
						_arr pushBack ( (_square) );
					};
				};
			};
			_j = (_j) + (100);
		};
		_i = (_i) + (100);
	};
	(_arr) breakOut "_FNCSCOPE_";
