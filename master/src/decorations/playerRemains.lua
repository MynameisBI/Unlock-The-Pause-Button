local Decoration = require 'src.decorations.decoration'

local PlayerRemains = Class('PlayerRemains', Decoration)

local colors = {
	{205/255, 104/255, 61/255, 0.85},
	{171/255, 148/255, 122/255, 0.85},
	{98/255, 85/255, 101/255, 0.85}
}

function PlayerRemains:initialize(x, y)
	Decoration.initialize(self, x, y)
	
	self.color = colors[math.random(1, 3)]
	
	self.timer = Timer()
	self.timer:after(180, function()
		self:destroy()
	end)
	
	local vect = Vector(0, math.random(35, 80))
	self.target = Vector(x, y) + vect:rotated(math.random(0, 30) * (math.pi * 2 / 30))
	self.timer:tween(0.6, self, {x = self.target.x, y = self.target.y}, 'out-cubic')
end

function PlayerRemains:update(dt)
	self.timer:update(dt)
end

function PlayerRemains:draw()
	love.graphics.setColor(self.color)
	love.graphics.rectangle('fill', self.x-3, self.y-3, 6, 6)
end

return PlayerRemains