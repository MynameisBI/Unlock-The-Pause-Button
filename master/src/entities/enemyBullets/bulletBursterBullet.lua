local Entity = require 'src.entities.entity'

local BulletBursterBullet = Class('BulletBursterBullet', Entity)

function BulletBursterBullet:initialize(x, y, dir)
	Entity.initialize(self, x, y, 6, 6)
	
	self.dir = dir
	self.speed = 330
end

function BulletBursterBullet:update(dt)
	self:translate(self.dir * self.speed * dt)
end

function BulletBursterBullet:draw()
	love.graphics.setColor(0.8, 0.5, 0.5)
	love.graphics.circle('fill', self.x, self.y, 3)
end

function BulletBursterBullet:onCollision(other)
	if other.tag == 'player' then
		other:takeDamage(3)
		self:destroy()
	end
end

return BulletBursterBullet