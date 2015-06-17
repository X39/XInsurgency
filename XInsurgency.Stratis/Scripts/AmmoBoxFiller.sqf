if(!isServer) exitWith {};

_ammoBox = _this select 0;
_part = _this select 1;
_ammoBox allowDamage false;
if(typeName _part != "ARRAY") then
{
	if(_part == 0) then 
	{
		_part = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];
	} else {
		_part = [_part];
	};
};
/* _part usage (doesnt matters if array or variable):
 * _part == 0 (or empty)
 *		Generate complete ammoBox
 * _part == 1
 *		Generate Uniforms box only
 * _part == 2
 *		Generate VESTS box only
 * _part == 3
 *		Generate Helmets box only
 * _part == 4
 *		Generate BackPack box only
 * _part == 5
 *		Generate Weapons box only
 * _part == 6
 *		Generate AMMO box only
 * _part == 7
 *		Generate Launcher box only
 * _part == 8
 *		Generate Launcher Ammo box only
 * _part == 9
 *		Generate Explosives box only
 * _part == 10
 *		Generate Grenades box only
 * _part == 11
 *		Generate Attachements box only
 * _part == 12
 *		Generate Items box only
*/

clearMagazineCargo _ammoBox;
clearWeaponCargo _ammoBox;
clearItemCargoGlobal _ammoBox;

