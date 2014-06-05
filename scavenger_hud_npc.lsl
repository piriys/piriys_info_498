float TIMEOUT = 50.0;

//Global Constants
integer SCAVENGER_HUD_CHANNEL = -498; 
integer SCAVENGER_OBJECT_CHANNEL = 498;
string XOR_KEY = "husky498uw!";
list DIALOGUE_CHOICES = ["A", "B", "C"];

/*Command Constants*/
integer SET_NPC = 0;
integer SET_NPC_TEXTURE = 1;
integer SET_DIALOGUE = 2;
integer SET_TIMEOUT = 3;
integer TALK = 4;
integer NPC_RESET = 5;
integer CHOOSE_DIALOGUE = 6;

string currentNPC = "DEFAULT";
key currentNPCtexture = TEXTURE_BLANK;
list currentDialogueOptions = [];

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
        llSetLinkPrimitiveParamsFast(LINK_THIS, [PRIM_NAME, currentNPC]);        
    }
    
    link_message(integer source, integer num, string str, key id)
    {
        llOwnerSay((string)num);
        if(num == SET_NPC)
        {
            currentNPC = str;
            llSetLinkPrimitiveParamsFast(LINK_THIS, [PRIM_NAME, currentNPC]);            
            
            //llOwnerSay("NPC: " + currentNPC);            
        }
        else if(num == SET_NPC_TEXTURE)
        {
            currentNPCtexture = (key)str;      
        }
        else if(num == SET_DIALOGUE)
        {
            currentDialogueOptions = llParseString2List(str, ["###"], [""]);   
        }    
        else if(num == SET_TIMEOUT)
        {
            llSetTimerEvent(0.0);
            llSetTimerEvent(TIMEOUT);
        }
        else if(num == TALK)
        {
            llOwnerSay(str);
        }
        else if(num == CHOOSE_DIALOGUE)
        {
            integer dialogueIndex = llListFindList(DIALOGUE_CHOICES, [str]);
            
            if(currentNPC != "DEFAULT")
            {           
                string timeStamp = llGetTimestamp();      
                string triggerID = currentNPC;
                string command = "CHOOSE_DIALOGUE";
                string parameter = llList2String(currentDialogueOptions, dialogueIndex);  
               
                llOwnerSay("Reply: " + parameter);
                
                string xorParameterList = Xor(timeStamp + "," + triggerID + "," + command + "," + parameter, XOR_KEY + triggerID);    
                llSay(SCAVENGER_OBJECT_CHANNEL, xorParameterList);       
            }
        }
    }
    
    timer()
    {
        llSetTimerEvent(0.0);
        //llOwnerSay("Resetting NPC");
        llResetScript();
    }
}