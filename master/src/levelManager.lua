local LevelUp = require 'src.states.levelUp'

local LevelManager = Class('LevelManager')

function LevelManager:initialize()
	self.statsAddition = {
		damage = 0,
		health = 0,
		speed = 0,
		cooldown = 0,
		lifesteal = 0
	}
	
	self.talents = {
	
	}
	
	self.obstacles = {
	
	}
end

function LevelManager:onWaveFinish(currentWave)
	--Gamestate.push(LevelUp)
	Gamestate.current():queueState(LevelUp)
end

function LevelManager:handleOptions(upgrade, obstacle)
	if upgrade == 'damage' then
		self.damage = self.damage + 1
		
	elseif upgrade == 'health' then
		self.health = self.health + 1
		
	elseif upgrade == 'speed' then
		self.speed = self.speed + 1
		
	elseif upgrade == 'health' then
		self.cooldown = self.cooldown + 1
		
	elseif upgrade == 'lifesteal' then
		self.lifesteal = self.lifesteal + 1
		
	end
end

return LevelManager