integer FFB_GAME_CHANNEL = 49811;
float GAME_TIME = 300.0;

integer listenHandle = 0;
integer gameStart = FALSE;

list players = [];
list collection = [];
default
{
	state_entry()
	{
		llSetTimerEvent(0.0);
		llListenRemove(listenHandle);
		listenHandle = llListen(FFB_GAME_CHANNEL, "", "", "");		
	}
	
    listen(integer channel, string name, key id, string message)
    {
		if(!gameStart)
		{
			gameStart = TRUE;
			llSetTimerEvent(300.0);
		}
		
		if(llListFindList(collect, [message]) == -1)
		{
			list parameters = llParseString2List(message, [","], [""]);
			key avatarKey = llList2Key(parameters, 0);
			string energy = llList2String(parameters, 1);
			
			if(llListFindList(players, [avatarKey]) != -1)
			{
				players = players + avatarKey;
			}
			
			integer playerIndex = llListFindList(players, [avatarKey]);
			
			if(playerIndex == -1)
			{
				collection = collection + energy;
				llSay(PUBLIC_CHANNEL, llGetDisplayName(avatarKey) + " collected " + energy);	
			}
			else
			{
				llSay(PUBLIC_CHANNEL, llGetDisplayName(avatarKey) + " collected " + energy + " and replaced their old choice." );			
				collection = llListReplaceList(collection, [energy], playerIndex, playerIndex);
			}
			

		}
	}
	
	timer()
	{
		state game_over;
		llSetTimerEvent(0.0);	
	}
}

state game_over
{
	state_entry()
	{
		llSay(PUBLIC_CHANNEL, "Good work everyone! I will announce the winner in 10 seconds.");
		llSetTimerEvent(10.0);
	}
	
	timer()
	{
		state announce
	}
}

state announce
{
	state_entry()
	{
		integer winnerIndex = llListFindList(collection, ["Solar Energy"]);
		if(winnerIndex != -1))
		{
			string avatarName = llGetDisplayName(llList2Key(players, winnerIndex));
			llSay(PUBLIC_CHANNEL, "The winner is " + avatarName + " because " + avatarName + " is fastest player who picked up Solar Energy.");
		}
		else
		{
			llSay(PUBLIC_CHANNEL, "There is no winner because no one picked up Solar Energy.");		
		}
		llSetTimerEvent(10.0);
	}
	
	timer()
	{
		state announce
	}
}