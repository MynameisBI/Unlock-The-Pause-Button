local Bullet = require 'src.entities.bullets.bullet'

local SeekerBullet = Class('SeekerBullet', Bullet)

function SeekerBullet:initialize(x, y, dir)
	Bullet.initialize(self, x, y, 12, 12, dir)
	
	self.speed = 900
	
	self.timer = Timer()
	self.isWaiting = true
	self.timer:after(0.2, function()
		self.isWaiting = false
	end)
end

function SeekerBullet:update(dt)
	self.timer:update(dt)
	
	if not self.isWaiting then
		self:translate(self.dir * self.speed * dt)
	end
end

return SeekerBullet