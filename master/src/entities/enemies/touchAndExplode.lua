local Enemy =  require 'src.entities.enemies.enemy'

local TouchAndExplode = Class('TouchAndExplode', Enemy)

function TouchAndExplode:initialize(x, y)
	Enemy.initialize(self, x, y, 16, 16, 4.6, 60, math.pi/4)
	
	self.timer = Timer()
	self.isAttackReady = true
end

function TouchAndExplode:update(dt)
	self.timer:update(dt)
	
	self.secondsToEndStun = self.secondsToEndStun - dt
	
	if self.secondsToEndStun <= 0 then
		self.timer:update(dt)
		
		self:move(dt)
	end
end

function TouchAndExplode:draw()
	love.graphics.setColor(0.8, 0.2, 0.2)
	love.graphics.circle('fill', self.x, self.y, 8)
end

function TouchAndExplode:onCollision(other)
	if other.tag == 'player' and self.isAttackReady then
		other:takeDamage(8)
		
		self.isAttackReady = false
		self.timer:after(2, function () self.isAttackReady = true end)
	end
end

function Enemy:takeDamage(damage)
	self.health = self.health - damage
	
	if self.health <= 0 then
		self:destroy()
	end
end

return TouchAndExplode