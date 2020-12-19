local Decoration = require 'src.decorations.decoration'

local AfterImage = Class('AfterImage', Decoration)

local disappearSpeed = 2.34

function AfterImage:initialize(x, y, isFlipped)
	Decoration.initialize(self, x, y)
	
	if isFlipped then self.sx = 1
	else self.sx = -1
	end
	
	self.opacity = 0.85
end

function AfterImage:update(dt)
	self.opacity = self.opacity - disappearSpeed * dt
	
	if self.opacity < 0 then
		self:destroy()
	end
end

function AfterImage:draw()
	love.graphics.setColor(1, 1, 1, self.opacity)
	love.graphics.draw(Sprites.player.topHat.normal, self.x, self.y - 10,
			0, self.sx, 1, 17 * (self.sx / 2 + 0.5), 30)
end

return AfterImage