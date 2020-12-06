local OptionGroup = require 'src.gui.optionGroup'
local ConfirmButton = require 'src.gui.confirmButton'

local LevelUp = {}

local screenWidth, screenHeight = love.graphics.getDimensions()
local upgrades = {
	'damage', 'health', 'speed', 'cooldown', 'lifesteal',
	'clone',
	'pause'
}
local obstacles = {
	'invert controls', 'pedestrians'
}

function LevelUp:enter(gameState)
	self.gameState = gameState
	self.levelManager = gameState.levelManager
	
	local o1, o2, o3 = self:chooseUpgradeOptions()
	self.upgradeGroup = OptionGroup(186, 50, 'clone', o2, o3)
	
	self.obstacleGroup = OptionGroup(186, 370, 'damage', 'damage','damage')
	
	self.confirmButton = ConfirmButton:new(screenWidth/2 - 60, screenHeight/2 - 35,
			self.upgradeGroup, self.obstacleGroup)
end


function LevelUp:chooseUpgradeOptions()
	local upgradeOptionIndexes = {}
	for i = 1, 3 do
		local optionIndex
		repeat
			optionIndex = math.random(1, #upgrades)
		until (
			self:isValueInTable(optionIndex, upgradeOptionIndexes) == false and
			self.levelManager:getStat(upgrades[optionIndex]) ~= true
		)
		upgradeOptionIndexes[i] = optionIndex
	end
	
	return upgrades[upgradeOptionIndexes[1]], upgrades[upgradeOptionIndexes[2]],
			upgrades[upgradeOptionIndexes[3]]
end

function LevelUp:chooseObstacleOptions()

end

function LevelUp:isValueInTable(v, t)
	for i = 1, #t do
		if v == t[i] then
			return true
		end
	end
	return false
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