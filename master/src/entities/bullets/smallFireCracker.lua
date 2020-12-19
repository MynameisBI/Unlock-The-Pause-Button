local Bullet = require 'src.entities.bullets.bullet'

local SmallFireCracker = Class('SmallFireCracker', Bullet)

function SmallFireCracker:initialize(x, y, dir)
  Bullet.initialize(self, x, y, 16, 16, dir)
  self.speed = 750
end

function SmallFireCracker:draw()
  local sprite = Sprites.player.bullets.smallFireCraker
  love.graphics.setColor(1, 1, 1)
  love.graphics.draw(sprite, self.x, self.y, self.dir.angle, 1, 1,
      sprite:getWidth()/2, sprite:getHeight()/2)
end

function SmallFireCracker:onCollision(other)
  local levelManager = Gamestate.current().levelManager
  
  if other.tag == 'enemy' and other.isDead == false then
    other:takeDamage(
        2 * (1 + levelManager:getStat('damage')/3)
    )
    Gamestate.current().playerManager:heal(
        5 * (1 + levelManager:getStat('damage')/3) * (levelManager:getStat('lifesteal')/10)
    )
		self:destroy()
  
  end
end

return SmallFireCracker