local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			    npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		    npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)	end
function onThink()				            npcHandler:onThink()					    end

local keywordTable = {
	[0] = {
        keywords = {{"shanoya"}},
        text = "She is top of our class and our combat trainer. Formidable with the spear! You should see her. A true huntress."
    },
    [1] = {
        keywords = {{"name"}},
        text = " I am Willem, prentice paladin to the honourable Narai."
    },
    [2] = {
        keywords = {{"paladin"}},
        text = "The noblest of vocations. Roam the forests as a {ranger}! Hunt with the {hunters}! Slay {unholy} beasts!"
    },
    [3] = {
        keywords = {{"unholy"}},
        text = "Undead creatures like mummies, ghouls or vampires. We paladins slay them with our unique gift of holy {magic}. But our primary weapon to hunt monsters is the bow or spear."
    },
}
keywordHandler:addBulkKeywords(keywordTable, npcHandler)


npcHandler:addModule(FocusModule:new())
