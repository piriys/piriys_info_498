integer ATNM_GAME_CHANNEL = 49822;
float TIMEOUT = 20.0;

/*v### Trigger Plate Settings - Make Changes Below ###v*/
string TOKEN_NAME = "Autonomy"; //VSD Value (Pick valid value from VSD_LIST below if this is not a decoy)
string TRIGGER_ID = "Autonomy Token Dispenser"; //Object name - Make sure this matches with the object settings in scavenger_object.lsl, meaningful name preferred
integer ACTIVATION_TIME = 30;  //Time until object disappears (seconds) after being activated (make sure ALWAYS_VISIBLE = FALSE in the scavenger_object.lsl)
/*^### Trigger Plate Settings - Make Changes Above ###^*/

/*Global Constants*/
string SEPERATOR = "|||";
integer SCAVENGER_HUD_CHANNEL = -498; 
integer SCAVENGER_OBJECT_CHANNEL = 498;
string XOR_KEY = "husky498uw!";
list VSD_LIST = 
    ["Accountability", "Autonomy", "Calmness", "Courtesy",
    "Educational", "Empirical", "Environmental Stability", "Freedom from Bias",
    "Human Welfare", "Identity", "Informed Consent", "Ownership/Property",
    "Trust", "Universal Usability", "Exceptional", "Privacy"];
    
/*Global Variables*/
integer listenHandle = 0;
  
/*Encode & Decode Functions (for security)*/
string Xor(string data, string xorKey)
{
     return llXorBase64(llStringToBase64(data), llStringToBase64(xorKey));
}
 
string Dexor(string data, string xorKey) 
{
     return llBase64ToString(llXorBase64(data, llStringToBase64(xorKey)));
}
            
default
{
    state_entry()
    {
        llVolumeDetect(FALSE);    
        llSetPrimitiveParams([
            PRIM_PHANTOM, FALSE,
            PRIM_GLOW, ALL_SIDES, 0.1,            
            PRIM_COLOR, ALL_SIDES, <0.153, 0.341, 0.153>, 0.66]);
        llSetAlpha(0.44, ALL_SIDES);
        llListenRemove(listenHandle);
        listenHandle = llListen(ATNM_GAME_CHANNEL, "", "", "");        
    }
    
    listen(integer channel, string name, key id, string message)
    {
        if(message== "BARRIER_OFF")
        {
            llSay(0, "The barrier is overloaded for 20 seconds!");
            state off;
        }
    }
}

state off
{
    state_entry()
    {
        llVolumeDetect(TRUE);        
        llSetPrimitiveParams([
            PRIM_PHANTOM, TRUE,
            PRIM_GLOW, ALL_SIDES, 0.0,
            PRIM_COLOR, ALL_SIDES, <0.153, 0.341, 0.153>, 0.0]);     
        llSetAlpha(0.0, ALL_SIDES);
        llSetTimerEvent(TIMEOUT);
    }

    collision_start(integer num_detected)
    {
        string timeStamp = llGetTimestamp();
        string triggerID = TRIGGER_ID;
        string command = "ACTIVATE";
        string parameter = (string)llDetectedKey(0);
        
        string xorParameterList = Xor(timeStamp + SEPERATOR + triggerID + SEPERATOR + command + SEPERATOR + parameter, XOR_KEY + triggerID);
        
        llSay(SCAVENGER_OBJECT_CHANNEL, xorParameterList);    
    }
    
    timer()
    {
        llSay(0, "Barrier reactivated!");    
        llSetTimerEvent(0.0);
        state default;
    }
}