RetryState = Class{__includes = BaseState}

function RetryState:enter(params)
	self.level = params.level 
end

function RetryState:update(dt)
    if love.mouse.wasPressed(1) then 
        gStateMachine:change('play', {level = self.level})
    end

	if love.keyboard.wasKeyPressed('escape') then
        love.event.quit()
    end
end


function RetryState:draw()

    love.graphics.setFont(all_fonts['huge'])

    love.graphics.printf('LEVEL '..tostring(self.level)..' FAILED!', 0, WINDOW_HEIGHT / 3, WINDOW_WIDTH, 'center')

    love.graphics.printf('CLICK TO RETRY, OR ESC TO QUIT!', 0, WINDOW_HEIGHT*0.55,
        WINDOW_WIDTH, 'center')

end