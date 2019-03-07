/**
 * ExileServer_system_territory_network_flagStolenRequest
 *
 * Exile Mod
 * www.exilemod.com
 * © 2015 Exile Mod Team
 *
 * This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License. 
 * To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/.
 */

private["_playerObject", "_myUid", "_numberOfTerritories", "_ownerUid", "_flag", "_dbID"];
_playerObject = _this select 0;
_myUid = getPlayerUID _playerObject;
_flag = _this select 4;
_flagOwner = _flag getVariable ["ExileOwnerUID", 0];
_dbID = _flag getVariable ["ExileDatabaseID",0];
_numberOfTerritories = 0;
{
	_ownerUid = _x getVariable ["ExileOwnerUID", ""];
	if (_ownerUid isEqualTo _myUid) then 
	{
		_numberOfTerritories = _numberOfTerritories + 1;
	};
}
forEach allMissionObjects "Exile_Construction_Flag_Static";

	_playerObject = _sessionID call ExileServer_system_session_getPlayerObject;
	if (isNull _playerObject) then
	{
		throw "Player Object NULL";
	};
	if ((_flag getVariable ["ExileFlagStolen", 0]) isEqualTo 1) then 
	{
		throw "Flag already stolen!";
	};
	if ((_playerObject distance2D _flag) > 5) then
	{
		throw "You are too far away!";
	};
	if(_numberOfTerritories > 0)
	{
		throw "You own too many bases!"
	};

_flag setVariable {"ExileOwnerID", _myUID, true];
_flag setVariable ["ExileTerritoryBuildRights", [_myUID], true];
_flag setVariable ["ExileTerritoryModerators", [_myUID], true]
_flag setVariable ["ExileFlagStolen", 0, true];
format ["updateTerritoryOwner:%1:%2",_myUid,_databaseID] call ExileServer_system_database_query_fireAndForget;
true