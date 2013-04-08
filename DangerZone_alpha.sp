#pragma semicolon 1

#include <sourcemod>
#include <sdkhooks>
#include <smlib>

public Plugin:myinfo = 
{
  name = "Danger Zone",
	author = "Pierce 'NameUser' Strine & various coders",
	description = "A new TF2 gamemode",
	version = "1.0",
	url = "steamcommunity.com/id/NameUser"
}

public OnPluginStart()
{
	for(new i=1; i<=GetMaxClients(); i++)
	{
		if(!IsValidEntity(i)) continue;
		SDKHook(i, SDKHook_OnTakeDamage, OnTakeDamage);
	}.
}

public OnClientPutInServer(client)
{
	SDKHook(client, SDKHook_OnTakeDamage, OnTakeDamage);
}

public Action:OnTakeDamage(victim, &attacker, &inflictor, &Float:damage, &damagetype)
{
	if(damagetype == 32) Client_Shake(victim, _, 20.0, 512.0, 0.6);
	else Client_Shake(victim, _, damage, 512.0, 0.2);
	return Plugin_Continue;
}

public Action:Event_Spawn(Handle:event, const String:name[], bool:dontBroadcast)
{
	new client = GetClientOfUserId(GetEventInt(event, "userid"));
	SetEntityRenderColor(client, 0, 255, 0, 255);
	TF2_AddCondition(i, TFCond_SpeedBuffAlly, 3.0);
	TF2_AddCondition(i, TFCond_Kritzkrieged, 5.0);
	
}

public Action:Event_Death(Handle:event, const String:name[], bool:dontBroadcast)
{
	new client = GetClientOfUserId(GetEventInt(event, "userid"));
	CreateTimer(1.0, Timer_Death, client);
}

public Action:Timer_Death(Handle:timer, any:client)
{
	TF2_RespawnPlayer(client);
}
