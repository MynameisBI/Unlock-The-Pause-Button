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
	}
}

Fonts = {
	menuFont = lg.newFont('assets/fonts/04B_03B_.TTF', 40),
	
	infoScreen = lg.newFont('assets/fonts/04B_03B_.TTF', 24),
}