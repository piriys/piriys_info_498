float TIMEOUT = 50.0;

//Global Constants
integer SCAVENGER_HUD_CHANNEL = -498; 
integer SCAVENGER_OBJECT_CHANNEL = 498;
string XOR_KEY = "husky498uw!";
list DIALOGUE_CHOICES = ["A", "B", "C"];
integer HUD_FRONT_FACE = 1;

/*Command Constants*/
integer SET_NPC = 0;
integer SET_NPC_TEXTURE = 1;
integer SET_DIALOGUE = 2;
integer SET_TIMEOUT = 3;
integer TALK = 4;
integer NPC_RESET = 5;
integer CHOOSE_DIALOGUE = 6;
integer REFRESH_NPC = 7;

/*Link Numbers*/
integer NPC_LINK_NUMBER = 24;
integer CHOICE_A_LINK_NUMBER = 25;
integer CHOICE_B_LINK_NUMBER = 26;
integer CHOICE_C_LINK_NUMBER = 27;
integer CHOICE_D_LINK_NUMBER = 28;

string currentNPC = "DEFAULT";
key currentNPCtexture = TEXTURE_BLANK;
list currentDialogueOptions = [];
integer activeNPC = FALSE;

string Xor(string data, string xorKey)
{
     return llXorBase64(llStringToBase64(data), llStringToBase64(xorKey));
}
 
string Dexor(string data, string xorKey) 
{
     return llBase64ToString(llXorBase64(data, llStringToBase64(xorKey)));
}

RefreshNPC()
{
    integer index = NPC_LINK_NUMBER;
    
    llSetLinkPrimitiveParamsFast(index, [
        PRIM_COLOR, HUD_FRONT_FACE, <1.0, 1.0, 1.0>, (float)(activeNPC),    
        PRIM_TEXT, currentNPC, <1.0, 1.0, 1.0>, (float)(activeNPC),
        PRIM_TEXTURE, HUD_FRONT_FACE, (string)currentNPCtexture, <1.0, 1.0, 0.0>, <0.0, 0.0, 0.0>, 0.0]);        
        
    for(index = CHOICE_A_LINK_NUMBER; index <= CHOICE_C_LINK_NUMBER; index++)
    {
        llSetLinkPrimitiveParamsFast(index, [
            PRIM_COLOR, HUD_FRONT_FACE, <1.0, 1.0, 1.0>, (float)(activeNPC),    
            PRIM_TEXT, llList2String(currentDialogueOptions, index - CHOICE_A_LINK_NUMBER), <1.0, 1.0, 1.0>, (float)(activeNPC)]);    
    }  

    llSetLinkPrimitiveParamsFast(index, [
        PRIM_COLOR, HUD_FRONT_FACE, <1.0, 1.0, 1.0>, (float)(activeNPC),    
        PRIM_TEXT, "[Leave] See You.", <1.0, 1.0, 1.0>, (float)(activeNPC)]);       
}

default
{
    state_entry()
    {
        RefreshNPC();
        llSetLinkPrimitiveParamsFast(NPC_LINK_NUMBER, [PRIM_NAME, currentNPC]);        
    }
    
    link_message(integer source, integer num, string str, key id)
    {
        if(num == SET_NPC)
        {
            activeNPC = TRUE;
            currentNPC = str;
            llSetLinkPrimitiveParamsFast(NPC_LINK_NUMBER, [PRIM_NAME, currentNPC]);              
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
                
                string xorParameterList = Xor(timeStamp + "," + triggerID + "," + command + "," + parameter, XOR_KEY + triggerID);    
                llSay(SCAVENGER_OBJECT_CHANNEL, xorParameterList);       
            }
        }
        else if(num == NPC_RESET)
        {
            llSetTimerEvent(0.0);
            llResetScript();
        }
        
        RefreshNPC();
    }
    
    timer()
    {
		llOwnerSay("*NPC interaction timed out*");
        llSetTimerEvent(0.0);
        llResetScript();
    }
}