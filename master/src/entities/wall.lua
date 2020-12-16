local Entity = require 'src.entities.entity'

local Wall = Class('Wall', Entity)

function Wall:initialize(x, y, w, h)
	Entity.initialize(self, x, y, w, h)
	self.tag = 'wall'
end

return Wall