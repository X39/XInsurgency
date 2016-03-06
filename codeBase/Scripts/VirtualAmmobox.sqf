_this addAction ["Virtual Arsenal", {["Open",true] spawn BIS_fnc_arsenal;}];
_this addAction ["Save Loadout", {[player, [missionNamespace, "Mission_var_SavedInventory"]] call BIS_fnc_saveInventory }];