/*v### Scavenger Object Settings - Make Changes Below ###v*/
string TOKEN_NAME = "Autonomy"; //VSD Value (Pick valid value from VSD_LIST below if this is not a decoy)
string TRIGGER_ID = "Autonomy Token Dispenser"; //Object name - Make sure this matches with the trigger plate/button settings in scavenger_trigger_button.lsl or scavenger_trigger_plate.lsl, meaningful name preferred
integer ALWAYS_VISIBLE = FALSE; //FALSE if there is another object that triggers this object to appear
integer ACTIVATION_TIME = 30;  //Time until object disappears (seconds) after being activated (make sure ALWAYS_VISIBLE = FALSE and this matches with the object settings)
float DEACTIVATED_ALPHA = 0.2; //1.0 for fully opaque, 0.0 for fully transparent 
integer SHOW_COUNTDOWN = TRUE; //Show floating text countdown
vector COUNTDOWN_COLOR = <1.0, 1.0, 1.0>;
integer ENABLE_PING = TRUE; //Allow object to be ping by HUD
/*^### Scavenger Object Settings - Make Changes Above ###^*/

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

/*Ping Function*/
ReturnPing(key avatarKey)
{
    string timeStamp = llGetTimestamp();        
    string command = "RETURN_PING";
    string parameter = "100.0";
      
    list detailRequest = llGetObjectDetails(avatarKey ,[OBJECT_POS]);
    
    if(llGetListLength(detailRequest) != 0)
    {
        vector avatarPosition = llList2Vector(detailRequest, 0);
        parameter = (string)llVecDist(avatarPosition,llGetPos());
        
        string xorParameterList = Xor(timeStamp + SEPERATOR + (string)avatarKey + SEPERATOR + command + SEPERATOR + parameter, XOR_KEY + (string)avatarKey);

        llSay(SCAVENGER_HUD_CHANNEL, xorParameterList);            
    }        
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
        list parameterList = llParseString2List(Dexor(message, XOR_KEY + TRIGGER_ID), [SEPERATOR], [""]);  
        
		//If from HUD
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
			else if(command == "ACTIVATE")
			{
				state activated;
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
        
        llListenRemove(listenHandle);
        listenHandle = llListen(SCAVENGER_OBJECT_CHANNEL, "", "", "");        
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
        
        string xorParameterList = Xor(timeStamp + SEPERATOR + (string)avatarKey + SEPERATOR + command + SEPERATOR + parameter, XOR_KEY + (string)avatarKey);
        
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
    