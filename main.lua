require 'src/Dependencies'

function love.load()
    min_dt = 1/max_FPS
    next_time = love.timer.getTime()

    math.randomseed(os.time())

    love.graphics.setDefaultFilter('nearest', 'nearest')
    love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = true,
        vsync = false
        })

    love.window.setTitle('Angry Birds')
    love.keyboard.keysPressed = {}
    -- background = all_textures['colored-shroom']
    background = all_textures['blue-desert']


    -- the state machine we'll be using to transition between various states
    -- in our game instead of clumping them together in our update and draw
    -- methods
    --
    -- our current game state can be any of the following:
    -- 1. 'start' (the beginning of the game, where we're told to click on screen)
    -- 1a. 'bird_select' (allows player to select bird sprite to play with and/or return to 'start')
    -- 2. 'play' (Allow player to shoot bird using mouse presses)
    -- 3. 'victory' (the current level is over, with a victory jingle)
    -- 4. 'retry' (the player has lost; allow restart on click)
    gStateMachine = StateMachine {
        ['start'] = function() return StartState() end,
        ['play'] = function() return PlayState() end,
        ['retry'] = function() return RetryState() end,
        ['victory'] = function() return VictoryState() end,
        -- ['bird_select']  = function() return BirdSelectState() end
        -- ['choose_level'] = function() return ChooseLevelState() end
    }
    gStateMachine:change('start')

    all_sounds['music']:setLooping(true)
    all_sounds['music']:setVolume(0.2)
    all_sounds['music']:play()

    -- a table we'll use to keep track of which keys have been pressed this
    -- frame, to get around the fact that LÖVE's default callback won't let us
    -- test for input from within other functions
    love.keyboard.keysPressed = {}
    love.mouse.keysPressed = {}
    love.mouse.keysReleased = {}

end

function love.update(dt)

    -- pass in dt to the state object we're currently using
    gStateMachine:update(dt)


    love.keyboard.keysPressed = {}
    love.mouse.keysPressed = {}
    love.mouse.keysReleased = {}

    next_time = next_time + min_dt

end



function love.draw()

    love.graphics.setColor(0, 0.8, 1, 1)
    love.graphics.draw(background, 0, 0, 0, WINDOW_WIDTH/512, WINDOW_HEIGHT/512)
    love.graphics.setColor(1, 1, 1, 1)



    -- use the state machine to defer rendering to the current state we're in
    gStateMachine:draw()

    -- displayFPS()

    local cur_time = love.timer.getTime()
        if next_time <= cur_time then
          next_time = cur_time
          return
        end

    love.timer.sleep(next_time - cur_time)


end


--[[
    Custom functions that will let us test for individual keystrokes outside
    of the default `love.keypressed` callback, since we can't call that logic
    elsewhere by default.
]]

function love.mousepressed(x, y, key)
    love.mouse.keysPressed[key] = true
end

function love.mousereleased(x, y, key)
    love.mouse.keysReleased[key] = true 
end

function love.mouse.wasPressed(key)
    return love.mouse.keysPressed[key]
end

function love.mouse.wasReleased(key)
    return love.mouse.keysReleased[key]
end


function love.keypressed(key)
    love.keyboard.keysPressed[key] = true
end

function love.keyboard.wasKeyPressed(key)
    if love.keyboard.keysPressed[key] then 
        return true
    else
        return false
    end
end


function displayFPS()
    -- simple FPS display across all states
    love.graphics.setFont(all_fonts['small'])
    love.graphics.setColor(0, 1, 0, 1)
    love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()), 5, 5)
    love.graphics.setColor(1, 1, 1, 1)
end





