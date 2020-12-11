local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, type, msg)      npcHandler:onCreatureSay(cid, type, msg)    end
function onThink()                          npcHandler:onThink()                        end

local function creatureSayCallback(cid, talkType, msg)
	if not npcHandler:isFocused(cid) then
		return false
	end

	if msgcontains(msg, "tylius") then
		npcHandler:say({
			"He's sooo cute. <blushes> ...",
			"I mean, he's an apprentice sorcerer, like me. He's in this tent right here. He's really good in staff and rod combat, you should totally check it out!"
		}, cid)

		return false
	end

	return true
end
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new())
