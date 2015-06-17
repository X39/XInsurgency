#include "default.hpp"
if(isDedicated) exitWith {};
[] spawn {
	waitUntil{!isNull player};
	waitUntil{alive player};
	waitUntil{X39_GM_Insurgency_var_serverDone};
	private["_insObjects", "_index", "_obj", "_res", "_insObj"];
	while{true} do
	{
		if(side player != X39_GM_Insurgency_var_Side || X39_GM_Insurgency_var_enemySideSpawning) then
		{
			DEBUG_LOG("InsurgencyWorker: Starting new roll")
			DEBUG_LOG("InsurgencyWorker: Dumping Variables:")
			DEBUG_CODE(diag_log format["	- X39_GM_Insurgency_var_SpawnedUnits = %1;" COMMA X39_GM_Insurgency_var_SpawnedUnits])
			DEBUG_CODE(diag_log format["	- allGroups = %1;" COMMA allGroups])
			DEBUG_LOG("InsurgencyWorker: Searching close InsurgencyModules...")
			
			_insObjects = nearestObjects [position player, ["Land_HelipadEmpty_F"], X39_GM_Insurgency_var_spawnRange];
			DEBUG_CODE(diag_log format["InsurgencyWorker: Found %1" COMMA count _insObjects])
			{
				if(_x getVariable ["X39_GM_Insurgency_enabled", false]) then
				{
					DEBUG_CODE(diag_log format["InsurgencyWorker: Handling %1 (position: %2)" COMMA _x COMMA position _x])
					if({if(typeName _x == "SCALAR") then { false } else { true }} count X39_GM_Insurgency_var_SpawnedUnits < X39_GM_Insurgency_var_MaxUnitsPerPlayer) then
					{
						DEBUG_LOG("InsurgencyWorker: Spawning new unit")
						_obj = _x call X39_GM_Insurgency_fnc_createUnit;
						if(!isNull _obj) then
						{
							DEBUG_CODE(diag_log format["InsurgencyWorker: Spawned new unit: '%1'" COMMA _obj])
							_x call X39_GM_Insurgency_fnc_updateInsurgencyObject;
							_index = X39_GM_Insurgency_var_SpawnedUnits find -1;
							if(_index == -1) then
							{
								_index = count X39_GM_Insurgency_var_SpawnedUnits;
							};
							X39_GM_Insurgency_var_SpawnedUnits set [_index, _obj];
						}DEBUG_CODE(else{diag_log "InsurgencyWorker: Spawning failed ... NULL object received from function"});
					};
				};
				false
			}count _insObjects;
			DEBUG_LOG("InsurgencyWorker: Validating spawned units")
			{
				if(typeName _x != "SCALAR") then
				{
					if(isNull _x) then
					{
						X39_GM_Insurgency_var_SpawnedUnits set[_forEachIndex, -1];
						DEBUG_LOG("InsurgencyWorker: Handled NULL object")
					}
					else
					{
						DEBUG_CODE(diag_log format["InsurgencyWorker: Validating %1" COMMA _x])
						if(typeOf _x != "Land_HelipadEmpty_F") then
						{
							_insObj = _x getVariable ["X39_GM_Insurgency_InsurgencyObject", objNull];
							if(!alive _x) then
							{
								DEBUG_CODE(diag_log format["InsurgencyWorker: Unit '%1' is dead, Handling ..." COMMA _x])
								X39_GM_Insurgency_var_SpawnedUnits set [_forEachIndex, _insObj];
								_res = [_insObj, _forEachIndex] spawn {
									DEBUG_CODE(diag_log format["InsurgencyWorkerASYNC: Starting ASYNC handle for '%1'" COMMA _this])
									sleep X39_GM_Insurgency_var_DeathTimeOut;
									X39_GM_Insurgency_var_SpawnedUnits set [_this select 1, -1];
									_insObj = _this select 0;
									_insObj setVariable["X39_GM_Insurgency_spawnedUnitsCount", (_insObj getVariable["X39_GM_Insurgency_spawnedUnitsCount", 0]) - 1];
									DEBUG_CODE(diag_log format["InsurgencyWorkerASYNC: Ending ASYNC handle for '%1'" COMMA _this])
								};
								_insObj call X39_GM_Insurgency_fnc_updateInsurgencyObject;
							}
							else
							{
								DEBUG_CODE(diag_log format["InsurgencyWorker: Unit '%1' is alive, Handling ..." COMMA _x])
								if(player distance (_insObj) > X39_GM_Insurgency_var_spawnRange) then
								{
									DEBUG_CODE(diag_log format["InsurgencyWorker: InsurgencyObject '%1' is out of range, despawning unit '%2'" COMMA _insObj COMMA _x])
									_x call X39_GM_Insurgency_fnc_removeUnit;
									X39_GM_Insurgency_var_SpawnedUnits set[_forEachIndex, -1];
									_insObj call X39_GM_Insurgency_fnc_updateInsurgencyObject;
								}
								else
								{
									if(_x distance (_insObj) >= X39_GM_Insurgency_var_maxDistanceToUnitGrid) then
									{
										DEBUG_CODE(diag_log format["InsurgencyWorker: Unit '%1' is out of InsurgencyObject range ..." COMMA _x])
										_x call X39_GM_Insurgency_fnc_removeUnit;
										_obj = objNull;
										_obj = _insObj call X39_GM_Insurgency_fnc_createUnit;
										if(isNull _obj) then
										{
											DEBUG_CODE(diag_log "InsurgencyWorker: Received NULL unit while respawning unit!";)
											X39_GM_Insurgency_var_SpawnedUnits set[_forEachIndex, -1];
											_insObj call X39_GM_Insurgency_fnc_updateInsurgencyObject;
										}
										else
										{
											X39_GM_Insurgency_var_SpawnedUnits set[_forEachIndex, _obj];
											DEBUG_CODE(diag_log format["InsurgencyWorker: Unit has been respawned (new unit: '%1')" COMMA _obj])
										};
									}
									else
									{
										if(_x distance player >= X39_GM_Insurgency_var_maxDistanceToOwner) then
										{
											DEBUG_CODE(diag_log format["InsurgencyWorker: Unit '%1' is out of player range, despawning" COMMA _x])
											_x call X39_GM_Insurgency_fnc_removeUnit;
											_insObj call X39_GM_Insurgency_fnc_updateInsurgencyObject;
											X39_GM_Insurgency_var_SpawnedUnits set[_forEachIndex, -1];
										};
									};
								};
							};
						}
						else
						{
							if!(_x getVariable ["X39_GM_Insurgency_enabled", false]) then
							{
								X39_GM_Insurgency_var_SpawnedUnits set[_forEachIndex, -1];
							};
						};
					};
				};
			}forEach X39_GM_Insurgency_var_SpawnedUnits;
			DEBUG_LOG("InsurgencyWorker: Roll is over")
		};
		sleep 0.00001;
	};
	diag_log "InsurgencyWorker: EXIT";
	systemChat "InsurgencyWorker: EXIT";
};