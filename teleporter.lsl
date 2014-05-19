/*v### Teleporter Settings - Make Changes Below ###v*/
string PROMPT_TEXT = "Teleport to Monochrome Circle Classroom: Click on Prim"; //Hover text
vector DEFAULT_DESTINATION = <180,90,3495.250>;
integer LOAD_LANDMARK = FALSE; //Set this to true if you want to load destination from landmark in object inventory instead
float HEIGHT_OFFSET = 1.0; //Height offset for destination
/*^### Teleporter Settings - Make Changes Above ###^*/

//Global Variables
vector startPosition;
vector destination; 
key requestID;

teleport(vector destination)
{
    if(llGetPos() != destination)
    {
        llSetRegionPos(destination);
        teleport(destination);
    }
    else
    {
        llSleep(0.5);
        llUnSit(llAvatarOnSitTarget());
        llSetRegionPos(startPosition);
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
        llSitTarget(<0.0, 0.0, 1.0>, ZERO_ROTATION);        
        startPosition = llGetPos();  
        destination = DEFAULT_DESTINATION + <0.0, 0.0, HEIGHT_OFFSET>; 
        
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
            destination = (vector)data + <0.0, 0.0, HEIGHT_OFFSET>;
        }  
    }
   
    changed(integer change)
    {
        if(CHANGED_LINK)
        {
            teleport(destination);
        }
        else if(CHANGED_INVENTORY)
        {
            llResetScript();   
        }
    }
}