local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, type, msg)      npcHandler:onCreatureSay(cid, type, msg)    end
function onThink()                          npcHandler:onThink()                        end

local voices = {
	{ text = "Are you injured? Come and get a free healing at my little hut." },
	{ text = "Sometimes it's not the loudest voice which has the most valuable information to give." },
	{ text = "If you like to choose a druid's way of life, talk to me." },
	{ text = "Follow your instincts and let nature guide you." }
}
npcHandler:addModule(VoiceModule:new(voices))

local Routes = {
	MAIN = 0,
	INFO = 1
}
local route = {}

local mainRoute = {
	[0] = {
		{
			keywords = {"yes"},
			message = "I'm happy to hear that, dear |PLAYERNAME|. I'll gladly give you some {information} or help you to become a {druid} right away. What would you prefer?"
		},
		{
			keywords = {"no"},
			message = "That's sad, but maybe you just lack some {information} about our beautiful vocation?"
		},
		{
			keywords = {""},
			message = "No, no, you are given the choice between receiving {information} or becoming a {druid} if you've already made up your mind."
		}
	},
	[1] = {
		{
			keywords = {"information"},
			message = "Depending on how much time you have, I can either give you the {short} or the {detailed} version. Choose whatever suits you most!",
			func = function(cid, msg)
				route[cid] = Routes.INFO
			end
		},
		{
			keywords = {"druid"},
			message = "Are you sure that you have all needed information and are ready to become a druid forever?",
			filter = function(cid, msg)
				return Player(cid):getVocation():getId() == 0
			end,
			func = function(cid, msg)
				npcHandler.topic[cid] = 2
			end
		}
	},
	[2] = {
		{
			keywords = {"yes"},
			message = "That's good to hear, |PLAYERNAME|. Since this is such an important decision, I have to ask you, though, whether you have gotten all the information that you need?"
		}
	},
	[3] = {
		{
			keywords = {"no"},
			message = "Well, ask me about anything. I'll gladly give you more {information}. You can also talk to {Hykrion}, {Estrella} or {Narai} about the other vocations. Maybe they suit you better.",
			func = function(cid, msg)
				npcHandler.topic[cid] = 0
			end
		},
		{
			keywords = {"yes"},
			message = "Be aware that this decision is final, |PLAYERNAME|! Step in front of me and announce it proudly: DO YOU WANT TO BE A DRUID?"
		}
	},
	[4] = {
		{
			keywords = {"no"},
			message = "Well, maybe you need some more time. Just make sure you choose the right vocation for you, no matter if it's the druid profession or something else. Talk to the other vocation masters, too, and take care!",
			func = function(cid, msg)
				npcHandler:releaseFocus(cid)
			end
		},
		{
			keywords = {"yes"},
			message = {
				"SO BE IT! Let the energy of nature fill you, druid |PLAYERNAME|! Learn the words of your first three spells: 'UTEVO LUX', 'EXURA' and 'EXORI MIN FLAM'! Light, Light healing and Apprentice's strike. ...",
				"You may cast it by saying the magic words 'UTEVO LUX', 'EXURA' and 'EXORI MIN FLAM' while you have enough mana. Also, you have earned the right to enter the cellar of this house. What you will find inside the chests there is yours to take. ...",
				"Equip yourself well and gather some experience in the caves below. You may stay there for a while, but you should leave for the main continent soon. ...",
				"The captain on the ship to the north will bring you to a city of your choice when you are prepared. Farewell, young druid, and don't hesitate to ask me if you have any questions."
			},
			func = function(cid, msg)
				Player(cid):setVocation(2)

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
			message = "In short: Druids are focused on ice, earth and healing magic. We use runes, spells and rods to hunt our enemies and usually try to avoid body contact. Easy, right?",
			func = function(cid, msg)
				routeInfo[cid] = InfoRoutes.SHORT
			end
		},
		{
			keywords = {"detailed"},
			message = "That's wonderful. As a druid, your spirit is close to nature and its power. Your aim is also to protect your friends with powerful healing magic. Can you follow me so far?",
			func = function(cid, msg)
				routeInfo[cid] = InfoRoutes.DETAILED
			end
		}
	},
	[3] = {
		{
			keywords = {"no", "yes"},
			message = "Well, anyway |PLAYERNAME|, after having learnt a few basic things about druids, do you think that vocation would be fine for you?",
			filter = function(cid, msg)
				return routeInfo[cid] == InfoRoutes.SHORT
			end
		},
		{
			keywords = {"no"},
			message = "Well, in short, druids use nature spells and healing magic. Can you follow me so far?",
			filter = function(cid, msg)
				return routeInfo[cid] == InfoRoutes.DETAILED
			end,
			func = function(cid, msg)
				npcHandler.topic[cid] = 2
			end
		},
		{
			keywords = {"yes"},
			message = "Good. Don't assume that druids are weak and can't defend themselves. Our magic is as strong as that of sorcerers, just in a different way. Do you understand that so far?",
			filter = function(cid, msg)
				return routeInfo[cid] == InfoRoutes.DETAILED
			end
		}
	},
	[4] = {
		{
			keywords = {"no"},
			message = "Well, the other vocations have their own advantages and disadvantages. Maybe you will find something more suitable for you by talking to {Hykrion}, {Estrella} and {Narai}. Come and talk to me anytime!",
			filter = function(cid, msg)
				return routeInfo[cid] == InfoRoutes.SHORT
			end,
			func = function(cid, msg)
				route[cid] = Routes.MAIN
				npcHandler.topic[cid] = 0
			end
		},
		{
			keywords = {"no"},
			message = "To say in easy words: Druids and sorcerers have similar powers, but different types of spells. Do you understand that so far?",
			filter = function(cid, msg)
				return routeInfo[cid] == InfoRoutes.DETAILED
			end,
			func = function(cid, msg)
				npcHandler.topic[cid] = 3
			end
		},
		{
			keywords = {"yes"},
			message = "Good. Whereas sorcerers call forth hellfire and death itself, druids ask nature for assistance to conjure powerful ice storms and rock showers. Can you follow me so far?",
			filter = function(cid, msg)
				return routeInfo[cid] == InfoRoutes.DETAILED
			end
		}
	},
	[5] = {
		{
			keywords = {"no"},
			message = "I said, the difference between sorcerer and druid spells is the focus. Sorcerers use black magic and druids white magic, so to speak. Can you follow me so far?",
			func = function(cid, msg)
				npcHandler.topic[cid] = 4
			end
		},
		{
			keywords = {"yes"},
			message = "Like all mages, we do not have that much health and should be careful when fighting strong monsters, but we can easily keep our distance and deal great damage anyway. Do you understand?"
		}
	},
	[6] = {
		{
			keywords = {"no"},
			message = "To put this differently: Don't get hit by monsters. Rather shoot spells on them from a distance as druids don't have a lot of hit points. Do you understand?",
			func = function(cid, msg)
				npcHandler.topic[cid] = 5
			end
		},
		{
			keywords = {"yes"},
			message = "Good. Last but not least, we can create runes storing magic power and enchant gems and elemental shrines to be used in weapons. Do you understand that so far?"
		}
	},
	[7] = {
		{
			keywords = {"no"},
			message = "Well, I just said that druids can create runes and enchant gems which are used in weapons. Do you understand that so far?",
			func = function(cid, msg)
				npcHandler.topic[cid] = 6
			end
		},
		{
			keywords = {"yes"},
			message = "Once a druid reaches character level 20, he or she can receive a vocation promotion and become an elder druid. Did you listen to everything I told you?"
		}
	},
	[8] = {
		{
			keywords = {"no"},
			message = "Again, at level 20 a druid can be promoted to an elder druid. Did you understand everything I told you?",
			func = function(cid, msg)
				npcHandler.topic[cid] = 7
			end
		},
		{
			keywords = {"yes"},
			message = "So, dear |PLAYERNAME|, let's test your newly gained knowledge! Let me ask you: How is a promoted druid called? {Master Druid}, {Elder Druid} or {Royal Druid}?"
		}
	},
	[9] = {
		{
			keywords = {"master druid"},
			message = "I'm sorry |PLAYERNAME|, but the sorcerers are the ones which gain a 'Master' title. We druids will become 'Elder'. Another question for you: Name one of the elements we mastered - is it {ice}, {holy} or {fire}?"
		},
		{
			keywords = {"royal druid"},
			message = "I'm sorry |PLAYERNAME|, but the paladins are the ones which gain a 'Royal' title. We druids will become 'Elder'. Another question for you: Name one of the elements we mastered - is it {ice}, {holy} or {fire}?"
		},
		{
			keywords = {"elite druid"},
			message = "I'm sorry |PLAYERNAME|, but the knights are the ones which gain an 'Elite' title. We druids will become 'Elder'. Another question for you: Name one of the elements we mastered - is it {ice}, {holy} or {fire}?"
		},
		{
			keywords = {"elder druid"},
			message = "Yes, well done! Elder druids are well respected among Tibians. Another question for you: Name one of the elements we mastered - is it {ice}, {holy} or {fire}?"
		}
	},
	[10] = {
		{
			keywords = {"ice"},
			message = "Very good |PLAYERNAME|, you remembered that detail about the ice storms. Next question: Where are magically enchanted gems used? In {weapons}, as {decoration} or as {food}?"
		},
		{
			keywords = {"holy"},
			message = "Although one can easily mistake healing magic for 'holy magic', it's not the same thing. Only paladins can use holy magic. So just try again: {Fire}, {Ice} or {earth}?",
			func = function(cid, msg)
				npcHandler.topic[cid] = 9
			end
		},
		{
			keywords = {"fire"},
			message = "That's rather a sorcerer's job, although we can use some basic fire magic, too. You may want to try again: {ice} or {holy}?",
			func = function(cid, msg)
				npcHandler.topic[cid] = 9
			end
		},
		{
			keywords = {""},
			message = "What element is this supposed to be? I know only {earth}, {fire}, {ice}, {energy}, {death} and {holy}.",
			func = function(cid, msg)
				npcHandler.topic[cid] = 9
			end
		}
	},
	[11] = {
		{
			keywords = {"weapon"},
			message = "Right, enchanted gems add elemental damage to weapons. I have one last question for you, |PLAYERNAME|. What do you think a druid will spend most of his money on - buying {runes} or buying {weapons}?"
		},
		{
			keywords = {"decoration"},
			message = {
				"Well... although some may use them for decoration, that's not their main purpose. They are used on weapons to add elemental damange. ...",
				"I have one last question for you, |PLAYERNAME|. What do you think a druid will spend most of his money on - buying {runes} or buying {weapons}?"
			}
		},
		{
			keywords = {"food"},
			message = {
				"...",
				"I have one last question for you, |PLAYERNAME|. What do you think a druid will spend most of his money on - buying {runes} or buying {weapons}?"
			}
		}
	},
	[12] = {
		{
			keywords = {"rune"},
			message = "Right, altough we need of course some basic equipment, most of our money is spent on buying new runes and mana potions. That was easy, don't you think?"
		},
		{
			keywords = {"weapon"},
			message = "Although we can use weapons, spells and runes are so much more effective. This is why we usually buy runes and mana potions. That was easy, don't you think?"
		}
	},
	[13] = {
		keywords = {"no", "yes"},
		message = "Well, anyway |PLAYERNAME|, after having learnt a few basic things about druids, do you think that vocation would be fine for you?",
		filter = function(cid, msg)
			return Player(cid):getVocation():getId() == 0
		end,
		func = function(cid, msg)
			npcHandler.topic[cid] = 1
			route[cid] = Routes.MAIN
		end
	}
}

