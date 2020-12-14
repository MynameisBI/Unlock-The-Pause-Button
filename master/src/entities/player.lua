local Entity = require 'src.entities.entity'

local Player = Class('Player', Entity)

local screenWidth, screenHeight = love.graphics.getDimensions()
local baseHealth = 100

function Player:initialize(x, y)
  Entity.initialize(self, x or screenWidth/2, y or screenHeight/2, 40, 40)
  self.tag = 'player'
  
  self.timer = Timer.new()
  
  self.maxHealth = baseHealth
  self.health = baseHealth
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
    self:translate(self.dashDir * self.dashSpeed * dt
        * (1 + Gamestate.current().levelManager:getStat('speed')/5))
  end
end

function Player:draw()
  love.graphics.setColor(1, 0, 1)
  love.graphics.circle('fill', self.x, self.y, 20)
end

function Player:guiDraw()
  love.graphics.setColor(1, 1, 1)
  love.graphics.draw(Sprites.player.healthBar, self.x, self.y - 24, 0, 1, 1,
      Sprites.player.healthBar:getWidth()/2, Sprites.player.healthBar:getHeight()/2)
  
  love.graphics.setColor(232/255, 59/255, 59/255)
  love.graphics.rectangle('fill',
      self.x - Sprites.player.healthBar:getWidth()/2 + 2,
      self.y - Sprites.player.healthBar:getHeight()/2 - 24 + 2,
      (Sprites.player.healthBar:getWidth() - 4) * (self.health / self.maxHealth),
      (Sprites.player.healthBar:getHeight() - 4)
  )
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

function Player:heal(health)
  self.health = self.health + health
  if self.health > self.maxHealth then
    self.health = self.maxHealth
  end
end

function Player:reCaculateStats()
  local levelManager = Gamestate.current().levelManager
  local newMaxHealth = baseHealth + levelManager:getStat('health') * 30
  
  self.health = self.health + newMaxHealth - self.maxHealth
  self.maxHealth = newMaxHealth
end

return Player