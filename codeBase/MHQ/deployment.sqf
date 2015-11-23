private["_action", "_vehicle"];
_action = _this select 0;
_vehicle = _this select 1;

switch(_action) do
{
    case "DEPLOY": {

    };
    case "UNDEPLOY": {

    };
    default {throw "UNKNOWN ACTION FOR DEPLOYMENT SCRIPT"};
};
