local Player = require 'src.entities.player'

local SkillSlot = require 'src.skills.skillSlot'
local Skill = require 'src.skills.skill'
local DoubleTapBullet = require 'src.entities.bullets.doubleTapBullet'
local TheBlastBullet = require 'src.entities.bullets.theBlastBullet'
local SeekerBullet = require 'src.entities.bullets.seekerBullet'
local BigFireCracker = require 'src.entities.bullets.bigFireCracker'

local PlayerManager = Class('PlayerManager')

function PlayerManager:initialize()
	self.players = {}
	
	self.playerSpeed = 312
	
	self.timer = Timer()
	
	self.attackSlot = SkillSlot(
			Skill(0.6, function(self, x, y, mx, my, dir, player) -- Double Tap
				if player.isGhostingLastFrame then
					return
				end
				
				local spawnBullet = function()
					local bullet = DoubleTapBullet(player.x, player.y, dir)
					Gamestate.current():addEntity(bullet)
				end
			
				self.timer:after(0, spawnBullet)
				self.timer:after(0.092, spawnBullet)
			end),
			
			Skill(0.34, function(self, x, y, mx, my, dir, player) -- Seeker
				if player.isGhostingLastFrame then
					return
				end
				
				local bullet = SeekerBullet(x, y, dir)
				Gamestate.current():addEntity(bullet)
			end),
			
			Skill(0.78, function(self, x, y, mx, my, dir, player) -- The Blast
				if player.isGhostingLastFrame then
					return
				end
				
				for i = 1, 6 do
					local angle = math.pi/15 - math.pi/45 * (i-1)
					local bullet = TheBlastBullet(x, y, dir:rotated(angle))
					Gamestate.current():addEntity(bullet)
				end
			end),
			
			Skill(0.72, function(self, x, y, mx, my, dir, player) -- FireCracker
				if player.isGhostingLastFrame then
					return
				end
				
				local bullet = BigFireCracker(x, y, dir)
				Gamestate.current():addEntity(bullet)
			end)
	)
	
	self.ultilitySlot = SkillSlot(
			Skill(2.2, function(skill, x, y, mx, my, dir, player) -- Dash
				if player.isGhostingLastFrame then
					return
				end
				
				player:dash(dir)
			end),
			
			Skill(5, function(skill, x, y, mx, my, dir, player) -- Stun
				if player.isGhostingLastFrame then
					return
				end
				
				for _, entity in ipairs(Gamestate.current().entities) do
					if entity.tag == 'enemy' then
						local dist = Vector(entity.x - x, entity.y - y).length
						if dist <= 260 then
							entity:setStun()
						end
					end
				end
			end),
			
			Skill(2.6, function(skill, x, y, mx, my, dir, player) -- Reflex
				if player.isGhostingLastFrame then
					return
				end
				
				for _, entity in ipairs(Gamestate.current().entities) do
					if entity.tag == 'enemy bullet' then
						local dist = Vector(entity.x - x, entity.y - y).length
						if dist <= 180 then
							entity:destroy()
						end
					end
				end
			end),
			
			Skill(nil, function(skill, x, y, mx, my, dir, player) -- Ghost
				player.isGhosting = true
			end)
	)
end

function PlayerManager:update(dt)
	self.timer:update(dt)
	
	self.attackSlot:update(dt)
	self.ultilitySlot:update(dt)
	
	local vect = self:getMoveDir() * self.playerSpeed * dt
			* (1 + Gamestate.current().levelManager:getStat('speed')/5)
	for _, player in ipairs(self.players) do
		player:move(vect)
	end
	
	if love.mouse.isDown(1) then
		self.attackSlot:useSkill()
	end
	
	if love.keyboard.isScancodeDown('space') then
		self.ultilitySlot:useSkill()
	end
	
	if self.players[1] ~= nil then
		Gamestate.current().camera:lockPosition(self.players[1].x, self.players[1].y,
				Camera.smooth.damped(1.57))
	end
end

function PlayerManager:draw()
	local attack, ultility
	if self.attackSlot.currentIndex == 1 then attack = 'DOUBLE TAP'
	elseif self.attackSlot.currentIndex == 2 then attack = 'SEEKER'
	elseif self.attackSlot.currentIndex == 3 then attack = 'THE BLAST'
	elseif self.attackSlot.currentIndex == 4 then attack = 'FIRE CRACKER'
	end
	
	if self.ultilitySlot.currentIndex == 1 then ultility = 'DASH'
	elseif self.ultilitySlot.currentIndex == 2 then ultility = 'STUN'
	elseif self.ultilitySlot.currentIndex == 3 then ultility = 'REFLECT'
	elseif self.ultilitySlot.currentIndex == 4 then ultility = 'SPRINT'
	end
	
	
	love.graphics.setColor(1, 1, 1)
	love.graphics.setFont(Fonts.playerManager_small)
	love.graphics.print('Weapon', 10, 454)
	love.graphics.print('Skill', 682, 454, 0, 1, 1, 0)
	
	
	love.graphics.setFont(Fonts.playerManager_big)
	love.graphics.setColor(1, 1, 1)
	love.graphics.print(attack, 10, 475)
	
	local color
	if ultility ~= 'SPRINT' then
		if self.ultilitySlot:isCurrentSkillReady() then color = {1, 1, 1}
		else color = {179/255, 56/255, 49/255}
		end
	else
		if self.players[1] == nil then color = {1, 1, 1}
		elseif self.players[1].isGhostingLastFrame then color = {145/255, 219/255, 105/255}
		else color = {1, 1, 1}
		end
	end
	love.graphics.setColor(color)
	love.graphics.print(ultility, 682, 475, 0, 1, 1, Fonts.playerManager_big:getWidth(ultility) - 58)
end

function PlayerManager:getMoveDir()
  local dir = Vector(0, 0)

  if love.keyboard.isScancodeDown('left') or love.keyboard.isScancodeDown('a') then
    dir.x = dir.x - 1
  end
  if love.keyboard.isScancodeDown('right') or love.keyboard.isScancodeDown('d') then
    dir.x = dir.x + 1
  end
  if love.keyboard.isScancodeDown('up') or love.keyboard.isScancodeDown('w') then
    dir.y = dir.y - 1
  end
  if love.keyboard.isScancodeDown('down') or love.keyboard.isScancodeDown('s') then
    dir.y = dir.y + 1
  end

  return dir.normalized
end

function PlayerManager:onEntityAdd(entity)
	if entity.tag == 'player' then
		table.insert(self.players, entity)
	end
end

function PlayerManager:onEntityRemove(entity)
	if entity.tag == 'player' then
		for i, player in ipairs(self.players) do
			if player ==  entity then
				table.remove(self.players, i)
			end
		end
	end
end

function PlayerManager:keypressed(key, scancode)
	if scancode == 'q' then
		self.attackSlot:switchSkill()
	end
	if scancode == 'e' then
		self.ultilitySlot:switchSkill()
	end
end

function PlayerManager:reCaculateStats()
	for _, player in ipairs(self.players) do
		player:reCaculateStats()
	end
end

function PlayerManager:heal(health)
	for _, player in ipairs(self.players) do
		player:heal(health)
	end
end

function PlayerManager:addNewPlayer()
	local vect = Vector(0, math.random(90, 170))
	vect = vect:rotated(math.random(0, 30) * (math.pi * 2 / 30))
	
	for _, p in pairs(self.players) do
		p.health = p.health/2
	end
	
	local player = Player(self.players[1].x + vect.x, self.players[1].y + vect.y)
	Gamestate.current():addEntity(player)
end

return PlayerManager