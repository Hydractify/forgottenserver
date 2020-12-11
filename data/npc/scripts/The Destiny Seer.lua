local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, type, msg)      npcHandler:onCreatureSay(cid, type, msg)    end
function onThink()                          npcHandler:onThink()                        end

local topics = {
	[0] = {
		keywords = {"question"},
		message = "Tell me: Do you like to keep your {distance}, or do you like {close} combat?"
	},
	[1] = {
		{
			keywords = {"distance"},
			message = "Tell me: Do you prefer to fight with {bow} and {spear}, or do you want to cast {magic}?"
		},
		{
			keywords = {"close"},
			message = "Your destiny is this: go seek the knight Hykrion on this island to join the knights and become a noble defender of Tibia, a feared fighter with sword and shield.",
			func = function(cid, msg)
				npcHandler:releaseFocus(cid)
			end
		}
	},
	[2] = {
		{
			keywords = {"magic"},
			message = "Tell me: Do you prefer to {heal} and defend with the power of nature, or cast fire and {death}?"
		},
		{
			keywords = {"bow", "spear"},
			message = "Your destiny is this: Go seek the paladin Narai on this island to join the ranks of the paladins, noble hunters and rangers of the wild.",
			func = function(cid, msg)
				npcHandler:releaseFocus(cid)
			end
		}
	},
	[3] = {
		{
			keywords = {"death"},
			message = "Your destiny is this: Go seek the sorcerer Estrella on this island to become a sorcerer, a mighty wielder of deathly energies and arcane fire.",
			func = function(cid, msg)
				npcHandler:releaseFocus(cid)
			end
		},
		{
			keywords = {"heal"},
			message = "Your destiny is this: Go seek the druid Yandur on this island to be taught the ways of the sage healers and powerful masters of natural magic.",
			func = function(cid, msg)
				npcHandler:releaseFocus(cid)
			end
		}
	}
}

local function creatureSayCallback(cid, talkType, msg)
	if not npcHandler:isFocused(cid) then
		npcHandler:say("Come nearer, child, and address me.", cid)
		npcHandler:addFocus(cid)

		return false
	end

	return npcHandler:handleTopics(cid, msg, topics)
end
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new())
