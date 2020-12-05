function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if item:getId() == 6898 then
		if player:getStorageValue(PlayerStorageKeys.RookgaardTutorialIsland.ZirellaNpcGreetStorage) > 7 then
			item:transform(item.itemid + 1)
			player:teleportTo(toPosition, true)
		else
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "The door seems to be sealed against unwanted intruders.")
		end
	end

	return true
end
