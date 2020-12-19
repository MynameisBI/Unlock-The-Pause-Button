local Decoration = Class('Decoration')

function Decoration:initialize(x, y)
	self.x, self.y = x, y
	self.isDestroyed = false
end

function Decoration:update(dt)
end

function Decoration:draw()
end

function Decoration:guiDraw()
end

function Decoration:translate(dir)
	self.x = self.x + dir.x
	self.y = self.y + dir.y
end

function Decoration:destroy()
	self.isDestroyed = true
end

return Decoration