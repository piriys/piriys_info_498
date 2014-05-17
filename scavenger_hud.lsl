//Global Constants
integer SCAVENGER_HUD_CHANNEL_IN = -498; 
integer SCAVENGER_HUD_CHANNEL_OUT = 498;
string XOR_KEY = "husky498uw!";
list VSD_LIST = 
	["Accountability", "Autonomy", "Calmness", "Courtesy",
	"Educational", "Empirical", "Environmental Stability", "Freedom from Bias",
	"Human Welfare", "Identity", "Informed Consent", "Ownership/Property",
	"Trust", "Universal Usability", "Exceptional", "Privacy"];

//Index Constants for Incoming Parameters
string AVATAR_KEY = 0;
string COMMAND = 1;
string PARAMETER = 2;

//Global Variables
integer listenHandle = 0;
list tokenList = [];

//Encode & Decode Functions (for security)
string Xor(string data)
{
     return llXorBase64(llStringToBase64(data), llStringToBase64(XOR_KEY));
}
 
string Dexor(string data) 
{
     return llBase64ToString(llXorBase64(data, llStringToBase64(XOR_KEY)));
}

//HUD Functions
ResetHUD()
{
	tokenList = [];
}

AddToken(string name)
{
	integer vsdIndex = llListFindList(VSD_LIST, [name]);
	integer itemIndex = llListFindList(tokenList, [name]);	
	
	if(vsdIndex != -1 & itemIndex == -1)
	{
		tokenList += name; 
		llSay(DEBUG_CHANNEL, llGetDisplayName(llGetOwner()) + " obtained " + name + " token.");
	}
}

RemoveToken(string name)
{
	integer itemIndex = llListFindList(tokenList, [name]);	
	
	if(itemIndex != -1)
	{
		tokenList = llDeleteSubList(tokenList, itemIndex, itemIndex);
		llSay(DEBUG_CHANNEL, llGetDisplayName(llGetOwner()) + " deleted " + name + " token.");		
	}
}

GetTokenList()
{
	key avatarKey = llGetOwner();
	string command = "RETURN_TOKEN_LIST";
	string parameter = llDumpList2String(tokenList, "##");
	
	string xorParameterList = Xor((string)avatarKey + "," + command + "," + parameter);
	
	llSay(SCAVENGER_HUD_CHANNEL_OUT, xorParameterList);
}

default
{
	state_entry()
	{
		llListenRemove(listenHandle);
		listenHandle = llListen(SCAVENGER_HUD_CHANNEL_IN, "", "", "");
	}
	
	listen(integer channel, string name, key id, string message)
	{
		list parameterList = llParseString2List(Dexor(message), ",", "");
		
		if(llGetListLength(parameters) == 3)
		{
			key avatarKey = llList2Key(parameterList, AVATAR_KEY);
			string command = llList2String(parameterList, COMMAND);
			string parameter = llList2String(parameterList, PARAMETER);
			
			if(avatarKey == llGetOwner())
			{
				if(command == "ADD_TOKEN")
				{
					AddToken(parameter);
				}
				else if(command == "REMOVE_TOKEN")
				{
					RemoveToken(parameter);
				}
				else if(command == "REQUEST_SCORE")
				{
					GetTokenList();
				}
			}
		}
	}
}

