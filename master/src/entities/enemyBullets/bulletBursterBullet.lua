local Entity = require 'src.entities.entity'

local BulletBursterBullet = Class('BulletBursterBullet', Entity)

function BulletBursterBullet:initialize(x, y, dir)
	Entity.initialize(self, x, y, 14, 14)
	
	self.dir = dir
	self.speed = 470
	
	self.timer = Timer()
  self.timer:after(6, function()
    self:destroy()
  end)
end

function BulletBursterBullet:update(dt)
	self.timer:update(dt)
	self:translate(self.dir * self.speed * dt)
end

function BulletBursterBullet:draw()
	love.graphics.setColor(1, 1, 1)
	love.graphics.draw(Sprites.enemies.bullet, self.x, self.y, 0, 1, 1,
			Sprites.enemies.bullet:getWidth()/2, Sprites.enemies.bullet:getHeight()/2)
end

function BulletBursterBullet:onCollision(other)
	if other.tag == 'player' then
		other:takeDamage(12)
		self:destroy()
	
	elseif other.tag == 'wall' then
		self:destroy()
		
	end
end

return BulletBursterBullet