----!!!! Problems
-- Missed bullets are not destroyed
-- Skill system is a mess -> Turning player into a state machine


require 'globals'
require 'assets'

local Game = require 'src.states.game'

function love.load()
  math.randomseed(os.time())
  
  Gamestate.registerEvents()
  Gamestate.switch(Game)
end

function love.update(dt)

end

function love.draw()
  love.graphics.setColor(1, 1, 1)
  love.graphics.print('FPS: '..tostring(love.timer.getFPS()))
end