local TouchAndExplode = require 'src.entities.enemies.touchAndExplode'
local BulletBurster = require 'src.entities.enemies.bulletBurster'
local BigBoy = require 'src.entities.enemies.bigBoy'

local Spawner = Class('Spawner')

function Spawner:initialize(x, y, enemyType)
	self.timer = Timer()
	
	local enemyClass, interval, quantity
	if enemyType == 'TouchAndExplode' then
		enemyClass = TouchAndExplode
		interval = 0.2
		quantity = 8
	elseif enemyType == 'BulletBurster' then
		enemyClass = BulletBurster
		interval = 0.28
		quantity = 5
	elseif enemyType == 'BigBoy' then
		enemyClass = BigBoy
		interval = 0.5
		quantity = 3
	else
	
	end
	
	self.timer:every(interval, function()
		local enemy = enemyClass(x, y)
		Gamestate.current():addEntity(enemy)
	end, quantity)
	
	self.timer:after(interval * quantity + 2, function()
		Gamestate.current().enemyManager:removeSpawner(self)
	end)
end

function Spawner:update(dt)
	self.timer:update(dt)
end

return Spawner