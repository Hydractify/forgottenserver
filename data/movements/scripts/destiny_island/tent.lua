function onStepIn(creature, item, position, fromPosition)
	if creature:isMonster() then
		return
	end

	local storage = PlayerStorageKeys.ChildOfDestiny

	if creature:getStorageValue(storage) < 1 then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Your way is barried. You need to talk to Neill before you can enter.")
	end
end
