local Bullet = require 'src.entities.bullets.bullet'

local DoubleTapBullet = Class('DoubleTapBullet', Bullet)

function DoubleTapBullet:initialize(x, y, dir)
  Bullet.initialize(self, x, y, 18, 18, dir)
  self.speed = 840
end

function DoubleTapBullet:draw()
  local sprite = Sprites.player.bullets.doubleTapBullet
  love.graphics.setColor(1, 1, 1)
  love.graphics.draw(sprite, self.x, self.y, self.dir.angle, 1, 1,
      sprite:getWidth()/2, sprite:getHeight()/2)
end

function DoubleTapBullet:onCollision(other)
  local levelManager = Gamestate.current().levelManager
  
  if other.tag == 'enemy' then
    other:takeDamage(
        5 * (1 + levelManager:getStat('damage')/4)
    )
    Gamestate.current().playerManager:heal(
        5 * (1 + levelManager:getStat('damage')/4) * (levelManager:getStat('lifesteal')/10)
    )
		self:destroy()
  
  elseif other.tag == 'wall' then
    self:destroy()
    
  end
end

return DoubleTapBullet