local ConfirmButton = Class('ConfirmButton')

local sw, sh = love.graphics.getDimensions()

function ConfirmButton:initialize(x, y, upgradeGroup, obstacleGroup)
	self.x, self.y = x, y
	
	self.suit = Suit.new()
	
	self.upgradeGroup = upgradeGroup
	self.obstacleGroup = obstacleGroup
end

function ConfirmButton:update(dt)
	local x, y, w, h = self.x, self.y, 200, 70
	local upgrade, obstacle = self.upgradeGroup:getSelectedOption(), self.obstacleGroup:getSelectedOption()
	
	if upgrade ~= nil and obstacle ~= nil then
		if self.suit:Button('CONFIRM', {font = Fonts.menuFont_small}, x, y, w, h).hit then
			Gamestate.pop(upgrade, obstacle)
		end
	end
end

function ConfirmButton:draw()
	self.suit:draw()
	
	local upgrade, obstacle = self.upgradeGroup:getSelectedOption(), self.obstacleGroup:getSelectedOption()
	if upgrade == nil or obstacle == nil then
		love.graphics.setColor(0.4, 0.4, 0.4, 0.8)
		love.graphics.setFont(Fonts.menuFont_small)
		love.graphics.print('CONFIRM', sw/2, sh/2 - 16, 0, 1, 1,
				Fonts.menuFont_small:getWidth('CONFIRM')/2)
	end
end

return ConfirmButton