local bossForms = {
	['snake god essence'] = {
		text = 'IT\'S NOT THAT EASY MORTALS! FEEL THE POWER OF THE GOD!',
		newForm = 'snake thing'
	},
	['snake thing'] = {
		text = 'NOOO! NOW YOU HERETICS WILL FACE MY GODLY WRATH!',
		newForm = 'lizard abomination'
	},
	['lizard abomination'] = {
		text = 'YOU ... WILL ... PAY WITH ETERNITY ... OF AGONY!',
		newForm = 'mutated zalamon'
	}
}

function onKill(player, target)
	if not target:isMonster() then
		return true
	end

	if target:getName():lower() == 'mutated zalamon' then
		Game.setStorageValue(PlayerStorageKeys.WrathoftheEmperor.Mission11, -1)
		return true
	end

	local bossConfig  = bossForms[target:getName():lower()]
	if not bossConfig then
		return true
	end

	Game.createMonster(bossConfig.newForm, target:getPosition(), false, true)
	player:say(bossConfig.text, TALKTYPE_MONSTER_SAY)
	return true
end
