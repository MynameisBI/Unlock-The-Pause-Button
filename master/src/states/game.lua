local Player = require 'src.entities.player'
local EnemyManager = require 'src.enemyManager'
local LevelManager = require 'src.levelManager'
local PlayerManager = require 'src.playerManager'

local LevelUp = require 'src.states.levelUp'
local Pause = require 'src.states.pause'

local Game = {}

function Game:enter()
  self.queuedState = nil
  
  self.bumpWorld = Bump.newWorld()
  
  self.playerManager = PlayerManager()
  self.levelManager = LevelManager()
  
  self.entities = {}
  
  self:addEntity(Player())
  
  self.enemyManager = EnemyManager()
  
  self.camera = Camera()
end

function Game:update(dt)
  self.playerManager:update(dt)
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
  self.camera:attach()
  
  for i, entity in ipairs(self.entities) do
    entity:draw()
  end
  
  self.playerManager:draw()
  
  self.camera:detach()
  
  love.graphics.setColor(1, 1, 1)
  love.graphics.print('#: '..tostring(#self.entities), 0, 500)
end

function Game:addEntity(entity)
  table.insert(self.entities, entity)
  
  self.playerManager:onEntityAdd(entity)
end

function Game:removeEntity(entity)
  for i, entity_ in ipairs(self.entities) do
    if entity == entity_ then
      table.remove(self.entities, i)
    end
  end
  
  self.playerManager:onEntityRemove(entity)
  self.enemyManager:onEntityRemove(entity)
end

function Game:keypressed(key, scancode)
  self.playerManager:keypressed(key, scancode)
  
  if self.levelManager:getStat('pause') == true
      and (scancode == 'escape' or scancode == 'p') then
    self:queueState(Pause)
  end
end

function Game:queueState(state, ...)
  self.queuedState = {state = state, args = {...}}
end

function Game:resume(from, ...)
  if from == LevelUp then
    self.levelManager:handleOptions(...)
    self.playerManager:reCaculateStats()
  end
end

return Game