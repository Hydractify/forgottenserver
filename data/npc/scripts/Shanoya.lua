local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

local questStorage = PlayerStorageKeys.ChildOfDestiny.quest

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, type, msg)      npcHandler:onCreatureSay(cid, type, msg)    end
function onThink()                          npcHandler:onThink()                        end

local voices = {
	{ text = "Want the best of all vocations? Become a paladin!" },
	{ text = "Master the bow to shoot an arrow in the knee!" },
	{ text = "Be a Jack of all trades, be a paladin!" },
	{ text = "Noble hunter, versatile adventurer - that's the paladin!" }
}
npcHandler:addModule(VoiceModule:new(voices))

local topics = {
	[0] = {
		keywords = {"yes", "ok"},
		message = {
			"You see, we paladins are the true distance fighter vocation. Nobody covers a long distance like we do! Spears, bow and arow, throwing stars... you name it, we master it. ...",
			"See that chest there? Take some spears from it and aim at the party skeletons. If a spear breaks, you can get a new one from the chest every 60 seconds. ...",
			"Drag your spear to your weapon slot, right-click a monster on the map or battle list, and choose 'attack'. If you mastered the principle, just go to the next tent while I - clean up the mess. <sigh>"
		},
		func = function(cid)
			local player = Player(cid)

			player:setStorageValue(questStorage, 3)
		end
	}
}

local function creatureSayCallback(cid, talkType, msg)
	if not npcHandler:isFocused(cid) then
		return false
	end

	local topic = topics[npcHandler.topic[cid]]

	if not isInArray(topic.keywords, msg:lower()) then
		return false
	end

	npcHandler:say(topic.message, cid)
	npcHandler.topic[cid] = npcHandler.topic[cid] + 1

	if type(topic.func) == "function" then
		topic.func(cid)
	end

	return true
end
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new())
