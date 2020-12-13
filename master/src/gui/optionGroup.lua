local OptionGroup = Class('OptionGroup')

function OptionGroup:initialize(x, y,...)
	self.x, self.y = x, y
	
	self.selectedOptionIndex = nil
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
	print(upgradeName)
	local images = Sprites.upgrades[upgradeName]
	-- index from self.options -> upgrade name -> appropriate upgrade images
	
	-- if images is nil then that means we debugging
	love.graphics.setColor(1, 1, 1)
	if images == nil then
		if self.selectedOptionIndex == index then -- if selected
			if self.suit:Button(upgradeName, {id = index},
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
		if self.selectedOptionIndex == index then -- if selected
			if self.suit:ImageButton(images.selected, {id = index},
					x, y, w, h).hit then
				self.selectedOptionIndex = index
			end
			
		else
			if self.suit:ImageButton(images.normal, {id = index, active = images.selected},
					x, y, w, h).hit then
				self.selectedOptionIndex = index
			end
		end
	end
end

function OptionGroup:draw()
	self.suit:draw()
end

function OptionGroup:getSelectedOption()
	if self.selectedOptionIndex == nil then
		return nil
	end
	return self.options[self.selectedOptionIndex]
end

return OptionGroup
