local Menu = {}

local sw, sh = love.graphics.getDimensions()

function Menu:enter()
	self.suit = Suit.new()
	self.suit.theme.color = {
		normal = {bg = {0, 0, 0, 0}, fg = {1, 1, 1, 1}},
		hovered = {bg = {0, 0, 0, 0}, fg = {230/255, 144/255, 78/255, 1}},
		active = {bg = {0, 0, 0, 0}, fg = {158/255, 69/255, 57/255, 1}},
	}
end

function Menu:update(dt)
	if self.suit:Button('PLAY', {font = Fonts.menuFont_medium}, sw/2 - 70, 275,
			140, 40).hit then
		Gamestate.switch(Game)
	end
end

function Menu:draw()
	love.graphics.setBackgroundColor(50/255, 51/255, 83/255)
	
	self.suit:draw()
	
	love.graphics.setFont(Fonts.menuFont_small)
	love.graphics.print('UNLOCK THE', sw/2, 75, 0, 1, 1,
			Fonts.menuFont_small:getWidth('UNLOCK THE')/2)
	love.graphics.setFont(Fonts.menuFont_veryBig)
	love.graphics.print('PAUSE BUTTON', sw/2, 115, 0, 1, 1,
			Fonts.menuFont_veryBig:getWidth('PAUSE BUTTON')/2)
	
	love.graphics.setColor(1, 1, 1)
	local mx, my = love.mouse.getPosition()
  love.graphics.draw(Sprites.cursor, mx, my, 0, 1, 1,
      Sprites.cursor:getWidth()/2, Sprites.cursor:getHeight()/2)
end

return Menu