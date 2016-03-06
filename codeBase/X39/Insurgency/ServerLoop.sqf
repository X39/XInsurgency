	scopeName "_FNCSCOPE_";
	while {true} do
	{
		private ["_playerUIDs", "_arr"];
		((GVAR_GVARS_missionGroup)) setCombatMode ("RED");
		((GVAR_GVARS_missionGroup)) setBehaviour ("COMBAT");
		_playerUIDs = ([ ]);
		_playerUIDs pushBack ( "NaN" );
		_arr = (allPlayers);
		{
			private "_player";
			_player = _x;
			_playerUIDs pushBack ( (getPlayerUID ((_player))) );
		} foreach _arr;
		_arr = (allUnits);
		{
			private ["_it", "_uid"];
			_it = _x;
			_uid = ([] call {private "___tmp___"; ___tmp___ = (_it); ___tmp___ = (___tmp___ getVariable [ "owner" , "NaN" ]); ___tmp___});
			if(!(((_uid) in _playerUIDs))) then
			{
				deleteVehicle _it;
			};
		} foreach _arr;
		sleep ( 5 );
	};
