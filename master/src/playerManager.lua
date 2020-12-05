local Player = require 'src.entities.player'

local SkillSlot = require 'src.skills.skillSlot'
local Skill = require 'src.skills.skill'
local DoubleTapBullet = require 'src.entities.bullets.doubleTapBullet'
local TheBlastBullet = require 'src.entities.bullets.theBlastBullet'
local SeekerBullet = require 'src.entities.bullets.seekerBullet'
local BigFireCracker = require 'src.entities.bullets.bigFireCracker'

local GameManager = Class('GameManager')

function GameManager:initialize()
	self.players = {}
	
	self.playerSpeed = 312
	
	self.timer = Timer()
	
	self.attackSlot = SkillSlot(
			Skill(0.5, function(self, x, y, mx, my, dir, player) -- Double Tap
				if player.isGhostingLastFrame then
					return
				end
				
				local spawnBullet = function()
					local bullet = DoubleTapBullet(x, y, dir)
					Gamestate.current():addEntity(bullet)
				end
			
				self.timer:after(0, spawnBullet)
				self.timer:after(0.07, spawnBullet)
			end),
			
			Skill(0.24, function(self, x, y, mx, my, dir, player) -- Seeker
				if player.isGhostingLastFrame then
					return
				end
				
				local bullet = SeekerBullet(x, y, dir)
				Gamestate.current():addEntity(bullet)
			end),
			
			Skill(0.66, function(self, x, y, mx, my, dir, player) -- The Blast
				if player.isGhostingLastFrame then
					return
				end
				
				for i = 1, 7 do
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

function GameManager:update(dt)
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
				Camera.smooth.damped(2))
	end
end

function GameManager:draw()
	love.graphics.setColor(1, 1, 1)
	love.graphics.print('current attack skill: '..tostring(self.attackSlot.currentIndex),
			0, 14)
	love.graphics.print('current ultility skill: '..tostring(self.ultilitySlot.currentIndex),
			0, 28)
end

function GameManager:getMoveDir()
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

function GameManager:onEntityAdd(entity)
	if entity.tag == 'player' then
		table.insert(self.players, entity)
	end
end

function GameManager:onEntityRemove(entity)
	if entity.tag == 'player' then
		for i, player in ipairs(self.players) do
			if player ==  entity then
				table.remove(self.players, i)
			end
		end
	end
end

function GameManager:keypressed(key, scancode)
	if scancode == 'q' then
		self.attackSlot:switchSkill()
	end
	if scancode == 'e' then
		self.ultilitySlot:switchSkill()
	end
end

function GameManager:reCaculateStats()
	for _, player in ipairs(self.players) do
		player:reCaculateStats()
	end
end

function GameManager:heal(health)
	for _, player in ipairs(self.players) do
		player:heal(health)
	end
end

function GameManager:addNewPlayer()

end

return GameManager