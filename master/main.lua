----!!!! Problems
-- Missed bullets are not destroyed
-- Skill system is a mess -> Turning player into a state machine


require 'globals'
require 'assets'

Game = require 'src.states.game'
LevelUp = require 'src.states.levelUp'
Pause = require 'src.states.pause'
Menu = require 'src.states.menu'

function love.load()
  math.randomseed(os.time())
  
  love.mouse.setVisible(false)
  
  Gamestate.registerEvents()
  Gamestate.switch(Menu)
end

function love.update(dt)

end

function love.draw()
  love.graphics.setColor(1, 1, 1)
  love.graphics.print('FPS: '..tostring(love.timer.getFPS()))
end