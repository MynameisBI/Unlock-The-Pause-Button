local LevelUp = require 'src.states.levelUp'

local LevelManager = Class('LevelManager')

function LevelManager:initialize()
	self.statsAddition = {
		damage = 0,
		health = 0,
		speed = 0,
		cooldown = 0,
		lifesteal = 1,
		
		pause = false,
	}
	
	self.obstacles = {
	
	}
end

function LevelManager:onWaveFinish(currentWave)
	Gamestate.current():queueState(LevelUp)
end

function LevelManager:handleOptions(upgrade, obstacle)
	if upgrade == 'damage' then
		self.statsAddition.damage = self.statsAddition.damage + 1
	
	elseif upgrade == 'health' then
		self.statsAddition.health = self.statsAddition.health + 1
	
	elseif upgrade == 'speed' then
		self.statsAddition.speed = self.statsAddition.speed + 1
	
	elseif upgrade == 'cooldown' then
		self.statsAddition.cooldown = self.statsAddition.cooldown + 1
	
	elseif upgrade == 'lifesteal' then
		self.statsAddition.lifesteal = self.statsAddition.lifesteal + 1
	
		
	elseif upgrade == 'clone' then
		Gamestate.current().playerManager:addNewPlayer()
		
	
	elseif upgrade == 'pause' then
		self.statsAddition.pause = true
		
		
	end
end

function LevelManager:getStat(stat)
	return self.statsAddition[stat]
end

function LevelManager:getObstacle(obstacle)
	return self.obstacles[obstacle]
end

return LevelManager