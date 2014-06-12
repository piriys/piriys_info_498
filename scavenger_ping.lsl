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

integer listenHandle = 0;   
         
default
{
    state_entry()
    {   
        llListenRemove(listenHandle);
        listenHandle = llListen(SCAVENGER_OBJECT_CHANNEL, "", "", "");        
    }

    timer()
    {
        if(timerCounter != ACTIVATION_TIME)
        {
            llSetText((string)(ACTIVATION_TIME - timerCounter), COUNTDOWN_COLOR, 1.0);         
            timerCounter++;   
        }
        else
        {
            llSetTimerEvent(0.0);
            timerCounter = 1;
            state default;   
        }
    }
    
    listen(integer channel, string name, key id, string message)
    {
        list parameterList = llParseString2List(Dexor(message, XOR_KEY + TRIGGER_ID), [SEPERATOR], [""]);  
                      
        //Check if Avatar
        if(llGetListLength(parameterList) != 4)
        {
            parameterList = llParseString2List(Dexor(message, XOR_KEY + (string)llGetOwnerKey(id)), [SEPERATOR], [""]);        
        }        
        
        if(llGetListLength(parameterList) == 4)
        {   
            string timeStamp = llList2Key(parameterList, TIME_STAMP);        
            string triggerID = llList2String(parameterList, ID); //Avatar Key or Trigger ID
            string command = llList2String(parameterList, COMMAND);
            string parameter = llList2String(parameterList, PARAMETER);      
                    
            if(command == "REQUEST_PING" & ENABLE_PING)
            {
                ReturnPing((key)triggerID);
            }            
        }
    } 
}