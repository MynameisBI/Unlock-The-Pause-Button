local Bullet = require 'src.entities.bullets.bullet'

local TheBlastBullet = Class('TheBlastBullet', Bullet)

function TheBlastBullet:initialize(x, y, dir)
  Bullet.initialize(self, x, y, 10, 10, dir)
  self.speed = 940 + (math.random() * 2 - 1) * 60
end

function TheBlastBullet:draw()
  love.graphics.setColor(0.5, 0.4, 0)
  love.graphics.circle('fill', self.x, self.y, 5)
end

function TheBlastBullet:onCollision(other)
  local levelManager = Gamestate.current().levelManager
  
  if other.tag == 'enemy' then
    other:takeDamage(
        3 * (1 + Gamestate.current().levelManager:getStat('damage')/4)
    )
    Gamestate.current().playerManager:heal(
        3 * (1 + levelManager:getStat('damage')/4) * (levelManager:getStat('lifesteal')/10)
    )
		self:destroy()
  end
end

return TheBlastBullet