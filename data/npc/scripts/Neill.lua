local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

local storage = PlayerStorageKeys.ChildOfDestiny.quest

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, type, msg)      npcHandler:onCreatureSay(cid, type, msg)    end
function onThink()                          npcHandler:onThink()                        end

local voices = {
	{ text = "Come, one and all! Come and enjoy our grand festival!" },
	{ text = "Enter our tents and choose your destiny!" },
	{ text = "Close quarter combat, swords and shields! Have at it!" },
	{ text = "Rookies! Initiates! Friends! Lend me your ears!" }
}
npcHandler:addModule(VoiceModule:new(voices))

local function greetCallback(cid)
	local player = Player(cid)

	if player:getStorageValue(storage) > 0 then
		npcHandler:say("Hello there! Having fun, I see. Just proceed to the other combat training tents or to a vocation trainer if you're certain about your destiny.", cid)

		return false
	end

	return true
end
npcHandler:setCallback(CALLBACK_GREET, greetCallback)

local topics = {
	[0] = {
		keywords = {"yes", "festival"},
		message = {
			"Indeed! As you willl have to choose your {vocation} soon, this festival will help you decide by showing you each vocation's unique style and techniques. ...",
			"In each tent, a combat trainer will show you his vocation's special fighting technique. So you can find out which vocation suits you best! ...",
			"Don't worry, it's all for fun, just to show you the principle, and won't hurt. {OK}?"
		}
	},
	[1] = {
		keywords = {"yes", "ok"},
		message = {
			"Good! Each of the combat and vocation trainers can give you details about his or her vocation, just ask them. ...",
			"So, shall we {start} your festival tour? Of course, if you already know which vocation to choose, you can also {skip} the tour entirely. What do you say?"
		}
	},
	[2] = {
		keywords = {"start"},
		message = {
			"Alright, here we go! On Rookgaard, you already had a first taste of how we proud knights fight: up close and personal. We're always first in a melee and the strongest heroes in Tibia. ...",
			"That means, in a fight we go to a monster and hit it upfront with a weapon. That's no job for weaklings, so we knights have a strong defense and many hitpoints to be able to hold out against damage. Are you {ready}?"
		}
	},
	[3] = {
		keywords = {"ready"},
		message = "Good! You already fought on Rookgaard, so you probably have a weapon. Or do you need a {sword}?"
	},
	[4] = function(cid, msg)
		local player = Player(cid)

		if isInArray({"yes", "sword"}, msg:lower()) then
			npcHandler:say({
				"Here's a training sword. Some last hints - knights fight with a shield and weapon. Remember: we fight at the front, so we need good armor. We're tough, but we don't fight from a distance or heal others. Always have a health potion ready! ...",
				"if you need a shield, take one from the box, left of the entrance. It will hold off two enemies at once. ...",
				"Have fun and make your way through this tent, past the skeletons. The next tent's just north of this one. I hear they fight from a little distance in there. Huh. Well."
			}, cid)

			player:addItem(ItemType("mean knight sword"):getId())
			player:setStorageValue(storage, 1)
		end

		if msgcontains(msg, "no") then
			npcHandler:say({
				"Good. Some last hints - knights fight with shield and weapon. Remember: we fight at the front, so we need good armor. We're tough, but we don't fight from a distance or heal others. Always have a health potion ready! ...",
				"If you need a shield, take one from the box, left of the entrance. It will hold off two enemies at once. ...",
				"Have fun and make your way through this tent, past the skeletons. The next tent's just north of this one. I hear they fight from a little distance in there. Huh. Well."
			}, cid)

			player:setStorageValue(storage, 1)
		end

		return false
	end
}

local function creatureSayCallback(cid, talkType, msg)
	if not npcHandler:isFocused(cid) then
		return false
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
