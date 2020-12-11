function onStepIn(creature, item, position, fromPosition)
	if creature:isMonster() then
		return
	end

	if item.actionid == 6004 then
		if creature:getStorageValue(PlayerStorageKeys.ChildOfDestiny.quest) > 3 then
			creature:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Congratulations, initiate! Go to your vocation trainer and choose your destiny!")
		end
	end

	if item.actionid == 6002 then
		if creature:getStorageValue(PlayerStorageKeys.ChildOfDestiny.quest) > 3 then
			creature:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Congratulations, initiate! Go to your vocation trainer and choose your destiny!")
			creature:getPosition():sendMagicEffect(CONST_ME_GIFT_WRAPS)
		end
	end
end
