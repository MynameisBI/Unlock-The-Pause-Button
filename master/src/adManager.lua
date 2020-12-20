local Ad = require 'src.gui.ad'

local AdManager = Class('AdManager')

local adRate = 20

function AdManager:initialize()
	self.ads = {}
	self.secondsToSpawnAd = 0
end

function AdManager:update(dt)
	for _, ad in ipairs(self.ads) do
		ad:update(dt)
	end
	
	self.secondsToSpawnAd = self.secondsToSpawnAd - dt
	
	local adModifier = Gamestate.current().levelManager:getObstacle('ads')
	if self.secondsToSpawnAd <= 0 and adModifier ~= 0 then
		self.secondsToSpawnAd = adRate / adModifier * (math.random(7, 13)/10) + 1.4
		self:spawnAd()
	end
end

function AdManager:spawnAd()
	local ad = Ad(Sprites.ads[math.random(1, #Sprites.ads)])
	table.insert(self.ads, ad)
end

function AdManager:removeAd(ad)
	for i, ad_ in ipairs(self.ads) do
		if ad == ad_ then
			table.remove(self.ads, i)
		end
	end
end

function AdManager:draw()
	for _, ad in ipairs(self.ads) do
		ad:draw()
	end
end

return AdManager