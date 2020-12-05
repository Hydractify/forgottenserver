function onDeath(creature, corpse, lasthitkiller, mostdamagekiller, lasthitunjustified, mostdamageunjustified)
	if not target:isMonster() or target:getMaster() then
		return true
	end

	local chance = math.random(100)
	if chance <= 10 then
		for i = 1, 2 do
			local spawnMonster = Game.createMonster('Elf Scout', target:getPosition(), true, true)
			if spawnMonster then
				spawnMonster:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
			end
		end

		target:say('The elves came too late to save the deer, however they might avenge it.', TALKTYPE_MONSTER_SAY)
	end
end
