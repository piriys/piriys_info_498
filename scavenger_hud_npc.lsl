float TIMEOUT = 50.0;

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

default
{
    state_entry()
    {
    
    }
    
    link_message(integer source, integer num, string str, key id)
    {
        if(num == SET_NPC)
        {
            currentNPC = str;
            llSetLinkPrimitiveParamsFast(LINK_THIS, [PRIM_NAME, currentNPC]);            
            
            //llOwnerSay("NPC: " + currentNPC);            
        }
        else if(num == SET_NPC_TEXTURE)
        {
            currentNPCtexture = (key)str;
            
            //llOwnerSay("Texture: " + (string)currentNPCtexture);            
        }
        else if(num == SET_DIALOGUE)
        {
            currentDialogueOptions = llParseString2List(str, ["###"], [""]); 
            
            //llOwnerSay("Dialogue: " + llDumpList2String(currentDialogueOptions, ","));      
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
			
		}
    }
    
    timer()
    {
        llSetTimerEvent(0.0);
        //llOwnerSay("Resetting NPC");
        llResetScript();
    }
}