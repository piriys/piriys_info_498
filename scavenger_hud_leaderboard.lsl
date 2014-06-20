/*
Piriya Saengsuwarn
This work is licensed under a Creative Commons Attribution-NonCommercial 4.0 International License.
http://creativecommons.org/licenses/by-nc/4.0/
*/

//Global Constants
string SINGLEPLAYER_API_URL = "http://www.crimsondash.com/SLapi/api/MB/CreateSPGameSession?";
string GAME_NAME = "Value Sensitive Design Scavenger Hunt";
string SEPERATOR = "|||";
integer SCAVENGER_HUD_CHANNEL = -498; 
integer SCAVENGER_OBJECT_CHANNEL = 498;
string XOR_KEY = "husky498uw!";
integer HUD_FRONT_FACE = 1;

/*Command Constants*/
integer SUBMIT_SCORE = 0;
integer RESET_SCORE = 1;

/*Index Constants for Incoming Parameters*/
integer GAME_VERSION = 0;
integer TIME_ELAPSED = 1;
integer DECOY_COUNT = 2;

key requestLeaderboard = NULL_KEY;

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

    }
    
    link_message(integer source, integer num, string str, key id)
    {
        if(num == SUBMIT_SCORE)
        {
            list parameters = llParseString2List(str, [SEPERATOR], [""]);
            string gameVersion = llList2String(parameters, GAME_VERSION);
            integer timeElapsed = llList2Integer(parameters, TIME_ELAPSED);
            integer decoyCount = llList2Integer(parameters, DECOY_COUNT); 
                     
            string scoreDisplay = "Calculating score...";

            integer totalScore = 10000;
            
            totalScore = totalScore + 10000;
            scoreDisplay = scoreDisplay + "\nCompletion: +10000"; 
            
            integer timeBonus = (1800 - timeElapsed) * 60; 
            
            if(timeBonus > 0)
            {
                totalScore = totalScore + timeBonus;
                scoreDisplay = scoreDisplay + "\nTime Bonus: +" + (string)timeBonus;
            }
            
            if(decoyCount == 0)
            {
                totalScore = totalScore + 6000;
                scoreDisplay = scoreDisplay + "\nPerfect Run: +6000";
            }
            else
            {
                if(decoyCount < 10)
                {
                    integer decoyBonus = 6000 - (600 * decoyCount);
                    
                    if(decoyCount > 0)
                    {
                        totalScore = totalScore + decoyBonus;
                        scoreDisplay = scoreDisplay + "\nDecoy Bonus: +" + (string)decoyBonus;
                    }
                }                
            }
            
            scoreDisplay = scoreDisplay + "\nTotal Score: " + (string)totalScore;
            llOwnerSay(scoreDisplay);
            
            string sessionParameters = "PlayerID=" + (string)llGetOwner() +  
                "&PlayerName=" + llKey2Name(llGetOwner()) + 
                "&GameName=" +  GAME_NAME + 
                "&GameVersionName=" + gameVersion +
                "&SessionScore=" + (string)totalScore;
            
            llReleaseURL(SINGLEPLAYER_API_URL);  
            requestLeaderboard = llHTTPRequest(SINGLEPLAYER_API_URL, [HTTP_METHOD,"POST", HTTP_MIMETYPE,"application/x-www-form-urlencoded"], sessionParameters);
        }
        else if(num == RESET_SCORE)
        {
            llResetScript();
        }
    }
    
    http_response(key request_id, integer status, list metadata, string body)
    {
        if (request_id == requestLeaderboard)
        {
            if(status == 201)
            {
                llOwnerSay("Score submission completed! Please view your score at: " + "http://www.crimsondash.com/marshmallowbrigade/Leaderboard/SpGame/5");
            }
            else 
            {
                llOwnerSay("Score submission failed. Please try again later.");                
            }
        }
    }        
}