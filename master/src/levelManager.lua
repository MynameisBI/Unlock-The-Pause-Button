local LevelUp = require 'src.states.levelUp'

local LevelManager = Class('LevelManager')

function LevelManager:initialize()
	self.statsAddition = {
		damage = 0,
		health = 0,
		speed = 0,
		cooldown = 0,
		lifesteal = 2,
		
		pause = false,
	}
	
	self.obstacles = {
		['game speed'] = 0,
		['invert controls'] = false,
		ads = 0,
	}
end

function LevelManager:onWaveFinish(currentWave)
	Gamestate.current():queueState(LevelUp)
end

function LevelManager:handleOptions(upgrade, obstacle)
	self:handleUpgrade(upgrade)
	self:handleObstacle(obstacle)
end

function LevelManager:handleUpgrade(upgrade)
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

function LevelManager:handleObstacle(obstacle)
	if obstacle == 'game speed' then
		self.obstacles['game speed'] = self.obstacles['game speed'] + 1
		
	elseif obstacle == 'cursor' then
		Gamestate.current().cursorManager:addCursor(3)
		
	elseif obstacle == 'invert controls' then
		self.obstacles['invert controls'] = not self.obstacles['invert controls']
		
	elseif obstacle == 'ads' then
		self.obstacles.ads = self.obstacles.ads + 1
		Gamestate.current().adManager.secondsToSpawnAd = 2.5
		
	end
end

function LevelManager:getStat(stat)
	return self.statsAddition[stat]
end

function LevelManager:getObstacle(obstacle)
	return self.obstacles[obstacle]
end

return LevelManager