local Background = Class('Background')

function Background:initialize(x, y, w, h)
	self.squares = {}
	for i = 1, 40 do
		table.insert(self.squares,
				{x = math.random(x, x + w), y = math.random(y, y + h)})
	end
end

function Background:draw()
	love.graphics.setColor(72/255, 74/255, 119/255)
	for i = 1, #self.squares do
		local square = self.squares[i]
		love.graphics.rectangle('fill', square.x, square.y, 8, 8)
	end
end

return Background