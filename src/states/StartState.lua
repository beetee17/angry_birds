--[[
    GD50
    Breakout Remake

    -- StartState Class --

    Author: Colton Ogden
    cogden@cs50.harvard.edu

    Represents the state the game is in when we've just started; should
    simply display "Breakout" in large text, as well as a message to press
    Enter to begin.
]]

-- the "__includes" bit here means we're going to inherit all of the methods
-- that BaseState has, so it will have empty versions of all StateMachine methods
-- even if we don't override them ourselves; handy to avoid superfluous code!
StartState = Class{__includes = BaseState}



function StartState:init()
    self.world = love.physics.newWorld(0, 500)

    self.leftWallBody = love.physics.newBody(self.world, 0, 0, 'static')
    self.rightWallBody = love.physics.newBody(self.world, 0, 0, 'static')
    self.groundBody = love.physics.newBody(self.world, 0, 0, 'static')

    self.leftWallShape = love.physics.newEdgeShape(0, 0, 
                                                    0, WINDOW_HEIGHT)
    self.rightWallShape = love.physics.newEdgeShape(WINDOW_WIDTH, 0, 
                                                    WINDOW_WIDTH , WINDOW_HEIGHT)
    self.groundShape = love.physics.newEdgeShape(0, WINDOW_HEIGHT, 
                                                WINDOW_WIDTH, WINDOW_HEIGHT)

    self.leftWall = love.physics.newFixture(self.leftWallBody, self.leftWallShape)
    self.rightWall = love.physics.newFixture(self.rightWallBody, self.rightWallShape)
    self.ground = love.physics.newFixture(self.groundBody, self.groundShape)

    self.sprites = {}

    for i = 1, 50 do 
        if i % 2 == 0 then 
            self.sprites[i] = Bird(self.world)
        else 
            self.sprites[i] = Pig(self.world)
        end
    end


end



function StartState:update(dt)

    if love.mouse.wasPressed(1) then 
        gStateMachine:change('play', {level = 1})
        self.sprites = {}
    end

    self.world:update(dt)

    -- we no longer have this globally, so include here
    if love.keyboard.wasKeyPressed('escape') then
        love.event.quit()

    end
end

function StartState:draw()
    
    for key, sprite in pairs(self.sprites) do 
        sprite:draw()
    end
    love.graphics.setFont(all_fonts['huge'])
    love.graphics.printf("ANGRY BIRDS!", 0, WINDOW_HEIGHT / 3, WINDOW_WIDTH, 'center')

    love.graphics.printf("CLICK TO PLAY!", 0, WINDOW_HEIGHT*0.5, WINDOW_WIDTH, 'center')



end