local Bullet = require 'src.entities.bullets.bullet'

local DoubleTapBullet = Class('DoubleTapBullet', Bullet)

function DoubleTapBullet:initialize(x, y, dir)
  Bullet.initialize(self, x, y, 14, 14, dir)
  self.speed = 840
end

function DoubleTapBullet:draw()
  love.graphics.setColor(0.5, 0.4, 0)
  love.graphics.circle('fill', self.x, self.y, 7)
end

function DoubleTapBullet:onCollision(other)
  if other.tag == 'enemy' then
    other:takeDamage(5)
		self:destroy()
  end
end

return DoubleTapBullet