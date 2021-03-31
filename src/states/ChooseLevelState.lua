ChooseLevelState = Class{__includes = BaseState}


local level = 1


function ChooseLevelState:update(dt)
	if love.keyboard.wasPressed('right') then
        all_sounds['select']:play()
    	level = level + 1
    
    elseif love.keyboard.wasPressed('left') then
        all_sounds['select']:play() 
    	if level == 1 then 
        	level = 1
        else 
        	level = level - 1
        end
    end

    if love.keyboard.wasPressed('return') or love.keyboard.wasPressed('enter') then 
    	gStateMachine:change('start', {paddle_color = 1,
                                        start_level = level})
    	all_sounds['confirm']:play()
    end


    if love.keyboard.wasPressed('escape') then 
    	love.event.quit()
    end
end


function ChooseLevelState:draw()
    local x_offset = WINDOW_WIDTH/15
    local scalex = WINDOW_WIDTH/540
    local scaley = WINDOW_HEIGHT/320

    love.graphics.setFont(all_fonts['medium'])

	love.graphics.printf(tostring(level), 
                            0,
                            WINDOW_HEIGHT*0.515,
                            WINDOW_WIDTH,
                            'center')

    love.graphics.draw(all_textures['arrows'],
                        all_frames['arrows'][1],
                        WINDOW_WIDTH/2 - x_offset*2,
                        WINDOW_HEIGHT/2,
                        0,
                        scalex,
                        scaley
                        )

    love.graphics.draw(all_textures['arrows'],
                        all_frames['arrows'][2],
                        WINDOW_WIDTH/2 + x_offset*1.1,
                        WINDOW_HEIGHT/2,
                        0,
                        scalex,
                        scaley
                        )


    love.graphics.printf('Press Enter to Select', 
                            0,
                            WINDOW_HEIGHT*0.4,
                            WINDOW_WIDTH,
                            'center')
end
