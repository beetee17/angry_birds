ServeState = Class{__includes = BaseState}

function ServeState:enter(params)
	self.paddle = params.paddle
	self.bricks = params.bricks
	self.health = params.health
	self.score = params.score
	self.level = params.level

	self.ball = Ball(math.random(7))
end

function ServeState:update(dt)
	self.paddle:update(dt)
	self.ball:update(dt)

	self.ball.x = self.paddle.x + self.paddle.width/2 - self.ball.width/2
	self.ball.y = self.paddle.y - 64
	

	if love.keyboard.wasPressed('return') or love.keyboard.wasPressed('enter')then 
		gStateMachine:change('play', {paddle = self.paddle,
										ball = self.ball,
										bricks = self.bricks,
										health = self.health,
										score = self.score,
										level = self.level
										})
	end

	if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end
end

function ServeState:draw()
	self.paddle:draw()
	self.ball:draw()
	drawHealth(self.health)
	drawScore(self.score)
	love.graphics.setFont(all_fonts['small'])
	love.graphics.printf('Level: '..tostring(self.level), 
								0, 
								WINDOW_HEIGHT*0.01, 
								WINDOW_WIDTH, 
								'center')

	for index, brick in pairs(self.bricks) do 
		brick:draw()
	end

	love.graphics.setFont(all_fonts['large'])
	love.graphics.printf('Press Enter to Serve!', 0, WINDOW_HEIGHT/2, WINDOW_WIDTH, 'center')

end