local routeTopics = {
	[Routes.MAIN] = mainRoute,
	[Routes.INFO] = infoRoute,
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

local keywords = {
	{
		keywords = {{"hykrion"}},
		text = "He's never afraid to fight for his friends. He can have quite a bad temper, though, if you catch him on the wrong foot."
	},
	{
		keywords = {{"estrella"}},
		text = "I respect every being... even if it's an arrogant self-centered as Estrella, haha. Just kidding, below the surface she's a decent person."
	},
	{
		keywords = {{"narai"}},
		text = "One of the most warmhearted and gentle people I know."
	},
	{
		keywords = {{"vocation"}},
		text = "This might be one of the biggest choices you have to make. All the other vocations - {druids}, {sorcerers}, {paladins} and {knights} - have their good sides."
	},
	{
		keywords = {{"sorcerer"}},
		text = "Sorcerers are on the more destructive side of elemental magic, but otherwise very similar to us. Talk to {Estrella} if you want to know more."
	},
	{
		keywords = {{"paladin"}},
		text = "Paladins are very good distance fighters and even blessed with some magic skills. Talk to {Narai} if you want to know more."
	},
	{
		keywords = {{"knight"}},
		message = "Knights are capable fighters and excellent blockers. Talk to {Hykrion} if you want to know more."
	}
}
keywordHandler:addBulkKeywords(StdModule.say, keywords, npcHandler)

npcHandler:addModule(FocusModule:new())
