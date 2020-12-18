local BigBoyBullet = require 'src.entities.enemyBullets.bigBoyBullet'

local Enemy = require 'src.entities.enemies.enemy'

local BigBoy = Class('BigBoy', Enemy)

function BigBoy:initialize(x, y)
	Enemy.initialize(self, x, y, 36, 36, 5.11, 110, math.pi/4.2)
	
	self.timer = Timer()
	self.isAttackReady = true
end

function BigBoy:update(dt)
	self.timer:update(dt)
	
	self.secondsToEndStun = self.secondsToEndStun - dt
	
	if self.secondsToEndStun <= 0 then
		self.timer:update(dt)
		
		self:move(dt)
	end
end

function BigBoy:onCollision(other)
	if other.tag == 'player' and self.isAttackReady and self.isDead == false then
		other:takeDamage(20)
		
		self.isAttackReady = false
		self.timer:after(3, function () self.isAttackReady = true end)
	end
end

function BigBoy:takeDamage(damage)
	self.health = self.health - damage
	
	if self.health <= 0 then
		for i = 1, 6 do
			local bullet = BigBoyBullet(self.x, self.y,
					Vector(0, -1):rotated(math.pi / 3 * i))
			Gamestate.current():addEntity(bullet)
		end
		
		self:die()
	end
end

function BigBoy:draw()
	if self.isDead then
		love.graphics.setColor(0.5, 0.5, 0.5, 0.7)
	else
		love.graphics.setColor(1, 1, 1)
	end
	love.graphics.draw(Sprites.enemies[3], self.x, self.y, 0, 1, 1,
			Sprites.enemies[3]:getWidth()/2, Sprites.enemies[3]:getHeight()/2)
end

return BigBoy