local Menu = {}

local sw, sh = love.graphics.getDimensions()

function Menu:enter()
	self.suit = Suit.new()
	self.suit.font = Fonts.menuFont
	self.suit.theme.color = {
		normal = {bg = {0, 0, 0, 0}, fg = {1, 1, 1, 1}},
		hovered = {bg = {0, 0, 0, 0}, fg = {230/255, 144/255, 78/255, 1}},
		active = {bg = {0, 0, 0, 0}, fg = {158/255, 69/255, 57/255, 1}},
	}
end

function Menu:update(dt)
	if self.suit:Button('PLAY', {font = Fonts.menuFont}, sw/2 - 70, 200,
			140, 40).hit then
		Gamestate.switch(Game)
	end
end

function Menu:draw()
	love.graphics.setColor(50/255, 51/255, 83/255)
	love.graphics.rectangle('fill', 0, 0, sw, sh)
	
	self.suit:draw()
	
	love.graphics.setColor(1, 1, 1)
	local mx, my = love.mouse.getPosition()
  love.graphics.draw(Sprites.cursor, mx, my, 0, 1, 1,
      Sprites.cursor:getWidth()/2, Sprites.cursor:getHeight()/2)
end

return Menu