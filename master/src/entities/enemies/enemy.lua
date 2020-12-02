local Entity = require 'src.entities.entity'

local Enemy = Class('Enemy', Entity)

function Enemy:initialize(x, y, w, h, speed, stepLength, maxSpreadAngle)
	Entity.initialize(self, x, y, w, h)
	self.timer = Timer()
	
	self.speed = speed or 4.6
	self.maxSpreadAngle = maxSpreadAngle or math.pi/15
	self.stepLength = stepLength or 65
	self.currentStep = self:findNewStep()
	
	self.health = 10
	
	self.tag = 'enemy'
	
	self.secondsToEndStun = 0
end

function Enemy:update(dt)
	self.secondsToEndStun = self.secondsToEndStun - dt
	
	if self.secondsToEndStun <= 0 then
		self.timer:update(dt)
		
		self:move(dt)
	end
end

function Enemy:move(dt)
	if self.currentStep ~= nil then
		local pos = Vector(self.x, self.y)
		local toBePos = pos + (self.currentStep - pos) * self.speed * dt
		self:translate(toBePos - pos)

		local distToStep = (self.currentStep - Vector(self.x, self.y)).length
		if distToStep <= 5 then
			self.currentStep = self:findNewStep()
		end
	end
end

function Enemy:draw()
	love.graphics.setColor(1, 1, 0)
	love.graphics.circle('fill', self.x, self.y, 15)
end

function Enemy:findNewStep()
	local target = self:findTarget()
	
	if target == nil then return end
	
	local dir = Vector(target.x - self.x, target.y - self.y).normalized
	local angle = (math.random() * 2 - 1) * self.maxSpreadAngle
	local newStep = Vector(self.x, self.y) + dir:rotated(angle) * self.stepLength
	
	return newStep
end

function Enemy:findTarget()
	local minDist = math.huge
	local closestPlayer
	
	for _, entity in ipairs(Gamestate.current().entities) do
		if entity.tag == 'player' then
			local dist = Vector(entity.x - self.x, entity.y - self.y).length
			if dist < minDist then
				minDist = dist
				closestPlayer = entity
			end
		end
	end
	
	return closestPlayer
end

function Enemy:takeDamage(damage)
	self.health = self.health - damage
	
	if self.health <= 0 then
		self:destroy()
	end
end

function Enemy:setStun()
	self.secondsToEndStun = 1
end

return Enemy