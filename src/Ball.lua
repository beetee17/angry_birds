Ball = Class{}

function Ball:init(skin)
	self.x = WINDOW_WIDTH/2
	self.y = WINDOW_HEIGHT/2
	self.width = (WINDOW_WIDTH/640) * 8
	self.height = (WINDOW_HEIGHT/360) * 8
	self.dx = math.random(2) == 1 and BALL_X_SPEED or -BALL_X_SPEED
	self.dy = BALL_Y_SPEED
	self.skin = skin 
end

function Ball:update(dt)
	if self.dy < 0 then 
		self.dy = -BALL_Y_SPEED
	else
		self.dy = BALL_Y_SPEED
	end

	if self.x < self.width then 
		self.x = self.width 
		self.dx = - self.dx
	elseif self.x + self.width > WINDOW_WIDTH then 
		self.dx = - self.dx
		self.x = WINDOW_WIDTH - self.width

	elseif self.y < 0 then 
		self.dy = - self.dy * 1.1
		self.y = 0
	end

	self.x = self.x + self.dx*dt
	self.y = self.y + self.dy*dt 
end

function Ball:draw()
	love.graphics.draw(all_textures['main'], 
						all_frames['balls'][self.skin], 
						self.x, 
						self.y,
						0,
						WINDOW_WIDTH/640,
						WINDOW_HEIGHT/360)
end


function Ball:is_collided_with(something)
	if self.x > something.x + something.width 
		or self.x + self.width < something.x then 

		return false
	end

	if self. y > something.y + something.height
		or self.y + self.height < something.y then 

		return false
	end

	return true
end




