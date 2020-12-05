local Bullet = require 'src.entities.bullets.bullet'
local SmallFireCracker = require 'src.entities.bullets.smallFireCracker'

local BigFireCracker = Class('BigFireCracker', Bullet)

function BigFireCracker:initialize(x, y, dir)
  Bullet.initialize(self, x, y, 24, 24, dir)
  self.speed = 750
  
  self.timer = Timer()
  self.timer:after(0.294, function()
    self:destroy()
    self:spawnSmallFireCrackers()
  end)
end

function BigFireCracker:update(dt)
  self.timer:update(dt)
  
  self:translate(self.dir * self.speed * dt)
end

function BigFireCracker:draw()
  love.graphics.setColor(0.7, 0.7, 0.8)
  love.graphics.circle('fill', self.x, self.y, 12)
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