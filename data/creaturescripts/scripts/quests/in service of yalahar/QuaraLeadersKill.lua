local quaraLeaders = {
	['inky'] = PlayerStorageKeys.InServiceofYalahar.QuaraInky,
	['sharptooth'] = PlayerStorageKeys.InServiceofYalahar.QuaraSharptooth,
	['splasher'] = PlayerStorageKeys.InServiceofYalahar.QuaraSplasher
}

function onKill(creature, target)
	if not target:isMonster() then
		return true
	end

	local bossStorage = quaraLeaders[target:getName():lower()]
	if not bossStorage then
		return true
	end

	local player = creature:getPlayer()
	if player:getStorageValue(bossStorage) < 1 then
		player:setStorageValue(bossStorage, 1)
		player:say('You slayed ' .. target:getName() .. '.', TALKTYPE_MONSTER_SAY)
		player:setStorageValue(PlayerStorageKeys.InServiceofYalahar.QuaraState, 2)
		player:setStorageValue(PlayerStorageKeys.InServiceofYalahar.Questline, 41)
		-- StorageValue for Questlog 'Mission 07: A Fishy Mission'
		player:setStorageValue(PlayerStorageKeys.InServiceofYalahar.Mission07, 4)
	end
	return true
end
