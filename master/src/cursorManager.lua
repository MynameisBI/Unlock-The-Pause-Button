local Cursor = require 'src.cursor'

local CursorManager = Class('CursorManager')

function CursorManager:initialize()
	self.cursors = {}
end

function CursorManager:update(dt)
	for i = 1, #self.cursors do
		self.cursors[i]:update(dt)
	end
end

function CursorManager:draw()
	for i = 1, #self.cursors do
		self.cursors[i]:draw()
	end
	
	if Gamestate.current() == Game then
		love.graphics.setColor(1, 1, 1)
		local mx, my = love.mouse.getPosition()
		love.graphics.draw(Sprites.cursor, mx, my, 0, 1, 1,
				Sprites.cursor:getWidth()/2, Sprites.cursor:getHeight()/2)
	end
end

function CursorManager:addCursor(num)
	num = num or 1
	
	for i = 1, num do
		table.insert(self.cursors, Cursor())
	end
end

return CursorManager