local Pause = {}

local sw, sh = love.graphics.getDimensions()

function Pause:enter(from)
	self.from = from
	
	self.suit = Suit.new()
	self.suit.theme.color = {
		normal = {bg = {0, 0, 0, 0}, fg = {0.85, 0.85, 0.85, 1}},
		hovered = {bg = {0, 0, 0, 0}, fg = {230/255, 144/255, 78/255, 1}},
		active = {bg = {0, 0, 0, 0}, fg = {158/255, 69/255, 57/255, 1}},
	}
end

function Pause:update(dt)
	if self.suit:Button('RESUME', {font = Fonts.menuFont_medium},
			sw/2 - 140, 260, 280, 100).hit then
		Gamestate.pop()
	end
end

function Pause:draw()
	self.from:draw()
	
	love.graphics.setColor(0, 0, 0, 0.4)
	love.graphics.rectangle('fill', 0, 0, sw, sh)
	
	self.suit:draw()
	
	love.graphics.setColor(0.85, 0.85, 0.85)
	love.graphics.setFont(Fonts.menuFont_big)
	love.graphics.print('GAME PAUSED', sw/2, 120, 0, 1, 1,
			Fonts.menuFont_big:getWidth('GAME PAUSED')/2)
	
	love.graphics.setColor(0.85, 0.85, 0.85)
	love.graphics.setFont(Fonts.menuFont_small)
	love.graphics.print('PRESS ESCAPE OR P TO', sw/2, 230, 0, 1, 1,
			Fonts.menuFont_small:getWidth('PRESS ESCAPE OR P TO')/2)
	
	love.graphics.setColor(0.85, 0.85, 0.85)
	local mx, my = love.mouse.getPosition()
  love.graphics.draw(Sprites.cursor, mx, my, 0, 1, 1,
      Sprites.cursor:getWidth()/2, Sprites.cursor:getHeight()/2)
end

function Pause:keypressed(key, scancode)
	if scancode == 'escape' or scancode == 'p' then
		Gamestate.pop()
	end
end

return Pause