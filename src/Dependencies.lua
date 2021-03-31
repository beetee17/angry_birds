-- push is a library that will allow us to draw our game at a virtual
-- resolution, instead of however large our window is; used to provide
-- a more retro aesthetic
--
-- https://github.com/Ulydev/push
push = require 'lib/push'

-- the "Class" library we're using will allow us to represent anything in
-- our game as code, rather than keeping track of many disparate variables and
-- methods
--
-- https://github.com/vrld/hump/blob/master/class.lua
Class = require 'lib/class'

-- a few global constants, centralized
require 'src/constants'

-- the rectangular entity the player controls, which deflects the ball
require 'src/Bird'
require 'src/Pig'
require 'src/Obstacle'
require 'src/LevelMaker'


-- for utility functions
require 'src/Util 2'

-- for debugging
require 'src/conf'

-- a basic StateMachine class which will allow us to transition to and from
-- game states smoothly and avoid monolithic code in one file
require 'src/StateMachine'

-- each of the individual states our game can be in at once; each state has
-- its own update and render methods that can be called by our state machine
-- each frame, to avoid bulky code in main.lua
require 'src/states/BaseState'
require 'src/states/StartState'
require 'src/states/PlayState'
require 'src/states/VictoryState'
require 'src/states/RetryState'

-- load all assets

all_textures = {
    -- backgrounds
    ['blue-desert'] = love.graphics.newImage('graphics/blue_desert.png'),
    ['blue-grass'] = love.graphics.newImage('graphics/blue_grass.png'),
    ['blue-land'] = love.graphics.newImage('graphics/blue_land.png'),
    ['blue-shroom'] = love.graphics.newImage('graphics/blue_shroom.png'),
    ['colored-land'] = love.graphics.newImage('graphics/colored_land.png'),
    ['colored-desert'] = love.graphics.newImage('graphics/colored_desert.png'),
    ['colored-grass'] = love.graphics.newImage('graphics/colored_grass.png'),
    ['colored-shroom'] = love.graphics.newImage('graphics/colored_shroom.png'),
    ['Bird_3'] = love.graphics.newImage('graphics/Bird3(resize).png'),
    ['Pig'] = love.graphics.newImage('graphics/Pig(resize).png'),
    ['particle'] = love.graphics.newImage('graphics/particle.png'),


    -- aliens
    ['aliens'] = love.graphics.newImage('graphics/aliens.png'),

    -- tiles
    ['tiles'] = love.graphics.newImage('graphics/tiles.png'),

    -- wooden obstacles
    ['wood'] = love.graphics.newImage('graphics/wood.png'),

    -- arrow for trajectory
    ['arrow'] = love.graphics.newImage('graphics/arrow.png')
}

all_frames = {
    ['aliens'] = GenerateQuads(all_textures['aliens'], 35, 35),
    ['tiles'] = GenerateQuads(all_textures['tiles'], 35, 35),

    ['wood'] = {
        love.graphics.newQuad(0, 0, 110, 35, all_textures['wood']:getDimensions()),
        love.graphics.newQuad(0, 35, 110, 35, all_textures['wood']:getDimensions()),
        love.graphics.newQuad(320, 180, 35, 110, all_textures['wood']:getDimensions()),
        love.graphics.newQuad(355, 355, 35, 110, all_textures['wood']:getDimensions())
    }
}

all_sounds = {
    ['break1'] = love.audio.newSource('sounds/break1.wav', 'static'),
    ['break2'] = love.audio.newSource('sounds/break2.wav', 'static'),
    ['break3'] = love.audio.newSource('sounds/break3.mp3', 'static'),
    ['break4'] = love.audio.newSource('sounds/break4.wav', 'static'),
    ['break5'] = love.audio.newSource('sounds/break5.wav', 'static'),
    ['bounce'] = love.audio.newSource('sounds/bounce.wav', 'static'),
    ['kill'] = love.audio.newSource('sounds/kill.wav', 'static'),

    ['music'] = love.audio.newSource('sounds/music.wav', 'static')
}

all_fonts = {
    ['small'] = love.graphics.newFont('fonts/font.ttf', 8),
    ['medium'] = love.graphics.newFont('fonts/font.ttf', 16),
    ['large'] = love.graphics.newFont('fonts/font.ttf', 32),
    ['huge'] = love.graphics.newFont('fonts/font.ttf', 64)
}

-- tweak circular alien quad
all_frames['aliens'][9]:setViewport(105.5, 35.5, 35, 34.2)