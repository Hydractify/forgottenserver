local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

local storage = PlayerStorageKeys.ChildOfDestiny.quest

function onCreatureAppear(cid)			    npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		    npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)	end
function onThink()				            npcHandler:onThink()					    end

local voices = {
    { text = "Weak punch? Deal out some heavy damage with magic!"},
    { text = "Wield a staff - the magician's weapon!"},
}

npcHandler:addModule(VoiceModule:new(voices))

local function creatureSayCallback(cid, type, msg)
    if not npcHandler:isFocused(cid) then
        return false
    end
    if npcHandler.topic[cid] == 0 then
        if not msgcontains(msg, "yes") then
            return false
        end

        npcHandler:say({
            "Good. We magic weilders prefer to fight from a distance, as our defense and armour is a lot weaker than that of the kinghts. But we deal a lot more damage with a hit than they do. ...",
            "Stay at a little distance from a monster. too far away: the staff won't hit the monster; come too close and the monster will hit YOU. ...",
            "First, drag your staff to the weapon slot in your Inventory to use it. Then, to attack, RIGHT-CLICK on a monster on the screen or battle list and choose 'ATTACK'. ...",
            "Remember that a staff also needs {mana} to work, so make sure you always have some food, or you won't regenerate mana. There's food in the chest outside, and some blueberry bushes. Oh yes, one other thing: mana will only be regenerated inside tents. ...",
            "{Ready} for the staff?"
        }, cid)

        npcHandler.topic[cid] = 1
        return false
    end

    if npcHandler.topic[cid] == 1 then
        if not msgcontains(msg, "yes") and not msgcontains(msg, "Ready") then 
            return false
        end
        npcHandler:say({
            "Alright, let's get started!<snaps fingers> Here's your staff! Just drag it from your inventory to your weapon slot to use it. ...",
            "<chuckles> Have a blast and just visit Shanoya next door to try out mundane distance weapons, too, afterwards."
        }, cid)

        local player = Player(cid)

        player:setStorageValue(storage, 2)
        player:addItem(ItemType("sorc and druid staff"):getId())
        return false
    end

    return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new())
