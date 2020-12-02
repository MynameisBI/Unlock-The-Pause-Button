local SkillSlot = Class('SkillSlot')

function SkillSlot:initialize(...)
	self.skills = {...}
	self.currentIndex = 1
end

function SkillSlot:update(dt)
	for i, skill in ipairs(self.skills) do
		skill:update(dt)
	end
end

function SkillSlot:switchSkill()
	self.currentIndex = self.currentIndex + 1
	
	if self.currentIndex > #self.skills then
		self.currentIndex = 1
	end
end

function SkillSlot:useSkill()
	self.skills[self.currentIndex]:activate()
end

return SkillSlot