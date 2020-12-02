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
	local text
	if self.selectedOptionIndex == index then
		text = 'selected'
	else
		text = 'hola'
	end
	
	if self.suit:Button(text, {id = index}, x, y, w, h).hit then
		self.selectedOptionIndex = index
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
