if(!isServer) exitWith {};

X39_MHQ_var_MHQVehicles = [];
X39_MHQ_var_MHQRespawnTimeout = 300;
X39_MHQ_var_EnemySides = [opfor, resistance];

[] spawn
{
	while{true} do
	{
		{
			_veh = _x select 0;
			if(!isNull _veh) then
			{
				_isBlocked = _veh getVariable["X39_MHQ_var_Deployment_isBlocked", false];
				if({side _x in X39_MHQ_var_EnemySides} count (_mhq nearEntities["Man", 500]) > 0)
				{//Enemies close
					if(!_isBlocked) then
					{
						_veh setVariable["X39_MHQ_var_Deployment_isBlocked", true];
						
						
					};
				}
				else
				{//All clear
					if(_isBlocked) then
					{
						_veh setVariable["X39_MHQ_var_Deployment_isBlocked", false];
						
						
					};
				}

			};
		}count X39_MHQ_var_MHQVehicles;
		sleep 1;
	};
};