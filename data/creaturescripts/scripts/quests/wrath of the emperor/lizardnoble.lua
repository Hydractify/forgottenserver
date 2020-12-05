function onKill(creature, target)
	if not target:isMonster() then
		return true
	end

	if target:getName():lower() ~= 'lizard noble' then
		return true
	end

	local player = creature:getPlayer()
	local storage = player:getStorageValue(PlayerStorageKeys.WrathoftheEmperor.Mission07)
	if storage >= 0 and storage < 6 then
		player:setStorageValue(PlayerStorageKeys.WrathoftheEmperor.Mission07, math.max(1, storage) + 1)
	end

	return true
end
