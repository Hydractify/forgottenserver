function onKill(creature, target)
	if not target:isMonster() then
		return true
	end

	if target:getName():lower() ~= 'black knight' then
		return true
	end

	local player = creature:getPlayer()
	if player:getStorageValue(PlayerStorageKeys.secretService.AVINMission04) == 1 then
		player:setStorageValue(PlayerStorageKeys.secretService.AVINMission04, 2)
	end

	return true
end
