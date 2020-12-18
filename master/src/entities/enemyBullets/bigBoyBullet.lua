local Entity = require 'src.entities.entity'

local BigBoyBullet = Class('BigBoyBullet', Entity)

function BigBoyBullet:initialize(x, y, dir)
	Entity.initialize(self, x, y, 14, 22)
	
	self.dir = dir
	self.speed = 300
	
	self.timer = Timer()
  self.timer:after(6, function()
    self:destroy()
  end)
end

function BigBoyBullet:update(dt)
	self.timer:update(dt)
	self:translate(self.dir * self.speed * dt)
end

function BigBoyBullet:draw()
	love.graphics.setColor(1, 1, 1)
	love.graphics.draw(Sprites.enemies.bullet, self.x, self.y, 0, 1, 1,
			Sprites.enemies.bullet:getWidth()/2, Sprites.enemies.bullet:getHeight()/2)
end

function BigBoyBullet:onCollision(other)
	if other.tag == 'player' then
		other:takeDamage(20)
		self:destroy()
	end
end

return BigBoyBullet