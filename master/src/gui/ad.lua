local Ad = Class('Ad')

local sw, sh = love.graphics.getDimensions()

function Ad:initialize(image)
	self.image = image
	self.w, self.h = image:getDimensions()
	
	self.x = math.random(30, sw - 40 - self.w)
	self.y = math.random(30, sh - 40 - self.h)
	
	self.suit = Suit.new()
end

function Ad:update(dt)
	if self.suit:ImageButton(Sprites.ads.close_normal,
			{hovered = Sprites.ads.close_hovered, active = Sprites.ads.close_active},
			self.x + self.w - 10, self.y + 5).hit then
		Gamestate.current().adManager:removeAd(self)
	end
end

function Ad:draw()
	love.graphics.setColor(46/255, 34/255, 47/255)
	love.graphics.rectangle('fill', self.x, self.y, self.w + 10, self.h + 30)
	
	love.graphics.setColor(1, 1, 1)
	love.graphics.draw(self.image, self.x + 5, self.y + 25, 0, 1, 1)
	
	self.suit:draw()
end

return Ad