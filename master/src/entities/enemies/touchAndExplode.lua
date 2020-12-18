local Enemy =  require 'src.entities.enemies.enemy'

local TouchAndExplode = Class('TouchAndExplode', Enemy)

function TouchAndExplode:initialize(x, y)
	Enemy.initialize(self, x, y, 16, 16, 6.2, 60, math.pi/3)
	
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

function TouchAndExplode:onCollision(other)
	if other.tag == 'player' and self.isAttackReady and self.isDead == false then
		other:takeDamage(8)
		
		self.isAttackReady = false
		self.timer:after(2, function () self.isAttackReady = true end)
	end
end

function TouchAndExplode:draw()
	if self.isDead then
		love.graphics.setColor(0.5, 0.5, 0.5, 0.7)
	else
		love.graphics.setColor(1, 1, 1)
	end
	love.graphics.draw(Sprites.enemies[1], self.x, self.y, 0, 1, 1,
			Sprites.enemies[1]:getWidth()/2, Sprites.enemies[1]:getHeight()/2)
end

return TouchAndExplode