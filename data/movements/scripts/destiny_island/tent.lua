function onStepIn(creature, item, position, fromPosition)
	if creature:isMonster() then
		return
	end

	local storage = PlayerStorageKeys.ChildOfDestiny.quest

	if creature:getStorageValue(storage) < 1 then
		creature:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Your way is barried. You need to talk to Neill before you can enter.")
		creature:teleportTo(fromPosition, true)
	end
end
