Pig = Class{}

function Pig:init(world, x, y, sprite)
	self.x = x or math.random(WINDOW_WIDTH - 50)
	self.y = y or math.random(WINDOW_HEIGHT*0.8)
	self.world = world 
	
	possible_sprites = {6, 7, 9, 10, 15}
	self.sprite = sprite or possible_sprites[math.random(#possible_sprites)]


	self.body = love.physics.newBody(self.world, self.x, self.y, 'dynamic')
	self.shape  = love.physics.newCircleShape(18*scale_x)
	self.fixture = love.physics.newFixture(self.body, self.shape, 1)
	self.fixture:setUserData('Pig')


end

function Pig:update(dt)

end

function Pig:draw()
	love.graphics.draw(all_textures['aliens'],
						all_frames['aliens'][self.sprite], 
						math.floor(self.body:getX()), 
						math.floor(self.body:getY()),
						self.body:getAngle(),
						scale_x,
						scale_x, 
						18,
						18)					
end
