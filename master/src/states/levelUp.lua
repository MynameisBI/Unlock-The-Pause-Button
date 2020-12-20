local OptionGroup = require 'src.gui.optionGroup'
local ConfirmButton = require 'src.gui.confirmButton'

local LevelUp = {}

local screenWidth, screenHeight = love.graphics.getDimensions()
local upgrades = {
	'damage', 'health', --'speed', 'cooldown', 'lifesteal',
	'clone',
	'pause'
}
local obstacles = {
	'game speed', 'cursor',
	'invert controls', 'ads'
}

function LevelUp:enter(gameState)
	self.gameState = gameState
	self.levelManager = gameState.levelManager
	
	local u1, u2, u3 = self:chooseFromOptions(upgrades)
	self.upgradeGroup = OptionGroup(186, 50, 'upgrade', u1, u2, u3)
	
	local o1, o2, o3 = self:chooseFromOptions(obstacles)
	self.obstacleGroup = OptionGroup(186, 370, 'obstacle', o1, o2, o3)
	
	self.confirmButton = ConfirmButton:new(screenWidth/2 - 100, screenHeight/2 - 35,
			self.upgradeGroup, self.obstacleGroup)
end


function LevelUp:chooseFromOptions(options)
	local optionIndexes = {}
	for i = 1, 3 do
		local optionIndex
		repeat
			optionIndex = math.random(1, #options)
		until (
			self:isValueInTable(optionIndex, optionIndexes) == false and
			self.levelManager:getStat(options[optionIndex]) ~= true
		)
		optionIndexes[i] = optionIndex
	end
	
	return options[optionIndexes[1]], options[optionIndexes[2]],
			options[optionIndexes[3]]
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
	
	love.graphics.setColor(0, 0, 0, 0.4)
	love.graphics.rectangle('fill', 0, 0, screenWidth, screenHeight)
	
	self.upgradeGroup:draw()
	self.obstacleGroup:draw()
	self.confirmButton:draw()
	
	local mx, my = love.mouse.getPosition()
	love.graphics.setColor(1, 1, 1)
	love.graphics.draw(Sprites.cursor, mx, my, 0, 1, 1,
			Sprites.cursor:getWidth()/2, Sprites.cursor:getHeight()/2)
end

return LevelUp