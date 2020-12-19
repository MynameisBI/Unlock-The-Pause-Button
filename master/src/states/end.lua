local End = {}

local sw, sh = love.graphics.getDimensions()

function End:enter(from)
	self.from = from
	
	self.suit = Suit.new()
	self.suit.theme.color = {
		normal = {bg = {0, 0, 0, 0}, fg = {1, 1, 1, 1}},
		hovered = {bg = {0, 0, 0, 0}, fg = {230/255, 144/255, 78/255, 1}},
		active = {bg = {0, 0, 0, 0}, fg = {158/255, 69/255, 57/255, 1}},
	}
end

function End:update(dt)
	if self.suit:Button('TRY AGAIN', {font = Fonts.menuFont_medium},
			sw/2 - 150, 240, 300, 120).hit then
		Gamestate.switch(Game)
	end
	if self.suit:Button('MAIN MENU', {font = Fonts.menuFont_verySmall},
			sw/2 - 100, 285, 200, 120).hit then
		Gamestate.switch(Menu)
	end
end

function End:draw()
	love.graphics.setBackgroundColor(50/255, 51/255, 83/255)
	
	self.suit:draw()
	
	love.graphics.setColor(1, 1, 1)
	local mx, my = love.mouse.getPosition()
  love.graphics.draw(Sprites.cursor, mx, my, 0, 1, 1,
      Sprites.cursor:getWidth()/2, Sprites.cursor:getHeight()/2)
	
	love.graphics.setColor(1, 1, 1)
	love.graphics.setFont(Fonts.menuFont_big)
	love.graphics.print('GAME OVER', sw/2, 85, 0, 1, 1,
			Fonts.menuFont_big:getWidth('GAME OVER')/2)
	
	local wave = self.from.enemyManager.currentWave
	local t = 'YOU SURVIVED A TOTAL OF '..tostring(wave)..' WAVE'
	love.graphics.setFont(Fonts.menuFont_tiny)
	love.graphics.print(t, sw/2, 140, 0, 1, 1, Fonts.menuFont_tiny:getWidth(t)/2)
end

return End