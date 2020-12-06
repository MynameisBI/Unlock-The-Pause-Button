local Skill = Class('Skill')

function Skill:initialize(cooldown, activationFunc)
	self.cooldown = cooldown
	self.isReady = true
	self.timer = Timer()
	
	self.activationFunc = activationFunc
end

function Skill:update(dt)
	self.timer:update(dt)
end

function Skill:activate()
	if self.cooldown ~= nil then
		if not self.isReady then
			return
		end
		
		self.isReady = false
		self.timer:after(self.cooldown * 6 / (Gamestate.current().levelManager:getStat('cooldown') + 6),
				function() self.isReady = true end)
		
		self:execute()
		
	elseif self.cooldown == nil then
		self:execute()
		
	end
end

function Skill:execute()
	local entities = Gamestate.current().entities
	local firtPlayer = Gamestate.current().playerManager.players[1]
	local mx, my = Gamestate.current().camera:mousePosition()
	local dir = Vector(mx - firtPlayer.x, my - firtPlayer.y).normalized
	
	for i, entity in ipairs(entities) do
		if entity.tag == 'player' then
			if not entity.isDashing then
				self.activationFunc(self, entity.x, entity.y, mx, my, dir, entity)
			end
		end
	end
end

return Skill