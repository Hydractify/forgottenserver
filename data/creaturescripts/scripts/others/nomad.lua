function onKill(creature, target)
	if not target:isMonster() then
		return true
	end

	if target:getName():lower() ~= 'nomad' then
		return true
	end

	local player = creature:getPlayer()
	if player:getStorageValue(PlayerStorageKeys.thievesGuild.Mission04) == 3 then
		player:setStorageValue(PlayerStorageKeys.thievesGuild.Mission04, 4)
	end

	return true
end
