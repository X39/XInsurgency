#define assignVariable(X,Y) if(isNil {X})then{X = Y;};
#define return


#define DEBUG

#ifndef DEBUG
	#define DEBUG_LOG(X) 
	#define DEBUG_CODE(X) 
	#define COMMA 
	#define PREVENTCALLOUTPUT
#else
	#define DEBUG_LOG(X) diag_log (X);
	#define DEBUG_CODE(X) X;
	#define COMMA ,
#endif

#ifndef PREVENTCALLOUTPUT
DEBUG_CODE(if(isNil "_fnc_scriptName") then { _fnc_scriptName = "nil"; })
DEBUG_LOG(format["%3: %1 call %2" COMMA _this COMMA _fnc_scriptName COMMA time])
#endif

#define CALLSERVER if(!isServer) exitWith {[_this, _fnc_scriptName, false, false] call BIS_fnc_MP;}
#define CALLLOCAL(X) if(!local X) exitWith {[_this, _fnc_scriptName, X, false] call BIS_fnc_MP;}
#define CALLGLOBAL if(true) exitWith {[_this, _fnc_scriptName, true, false] call BIS_fnc_MP;}