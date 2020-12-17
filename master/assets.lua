local lg = love.graphics

--lg.setDefaultFilter('nearest', 'nearest')

Sprites = {
	cursor = lg.newImage('assets/cursor.png'),
	enemies = {
		lg.newImage('assets/enemies/01.png'),
		lg.newImage('assets/enemies/02.png'),
		lg.newImage('assets/enemies/03.png'),
		bullet = lg.newImage('assets/enemies/enemyBullet.png')
	},
	upgrades = {
		selected = lg.newImage('assets/upgrades/selected.png'),
		
		damage = lg.newImage('assets/upgrades/atk.png'),
		health = lg.newImage('assets/upgrades/hp.png'),
		cooldown = lg.newImage('assets/upgrades/cdr.png'),
		speed = lg.newImage('assets/upgrades/spe.png'),
		lifesteal = lg.newImage('assets/upgrades/lifesteal.png'),
		clone = lg.newImage('assets/upgrades/clone.png'),
		pause = lg.newImage('assets/upgrades/pause.png'),
	},
	obstacles = {
		selected = lg.newImage('assets/obstacles/selected.png'),
		
		['game speed'] = lg.newImage('assets/obstacles/gameSpeed.png'),
		cursor = lg.newImage('assets/obstacles/cursor.png'),
	},
	player = {
		healthBar = lg.newImage('assets/player/healthBar.png'),
		bullets = {
			doubleTapBullet = lg.newImage('assets/player/bullets/doubleTapBullet.png'),
			seekerBullet = lg.newImage('assets/player/bullets/seekerBullet.png'),
			theBlastBullet = lg.newImage('assets/player/bullets/theBlastBullet.png'),
			bigFireCraker = lg.newImage('assets/player/bullets/bigFireCracker.png'),
			smallFireCraker = lg.newImage('assets/player/bullets/smallFireCracker.png'),
		},
		topHat = {
			idle = lg.newImage('assets/player/topHat_idle.png'),
			walk = lg.newImage('assets/player/topHat_walk.png'),
		}
	}
}

Fonts = {
	menuFont = lg.newFont('assets/fonts/04B_03B_.TTF', 40),
	
	playerManager_small = lg.newFont('assets/fonts/04B_08__.TTF', 16),
	playerManager_big = lg.newFont('assets/fonts/04B_08__.TTF', 24),
	
	infoScreen = lg.newFont('assets/fonts/04B_03B_.TTF', 24),
	
	enemyStatus = lg.newFont('assets/fonts/04B_03B_.TTF', 8),
}