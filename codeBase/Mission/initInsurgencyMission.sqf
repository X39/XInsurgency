	scopeName "_FNCSCOPE_";
	params ["_logic", "_side", "_unitClasses", "_markerArray", "_ammoCacheCount", "_ammoCacheDistance"];
		private ["_logic", "_side", "_unitClasses", "_markerArray", "_ammoCacheCount", "_ammoCacheDistance"];
	GVAR_GVARS_unitClasses = (_unitClasses);
	GVAR_GVARS_missionContext = (_logic);
	GVAR_GVARS_AmmoCachesIntelDistances = ([ ]);
		GVAR_GVARS_AmmoCachesIntelDistances pushBack ( 900 );
		GVAR_GVARS_AmmoCachesIntelDistances pushBack ( 750 );
		GVAR_GVARS_AmmoCachesIntelDistances pushBack ( 600 );
		GVAR_GVARS_AmmoCachesIntelDistances pushBack ( 450 );
		GVAR_GVARS_AmmoCachesIntelDistances pushBack ( 300 );
		GVAR_GVARS_AmmoCachesIntelDistances pushBack ( 200 );
		GVAR_GVARS_AmmoCachesIntelDistances pushBack ( 150 );
		GVAR_GVARS_AmmoCachesIntelDistances pushBack ( 100 );
		GVAR_GVARS_AmmoCachesIntelDistances pushBack ( 50 );
	GVAR_GVARS_missionGroup = (createGroup (_side));
	if((isServer)) then
	{
		createCenter ((_side));
		GVAR_GVARS_missionContext setVariable [ "MissionReady" , false , true ];
		{
			private ["_it", "_size", "_pos", "_x", "_y", "_w", "_h", "_topLeft", "_botRight", "_ia"];
			_it = _x;
			_size = (markerSize _it);
			_pos = (markerPos _it);
			_x = (_pos select ( 0 ));
			_y = (_pos select ( 1 ));
			_w = (_size select ( 0 ));
			_h = (_size select ( 1 ));
			_topLeft = ([ ((_x) - (_w)) , ((_y) - (_h)) , 0 ]);
			_botRight = ([ ((_x) + (_w)) , ((_y) + (_h)) , 0 ]);
			_ia = ([(_topLeft), (_botRight)] call X39_Insurgency_IgnoreArea_fnc_IgnoreArea);
			GVAR_GVARS_IgnoreAreas pushBack ( (_ia) );
			deleteMarker _it;
		} foreach _markerArray;
		GVAR_Mission_allSquares = ([] call Mission_fnc_getAllBuildingsOnMap);
		[(_ammoCacheCount), (_ammoCacheDistance)] call Mission_fnc_generateAmmmoCaches;
		GVAR_GVARS_missionContext setVariable [ "MissionReady" , true , true ];
		[] spawn X39_Insurgency_fnc_ServerLoop;
	};
	if(!((isDedicated))) then
	{
		[] spawn X39_Insurgency_fnc_PlayerLoop;
	};
