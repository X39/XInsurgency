	scopeName "_FNCSCOPE_";
		private ["_noFilter", "_currentSquaresInPool"];
	while {!((GVAR_GVARS_missionContext getVariable [ "MissionReady" , false ]))} do
	{
		sleep ( 1 );
	};
	_noFilter = ([ ]);
		_noFilter pushBack ( "Land_HelipadEmpty_F" );
	_currentSquaresInPool = ([ ]);
	while {true} do
	{
		private "_player";
		_player = (player);
		if((alive ((_player)))) then
		{
			private ["_tmp", "_handledSquares", "_toRemove", "_tmpFilter", "_arr", "_i"];
			_tmp = (nearestObjects [(_player), (_noFilter), (GVAR_GVARS_DespawnDistance)]);
			_handledSquares = ([ ]);
			{
				private "_it";
				_it = _x;
				if(([(_it)] call X39_Insurgency_Square_fnc_isSquare)) then
				{
					private "_square";
					_square = ([] call {private "___tmp___"; ___tmp___ = (_it); ___tmp___ = (___tmp___ getVariable ( "square" )); ___tmp___});
					[_square] call X39_Insurgency_Square_fnc_update;
					_handledSquares pushBack ( (_square) );
					if(!(((_square) in _currentSquaresInPool))) then
					{
						_currentSquaresInPool pushBack ( (_square) );
					};
				};
			} foreach _tmp;
			_toRemove = ([ ]);
				_i = 0;
			while {((_i) < (count _currentSquaresInPool))} do
			{
				private "_sq";
				_sq = (_currentSquaresInPool select ( (_i) ));
				if(!(((_sq) in _handledSquares))) then
				{
					if(([_sq] call X39_Insurgency_Square_fnc_update)) then
					{
						_toRemove pushBack ( (_i) );
					};
				};
				_i = (_i) + 1;
			};
			((_toRemove)) sort (false);
			{
				private "_index";
				_index = _x;
				_currentSquaresInPool deleteAt ( (_index) );
			} foreach _toRemove;
			_tmpFilter = ([ ]);
			_tmpFilter pushBack ( "Land_File1_F" );
			_arr = (nearestObjects [(_player), (_tmpFilter), 2]);
			if(((count _arr) > 0)) then
			{
				{
					private "_intel";
					_intel = _x;
					if(([] call {private "___tmp___"; ___tmp___ = (_intel); ___tmp___ = (___tmp___ getVariable [ "isIntel" , false ]); ___tmp___})) then
					{
						private ["_lastDistance", "_lastCache", "_markers", "_dstnc", "_marker", "_xPos", "_yPos", "_tmpArray"];
						deleteVehicle _intel;
						_lastDistance = (worldSize);
						{
							private "_cache";
							_cache = _x;
							if((((((_cache select 4))) distance ((_player))) < (_lastDistance))) then
							{
								_lastDistance = ((((_cache select 4))) distance ((_player)));
								_lastCache = (_cache);
							};
						} foreach GVAR_GVARS_AmmoCaches;
						_markers = ([_lastCache] call X39_Insurgency_AmmoCache_fnc_getMarkers);
						if(((count _markers) > (count GVAR_GVARS_AmmoCachesIntelDistances))) then
						{
							_dstnc = (GVAR_GVARS_AmmoCachesIntelDistances select ( ((count GVAR_GVARS_AmmoCachesIntelDistances) - 1) ));
						}
						else
						{
							_dstnc = (GVAR_GVARS_AmmoCachesIntelDistances select ( (count _markers) ));
						};
						_marker = (createMarker [ (format ["X39OBJ_%1%2", (position (_lastCache select 4)), (count _markers)]) , [ 0 , 0 , 0 ] ]);
						_marker setMarkerShape ( ("ICON") );
						_marker setMarkerType ( "mil_unknown" );
						_marker setMarkerText ( (str ((_dstnc))) );
						_marker setMarkerSize [ 0.5 , 0.5 ];
						_xPos = ((random ( ((_dstnc) / 2) )) + ((_dstnc) / 2));
						if(((random ( 2 )) > 1)) then
						{
							_xPos = ((_xPos) * -1);
						};
						_yPos = ((random ( ((_dstnc) / 2) )) + ((_dstnc) / 2));
						if(((random ( 2 )) > 1)) then
						{
							_yPos = ((_yPos) * -1);
						};
						_marker setMarkerPos [ (([] call {private "___tmp___"; ___tmp___ = (_lastCache); ___tmp___ = (position (___tmp___ select 4)); ___tmp___ = (___tmp___ select 0); ___tmp___}) + (_xPos)) , (([] call {private "___tmp___"; ___tmp___ = (_lastCache); ___tmp___ = (position (___tmp___ select 4)); ___tmp___ = (___tmp___ select 1); ___tmp___}) + (_yPos)) , 0 ];
						_marker setMarkerColor ( ("ColorRed") );
						_marker setMarkerAlpha ( 0.75 );
						_markers pushBack ( (_marker) );
						[_lastCache, (_markers)] call X39_Insurgency_AmmoCache_fnc_setMarkers;
						_tmpArray = ([ ]);
						_tmpArray pushBack ( "New intel was located!" );
						_tmpArray pushBack ( (["mil_warning"] call BIS_fnc_textureMarker) );
						["IntelAdded", (_tmpArray)] remoteExec [(""), true, false];
					};
				} foreach _arr;
			};
		};
		sleep ( 0.5 );
	};
