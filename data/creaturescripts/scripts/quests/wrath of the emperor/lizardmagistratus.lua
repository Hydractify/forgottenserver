function onKill(creature, target)
	if not target:isMonster() then
		return true
	end

	if target:getName():lower() ~= 'lizard magistratus' then
		return true
	end

	local player = creature:getPlayer()
	local storage = player:getStorageValue(PlayerStorageKeys.WrathoftheEmperor.Mission06)
	if storage >= 0 and storage < 4 then
		player:setStorageValue(PlayerStorageKeys.WrathoftheEmperor.Mission06, math.max(1, storage) + 1)
	end

	return true
end
