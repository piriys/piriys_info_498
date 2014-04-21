integer PLANETARIUM_CHANNEL = 42;
string TEXTURE_NOTECARD_NAME  = "Planetarium Texture List";
string END_OF_FILE_LINE = "###END OF FILE";

integer changeTextureIndex = 0;
integer loadTextureIndex = 1; //skip header

list textureNameList = [];
list textureKeyList = [];
list rotationSettingList = [];

key lineDataRequest = "";
integer listenHandle;

changeTexture()
{    
    if(changeTextureIndex >= llGetListLength(textureKeyList))
    {
        changeTextureIndex = 0;  
    } 
    
    string textureName = llList2String(textureNameList, changeTextureIndex); 
    key textureKey = llList2Key(textureKeyList, changeTextureIndex);
    integer rotationSetting = llList2Integer(rotationSettingList, changeTextureIndex);
    
    llSay(PUBLIC_CHANNEL, textureName);
    llSetTexture(textureKey, ALL_SIDES);

    if(rotationSetting)
    {
        llSetTextureAnim(ANIM_ON |SMOOTH| LOOP, ALL_SIDES, 0, 0, 0.0, 0.0, 0.01);
    } 
    else
    {
        llSetTextureAnim(FALSE, ALL_SIDES, 0, 0, 0.0, 0.0, 1.0);        
    }  
    
    changeTextureIndex++;  
}

default
{
    on_rez(integer start_param)
    {
        llResetScript();   
    }
    
    state_entry()
    {
        llSetTexture(TEXTURE_BLANK, ALL_SIDES);
        state loading_textures;
    }
}

state loading_textures
{
    on_rez(integer start_param)
    {
        llResetScript();   
    }
        
    state_entry()
    {  
        llSay(PUBLIC_CHANNEL, "Loading spherical texture list...");
        
        loadTextureIndex = 1;
        
        textureNameList =[];
        textureKeyList = [];
        rotationSettingList = [];
        
        lineDataRequest = "";           

        lineDataRequest = llGetNotecardLine(TEXTURE_NOTECARD_NAME, loadTextureIndex);   
    }
     
    dataserver(key request, string data)
    {      
        //llOwnerSay("Dataserver reached. Data: " + data);

        if(request == lineDataRequest)
        {
            if(data != EOF && data != END_OF_FILE_LINE)
            {
                list texture = llParseString2List(data, ["###"], [""]); 
            
                string textureName = llList2Key(texture, 0);
                key textureKey = llList2Key(texture, 1);
                integer rotationSetting = llList2Integer(texture, 2);
                
                textureNameList = textureNameList + textureName;
                textureKeyList = textureKeyList + textureKey;
                rotationSettingList = rotationSettingList + rotationSetting;  
                loadTextureIndex++;
                lineDataRequest = llGetNotecardLine(TEXTURE_NOTECARD_NAME, loadTextureIndex);    
            }
            else
            {
                //llOwnerSay(llDumpList2String(textureKeyList, ","));                   
				//llOwnerSay(llDumpList2String(rotationSettingList, ","));                 
                state ready;   
            } 
        } 
    }      
}

state ready
{
    on_rez(integer start_param)
    {
        llResetScript();   
    }
        
    state_entry()
    {
        llSay(PUBLIC_CHANNEL, "Planetarium ready. " + (string)llGetListLength(textureNameList) + " texture(s) loaded. Click to change texture.");
        changeTextureIndex = 0;
        changeTexture();  
        
        listenHandle = llListen(PLANETARIUM_CHANNEL, "", llGetOwner(), "");
    } 
    
    state_exit()
    {
        llListenRemove(listenHandle);
    }  
    
    touch_start(integer num_detected)
    {
        changeTexture();   
    } 
    
    listen(integer channel, string name, key id, string message)
    {
        if(message == "reload")
        {
            state loading_textures;    
        }    
    }    
}

