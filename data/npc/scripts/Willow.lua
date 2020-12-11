local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, type, msg)      npcHandler:onCreatureSay(cid, type, msg)    end
function onThink()                          npcHandler:onThink()                        end

local keywords = {
	["nature"] = {
		"Mother Nature is our element, the element of the {druids}. ...",
		"If you want to learn how to use the magical forces of nature, and not just use a crude weapon, talk to {Salbra}. She will teach you the use of {runes} and {spells}"
	},
	["druid"] = {
		"We are healers, and versed in the use of ice and earth magic. We seek the balance of things. ...",
		"{Salbra} will teach you how to use {spells} and {runes}, should you wish to learn the ways of magic."
	},
	["spell"] = {
		"Spells are words of wisdom and power that perform magic in the world. ...",
		"Salbra will tell you how to learn them."
	},
	["runes"] = {
		"Runes are stones that store spells. ...",
		"Each rune can hold only one spell and can only be used once. ...",
		"{Salbra} will tell you how to make spell runes, if you wish to learn."
	}
}

function creatureSayCallback(cid, talkType, msg)
	if not npcHandler:isFocused(cid) then
		return false
	end

	for keyword, message in pairs(keywords) do
		if msgcontains(msg, keyword) then
			npcHandler:say(message, cid)

			return false
		end
	end

	return true
end
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new())
