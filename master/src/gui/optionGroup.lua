local OptionGroup = Class('OptionGroup')

function OptionGroup:initialize(x, y, optionType, ...)
	self.x, self.y = x, y
	
	self.selectedOptionIndex = nil
	self.optionType = optionType
	self.options = {...}
	
	self.suit = Suit.new()
end

function OptionGroup:update(dt)
	for i = 1, 3 do
		self:updateOption(self.x + 144 * (i-1), self.y, 90, 90, i)
	end
end

function OptionGroup:updateOption(x, y, w, h, index)
	local upgradeName = self.options[index]
	local image = Sprites[self.optionType..'s'][upgradeName]
	-- index from self.options -> upgrade name -> appropriate upgrade images
	
	-- if images is nil then that means we debugging
	love.graphics.setColor(1, 1, 1)
	if image == nil then
		if self.selectedOptionIndex == index then -- if selected
			if self.suit:Button('selected', {id = index},
					x, y, w, h).hit then
				self.selectedOptionIndex = index
			end
		else
			if self.suit:Button(upgradeName, {id = index},
					x, y, w, h).hit then
				self.selectedOptionIndex = index
			end
		end
		
	else
		if self.suit:ImageButton(image, {id = index},
				x, y, w, h).hit then
			self.selectedOptionIndex = index
		end
	end
end

function OptionGroup:draw()
	self.suit:draw()
	
	for i = 1, 3 do
		self:drawOption(self.x + 144 * (i-1), self.y, 90, 90, i)
	end
end

function OptionGroup:drawOption(x, y, w, h, index)
	local upgradeName = self.options[index]
	local image = Sprites[self.optionType..'s'][upgradeName]
	
	love.graphics.setColor(1, 1, 1)
	if image == nil then
	
	else
		if self.suit:ImageButton(image, {id = index},
				x, y, w, h).hovered then
			love.graphics.setColor(0, 0, 0, 0.3)
			love.graphics.rectangle('fill', x, y, 64, 64)
		end
		
		if self.suit:ImageButton(image, {id = index},
				x, y, w, h).hit then
			love.graphics.setColor(0, 0, 0, 0.7)
			love.graphics.rectangle('fill', x, y, 64, 64)
		end
		
		if self.selectedOptionIndex == index then
			love.graphics.setColor(1, 1, 1)
			love.graphics.draw(Sprites[self.optionType..'s'].selected, x + 32, y + 32, 0, 1, 1,
					Sprites.upgrades.selected:getWidth()/2, Sprites.upgrades.selected:getHeight()/2)
		end
		
	end
end

function OptionGroup:getSelectedOption()
	if self.selectedOptionIndex == nil then
		return nil
	end
	return self.options[self.selectedOptionIndex]
end

return OptionGroup
