string ENERGY_NAME = "Solar"; /*<-- Change this*/
integer FFB_GAME_CHANNEL = 49811;
string SEPERATOR = "|||";

default
{
    state_entry()
    {
    
    }
    
    touch_end(integer num_detected)
    {
        key avatarKey = llDetectedKey(0);
        
        llShout(FFB_GAME_CHANNEL, (string)avatarKey + SEPERATOR + "ADD_ENERGY" + SEPERATOR + ENERGY_NAME);
    }
}