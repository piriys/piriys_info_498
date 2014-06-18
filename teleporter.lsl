/*v### Teleporter Settings - Make Changes Below ###v*/
integer DEFAULT_PRIM_COUNT = 1;
string PROMPT_TEXT = ""; //Hover text
vector DESTINATION = <147, 232, 21>;
vector DEG_ROTATION = ZERO_VECTOR;
integer LOAD_LANDMARK = FALSE; //Set this to true if you want to load destination from landmark in object inventory instead
float HEIGHT_OFFSET = 1.0; //Height offset for destination - Must not equal to 0
/*^### Teleporter Settings - Make Changes Above ###^*/

//Global Variables
vector startPosition;
rotation startRotation;
key requestID;

teleport()
{
    if(llGetPos() != DESTINATION)
    {
        rotation ROTATION = llEuler2Rot(DEG_ROTATION * DEG_TO_RAD);
        //llOwnerSay("going to destination");
        llSetRegionPos(DESTINATION);   
        llSetRot(ROTATION);
        llSleep(0.5);
        //llOwnerSay("Unsitting " + llKey2Name(llAvatarOnSitTarget()));
        llUnSit(llAvatarOnSitTarget());      
        teleport();
    }
    else
    {                
        llSetRegionPos(startPosition);
        llSetRot(startRotation);       
    }
}

default
{
    on_rez(integer start_param)
    {
        llResetScript(); 
    }
    
    state_entry()
    {
        llSetText(PROMPT_TEXT, <1,1,1>, 1.0);
		
		if(HEIGHT_OFFSET == 0)
		{
			llOwnerSay("Please make sure HEIGHT_OFFSET is not 0."); 
		}
		else
		{
			llSetClickAction(CLICK_ACTION_SIT);
			llSitTarget(<0.0, 0.0, HEIGHT_OFFSET>, ZERO_ROTATION);
		}	
		
        startPosition = llGetPos();  
        startRotation = llGetRot();
        
        if(LOAD_LANDMARK)
        {
            if (llGetInventoryNumber(INVENTORY_LANDMARK) == 0)
            {
                llSay(0, "No Landmark found in inventory, destination set to default in script");
                  
            }
            else
            {
                requestID = llRequestInventoryData(llGetInventoryName(INVENTORY_LANDMARK, 0));
            }
        }
    }
    
    dataserver(key query, string data)
    {
        if(requestID ==  query)
        {
            DESTINATION = (vector)data + <0.0, 0.0, HEIGHT_OFFSET>;
        }  
    }
       
    changed(integer change)
    {
        if(change & CHANGED_LINK)
        {
            if(llGetNumberOfPrims() != DEFAULT_PRIM_COUNT)
            {
				teleport();
            }
        }
        else if(change & CHANGED_INVENTORY)
        {
            llResetScript();   
        }
    }
}