	scopeName "_FNCSCOPE_";
	params ["_x", "_y"];
	private ["___obj___fnctoString", "___obj___fncequals"];
	___obj___fnctoString = {
		scopeName "_FNCSCOPE_";
		params ["___obj___"];
	(str ((___obj___))) breakOut "_FNCSCOPE_";
	};
	___obj___fncequals = {
		scopeName "_FNCSCOPE_";
		params ["___obj___", "_obj"];
			private "_obj";
	(((___obj___)) isEqualTo ((_obj))) breakOut "_FNCSCOPE_";
	};
	___obj___ = [["object", "X39::Insurgency::Square"], ["toString", "equals", "marker", "houses", "housesCount", "veh", "isCleared"], ___obj___fnctoString, ___obj___fncequals, nil, nil, nil, nil, nil];
		private ["_x", "_y"];
	___obj___ set [4, (createMarker [ (format ["X39INS_%1%2", (_x), (_y)]) , [ 0 , 0 , 0 ] ])];
		(___obj___ select 4) setMarkerShape ( ("RECTANGLE") );
		(___obj___ select 4) setMarkerBrush ( ("Solid") );
		(___obj___ select 4) setMarkerType ( "Empty" );
		(___obj___ select 4) setMarkerSize [ 50 , 50 ];
		(___obj___ select 4) setMarkerPos [ (50 + ((_x) - (( (_x) ) mod ( 100 )))) , (50 + ((_y) - (( (_y) ) mod ( 100 )))) , 0 ];
		(___obj___ select 4) setMarkerAlpha ( 0.75 );
	___obj___ set [5, ([ ])];
	___obj___ set [7, ("Land_HelipadEmpty_F" createVehicle [ (_x) , (_y) , 0 ])];
		[] call {private "___tmp___"; ___tmp___ = (___obj___); ___tmp___ = ((___tmp___ select 7)); ___tmp___ = (___tmp___ setVariable [ "IsInsurgencyObject" , true , true ]);};
		[___obj___, false] call X39_Insurgency_Square_fnc_setCleared;
	___obj___