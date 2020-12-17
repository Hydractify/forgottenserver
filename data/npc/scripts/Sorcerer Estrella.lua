local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, type, msg)      npcHandler:onCreatureSay(cid, type, msg)    end
function onThink()                          npcHandler:onThink()                        end

local Routes = {
	MAIN = 0,
	INFO = 1
}
local route = {}

local mainRoute = {
	[0] = {
		keywords = {"yes", "right"},
		message = "Well, I'm not surprised to hear that. I can either give you some more {information} or invite you into the {sorcerers} guild right away. What do you prefer?"
	},
	[1] = {
		{
			keywords = {"information"},
			message = "Improving your knowledge is always a wise choice. Now, I can make this very {short} and just give you a basic description or some {detailed} information. What would you like?",
			func = function(cid, msg)
				route[cid] = Routes.INFO
			end
		},
		{
			keywords = {"sorcerer"},
			message = "Are you sure that you are wise enough to become one of us sorcerers and gathered all the needed information?"
		}
	},
	[2] = {
		{
			keywords = {"yes"},
			message = "Be aware that this decision is final, |PLAYERNAME|! Step in front of me and announce it proudly: DO YOU WANT TO BE A SORCERER?"
		},
		{
			keywords = {"no"},
			message = "Yes, you obviously require more knowledge. I can make this very {short} and just give you a basic description or some {detailed} information. What would you like?"
		}
	},
	[3] = {
		{
			keywords = {"yes"},
			message = {
				"SO BE IT! Rise and feel the power, sorcerer |PLAYERNAME|! Learn the words of your first three spells: 'UTEVO LUX', 'EXURA' and 'EXORI MIN FLAM'! light, light healing, Apprentice's strike. ...",
				"You may cast it by saying the magic words 'UTEVO LUX', 'EXURA' or 'EXORI MIN FLAM' while you have enough mana. Also, you have earned the right to enter the cellar of this house. What you find inside the chests there, is yours to take. ...",
				"Equip yourself well and gather some experience in the caves below. You may stay here for a while, but you should leave for the main continent soon. ...",
				"The captain on the ship to the north will bring you to a city of your choice when you are prepared. Farewell, young sourcerer, and don't hesitate to ask me if you have any questions."
			},
			func = function(cid, msg)
				Player(cid):setVocation(1)

				npcHandler:releaseFocus(cid)
			end
		},
		{
			keywords = {"no"},
			message = "Quite a few students back out in the last minute. You have to decide at some time, though. Come back when your mind is clear about your decision. Farewell!",
			func = function(cid, msg)
				npcHandler:releaseFocus(cid)
			end
		}
	}
}

local InfoRoutes = {
	NONE = 0,
	SHORT = 1,
	DETAILED = 2
}
local routeInfo = {}

local infoRoute = {
	[2] = {
		{
			keywords = {"short"},
			message = "In short: Sorcerers focus on fire, death and energy magic. We use runes, spells and wands to hunt our enemies and usually try to avoid body contact. Got that?",
			func = function(cid, msg)
				routeInfo[cid] = InfoRoutes.SHORT
			end
		},
		{
			keywords = {"detailed"},
			message = "Fine then. As powerful and noble elemental magicians we mastered fire, energy and death magic. We can dish out some earth and ice magic too and heal ourselves quite well. Can you follow me so far?",
			func = function(cid, msg)
				routeInfo[cid] = InfoRoutes.DETAILED
			end
		}
	},
	[3] = {
		{
			keywords = {"yes"},
			message = "Well, that was really just some basic information, but still, do you think the sorcerer vocation might be suited for you?",
			filter = function(cid, msg)
				return routeInfo[cid] == InfoRoutes.SHORT
			end,
			func = function(cid, msg)
				route[cid] = Routes.MAIN
			end
		},
		{
			keywords = {"yes"},
			message = "Good. As our real strengths are our mind and skill, you will not find us carrying tons of resources. Also, we have no shielding against strong attacks like knights do. Is that clear so far?",
			filter = function(cid, msg)
				print(routeInfo[cid])
				return routeInfo[cid] == InfoRoutes.DETAILED
			end
		}
	},
	[4] = {
		keywords = {"yes"},
		message = "Fine. We don't have as much life energy as we have magic energy - mana -, thus you have to be careful and avoid getting hit by stronger monsters. Did you understand that?"
	},
	[5] = {
		keywords = {"yes"},
		message = "Very well. Experienced sorcerers are very good at shooting their enemies from a distance while using haste spells to outrun their attacks. They are also one of the main damage dealers in a hunting party. Can you follow me so far?"
	},
	[6] = {
		keywords = {"yes"},
		message = "Good. Last but not least, we create runes storing magic power and enchant gems at elemental shrines to be used in weapons. At character level 20, we can receive a vocation promotion and become master sorcerers. Do you understand that?"
	},
	[7] = {
		keywords = {"yes"},
		message = "Very well. Since you, my aspiring student, were listening so patiently, I will now test your knowledge! Do sorcerers have higher {health} or higher {mana}?"
	},
	[8] = {
		keywords = {"mana"},
		message = "True, our magic power is stronger. You'll notice that within a few levels if you become a sorcerer. Next question: Name one of the elements which we mastered - is it {earth}, {holy} or {fire}?"
	},
	[9] = {
		keywords = {"fire"},
		message = "Correct, fire is one of our strenghts, as well as energy and death. Let's move on: Do you think of a sorcerer as a {damage} dealer or as a {blocker} of attacks?"
	},
	[10] = {
		keywords = {"damage"},
		message = "Muahahah! Yes! A sorcerer's magic power shouldn't be understimated! Now, a material question - what do you think a sorcerer spends his or her money on? Choose one among those: {runes}, {weapons} or {women}!"
	},
	[11] = {
		keywords = {"runes"},
		message = "Indeed, good answer. Most of your hunting income will very likely be spent on runes and mana potions. Now, since you have been such a good student, I'd like to ask you whether you think you might enjoy being a sorcerer, {yes} or {no}?"
	},
	[12] = {
		keywords = {"yes"},
		message = "Aha! So, are you sure that you are wise enough to become one of us sorcerers and gatheered all the information?",
		func = function(cid, msg)
			npcHandler.topic[cid] = 2
			route[cid] = Routes.MAIN
		end
	}
}

local sorcRoute = {
	[2] = {
		{
			keywords = {"no"},
			message = "Yes, you obviously require more knowledge. I can make this very {short} and just give you a basic description or some {detailed} information. What would you like?",
			func = function(cid, msg)
				npcHandler.topic[cid] = 2
				route[cid] = Routes.INFO
			end
		}
	}
}

local routeTopics = {
	[Routes.MAIN] = mainRoute,
	[Routes.INFO] = infoRoute
}

local function creatureSayCallback(cid, talkType, msg)
	if not npcHandler:isFocused(cid) then
		return false
	end

	return npcHandler:handleTopics(cid, msg, routeTopics[route[cid]])
end
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

local function onAddFocus(cid)
	route[cid] = Routes.MAIN
	routeInfo[cid] = InfoRoutes.NONE
end
npcHandler:setCallback(CALLBACK_ONADDFOCUS, onAddFocus)

local function onReleaseFocus(cid)
	route[cid] = nil
	routeInfo[cid] = nil
end
npcHandler:setCallback(CALLBACK_ONRELEASEFOCUS, onReleaseFocus)

npcHandler:addModule(FocusModule:new())
