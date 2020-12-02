local Player = require 'src.entities.player'
local EnemyManager = require 'src.enemyManager'
local LevelManager = require 'src.levelManager'
local GameManager = require 'src.gameManager'

local LevelUp = require 'src.states.levelUp'

local Game = {}

function Game:enter()
  self.queuedState = nil
  
  self.bumpWorld = Bump.newWorld()
  
  self.gameManager = GameManager()
  self.levelManager = LevelManager()
  
  self.entities = {}
  
  self:addEntity(Player())
  self:addEntity(Player(300, 200))
  
  self.enemyManager = EnemyManager()
end

function Game:update(dt)
  self.gameManager:update(dt)
  self.enemyManager:update(dt)
  
  for i, entity in ipairs(self.entities) do
    if entity.isDestroyed then
      self:removeEntity(entity)
    else
      entity:update(dt)
    end
  end
  
  if self.queuedState ~= nil then
    Gamestate.push(self.queuedState.state, unpack(self.queuedState.args))
    self.queuedState = nil
  end
end

function Game:draw()
  for i, entity in ipairs(self.entities) do
    entity:draw()
  end
  
  self.gameManager:draw()
  
  love.graphics.setColor(1, 1, 1)
  love.graphics.print('#: '..tostring(#self.entities), 0, 500)
end

function Game:addEntity(entity)
  table.insert(self.entities, entity)
  
  self.gameManager:onEntityAdd(entity)
end

function Game:removeEntity(entity)
  for i, entity_ in ipairs(self.entities) do
    if entity == entity_ then
      table.remove(self.entities, i)
    end
  end
  
  self.gameManager:onEntityRemove(entity)
  self.enemyManager:onEntityRemove(entity)
end

function Game:keypressed(key, scancode)
  self.gameManager:keypressed(key, scancode)
end

function Game:queueState(state, ...)
  self.queuedState = {state = state, args = {...}}
end

function Game:resume(from, ...)
  if from == LevelUp then
    self.levelManager:handleOptions(...)
  end
end


return Game