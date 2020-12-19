local Entity = require 'src.entities.entity'
local AfterImage = require 'src.decorations.afterImage'

local Player = Class('Player', Entity)

local screenWidth, screenHeight = love.graphics.getDimensions()
local baseHealth = 100

function Player:initialize(x, y)
  Entity.initialize(self, x or screenWidth/2, y or screenHeight/2, 32, 38)
  self.tag = 'player'
  
  self.timer = Timer.new()
  
  self.maxHealth = baseHealth
  self.health = baseHealth
  self.isInvicible = false
  
  self.dashSpeed = 700
  self.isDashing = false
  self.dashDir = nil
  
  self.isGhostingLastFrame = false
  self.isGhosting = false
  
  
  -- Drawing stuff
  self.currentState = 'idle'
  self.animations = {}
  local grid = Anim8.newGrid(34, 60,
      Sprites.player.topHat.idle:getWidth(), Sprites.player.topHat.idle:getHeight())
  self.animations.idle = Anim8.newAnimation(grid('1-2', 1), 0.32)
  grid = Anim8.newGrid(34, 60,
      Sprites.player.topHat.walk:getWidth(), Sprites.player.topHat.walk:getHeight())
  self.animations.walk = Anim8.newAnimation(grid('1-4', 1), 0.2)
  
  self.isFlipped = true
  
  self.timer:every(0.054, function()
    if self.isDashing then
      local afterImage = AfterImage(self.x, self.y, self.isFlipped)
      Gamestate.current():addEntity(afterImage)
    end
  end)
end

function Player:update(dt)
  self.timer:update(dt)
  
  self.isGhostingLastFrame = self.isGhosting
  self.isGhosting = false
  
  if self.isDashing then
    self:translate(self.dashDir * self.dashSpeed * dt
        * (1 + Gamestate.current().levelManager:getStat('speed')/5))
  end
  
  -- Drawing stuff
  for _, animation in pairs(self.animations) do
    if self.isGhostingLastFrame then
      animation:update(dt * 1.85)
    else
      animation:update(dt)
    end
  end
  self:checkDirectionBaseOnCursor()
end

function Player:draw()
  love.graphics.setColor(1, 1, 1)
  if self.currentState == 'idle' then
    self.animations.idle:draw(Sprites.player.topHat.idle, self.x, self.y - 10, 0, 1, 1, 17, 30)
  elseif self.currentState == 'walk' then
    self.animations.walk:draw(Sprites.player.topHat.walk, self.x, self.y - 10, 0, 1, 1, 17, 30)
  end
end

function Player:guiDraw()
  love.graphics.setColor(1, 1, 1)
  love.graphics.draw(Sprites.player.healthBar, self.x, self.y - 30, 0, 1, 1,
      Sprites.player.healthBar:getWidth()/2, Sprites.player.healthBar:getHeight()/2)
  
  love.graphics.setColor(232/255, 59/255, 59/255)
  love.graphics.rectangle('fill',
      self.x - Sprites.player.healthBar:getWidth()/2 + 2,
      self.y - Sprites.player.healthBar:getHeight()/2 - 30 + 2,
      (Sprites.player.healthBar:getWidth() - 4) * (self.health / self.maxHealth),
      (Sprites.player.healthBar:getHeight() - 4)
  )
end

function Player:move(vect)
  if vect == Vector(0, 0) then
    self.currentState = 'idle'
  else
    self.currentState = 'walk'
  end
  
  if not self.isDashing then
    if not self.isGhostingLastFrame then
      self:translate(vect)
    elseif self.isGhostingLastFrame then
      self:translate(vect * 1.75)
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
  if not self.isInvicible and not self.isDashing then
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

function Player:checkDirectionBaseOnCursor()
  local mx, my = love.mouse.getPosition()
  mx, my = Gamestate.current().camera:worldCoords(mx, my)
  
  if mx - self.x < 0 then
    self:setFlipped(false)
  else
    self:setFlipped(true)
  end
end

function Player:setFlipped(isFlipped)
  if self.isFlipped ~= isFlipped then
    for _, animation in pairs(self.animations) do
      animation:flipH()
    end
  end
  
  self.isFlipped = isFlipped
end

function Player:translate(dir)
	self.x = self.x + dir.x
	self.y = self.y + dir.y
	
	local ax, ay, cols, len = Gamestate.current().bumpWorld:move(self,
			self.x - self.w/2, self.y - self.h/2,
      function(item, other)
        if other.tag == 'wall' then
          return 'slide'
        else
          return 'cross'
        end
      end )
  self.x, self.y = ax + self.w/2, ay + self.h/2
  
	for i = 1, len do
		local other = cols[i].other
		if not other.isDestroyed and not self.isDestroyed then
			self:onCollision(other)
		end
	end
end

return Player