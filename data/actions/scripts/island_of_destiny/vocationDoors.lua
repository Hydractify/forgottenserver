local Vocations = {
	SORCERER = 1,
	DRUID = 2,
	PALADIN = 3,
	KNIGHT = 4
}

local doors = {
	[55005] = Vocations.SORCERER
}

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:getVocation():getId() == doors[item.uid] then
		item:transform(item.itemid + 1)
		player:teleportTo(toPosition, true)

		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "In this room, open all chests and equip yourself with what you find in there. Afterwards, you can hunt in the dungeon below.")
	else
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "The door seems to be sealed against unwanted intruders.")
	end

	return true
end
