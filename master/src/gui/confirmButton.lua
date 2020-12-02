local ConfirmButton = Class('ConfirmButton')

function ConfirmButton:initialize(x, y, upgradeGroup, obstacleGroup)
	self.x, self.y = x, y
	
	self.suit = Suit.new()
	
	self.upgradeGroup = upgradeGroup
	self.obstacleGroup = obstacleGroup
end

function ConfirmButton:update(dt)
	local x, y, w, h = self.x, self.y, 120, 70
	local upgrade, obstacle = self.upgradeGroup:getSelectedOption(), self.obstacleGroup:getSelectedOption()
	
	if upgrade ~= nil and obstacle ~= nil then
		if self.suit:Button('CONFIRM', x, y, w, h).hit then
			Gamestate.pop(upgrade, obstacle)
		end
	
	else
		-- draw disabled button
	end
end

function ConfirmButton:draw()
	self.suit:draw()
end

return ConfirmButton