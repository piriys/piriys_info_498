/*v### Scavenger Object Settings - Make Changes Below ###v*/
string TOKEN_NAME = "Educational"; //VSD Value (Pick valid value from VSD_LIST below if this is not a decoy)
string TRIGGER_ID = "Educational Token Dispenser"; //Object name - Make sure this matches with the trigger plate/button settings in scavenger_trigger_button.lsl or scavenger_trigger_plate.lsl, meaningful name preferred
integer ALWAYS_VISIBLE = TRUE; //FALSE if there is another object that triggers this object to appear
integer ACTIVATION_TIME = 30;  //Time until object disappears (seconds) after being activated (make sure ALWAYS_VISIBLE = FALSE and this matches with the object settings)
float DEACTIVATED_ALPHA = 0.2; //1.0 for fully opaque, 0.0 for fully transparent 
integer SHOW_COUNTDOWN = TRUE; //Show floating text countdown
vector COUNTDOWN_COLOR = <1.0, 1.0, 1.0>;
/*^### Scavenger Object Settings - Make Changes Above ###^*/

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
        if(!ALWAYS_VISIBLE)
        {
            llSetAlpha(DEACTIVATED_ALPHA, ALL_SIDES);
            llListenRemove(listenHandle);
            listenHandle = llListen(SCAVENGER_OBJECT_CHANNEL, "", "", "");
        }
        else
        {
            state activated;   
        }
    }
    state_exit()
    {
        llListenRemove(listenHandle);          
    }

    
    listen(integer channel, string name, key id, string message)
    {
        list parameterList = llParseString2List(Dexor(message, XOR_KEY + TRIGGER_ID), [","], [""]);
        
        //For Debugging
        //llOwnerSay(Dexor(message));
        
        if(llGetListLength(parameterList) == 4)
        {
            //For Debugging
            //llOwnerSay("Correct Parameter.");
            
            string timeStamp = llList2Key(parameterList, TIME_STAMP);        
            string triggerID = llList2String(parameterList, ID);
            string command = llList2String(parameterList, COMMAND);
            string parameter = llList2String(parameterList, PARAMETER);
            
            if(triggerID == TRIGGER_ID)
            {
                if(command == "ACTIVATE")
                {
                    state activated;
                }
            }
        }
    }    
}

state activated
{
    state_entry()
    {
        llSetAlpha(1.0, ALL_SIDES);          
        if(!ALWAYS_VISIBLE)
        {
			if(SHOW_COUNTDOWN)
			{
				llSetText((string)ACTIVATION_TIME, COUNTDOWN_COLOR, 1.0); 
			}		
            timerCounter = 1;
            llSetTimerEvent(1.0);
        }
    }
	
	state_exit()
	{
		llSetText("", COUNTDOWN_COLOR, 0.0); 	
	}
    
    touch_end(integer num_detected)
    {
        string timeStamp = llGetTimestamp();
        key avatarKey = llDetectedKey(0);
        string command = "ADD_TOKEN";
        string parameter = TOKEN_NAME;
        
        string xorParameterList = Xor(timeStamp + "," + (string)avatarKey + "," + command + "," + parameter, XOR_KEY + (string)avatarKey);
        
        llSay(SCAVENGER_HUD_CHANNEL, xorParameterList);
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
}
    