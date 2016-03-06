	scopeName "_FNCSCOPE_";
	params ["_dead"];
		private "_dead";
		[] call {private "___tmp___"; ___tmp___ = (_dead); ___tmp___ = (___tmp___ setVariable [ "KillTime" , (time) , false ]);};
	if(((random ( 100 )) < 20)) then
	{
		private "_intel";
		_intel = ("Land_File1_F" createVehicle (position _dead));
		[] call {private "___tmp___"; ___tmp___ = (_intel); ___tmp___ = (___tmp___ setVariable [ "isIntel" , true , true ]);};
	};
