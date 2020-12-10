function onStepIn(creature, item, position, fromPosition)
	if creature:isPlayer() then
		return
	end

	creature:teleportTo(fromPosition, true)
end
