/*
Piriya Saengsuwarn
This work is licensed under a Creative Commons Attribution-NonCommercial 4.0 International License.
http://creativecommons.org/licenses/by-nc/4.0/
*/

/*Global Constants*/
integer INTERNAL_CHANNEL = -4981;
	
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
