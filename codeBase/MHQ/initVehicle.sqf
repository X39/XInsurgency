/*
 * Params:
 *		0 - MHQVehicle
 */
(_this select 0) addAction ["Deploy", {["DEPLOY", _this select 0] call X39_MHQ_fnc_deployment;}, [], 1.5, false, true, "", "!(_target getVariable ['X39_MHQ_fnc_deployment_isDeployed', false])"];
(_this select 0) addAction ["Undeploy", {["UNDEPLOY", _this select 0] call X39_MHQ_fnc_deployment;}, [], 1.5, false, true, "", "(_target getVariable ['X39_MHQ_fnc_deployment_isDeployed', false])"];
if(!isServer) exitWith {};
_this spawn {
	waitUntil{!isNil "X39_MHQ_var_MHQVehicles"};
	private["_mhqVehicle"];

	_mhqVehicle = _this select 0;
	_mhqVehicle setVariable ["X39_MHQ_var_MHQVehiclesIndex", X39_MHQ_var_MHQVehicles pushBack [_mhqVehicle, position _mhqVehicle, direction _mhqVehicle], false];
	_mhqVehicle addEventHandler["Killed", {
		_vehicle = vehicle (_this select 0);
		_vehicleClass = typeOf _vehicle;
		_MHQIndex = _vehicle getVariable["X39_MHQ_var_MHQVehiclesIndex", -1];

		if(_MHQIndex == -1) then {throw "MHQIndex of MHQ is not existing, FATAL ERROR in Killed EventHandler";};

		["UNDEPLOY", _vehicle] call X39_MHQ_fnc_deployment;
		(X39_MHQ_var_MHQVehicles select _MHQIndex) set [0, objNull];

		[_vehicleClass, _MHQIndex] spawn {
			sleep X39_MHQ_var_MHQRespawnTimeout;
			_mhqArray = X39_MHQ_var_MHQVehicles select (_this select 1);
			_mhqArray set[0, (_this select 0) createVehicle (_mhqArray select 1)];
			_vehicle = (_mhqArray select 0);
			_vehicle setDir (_mhqArray select 2);
			[
				"addAction",
				[
					_vehicle,
					"MHQAction",
					[
						"Deploy",
						{["DEPLOY", _this select 0] call X39_MHQ_fnc_deployment;},
						[],
						1.5,
						false,
						true,
						"",
						"!(_target getVariable ['X39_MHQ_fnc_deployment_isDeployed', false])"
					]
				]
			] call Mission_fnc_performBroadcast;
			[
				"addAction",
				[
					_vehicle,
					"MHQAction",
					[
						"Undeploy",
						{["UNDEPLOY", _this select 0] call X39_MHQ_fnc_deployment;},
						[],
						1.5,
						false,
						true,
						"",
						"(_target getVariable ['X39_MHQ_fnc_deployment_isDeployed', false])"
					]
				]
			] call Mission_fnc_performBroadcast;
		};
	}];
};
