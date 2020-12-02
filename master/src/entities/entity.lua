local Entity = Class('Entity')

function Entity:initialize(x, y, w, h)
	self.x, self.y = x, y
	self.w, self.h = w, h
	self.isDestroyed = false
	
	Gamestate.current().bumpWorld:add(self, x - w/2, y - h/2, w, h)
end

function Entity:update(dt)
end

function Entity:draw()
end

function Entity:translate(dir)
	self.x = self.x + dir.x
	self.y = self.y + dir.y
	
	local ax, ay, cols, len = Gamestate.current().bumpWorld:move(self,
			self.x - self.w/2, self.y - self.h/2, function() return 'cross' end)
	
	for i = 1, len do
		local other = cols[i].other
		if not other.isDestroyed and not self.isDestroyed then
			self:onCollision(other)
		end
	end
end

function Entity:onCollision(other)
end

function Entity:destroy()
	self.isDestroyed = true
end

return Entity