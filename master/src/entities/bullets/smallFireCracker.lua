local Bullet = require 'src.entities.bullets.bullet'

local SmallFireCracker = Class('SmallFireCracker', Bullet)

function SmallFireCracker:initialize(x, y, dir)
  Bullet.initialize(self, x, y, 8, 8, dir)
  self.speed = 750
end

function SmallFireCracker:draw()
  love.graphics.setColor(0.7, 0.7, 0.8)
  love.graphics.circle('fill', self.x, self.y, 4)
end

function SmallFireCracker:onCollision(other)
  local levelManager = Gamestate.current().levelManager
  
  if other.tag == 'enemy' then
    other:takeDamage(
        2 * (1 + levelManager:getStat('damage')/4)
    )
    Gamestate.current().playerManager:heal(
        5 * (1 + levelManager:getStat('damage')/4) * (levelManager:getStat('lifesteal')/10)
    )
		self:destroy()
  end
end

return SmallFireCracker