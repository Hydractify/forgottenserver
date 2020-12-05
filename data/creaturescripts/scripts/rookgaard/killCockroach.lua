function onKill(creature, target)
	if not target:isMonster() then
		return true
	end

	if target:getName():lower() ~= 'cockroach' then
		return true
	end

	local player = creature:getPlayer()

	local cockroachKills = player:getStorageValue(PlayerStorageKeys.RookgaardTutorialIsland.cockroachKillStorage)

	if cockroachKills < 1 then
		player:sendTutorial(8)
		player:setStorageValue(PlayerStorageKeys.RookgaardTutorialIsland.cockroachKillStorage, 1)

	elseif cockroachKills == 1 then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You can also automatically chase after selected creatures by clicking the 'chase opponent' button in the Combat Controls menu.")
		player:setStorageValue(PlayerStorageKeys.RookgaardTutorialIsland.cockroachKillStorage, 2)

		player:sendTutorial(18)
		player:sendTutorial(38)

	elseif cockroachKills == 2 then
		player:setStorageValue(PlayerStorageKeys.RookgaardTutorialIsland.cockroachKillStorage, 3)

		if player:getStorageValue(PlayerStorageKeys.RookgaardTutorialIsland.SantiagoNpcGreetStorage) == 5 then
			player:setStorageValue(PlayerStorageKeys.RookgaardTutorialIsland.SantiagoNpcGreetStorage, 6)
		end
	end

	return true
end
