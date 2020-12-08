local BulletBursterBullet = require 'src.entities.enemyBullets.bulletBursterBullet'

local Enemy = require 'src.entities.enemies.enemy'

local BulletBurster = Class('BulletBurster', Enemy)

local d_DistToTarget = {
	320, 250, 180
}
local maxSpreadAngle2 = -math.pi/18
local bulletSpread = math.pi/6

function BulletBurster:initialize(x, y)
	Enemy.initialize(self, x, y, 18, 18, 2.5, 80, math.pi/4)
	
	self.timer:every(1.6 + math.random(30, 60) / 10, function()
		local target = self:findTarget()
		local vect = Vector(target.x - self.x, target.y - self.y)
		local dist, dir = vect.length, vect.normalized
		
		if dist <= d_DistToTarget[1] then
			for i = 1, 4 do
				local angle = bulletSpread - bulletSpread / 3 * (i-1)
				local bullet = BulletBursterBullet(self.x, self.y, dir:rotated(angle))
				Gamestate.current():addEntity(bullet)
			end
		end
	end)
end

function BulletBurster:draw()
	love.graphics.setColor(1, 1, 1)
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

return BulletBurster