local Entity = require 'src.entities.entity'

local BigBoyBullet = Class('BigBoyBullet', Entity)

function BigBoyBullet:initialize(x, y, dir)
	Entity.initialize(self, x, y, 8, 8)
	
	self.dir = dir
	self.speed = 330
end

function BigBoyBullet:update(dt)
	self:translate(self.dir * self.speed * dt)
end

function BigBoyBullet:draw()
	love.graphics.setColor(0.9, 0.75, 0.5)
	love.graphics.circle('fill', self.x, self.y, 4)
end

function BigBoyBullet:onCollision(other)
	if other.tag == 'player' then
		other:takeDamage(5)
		self:destroy()
	end
end

return BigBoyBullet