if(1 in _part) then 
{
	/************
	 * Uniforms *
	 ***********/
	_ammoBox addItemCargo ["U_BasicBody", 2];
	_ammoBox addItemCargo ["U_B_CombatUniform_mcam", 2];
	_ammoBox addItemCargo ["U_B_CombatUniform_mcam_tshirt", 2];
	_ammoBox addItemCargo ["U_B_CombatUniform_mcam_vest", 2];
	_ammoBox addItemCargo ["U_B_HeliPilotCoveralls", 2];
	_ammoBox addItemCargo ["U_B_Wetsuit", 2];
	_ammoBox addItemCargo ["U_C_Poloshirt_blue", 2];
	_ammoBox addItemCargo ["U_C_Poloshirt_burgundy", 2];
	_ammoBox addItemCargo ["U_C_Poloshirt_stripped", 2];
	_ammoBox addItemCargo ["U_C_Poloshirt_tricolour", 2];
	_ammoBox addItemCargo ["U_C_Poloshirt_salmon", 2];
	_ammoBox addItemCargo ["U_C_Poloshirt_redwhite", 2];
	_ammoBox addItemCargo ["U_C_Commoner1_1", 2];
	_ammoBox addItemCargo ["U_C_Commoner1_2", 2];
	_ammoBox addItemCargo ["U_C_Commoner1_3", 2];
	_ammoBox addItemCargo ["U_Rangemaster", 2];
};
if(2 in _part) then 
{
	/************
	 *	VESTS	*
	 ***********/
	_ammoBox addItemCargo ["V_Rangemaster_belt", 2];
	_ammoBox addItemCargo ["V_BandollierB_khk", 2];
	_ammoBox addItemCargo ["V_BandollierB_rgr", 2];
	_ammoBox addItemCargo ["V_BandollierB_cbr", 2];
	_ammoBox addItemCargo ["V_PlateCarrier1_rgr", 2];
	_ammoBox addItemCargo ["V_PlateCarrier1_cbr", 2];
	_ammoBox addItemCargo ["V_PlateCarrier2_rgr", 2];
	_ammoBox addItemCargo ["V_PlateCarrierGL_rgr", 2];
	_ammoBox addItemCargo ["V_Chestrig_khk", 2];
	_ammoBox addItemCargo ["V_TacVest_khk", 2];
	_ammoBox addItemCargo ["V_TacVest_brn", 2];
	_ammoBox addItemCargo ["V_TacVest_oli", 2];
	_ammoBox addItemCargo ["V_HarnessO_brn", 2];
	_ammoBox addItemCargo ["V_HarnessOGL_brn", 2];
	_ammoBox addItemCargo ["V_RebreatherB", 2];
	_ammoBox addItemCargo ["V_RebreatherIR", 2];
};
if(3 in _part) then 
{
	/***********
	 * Helmets *
	 **********/
	_ammoBox addItemCargo ["H_HelmetB", 2];
	_ammoBox addItemCargo ["H_Booniehat_khk", 2];
	_ammoBox addItemCargo ["H_Booniehat_mcamo", 2];
	_ammoBox addItemCargo ["H_Booniehat_ocamo", 2];
	_ammoBox addItemCargo ["H_HelmetB_paint", 2];
	_ammoBox addItemCargo ["H_HelmetB_light", 2];
	_ammoBox addItemCargo ["H_Cap_red", 2];
	_ammoBox addItemCargo ["H_Cap_brn_SERO", 2];
	_ammoBox addItemCargo ["H_Cap_blu", 2];
	_ammoBox addItemCargo ["H_Cap_headphones", 2];
	_ammoBox addItemCargo ["H_PilotHelmetHeli_B", 2];
	_ammoBox addItemCargo ["H_PilotHelmetHeli_O", 2];
	_ammoBox addItemCargo ["H_HelmetO_ocamo", 2];
	_ammoBox addItemCargo ["H_MilCap_ocamo", 2];
	_ammoBox addItemCargo ["H_MilCap_mcamo", 2];
};
if(4 in _part) then 
{
	/****************
	 *	Backpacks	*
	 ***************/
	_ammoBox addBackpackCargo ["B_AssaultPack_blk", 2];
	_ammoBox addBackpackCargo ["B_AssaultPack_blk_DiverExp", 2];
	_ammoBox addBackpackCargo ["B_AssaultPack_cbr", 2];
	_ammoBox addBackpackCargo ["B_AssaultPack_dgtl", 2];
	_ammoBox addBackpackCargo ["B_AssaultPack_khk", 2];
	_ammoBox addBackpackCargo ["B_AssaultPack_mcamo", 2];
	_ammoBox addBackpackCargo ["B_AssaultPack_ocamo", 2];
	_ammoBox addBackpackCargo ["B_AssaultPack_rgr", 2];
	_ammoBox addBackpackCargo ["B_AssaultPack_rgr_Medic", 2];
	_ammoBox addBackpackCargo ["B_AssaultPack_rgr_Repair", 2];
	_ammoBox addBackpackCargo ["B_AssaultPack_sgg", 2];
	_ammoBox addBackpackCargo ["B_Bergen_sgg", 2];
	//_ammoBox addBackpackCargo ["B_Bergen_sgg_Exp", 2];
	_ammoBox addBackpackCargo ["B_Carryall_ocamo", 2];
	_ammoBox addBackpackCargo ["B_Carryall_oucamo", 2];
	_ammoBox addBackpackCargo ["B_FieldPack_blk", 2];
	_ammoBox addBackpackCargo ["B_FieldPack_blk_DiverExp", 2];
	_ammoBox addBackpackCargo ["B_FieldPack_cbr", 2];
	_ammoBox addBackpackCargo ["B_FieldPack_cbr_AT", 2];
	_ammoBox addBackpackCargo ["B_FieldPack_cbr_Repair", 2];
	_ammoBox addBackpackCargo ["B_FieldPack_ocamo", 2];
	_ammoBox addBackpackCargo ["B_FieldPack_ocamo_Medic", 2];
	_ammoBox addBackpackCargo ["B_FieldPack_oucamo", 2];
	_ammoBox addBackpackCargo ["B_Kitbag_cbr", 2];
	_ammoBox addBackpackCargo ["B_Kitbag_mcamo", 2];
	_ammoBox addBackpackCargo ["B_Kitbag_sgg", 2];
};
if(5 in _part) then 
{
	/************
	 *	Weapons	*
	 ************/
	_ammoBox addWeaponCargo ["arifle_MX_F", 50];
	_ammoBox addWeaponCargo ["arifle_MX_GL_F", 50];
	_ammoBox addWeaponCargo ["arifle_MXC_F", 50];
	_ammoBox addWeaponCargo ["arifle_TRG20_F", 50];
	_ammoBox addWeaponCargo ["arifle_TRG21_F", 50];
	_ammoBox addWeaponCargo ["arifle_TRG21_GL_F", 50];
	_ammoBox addWeaponCargo ["srifle_EBR_F", 50];
	_ammoBox addWeaponCargo ["LMG_Mk200_F", 50];
	_ammoBox addWeaponCargo ["hgun_rook40_F", 50];
};
if(6 in _part) then 
{
	/************
	 *	 AMMO	*
	 ************/
	_ammoBox addMagazineCargo ["100Rnd_65x39_Caseless_mag", 200];
	_ammoBox addMagazineCargo ["30Rnd_65x39_caseless_mag_Tracer", 200];
	_ammoBox addMagazineCargo ["100Rnd_65x39_caseless_mag_Tracer", 200];
	_ammoBox addMagazineCargo ["16Rnd_9x21_Mag", 200];
	_ammoBox addMagazineCargo ["30Rnd_9x21_Mag", 200];
	_ammoBox addMagazineCargo ["20Rnd_556x45_UW_Mag", 200];
	_ammoBox addMagazineCargo ["30RND_556x45_Stanag", 200];
	_ammoBox addMagazineCargo ["200RND_65x39_Cased_box_Tracer", 200];
};
if(7 in _part) then 
{
	/*************
	 * Launchers *
	 ************/
	_ammoBox addWeaponCargo ["launch_NLAW_F", 50];
	_ammoBox addWeaponCargo ["launch_RPG32_F", 50];
};
if(8 in _part) then 
{
	/****************
	 * Launcher ammo*
	 ***************/
	_ammoBox addMagazineCargo ["RPG32_F", 50];
	_ammoBox addMagazineCargo ["NLAW_F", 50];
};
if(9 in _part) then 
{
	/**************
	 * Explosives *
	 *************/
	 _ammoBox addMagazineCargo ["ATMine_Range_Mag", 50];
	_ammoBox addMagazineCargo ["APERSMine_Range_Mag", 50];
	_ammoBox addMagazineCargo ["ClaymoreDirectionalMine_Remote_Mag", 50];
	_ammoBox addMagazineCargo ["DemoCharge_Remote_Mag", 50];
	_ammoBox addMagazineCargo ["APERSBoundingMine_Range_Mag", 50];
	_ammoBox addMagazineCargo ["SLAMDirectionalMine_Wire_Mag", 50];
	_ammoBox addMagazineCargo ["APERSTripMine_Wire_Mag", 50];
	_ammoBox addWeaponCargo ["ToolKit", 50];
	_ammoBox addWeaponCargo ["MineDetector", 50];
	_ammoBox addWeaponCargo ["Medikit", 50];
};
if(10 in _part) then 
{
	/************
	 * Grenades *
	 ************/
	_ammoBox addMagazineCargo ["1Rnd_HE_Grenade_shell", 50];
	_ammoBox addMagazineCargo ["1Rnd_Smoke_Grenade_shell", 50];
	_ammoBox addMagazineCargo ["1Rnd_SmokeGreen_Grenade_shell", 50];
	_ammoBox addMagazineCargo ["1Rnd_SmokeYellow_Grenade_shell", 50];
	_ammoBox addMagazineCargo ["1Rnd_SmokePurple_Grenade_shell", 50];
	_ammoBox addMagazineCargo ["1Rnd_SmokeBlue_Grenade_shell", 50];
	_ammoBox addMagazineCargo ["1Rnd_SmokeOrange_Grenade_shell", 50];
	_ammoBox addMagazineCargo ["SmokeShellRed", 50];
	_ammoBox addMagazineCargo ["SmokeShell", 50];
	_ammoBox addMagazineCargo ["SmokeShellGreen", 50];
	_ammoBox addMagazineCargo ["SmokeShellYellow", 50];
	_ammoBox addMagazineCargo ["SmokeShellPurple", 50];
	_ammoBox addMagazineCargo ["SmokeShellBlue", 50];
	_ammoBox addMagazineCargo ["SmokeShellOrange", 50];
};
if(11 in _part) then 
{
	/********************
	 *	Attachements	*
	 *******************/
	 _ammoBox addItemCargo ["Zasleh2",50]; 
	_ammoBox addItemCargo ["muzzle_snds_H", 50]; 
	_ammoBox addItemCargo ["muzzle_snds_L", 50]; 
	_ammoBox addItemCargo ["muzzle_snds_B", 50]; 
	_ammoBox addItemCargo ["muzzle_snds_H_MG", 50]; 
	_ammoBox addItemCargo ["optic_Arco", 50]; 
	_ammoBox addItemCargo ["optic_Hamr", 50]; 
	_ammoBox addItemCargo ["optic_Aco", 50]; 
	_ammoBox addItemCargo ["optic_ACO_grn",50]; 
	_ammoBox addItemCargo ["optic_Holosight", 50]; 
	_ammoBox addItemCargo ["acc_flashlight", 50]; 
	_ammoBox addItemCargo ["acc_pointer_IR", 50];
};
if(12 in _part) then 
{
	/************
	 *	Items	*
	 ***********/
	_ammoBox addItemCargo ["FirstAidKit", 50];
	_ammoBox addItemCargo ["Toolkit", 50];
};