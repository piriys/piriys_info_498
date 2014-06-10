string PLATE_ID = "A";
integer ACC_GAME_CHANNEL = 49805;
string SEPERATOR = "|||";
default
{
	state_entry()
	{
	
	}
	
    collision_start(integer num_detected)
	{
		key avatarKey = llDetectedKey(0);
		
		llSay(ATNM_GAME_CHANNEL, (string)avatarKey + SEPERATOR + "ADD_STEPPER" + SEPERATOR + PLATE_ID);
	}
}