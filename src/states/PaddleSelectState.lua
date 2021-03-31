PaddleSelectState = Class{__includes = BaseState}


local color = 1
-- function PaddleSelectState:init()
--     self.paddle_color = color
-- end

function PaddleSelectState:update(dt)
	if love.keyboard.wasPressed('right') then
        all_sounds['select']:play()
        if color == 4 then 
        	color = 1
        else 
        	color = color + 1
        end
    elseif love.keyboard.wasPressed('left') then 
        all_sounds['select']:play()
    	if color == 1 then 
        	color = 4
        else 
        	color = color - 1
        end
    end

    if love.keyboard.wasPressed('return') or love.keyboard.wasPressed('enter') then 
    	gStateMachine:change('start', {paddle_color = color,
                                        start_level = 1})
    	all_sounds['confirm']:play()
    end


    if love.keyboard.wasPressed('escape') then 
    	love.event.quit()
    end
end


function PaddleSelectState:draw()
    local x_offset = WINDOW_WIDTH/30
    local scalex = WINDOW_WIDTH/540
    local scaley = WINDOW_HEIGHT/320

    local scale_pad_x = WINDOW_WIDTH/270
    local scale_pad_y = WINDOW_HEIGHT/210

	love.graphics.draw(all_textures['main'], 
					all_frames['paddles'][2 + 4*(color - 1)], 
					WINDOW_WIDTH/2 - (PADDLE_STARTW*scale_pad_x)/2, 
					WINDOW_HEIGHT/2,
					0,
					scale_pad_x,
                    scale_pad_y)

    love.graphics.draw(all_textures['arrows'],
                        all_frames['arrows'][1],
                        WINDOW_WIDTH/2 - (PADDLE_STARTW*scale_pad_x)/2 - 24*scalex - x_offset,
                        WINDOW_HEIGHT/2,
                        0,
                        scalex,
                        scaley
                        )

    love.graphics.draw(all_textures['arrows'],
                        all_frames['arrows'][2],
                        WINDOW_WIDTH/2 + (PADDLE_STARTW*scale_pad_x)/2 + x_offset,
                        WINDOW_HEIGHT/2,
                        0,
                        scalex,
                        scaley
                        )

    love.graphics.setFont(all_fonts['medium'])
    love.graphics.printf('Press Enter to Select', 
                            0,
                            WINDOW_HEIGHT*0.4,
                            WINDOW_WIDTH,
                            'center')
end
