local Bullet = require 'src.entities.bullets.bullet'
local SmallFireCracker = require 'src.entities.bullets.smallFireCracker'

local BigFireCracker = Class('BigFireCracker', Bullet)

function BigFireCracker:initialize(x, y, dir)
  Bullet.initialize(self, x, y, 40, 40, dir)
  self.speed = 750
  
  self.timer = Timer()
  self.timer:after(0.294, function()
    self:destroy()
    self:spawnSmallFireCrackers()
  end)
  self.timer:after(6, function()
    self:destroy()
  end)
end

function BigFireCracker:update(dt)
  self.timer:update(dt)
  
  self:translate(self.dir * self.speed * dt)
end

function BigFireCracker:draw()
  local sprite = Sprites.player.bullets.bigFireCraker
  love.graphics.setColor(1, 1, 1)
  love.graphics.draw(sprite, self.x, self.y, self.dir.angle, 1, 1,
      sprite:getWidth()/2, sprite:getHeight()/2)
end

function BigFireCracker:spawnSmallFireCrackers()
  for i = 1, 5 do
    local angle = math.pi/5 - math.pi/10 * (i-1)
    local bullet = SmallFireCracker(self.x, self.y, self.dir:rotated(angle))
    Gamestate.current():addEntity(bullet)
  end
end

function BigFireCracker:onCollision(other)
  local levelManager = Gamestate.current().levelManager
  
  if other.tag == 'enemy' then
    other:takeDamage(
        10 * (1 + levelManager:getStat('damage')/4)
    )
    Gamestate.current().playerManager:heal(
        10 * (1 + levelManager:getStat('damage')/4) * (levelManager:getStat('lifesteal')/10)
    )
		self:destroy()
  
  end
end

return BigFireCracker