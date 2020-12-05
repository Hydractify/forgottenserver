function onStepIn(creature, item, position, fromPosition)
	if not creature:isPlayer() then
		return false
	end

	-- item.uid defaults to nil?
	if creature:getStorageValue(item.actionid) == -1 and item.uid == nil then
		creature:sendTextMessage(MESSAGE_EVENT_ADVANCE, "no.")
		creature:teleportTo(fromPosition, true)
		return false
	end
	return true
end
