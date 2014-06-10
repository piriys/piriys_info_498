/*Global Constants*/
string SEPERATOR = "|||";
integer SCAVENGER_HUD_CHANNEL = -498; 
integer SCAVENGER_OBJECT_CHANNEL = 498;
integer INTERNAL_CHANNEL = -4981;
string XOR_KEY = "husky498uw!";
list VSD_LIST = 
    ["Accountability", "Autonomy", "Calmness", "Courtesy",
    "Educational", "Empirical", "Environmental Stability", "Freedom from Bias",
    "Human Welfare", "Identity", "Informed Consent", "Ownership/Property",
    "Trust", "Universal Usability", "Exceptional", "Privacy"];
	
default
{
	state_entry()
	{

	}
	
    touch_start(integer total_number)
    {
		string hudName = llGetInventoryName(INVENTORY_OBJECT, 0);	
        key avatarKey = llDetectedKey(0);
        llRezObject(hudName, llGetPos(), ZERO_VECTOR, llGetRot(), 0);     
		llSleep(1.0);
        llWhisper(INTERNAL_CHANNEL, (string)avatarKey);
		state wait;
    }	
}

state wait
{
	state_entry()
	{
		llSetTimerEvent(5.0);
	}
	
    touch_start(integer total_number)
    {
		llSay(PUBLIC_CHANNEL, "Please wait a few seconds to try again.");
	}	
	
	timer()
	{
		state default;
	}
}