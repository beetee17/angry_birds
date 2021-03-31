Bird = Class{}

function Bird:init(world, sprite, x, y)
	self.x = x or math.random(WINDOW_WIDTH - 50)
	self.y = y or math.random(WINDOW_HEIGHT*0.8)
	self.world = world 
	self.sprite = sprite or math.random(5)

	self.width = 35*(scale_x)
	self.height = 35*(scale_y)

	self.body = love.physics.newBody(self.world, self.x, self.y, 'dynamic')
	self.shape  = love.physics.newRectangleShape(self.width, self.height)
	self.fixture = love.physics.newFixture(self.body, self.shape, 1)
	self.fixture:setUserData('Bird')

end


function Bird:draw()
	love.graphics.draw(all_textures['aliens'],
						all_frames['aliens'][self.sprite], 
						math.floor(self.body:getX()), 
						math.floor(self.body:getY()),
						self.body:getAngle(),
						scale_x,
						scale_y,
						self.width/4,
						self.height/4)					
end
