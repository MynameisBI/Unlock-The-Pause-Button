local lg = love.graphics

--lg.setDefaultFilter('nearest', 'nearest')

Sprites = {
	cursor = lg.newImage('assets/cursor.png'),
	enemies = {
		lg.newImage('assets/enemies/01.png'),
		lg.newImage('assets/enemies/02.png'),
		lg.newImage('assets/enemies/03.png')
	}
}

Fonts = {
	menuFont = lg.newFont('assets/fonts/04B_03B_.TTF', 40),
	
	infoScreen = lg.newFont('assets/fonts/04B_03B_.TTF', 24),
}