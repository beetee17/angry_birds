Brick = Class{}

-- some of the colors in our palette (to be used with particle systems)
paletteColors = {
    -- blue
    [1] = {
        ['r'] = 99/255,
        ['g'] = 155/255,
        ['b'] = 255/255
    },
    -- green
    [2] = {
        ['r'] = 106/255,
        ['g'] = 190/255,
        ['b'] = 47/255
    },
    -- red
    [3] = {
        ['r'] = 217/255,
        ['g'] = 87/255,
        ['b'] = 99/255
    },
    -- purple
    [4] = {
        ['r'] = 215/255,
        ['g'] = 123/255,
        ['b'] = 186/255
    },
    -- gold
    [5] = {
        ['r'] = 251/255,
        ['g'] = 242/255,
        ['b'] = 54/255
    }
}

function Brick:init(x, y)
	self.x = x 
	self.y = y 
	
	self.width = 32*(WINDOW_WIDTH/432)
	self.height = 16*(WINDOW_HEIGHT/256)

	self.color = 1

	self.tier = 0

	self.inPlay = true

    -- particle system belonging to the brick, emitted on hit
    self.psystem = love.graphics.newParticleSystem(all_textures['particle'], 64)

    -- various behavior-determining functions for the particle system
    -- https://love2d.org/wiki/ParticleSystem

    -- lasts between 0.5-1 seconds seconds
    self.psystem:setParticleLifetime(0.5, 1)


    -- give it an acceleration of anywhere between X1,Y1 and X2,Y2 (0, 0) and (80, 80) here
    -- gives generally downward 
    self.psystem:setLinearAcceleration(-15, 0, 15, 80)

    -- spread of particles; normal looks more natural than uniform
    self.psystem:setEmissionArea('normal', 10, 10)

end


function Brick:hit()
    -- sound on hit
    self.psystem:setColors(
        paletteColors[self.color].r,
        paletteColors[self.color].g,
        paletteColors[self.color].b,
        55 * (self.tier + 1),
        paletteColors[self.color].r,
        paletteColors[self.color].g,
        paletteColors[self.color].b,
        0
    )
    self.psystem:emit(64)

    all_sounds['brick-hit-2']:play()
    if self.tier > 0 then
        if self.color > 1 then  
            self.color = self.color - 1
        else 
            self.tier = self.tier - 1
            self.color = 5
        end
    else 
        if self.color > 1 then  
            self.color = self.color - 1
        else 
            self.inPlay = false
        end
    end

end



function Brick:update(dt)
    self.psystem:update(dt)
end


function Brick:draw()
    if self.inPlay then
        love.graphics.draw(all_textures['main'], 
            				all_frames['bricks'][1 + ((self.color - 1) * 4) + self.tier],
            				self.x, 
           					self.y,
                            0,
                            WINDOW_WIDTH/432,
                            WINDOW_HEIGHT/256)
        -- multiply color by 4 (-1) to get our color offset, then add tier to that
        -- to draw the correct tier and color brick onto the screen
    end
end

--[[
    Need a separate render function for our particles so it can be called after all bricks are drawn;
    otherwise, some bricks would render over other bricks' particle systems.
]]
function Brick:renderParticles()
    love.graphics.draw(self.psystem, self.x + 16, self.y + 8)
end