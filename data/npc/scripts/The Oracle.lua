local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

local vocation = {}
local town = {}
local destination = {}

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, type, msg)      npcHandler:onCreatureSay(cid, type, msg)    end
function onThink()                          npcHandler:onThink()                        end

local function greetCallback(cid)
	local player = Player(cid)
	local level = player:getLevel()
	if level < 8 then
		npcHandler:say("CHILD! COME BACK WHEN YOU HAVE GROWN UP!", cid)
		return false
	elseif level > 9 then
		npcHandler:say(player:getName() .. ", I CAN'T LET YOU LEAVE - YOU ARE TOO STRONG ALREADY! YOU CAN ONLY LEAVE WITH LEVEL 9 OR LOWER.", cid)
		return false
	elseif player:getVocation():getId() > 0 then
		npcHandler:say("YOU ALREADY HAVE A VOCATION!", cid)
		return false
	end
	return true
end

local function creatureSayCallback(cid, type, msg)
	if not npcHandler:isFocused(cid) then
		return false
	end

	if msgcontains(msg, "yes") then
		if npcHandler.topic[cid] == 0 then
			npcHandler:say("I WILL BRING YOU TO THE ISLAND OF DESTINY AND YOU WILL BE UNABLE TO RETURN HERE! ARE YOU SURE?", cid)
			npcHandler.topic[cid] = 1
		elseif npcHandler.topic[cid] == 1 then
			npcHandler:say("SO BE IT!", cid)

			local player = Player(cid)
			local islandOfDestiny = Town('Island Of Destiny')
			local templePosition = islandOfDestiny:getTemplePosition()

			player:setTown(islandOfDestiny)
			player:teleportTo(templePosition)

			player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
			templePosition:sendMagicEffect(CONST_ME_TELEPORT)
		end
	end

	return true
end

npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
