if(isDedicated) exitWith {};
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
    if(alive (_params select 0)) then
    {
      (_params select 0) setVariable [(_params select 1), (_params select 0) addAction (_params select 2)];
    };
  };
  case "removeAction": {
    if(alive (_params select 0)) then
    {
      (_params select 0) removeAction (_params select 2);
      (_params select 0) setVariable [(_params select 1), -1];
    };
  };
};
