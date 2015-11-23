#define assignDefaultValue3(NAMESPACE, STRING, VALUE) if(isNil(STRING)) then {NAMESPACE setVariable [STRING, VALUE];}
#define assignDefaultValue(STRING, VALUE) assignDefaultValue3(missionNamespace, STRING, VALUE)

assignDefaultValue("Mission_var_VehicleSpawnerEnabled", (paramsArray select 0) > 0);
assignDefaultValue("Mission_var_MissionPoller", ["", []]);
assignDefaultValue("Mission_var_DynamicActions", []);
