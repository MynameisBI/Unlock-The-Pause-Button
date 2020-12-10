local Cursor = Class('Cursor')

local sw, sh = love.graphics.getDimensions()

function Cursor:initialize()
	self.x, self.y = math.random(0, sw), math.random(0, sh)
	self.target = Vector(math.random(0, sw), math.random(0, sh))
	
	self.speed = 300
end

function Cursor:update(dt)
	local vect = self.target - Vector(self.x, self.y)
	
	if vect.length <= 20 then
		self.target = Vector(math.random(0, sw), math.random(0, sh))
		self.speed = 300 + math.random(-75, 75)
	end
	
	local dir = vect.normalized
	self.x = self.x + dir.x * self.speed * dt
	self.y = self.y + dir.y * self.speed * dt
end

function Cursor:draw()
	love.graphics.setColor(1, 1, 1)
	love.graphics.draw(Sprites.cursor, self.x, self.y, 0, 1, 1,
      Sprites.cursor:getWidth()/2, Sprites.cursor:getHeight()/2)
end

return Cursor