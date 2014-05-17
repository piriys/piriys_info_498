/*Object Settings - Make Changes Here*/
string TOKEN_NAME = "Educational"; //VSD Value (Pick valid value from VSD_LIST below if this is not a decoy)
string TRIGGER_ID = "Educational Token Dispenser"; //Object name - Make sure this matches with the trigger plate settings
integer ACTIVATION_TIME = 30;  //Time until object disappear (Seconds) after being activated (make sure ALWAYS_VISIBLE = FALSE)

/*Global Constants*/
integer SCAVENGER_HUD_CHANNEL = -498; 
integer SCAVENGER_OBJECT_CHANNEL = 498;
string XOR_KEY = "husky498uw!";
    
/*Index Constants for Incoming Parameters*/
integer TIME_STAMP = 0;
integer ID = 1;
integer COMMAND = 2;
integer PARAMETER = 3;

/*Global Variables*/
integer listenHandle = 0;
integer timerCounter = 1;

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
        llVolumeDetect(TRUE);
    }
    
    collision_start(integer num_detected)
    {
        string timeStamp = llGetTimestamp();
        string triggerID = TRIGGER_ID;
        string command = "ACTIVATE";
        string parameter = (string)llDetectedKey(0);
        
        string xorParameterList = Xor(timeStamp + "," + triggerID + "," + command + "," + parameter, XOR_KEY + triggerID);
        
        llSay(SCAVENGER_OBJECT_CHANNEL, xorParameterList);    
    }
}

state activated
{
    state_entry()
    {
        timerCounter = 1;
        llSetTimerEvent(1.0);
    }
      
    timer()
    {
        if(timerCounter != ACTIVATION_TIME)
        {
            timerCounter++;   
        }
        else
        {
            llSetTimerEvent(0.0);
            timerCounter = 1;
            state default;   
        }
    }
}
    