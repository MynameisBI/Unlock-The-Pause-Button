local Player = require 'src.entities.player'
local Wall = require 'src.entities.wall'
local EnemyManager = require 'src.enemyManager'
local LevelManager = require 'src.levelManager'
local PlayerManager = require 'src.playerManager'
local CursorManager = require 'src.cursorManager'

local Game = {}

local sw, sh = love.graphics.getDimensions()

function Game:enter()
  self.queuedState = nil
  
  self.bumpWorld = Bump.newWorld()
  
  self.playerManager = PlayerManager()
  self.levelManager = LevelManager()
  
  self.entities = {}
  self:addEntity(Player())
  self:addEntity(Wall(sw/2, -sh, sw * 3, 10))
  self:addEntity(Wall(sw/2, sh * 2, sw * 3, 10))
  self:addEntity(Wall(-sw, sh/2, 10, sh * 3))
  self:addEntity(Wall(sw * 2, sh/2, 10, sh * 3))
  
  
  self.enemyManager = EnemyManager()
  self.cursorManager = CursorManager()
  self.camera = Camera()
    self.camera:zoom(0.5)
  self.isInInfoScreen = false
end

function Game:update(dt)
    dt = dt * (1 + self.levelManager:getObstacle("game speed") / 5)

    self.playerManager:update(dt)
    self.enemyManager:update(dt)
    self.cursorManager:update(dt)

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

    if
        Suit.ImageButton(
            love.graphics.newImage("assets/enemies/01.png"),
            {
                hovered = love.graphics.newImage("assets/enemies/02.png"),
                active = love.graphics.newImage("assets/enemies/02.png")
            },
            100,
            100
        ).hit
     then
    end
end

function Game:draw()
    love.graphics.setBackgroundColor(69/255, 41/255, 63/255)

    self.camera:attach()

    love.graphics.setColor(50/255, 51/255, 83/255)
    love.graphics.rectangle('fill', -sw - 30, -sh - 30, sw * 3 + 60, sh * 3 + 60)
    
    for i, entity in ipairs(self.entities) do
        entity:draw()
    end

    for i, entity in ipairs(self.entities) do
        entity:guiDraw()
    end

    self.camera:detach()

    self.cursorManager:draw()

    self.playerManager:draw()

    if self.isInInfoScreen then
        love.graphics.setColor(0, 0, 0, 0.4)
        love.graphics.rectangle("fill", 0, 0, sw, sh)

        love.graphics.setColor(1, 1, 1)
        love.graphics.setFont(Fonts.infoScreen)
        love.graphics.print(
            "PRESS ESCAPE TO RESUME",
            sw / 2,
            330,
            0,
            1,
            1,
            Fonts.infoScreen:getWidth("PRESS ESCAPE TO RESUME") / 2
        )
        love.graphics.print(
            "PRESS R TO RESTART",
            sw / 2,
            360,
            0,
            1,
            1,
            Fonts.infoScreen:getWidth("PRESS R TO RESTART") / 2
        )
        love.graphics.print(
            "PRESS M TO RETURN TO MENU",
            sw / 2,
            390,
            0,
            1,
            1,
            Fonts.infoScreen:getWidth("PRESS M TO RETURN TO MENU") / 2
        )
    end
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
end

function Game:keypressed(key, scancode)
    self.playerManager:keypressed(key, scancode)

    if (scancode == "escape" or scancode == "p") then
        if self.levelManager:getStat("pause") == true then
            self:queueState(Pause)
        else
            self:toggleInfoScreen()
        end
    end

    if self.isInInfoScreen then
        if scancode == "r" then
            Gamestate.switch(self)
        elseif scancode == "m" then
            Gamestate.switch(Menu)
        end
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

function Game:toggleInfoScreen()
    if self.isInInfoScreen == true then
        self.isInInfoScreen = false
    else
        self.isInInfoScreen = true
    end
end

return Game
