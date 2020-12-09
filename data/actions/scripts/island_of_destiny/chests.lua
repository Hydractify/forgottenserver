local chests = {
	[55000] = PlayerStorageKeys.ChildOfDestiny.shieldChest,
	[55001] = PlayerStorageKeys.ChildOfDestiny.potionChest
}

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local storage = chests[item.uid]

	if player:getStorageValue(storage) > 0 then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "The " .. item:getName() .. " is empty.")

		return true
	end

	local resultText = ""

	local reward = Container(item.uid):getItem(0):clone()
	if reward:getArticle() ~= "" then
		resultText = reward:getArticle() .. " " .. reward:getName()
	else
		resultText = reward:getName()
	end

	if player:addItemEx(reward) ~= RETURNVALUE_NOERROR then
		local weight = reward:getWeight()
		if player:getFreeCapacity() < weight then
			player:sendCancelMessage(string.format('You have found %s weighing %.2f oz. You have no capacity.', resultText, (weight / 100)))
		else
			player:sendCancelMessage('You have found ' .. resultText .. ', but you have no room to take it.')
		end

		return true
	end

	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'You have found ' .. resultText .. '.')
	player:setStorageValue(storage, 1)

	return true
end
