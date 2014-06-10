string FORK_ID = "A";
integer ATNM_GAME_CHANNEL = 49822;
string SEPERATOR = "|||";
default
{
	state_entry()
	{
	
	}
	
    touch_end(integer num_detected)
	{
		key avatarKey = llDetectedKey(0);
		
		llSay(ATNM_GAME_CHANNEL, (string)avatarKey + SEPERATOR + "ADD_FORK" + SEPERATOR + FORK_ID);
	}
}