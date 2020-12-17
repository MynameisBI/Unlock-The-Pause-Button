local Bullet = require 'src.entities.bullets.bullet'

local SeekerBullet = Class('SeekerBullet', Bullet)

function SeekerBullet:initialize(x, y, dir)
	Bullet.initialize(self, x, y, 24, 24, dir)
	
	self.speed = 900
	
	self.timer = Timer()
	self.isWaiting = true
	self.timer:after(0.2, function()
		self.isWaiting = false
	end)
  self.timer:after(6, function()
    self:destroy()
  end)
end

function SeekerBullet:update(dt)
	self.timer:update(dt)
	
	if not self.isWaiting then
		self:translate(self.dir * self.speed * dt)
	end
end

function SeekerBullet:onCollision(other)
	local levelManager = Gamestate.current().levelManager
	
  if other.tag == 'enemy' then
    other:takeDamage(
        6 * (1 + levelManager:getStat('damage')/4)
    )
		Gamestate.current().playerManager:heal(
        6 * (1 + levelManager:getStat('damage')/4) * (levelManager:getStat('lifesteal')/10)
    )
		self:destroy()
		
	elseif other.tag == 'wall' then
    self:destroy()
		
  end
end

function SeekerBullet:draw()
	local sprite = Sprites.player.bullets.seekerBullet
  love.graphics.setColor(1, 1, 1)
  love.graphics.draw(sprite, self.x, self.y, self.dir.angle, 1, 1,
      sprite:getWidth()/2, sprite:getHeight()/2)
end

return SeekerBullet