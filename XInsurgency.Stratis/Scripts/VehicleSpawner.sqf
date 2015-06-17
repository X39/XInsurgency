if(typeName (_this select 0) == "STRING") then
{
	switch((_this select 0)) do
	{
		case "init": {
			private ["_types", "_spawnerObject", "_spawnLocationObject", "_config", "_vehCfg", "_icon"];
			_types = if(typeName (_this select 1) == "STRING") then { [(_this select 1)] } else { (_this select 1) };
			_spawnerObject = _this select 2;
			_spawnLocationObject = _this select 3;
			_config = configFile >> "CfgVehicles";
			
			
			_spawnerObject enableSimulation false;
			
			_spawnerObject addAction ["Despawn", {
					_objs = nearestObjects[position (_this select 3 select 1 select 2), ["AllVehicles"], 10];
					{
						if(_x getVariable["wasSpawned", false]) then
						{
							[["despawnVehicle", _x], _this select 3 select 0, false] call BIS_fnc_MP;
						};
						false
					}count _objs;
				},
				[_fnc_scriptName, ["spawnVehicle", configName _vehCfg, _spawnLocationObject]],
				6,
				true,
				false,
				"",
				"Mission_var_VehicleSpawnerEnabled"
			];
			
			for "_i" from 0 to ((count _config) - 1) do
			{
				_vehCfg = _config select _i;
				if(isClass _vehCfg) then
				{
					if(getNumber (_vehCfg >> "scope") == 2 && {{(configName _vehCfg isKindOf _x)} count _types > 0}) then
					{
						_icon = getText (_vehCfg >> "icon");
						if(_icon select [(count _icon) - 3, 3] == "paa") then
						{
							private "_color";
							switch (getNumber (_vehCfg >> "side")) do
							{
								default { _color = "#FFFFFF"; };
								case 0: { _color = [east] call BIS_fnc_sideColor call BIS_fnc_colorRGBtoHTML; }; //CSAT
								case 1: { _color = [west] call BIS_fnc_sideColor call BIS_fnc_colorRGBtoHTML; }; //NATO
								case 2: { _color = [resistance] call BIS_fnc_sideColor call BIS_fnc_colorRGBtoHTML; }; //GUERILLA
								case 3: { _color = [civilian] call BIS_fnc_sideColor call BIS_fnc_colorRGBtoHTML; }; //CIVILIAN
							};
							_spawnerObject addAction [format["<img 
									size='3' 
									color='%3' 
									shadow='2' 
									image='%1'
								/>%2", _icon, getText (_vehCfg >> "displayName"), _color], {
									if(count nearestObjects[position (_this select 3 select 1 select 2), ["AllVehicles"], 10] > 0) then
									{
										["TaskFailed",["", "Spawn area is blocked"]] call bis_fnc_showNotification;  
									}
									else
									{
										[_this select 3 select 1, _this select 3 select 0, false] call BIS_fnc_MP;
									};
								},
								[_fnc_scriptName, ["spawnVehicle", configName _vehCfg, _spawnLocationObject]],
								6,
								false,
								true,
								"",
								"Mission_var_VehicleSpawnerEnabled"
							];
						};
					};
				};
			};
		};
		case "spawnVehicle": {
		private "_heli";
			_heli = createVehicle [
				_this select 1,
				position (_this select 2),
				[],
				0,
				"CAN_COLLIDE"
			];
			_heli setDir (direction (_this select 2));
			_heli setVectorUp surfaceNormal position (_this select 2);
			_heli setVariable["wasSpawned", true, true];
		};
		case "despawnVehicle": {
		private "_heli";
			_obj = _this select 1;
			if(_obj getVariable["wasSpawned", false]) then
			{
				deleteVehicle _obj;
			};
		};
	};
}
else
{
	["%1 cant be callen without any args", _fnc_scriptName] call BIS_fnc_HALT;
};