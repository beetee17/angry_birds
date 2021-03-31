VictoryState = Class{__includes = BaseState}

function VictoryState:enter(params)
	self.level = params.level
end

function VictoryState:update(dt)
    if love.mouse.wasPressed(1) then 
        gStateMachine:change('play', {level = self.level})
    end

	if love.keyboard.wasKeyPressed('escape') then 
		 gStateMachine:change('start')
	end
end

function VictoryState:draw()

	love.graphics.setFont(all_fonts['huge'])

    love.graphics.printf('LEVEL '..tostring(self.level - 1)..' COMPLETE!', 0, WINDOW_HEIGHT / 3, WINDOW_WIDTH, 'center')

    love.graphics.printf('CLICK TO CONTINUE!', 0, WINDOW_HEIGHT*0.55,
        WINDOW_WIDTH, 'center')
end