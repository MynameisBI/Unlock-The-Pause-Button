local Entity = require 'src.entities.entity'

local Player = Class('Player', Entity)

local screenWidth, screenHeight = love.graphics.getDimensions()

function Player:initialize(x, y)
  Entity.initialize(self, x or screenWidth/2, y or screenHeight/2, 40, 40)
  self.tag = 'player'
  
  self.speed = 200
  
  self.timer = Timer.new()
  
  self.health = 10
  self.isInvicible = false
  
  self.dashSpeed = 400
  self.isDashing = false
  self.dashDir = nil
  
  self.isGhostingLastFrame = false
  self.isGhosting = false
end

function Player:update(dt)
  self.timer:update(dt)
  
  self.isGhostingLastFrame = self.isGhosting
  self.isGhosting = false
  
  if self.isDashing then
    self:translate(self.dashDir * self.dashSpeed * dt)
  end
end

function Player:draw()
  love.graphics.setColor(1, 0, 1)
  love.graphics.circle('fill', self.x, self.y, 20)
end

function Player:move(vect)
  if not self.isDashing then
    if not self.isGhostingLastFrame then
      self:translate(vect)
    elseif self.isGhostingLastFrame then
      self:translate(vect * 1.6)
    end
  end
end

function Player:dash(dir)
  self.isDashing = true
  self.dashDir = dir
  
  self.timer:after(0.4, function()
    self.isDashing = false
    self.dashDir = nil
  end)
end

function Player:takeDamage(damage)
  if not self.isInvicible then
    self.health = self.health - damage
  
    if self.health <= 0 then
      print("I'm freaking dead")
    end
    
  end
end

return Player