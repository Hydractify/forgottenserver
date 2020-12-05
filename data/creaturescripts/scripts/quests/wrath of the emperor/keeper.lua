function onKill(creature, target)
	if not target:isMonster() then
		return true
	end

	if target:getName():lower() == 'the keeper' then
		Game.setStorageValue(PlayerStorageKeys.WrathoftheEmperor.Mission03, 0)
	end
	return true
end
