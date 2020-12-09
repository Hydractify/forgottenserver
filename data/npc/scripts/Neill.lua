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

local function creatureSayCallback(cid, type, msg)
	if not npcHandler:isFocused(cid) then
		return false
	end

	if npcHandler.topic[cid] == 0 then
		if not msgcontains(msg, "yes") and not msgcontains(msg, "festival") then
			return false
		end

		npcHandler:say({
			"Indeed! As you willl have to choose your {vocation} soon, this festival will help you decide by showing you each vocation's unique style and techniques. ...",
			"In each tent, a combat trainer will show you his vocation's special fighting technique. So you can find out which vocation suits you best! ...",
			"Don't worry, it's all for fun, just to show you the principle, and won't hurt. {OK}?"
		}, cid)

		npcHandler.topic[cid] = 1
	end

	if npcHandler.topic[cid] == 1 then
		if not msgcontains(msg, "yes") and not msgcontains(msg, "ok") then
			return false
		end

		npcHandler:say({
			"Good! Each of the combat and vocation trainers can give you details about his or her vocation, just ask them. ...",
			"So, shall we {start} your festival tour? Of course, if you already know which vocation to choose, you can also {skip} the tour entirely. What do you say?"
		}, cid)

		npcHandler.topic[cid] = 2
	end

	if npcHandler.topic[cid] == 2 then
		if not msgcontains(msg, "start") then
			return false
		end

		npcHandler:say({
			"Alright, here we go! On Rookgaard, you already had a first taste of how we proud knights fight: up close and personal. We're always first in a melee and the strongest heroes in Tibia. ...",
			"That means, in a fight we go to a monster and hit it upfront with a weapon. That's no job for weaklings, so we knights have a strong defense and many hitpoints to be able to hold out against damage. Are you {ready}?"
		}, cid)

		npcHandler.topic[cid] = 3
	end

	if npcHandler.topic[cid] == 3 then
		if not msgcontains(msg, "ready") then
			return false
		end

		npcHandler:say("Good! You already fought on Rookgaard, so you probably have a weapon. Or do you need a {sword}?", cid)

		npcHandler.topic[cid] = 4
	end

	if npcHandler.topic[cid] == 4 then
		if not msgcontains(msg, "yes") and not msgcontains(msg, "sword") then
			return false
		end

		npcHandler:say({
			"Here's a training sword. Some last hints - knights fight with a shield and weapon. Remember: we fight at the front, so we need good armor. We're tough, but we don't fight from a distance or heal others. Always have a health potion ready! ...",
			"if you need a shield, take one from the box, left of the entrance. It will hold off two enemies at once. ...",
			"Have fun and make your way through this tent, past the skeletons. The next tent's just north of this one. I hear they fight from a little distance in there. Huh. Well."
		}, cid)

		local player = Player(cid)

		player:setStorageValue(storage, 1)
		player:addItem(ItemType("mean knight sword"):getId())
	end

	return true
end
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new())
