local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

local questStorage = PlayerStorageKeys.ChildOfDestiny.quest
local spellStorage = PlayerStorageKeys.ChildOfDestiny.spellsUsed

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, type, msg)      npcHandler:onCreatureSay(cid, type, msg)    end
function onThink()                          npcHandler:onThink()                        end

local voices = {
	{ text = "It's a kind of magic!" },
	{ text = "How to heal your party? I can teach you!" },
	{ text = "The fine arts of magic - rune and spellcraft!" },
	{ text = "Heal the world - make a better place!" },
	{ text = "Runes and spells - a beginner's guide!" }
}
npcHandler:addModule(VoiceModule:new(voices))

local function greetCallback(cid)
	local player = Player(cid)

	if player:getStorageValue(spellStorage) == 1 then
		npcHandler:setMessage(MESSAGE_GREET, "Hi there! Do you want to hear {again} what I just said or do you prefer to {proceed} to the next chapter: distance fight runes?")

	elseif player:getStorageValue(spellStorage) == 2 then
		npcHandler:setMessage(MESSAGE_GREET, "Hi there! Do you want to {proceed} to healing, or dou want to hear what I said {again}, and get a new rune?")
	end

	return true
end
npcHandler:setCallback(CALLBACK_GREET, greetCallback)

local topics = {
	[0] = {
		keywords = {"yes", "ready"},
		message = {
			"Lovely! There are two types of casting magic: spells and runes. Runes are magic spells stored in special stones. To cast a spell, you need to have learned the spell first. To use a rune, you onlt need to use the rune. ...",
			"But only DRUIDS and SORCERERS have a high enough MAGIC LEVEL to use spells or runes properly. ...",
			"Now, spells, they have to be learned before you can use them. Later on, you will have to find your specific teachers, but for now, I know some fine spells to teach you the principle. {Ready}?"
		}
	},
	[1] = {
		keywords = {"yes", "ready"},
		message = "Your new spell can be cast anytime by saying 'exevo dis flam hur'. Go and test it on the monsters over there, then come back!",
		func = function(cid)
			local player = Player(cid)

			player:learnSpell("exevo dis flam hur")
			player:setStorageValue(spellStorage, 1)

			npcHandler:releaseFocus(cid)

			return false
		end
	},
	[2] = function(cid, msg)
		if msgcontains(msg, "proceed") then
			npcHandler:say("Very well, now we we'll talk about attack runes, this will be fun! Are you {ready}?", cid)
			npcHandler.topic[cid] = npcHandler.topic[cid] + 1
		end

		if msgcontains(msg, "again") then
			npcHandler:say("Your new spell can be cast anytime by saying 'exevo dis flam hur'. Go and test it on the monsters over there, then come back!", cid)

			npcHandler:releaseFocus(cid)
		end

		return false
	end,
	[3] = {
		keywords = {"yes", "ready"},
		message = {
			"Using attack runes is simple: just right-click on the rune. If it's a rune that needs a target like a missile or healing rune, you need to click on the target on the map or battle list afterwards. Other runes need no target. ...",
			"Just walk to the counter and see if you can hit the monster from there."
		},
		func = function(cid)
			local player = Player(cid)

			player:addItem(ItemType("light magic missile rune"):getId(), 10)
			player:setStorageValue(spellStorage, 2)

			npcHandler:releaseFocus(cid)

			return false
		end
	},
	[4] = function(cid, msg)
		if msgcontains(msg, "proceed") then
			npcHandler:say("Of course! I will now tell you something about healing yourself. Are you {ready}?", cid)
			npcHandler.topic[cid] = npcHandler.topic[cid] + 1
		end

		if msgcontains(msg, "again") then
			npcHandler:say({
				"Using attack runes is simple: just right-click on the rune. If it's a rune that needs a target like a missile or healing rune, you need to click on the target on the map or battle list afterwards. Other runes need no target. ...",
				"Just walk to the counter and see if you can hit the monster from there."
			}, cid)

			npcHandler:releaseFocus(cid)
		end

		return false
	end,
	[5] = {
		keywords = {"yes", "ready"},
		message = "That's easy, you have just learned 'exura dis', an easy healing spell. Now, type in the spell's magic words, 'exura dis', in your chatbar, {OK}?",
		func = function(cid)
			local player = Player(cid)

			player:learnSpell("exura dis")

			return false
		end
	},
	[6] = {
		keywords = {"yes", "ok"},
		message = {
			"BAM! Now heal yourself! ...",
			"If it doesn't work, please make sure you have enough mana. There's a mana potion in the chest, just in case you need it. ...",
			"It worked, {yes}?"
		}
	},
	[7] = {
		keywords = {"yes"},
		message = {
			"Great! You can of course use some healing spells on OTHERS, too. But keep in mind, ONLY A DRUID can HEAL OTHERS with a SPELL. Why would you want this? Well, other players will want to have you in their party if you are a druid! ...",
			"Now that was about all I had to tell you. Please proceed east and then north through the Gate of Initiates! ...",
			"Good luck, and find a vocation that suits your style at the 4 vocation trainers: Sorcerer Estrella, Knight Hykrion, Druid Yandur and Paladin Narai!"
		},
		func = function(cid, msg)
			local player = Player(cid)

			player:setStorageValue(questStorage, 4)

			npcHandler:releaseFocus(cid)

			return false
		end
	}
}

local function creatureSayCallback(cid, talkType, msg)
	if not npcHandler:isFocused(cid) then
		return false
	end

	local player = Player(cid)

	if npcHandler.topic[cid] == 0 then
		if player:getStorageValue(spellStorage) == 1 then
			npcHandler.topic[cid] = 2
		elseif player:getStorageValue(spellStorage) == 2 then
			npcHandler.topic[cid] = 4
		end
	end

	local topic = topics[npcHandler.topic[cid]]

	if type(topic) == "function" then
		return topic(cid, msg)
	end

	if not isInArray(topic.keywords, msg:lower()) then
		return false
	end

	npcHandler:say(topic.message, cid)
	npcHandler.topic[cid] = npcHandler.topic[cid] + 1

	if type(topic.func) == "function" then
		topic.func(cid, msg)
	end

	return true
end
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new())
