function onStepOut(creature, item, position, fromPosition)
	if creature:isPlayer() and creature:isInGhostMode() then
		return true
	end

	if item:getId() == 670 then
		item:transform(6594)
	else
		item:transform(item.itemid + 15)
	end

	if creature:isPlayer() then
		creature:addAchievementProgress("Snowbunny", 10000)
	end

	item:decay()
	return true
end
