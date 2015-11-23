if(!isServer) exitWith {};
private["_variableName", "_newValue", "_operation", "_params"];
_variableName = _this select 0;
_newValue = _this select 1;

if(typeOf _newValue != "ARRAY") exitWith {throw "Invalid Params in ClientReceiver";};
if(count _newValue < 2) exitWith {throw "Invalid Params in ClientReceiver";};
_operation = _newValue select 0;
_params = _newValue select 1;
if(typeOf _operation != "STRING") exitWith {throw "Invalid Params in ClientReceiver";};

switch(_operation) do
{
  default {throw "Unknown Operation in ClientReceiver";};
  case "addAction": {
    Mission_var_DynamicActions pushBack _params;
    publicVariable "Mission_var_DynamicActions";
  };
  case "removeAction": {
    for "_i" from 0 to ((count Mission_var_DynamicActions) - 1) do
    {
      if((_x select 1) == (_params select 1)) then
      {
        Mission_var_DynamicActions deleteAt _i;
        _i = _i - 1;
      };
    };
    publicVariable "Mission_var_DynamicActions";
  };
};
