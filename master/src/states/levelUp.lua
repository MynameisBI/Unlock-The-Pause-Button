local OptionGroup = require 'src.gui.optionGroup'
local ConfirmButton = require 'src.gui.confirmButton'

local LevelUp = {}

local screenWidth, screenHeight = love.graphics.getDimensions()
local upgrades = {
	'damage', 'health', 'speed', 'cooldown', 'lifesteal'
}
local obstacles = {
	'invert controls', 'pedestrians'
}

function LevelUp:enter(gameState, wave)
	self.gameState = gameState
	
	self.upgradeGroup = OptionGroup(186, 50,
			upgrades[math.random(1, 3)], upgrades[math.random(1, 3)], upgrades[math.random(1, 3)]
	)
	
	self.obstacleGroup = OptionGroup(186, 370, 'damage', 'damage','damage')
	
	self.confirmButton = ConfirmButton:new(screenWidth/2 - 60, screenHeight/2 - 35,
			self.upgradeGroup, self.obstacleGroup)
end

function LevelUp:chooseUpgradeOptions()

end

function LevelUp:chooseObstacleOptions()

end

function LevelUp:update(dt)
	self.upgradeGroup:update()
	self.obstacleGroup:update()
	self.confirmButton:update()
end

function LevelUp:draw()
	self.gameState:draw()
	
	love.graphics.setColor(0, 0, 0, 0.6)
	love.graphics.rectangle('fill', 0, 0, screenWidth, screenHeight)
	
	self.upgradeGroup:draw()
	self.obstacleGroup:draw()
	self.confirmButton:draw()
end

return LevelUp