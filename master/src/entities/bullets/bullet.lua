local Entity = require 'src.entities.entity'

local Bullet = Class('Bullet', Entity)

function Bullet:initialize(x, y, w, h, dir)
  Entity.initialize(self, x, y, w or 16, h or 16)
  self.dir = dir
  self.speed = 840
end

function Bullet:update(dt)
  self:translate(self.dir * self.speed * dt)
end

function Bullet:draw()
  love.graphics.setColor(0, 1, 1)
  love.graphics.circle('fill', self.x, self.y, 8)
end

function Bullet:onCollision(other)
  if other.tag == 'enemy' or other.tag == 'wall' then
    self:destroy()
  end
end

return Bullet