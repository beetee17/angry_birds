Obstacle = Class{}

function Obstacle:init(world, shape, x, y) 
	self.world = world
	self.shape = shape or 'horizontal'
	self.start_x = x or math.random(WINDOW_WIDTH)
	self.start_y = y or math.random(WINDOW_HEIGHT)
	-- self.hit = 'false'

	if self.shape == 'horizontal' then 
		
		self.width = 110
		self.height = 35
		self.frame = 2

	elseif self.shape == 'vertical' then

		self.width = 35
		self.height = 110
		self.frame = 4

	end



	self.body = love.physics.newBody(self.world, self.start_x, self.start_y, 'dynamic')
	self.shape  = love.physics.newRectangleShape(self.width, self.height)
	self.fixture = love.physics.newFixture(self.body, self.shape, 0.5)

	self.body:setUserData('false')
	self.fixture:setUserData('Obstacle')

    -- particle system belonging to the brick, emitted on hit
    self.psystem = love.graphics.newParticleSystem(all_textures['particle'], 64)
    self.psystem:setSizes(0.8)
    -- various behavior-determining functions for the particle system
    -- https://love2d.org/wiki/ParticleSystem

    -- lasts between 0.5-1 seconds seconds
    self.psystem:setParticleLifetime(0.5, 1)


    -- give it an acceleration of anywhere between X1,Y1 and X2,Y2 (0, 0) and (80, 80) here
    -- gives generally downward 
    self.psystem:setLinearAcceleration(-30, 70, 30, 100)

    -- spread of particles; normal looks more natural than uniform
    self.psystem:setEmissionArea('normal', 20, 20)
    self.psystem:setEmitterLifetime(0.2)




end

function Obstacle:update(dt)
	if self.body:getUserData() == 'true' then  
		self.psystem:setColors(222/255, 184/255, 135/255, 1,
				       222/255, 184/255, 135/255, 0)

	    self.psystem:emit(1000)
	    self.psystem:update(dt)
	end
end

function Obstacle:draw()


	if self.body:getUserData() == 'true' then 
		love.graphics.draw(all_textures['wood'],
						all_frames['wood'][self.frame-1], 
						math.floor(self.body:getX()), 
						math.floor(self.body:getY()),
						self.body:getAngle(),
						1,
						1,
						self.width/2,
						self.height/2)
    

	    love.graphics.draw(self.psystem, self.body:getX(), self.body:getY())

	else
		love.graphics.draw(all_textures['wood'],
						all_frames['wood'][self.frame], 
						math.floor(self.body:getX()), 
						math.floor(self.body:getY()),
						self.body:getAngle(),
						1,
						1,
						self.width/2,
						self.height/2)
	end

end 	

