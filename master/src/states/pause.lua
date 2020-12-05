local Pause = {}

local sw, sh = love.graphics.getDimensions()

function Pause:enter(from)
	self.from = from
end

function Pause:draw()
	self.from:draw()
	
	love.graphics.setColor(0, 0, 0, 0.4)
	love.graphics.rectangle('fill', 0, 0, sw, sh)
end

function Pause:keypressed(key, scancode)
	if scancode == 'escape' or scancode == 'p' then
		Gamestate.pop()
	end
end

return Pause