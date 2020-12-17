local Spawner = require 'src.spawner'

local EnemyManager = Class('EnemyManager')

local sw, sh = love.graphics.getDimensions()

local spawnPointsPositions = {} --{Vector(0, 0)}
for i = 0, 8 do
	for j = 0, 1 do
		table.insert(spawnPointsPositions,
			Vector(
				(-0.8 + 2.6/8 * i) * sw,
				(-0.8 + 2.6 * j) * sh
			)
		)
	end
end
for i = 0, 6 do
	for j = 0, 1 do
		table.insert(spawnPointsPositions,
			Vector(
				(-0.8 + 2.6 * j) * sw,
				(-0.8 + 2.6/8 * (i+1)) * sh
			)
		)
	end
end

function EnemyManager:initialize()
	self.timer = Timer()
	
	self.currentWave = 0
	
	self.spawners = {}
	
	self:startNextWave()
end

function EnemyManager:update(dt)
	self.timer:update(dt)
	
	for _, spawner in ipairs(self.spawners) do
		spawner:update(dt)
	end
end

function EnemyManager:startNextWave()
	self.currentWave = self.currentWave + 1
	
	for i = 1, self.currentWave do
		local pos = spawnPointsPositions[math.random(1, #spawnPointsPositions)]
		print(pos)
		local spawner = Spawner(pos.x, pos.y, 'TouchAndExplode')
		table.insert(self.spawners, spawner)
	end
	
	for i = 1, self.currentWave/3 do
		local pos = spawnPointsPositions[math.random(1, #spawnPointsPositions)]
		print(pos)
		local spawner = Spawner(pos.x, pos.y, 'BulletBurster')
		table.insert(self.spawners, spawner)
	end
	
	for i= 1, self.currentWave do
		local pos = spawnPointsPositions[math.random(1, #spawnPointsPositions)]
		print(pos)
		local spawner = Spawner(pos.x, pos.y, 'BigBoy')
		table.insert(self.spawners, spawner)
	end
end

function EnemyManager:onEntityRemove(entity)
	if entity.tag == 'enemy' then
		local enemies = {}
		for _, entity_ in ipairs(Gamestate.current().entities) do
			if entity_.tag == 'enemy' then
				table.insert(enemies, entity_)
			end
		end
		
		if #enemies == 0 then
			self.timer:after(2, function()
				Gamestate.current().levelManager:onWaveFinish(self.currentWave)
			
				self.timer:after(2, function()
					self:startNextWave()
				end)
			end)
		end
	end
end

function EnemyManager:removeSpawner(spawner)
	for i, spawner_ in ipairs(self.spawners) do
		if spawner == spawner_ then
			table.remove(self.spawners, i)
		end
	end
end

return EnemyManager