local config = {
	-- ordered by chance, the last chance being 100
	{chance = 30,  monster = 'Enraged White Deer',   message = 'The white deer summons all his strength and turns to fight!'},
	{chance = 100, monster = 'Desperate White Deer', message = 'The white deer desperately tries to escape!'}
}

function onDeath(creature, corpse, killer, mostDamageKiller, unjustified, mostDamageUnjustified)
	if not target:isMonster() or target:getMaster() then
		return true
	end

	local chance = math.random(100)
	for i = 1, #config do
		if chance <= config[i].chance then
			local spawnMonster = Game.createMonster(config[i].monster, target:getPosition(), true, true)
			if spawnMonster then
				spawnMonster:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
				target:say(config[i].message, TALKTYPE_MONSTER_SAY)
			end
			break
		end
	end
	return true
end
