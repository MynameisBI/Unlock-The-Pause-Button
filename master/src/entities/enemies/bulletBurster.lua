local BulletBursterBullet = require 'src.entities.enemyBullets.bulletBursterBullet'

local Enemy = require 'src.entities.enemies.enemy'

local BulletBurster = Class('BulletBurster', Enemy)

local d_DistToTarget = {
	460, 300, 90
}
local maxSpreadAngle2 = -math.pi/18
local bulletSpread = math.pi/6

function BulletBurster:initialize(x, y)
	Enemy.initialize(self, x, y, 20, 20, 3.2, 80, math.pi/4)
	
	self.shootTimer = self.timer:every(1.4 + math.random(30, 60) / 10, function()
		local target = self:findTarget()
		
		if target ~= nil then
			local vect = Vector(target.x - self.x, target.y - self.y)
			local dist, dir = vect.length, vect.normalized
			
			if dist <= d_DistToTarget[1] then
				for i = 1, 4 do
					local angle = bulletSpread - bulletSpread / 3 * (i-1)
					local bullet = BulletBursterBullet(self.x, self.y, dir:rotated(angle))
					Gamestate.current():addEntity(bullet)
				end
			end
		end
	end)
end

function BulletBurster:draw()
	if self.isDead then
		love.graphics.setColor(0.5, 0.5, 0.5, 0.7)
	else
		love.graphics.setColor(1, 1, 1)
	end
	love.graphics.draw(Sprites.enemies[2], self.x, self.y, 0, 1, 1,
		Sprites.enemies[2]:getWidth()/2, Sprites.enemies[2]:getHeight()/2)
end

function BulletBurster:findNewStep()
	local target = self:findTarget()
	
	if target == nil then return end
	
	local vect = Vector(target.x - self.x, target.y - self.y)
	local dist, dir = vect.length, vect.normalized
	
	local angle
	if dist >= d_DistToTarget[1] then
		angle = (math.random() * 2 - 1) * self.maxSpreadAngle
	elseif dist >= d_DistToTarget[2] then
		angle = ((math.random(1, 2) - 1.5) * 2) *
				(math.random() * maxSpreadAngle2 + self.maxSpreadAngle)
	elseif dist >= d_DistToTarget[3] then
		angle = math.pi - (
				((math.random(1, 2) - 1.5) * 2) *
						(math.random() * maxSpreadAngle2 + self.maxSpreadAngle)
		)
	else
		angle = math.pi - (math.random() * 2 - 1) * self.maxSpreadAngle
	end
	
	local newStep = Vector(self.x, self.y) + dir:rotated(angle) * self.stepLength
	
	return newStep
end

function BulletBurster:die()
	self.timer:cancel(self.shootTimer)
	
	self.isDead = true
	
	self.timer:after(120, function()
		self:destroy()
	end)
	Gamestate.current().enemyManager:onEnemyDie(self)
end

return BulletBurster