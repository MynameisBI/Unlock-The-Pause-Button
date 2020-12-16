local lg = love.graphics

--lg.setDefaultFilter('nearest', 'nearest')

Sprites = {
	cursor = lg.newImage('assets/cursor.png'),
	enemies = {
		lg.newImage('assets/enemies/01.png'),
		lg.newImage('assets/enemies/02.png'),
		lg.newImage('assets/enemies/03.png')
	},
	upgrades = {
		damage = {
			normal = lg.newImage('assets/upgrades/atk_normal.png'),
			selected = lg.newImage('assets/upgrades/atk_selected.png'),
		},
		health = {
			normal = lg.newImage('assets/upgrades/cdr_normal.png'),
			selected = lg.newImage('assets/upgrades/cdr_selected.png'),
		},
		speed = {
			normal = lg.newImage('assets/upgrades/hp_normal.png'),
			selected = lg.newImage('assets/upgrades/hp_selected.png'),
		},
		cooldown = {
			normal = lg.newImage('assets/upgrades/lifesteal_normal.png'),
			selected = lg.newImage('assets/upgrades/lifesteal_selected.png'),
		},
		lifesteal = {
			normal = lg.newImage('assets/upgrades/spe_normal.png'),
			selected = lg.newImage('assets/upgrades/spe_selected.png'),
		}
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
}