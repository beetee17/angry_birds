PlayState = Class{__includes = BaseState}

function PlayState:enter(params)

    self.level = params.level

	self.world = love.physics.newWorld(0, 500)
	self.world:setCallbacks(beginContact, endContact, preSolve, postSolve)

	self.leftWallBody = love.physics.newBody(self.world, 0, 0, 'static')
    self.rightWallBody = love.physics.newBody(self.world, 0, 0, 'static')
    self.groundBody = love.physics.newBody(self.world, 0, 0, 'static')

    self.leftWallShape = love.physics.newEdgeShape(0, 0, 
                                                    0, WINDOW_HEIGHT)
    self.rightWallShape = love.physics.newEdgeShape(WINDOW_WIDTH, 0, 
                                                    WINDOW_WIDTH, WINDOW_HEIGHT)
    self.groundShape = love.physics.newEdgeShape(0, WINDOW_HEIGHT, 
                                                WINDOW_WIDTH, WINDOW_HEIGHT)

    self.leftWall = love.physics.newFixture(self.leftWallBody, self.leftWallShape)
    self.rightWall = love.physics.newFixture(self.rightWallBody, self.rightWallShape)
    self.ground = love.physics.newFixture(self.groundBody, self.groundShape)

    self.leftWall:setUserData('Wall')
    self.rightWall:setUserData('Wall')
    self.ground:setUserData('Wall')

    self.sprite = Bird(self.world, 1, WINDOW_WIDTH*0.2, WINDOW_HEIGHT*0.7)
    self.sprite.body:setAwake(false)


	self.obstacles = LevelMaker.createMap(self.world, self.level)

	self.follow_alien = false
	self.launch_alien = false

	self.has_launched = false

	init_sprite_x = self.sprite.body:getX()
	init_sprite_y = self.sprite.body:getY()
	to_destroy = {}
	count_down = 6

end

function PlayState:update(dt)


	mouse_x, mouse_y = love.mouse.getPosition()
	sprite_x = self.sprite.body:getX()
	sprite_y = self.sprite.body:getY()

	if not self.has_launched then
		if mouse_x > sprite_x - 70 and mouse_x < sprite_x + 70   
			and mouse_y < sprite_y + 70 and mouse_y > sprite_y - 70 then 
			if love.mouse.wasPressed(1) then 
				self.follow_alien = true
				
			end
		end

		if not love.mouse.wasReleased(1) and self.follow_alien then 

			mouse_x, mouse_y = love.mouse.getPosition()
			if mouse_x - init_sprite_x > 0 then 
				self.sprite.body:setX(math.min(init_sprite_x + 70 + 100, mouse_x))
			else 
				self.sprite.body:setX(math.max(mouse_x, init_sprite_x - 70 - 100))
			end
			if mouse_y - init_sprite_y > 0 then 
				self.sprite.body:setY(math.min(mouse_y, init_sprite_y + 70 + 100))
			else 
				self.sprite.body:setY(math.max(mouse_y, init_sprite_y - 70 - 100))
			end

			-- if mouse_x < init_sprite_x - 70 - 100 or mouse_x > init_sprite_x + 70 + 100 
			-- 	or mouse_y > init_sprite_y + 70 + 100 or mouse_y < init_sprite_y - 70 - 100 then 
				
			-- 	self.follow_alien = false 
			-- 	self.launch_alien = true

			
		end



		if love.mouse.wasReleased(1) and self.follow_alien then 

			if mouse_x > init_sprite_x - 40 and mouse_x < init_sprite_x + 40 
				and mouse_y < init_sprite_y + 40 and mouse_y > init_sprite_y - 40 then 
				self.sprite.body:setX(init_sprite_x)
				self.sprite.body:setY(init_sprite_y)
				self.follow_alien = false
			else
				self.launch_alien = true
			end
		end

	else 

		count_down = count_down - dt 

		num_pigs = 0

	    for key, value in pairs(self.obstacles) do
	    	for key, obstacle in pairs(value) do
	    		if not obstacle.body:isDestroyed() then 
		    		if obstacle.fixture:getUserData() == 'Pig' then 
		    			num_pigs = num_pigs + 1 
		    		end
	    		end
	    	end
	    end


	    if count_down <= 0 then 
		    if num_pigs == 0 then 
		    	self.level = self.level + 1
		    	gStateMachine:change('victory', {level = self.level})

			else
		    	gStateMachine:change('retry', {level = self.level})
		    end
	    end

	end

	if self.launch_alien and not self.has_launched then

		self.sprite.body:setLinearVelocity(5*(init_sprite_x - mouse_x), 
											5*(init_sprite_y - mouse_y))
		self.sprite.fixture:setRestitution(0.4)
		self.sprite.body:setAwake(true)
		self.has_launched = true
	end

    self.world:update(dt)

    for key, obstacle_body in pairs(to_destroy) do
    	if not obstacle_body:isDestroyed() then  
    		obstacle_body:destroy()
    	end
    end

    for key, value in pairs(self.obstacles) do
    	for key, obstacle in pairs(value) do
    		if obstacle.body:isDestroyed() then  
    			table.remove(value, key)
    		else 
    			obstacle:update(dt)
    		end
    	end
    end

	to_destroy = {}

    -- we no longer have this globally, so include here
    if love.keyboard.wasKeyPressed('escape') then
        gStateMachine:change('start')

    end
end


function beginContact(a, b, coll)


	type_a = a:getUserData()
	type_b = b:getUserData()

	a_body = a:getBody()
	a_speed_x, a_speed_y = a_body:getLinearVelocity()
	a_res_speed = math.abs(a_speed_x) + math.abs(a_speed_y)

	b_body = b:getBody()
	b_speed_x, b_speed_y = b_body:getLinearVelocity()
	b_res_speed = math.abs(b_speed_x) + math.abs(b_speed_y)

	if b_res_speed > 400 or a_res_speed > 400 then 
		if type_a == 'Wall' and type_b == 'Pig' then 
			table.insert(to_destroy, b:getBody())
			love.audio.play(all_sounds['kill'])

		elseif type_a == 'Pig' and type_b == 'Wall' then 
			table.insert(to_destroy, a:getBody())
			love.audio.play(all_sounds['kill'])

		elseif type_a == 'Wall' and type_b == 'Obstacle' then 
			table.insert(to_destroy, b:getBody())
			love.audio.play(all_sounds['break1'])

		elseif  type_a == 'Obstacle' and type_b == 'Obstacle' then
			table.insert(to_destroy, a:getBody())
			table.insert(to_destroy, b:getBody())
			love.audio.play(all_sounds['break1'])

		elseif type_a == 'Bird' and type_b == 'Pig' then 
			table.insert(to_destroy, b:getBody())
			love.audio.play(all_sounds['kill'])

		elseif type_a == 'Bird' and type_b == 'Obstacle' then 
			table.insert(to_destroy, b:getBody())
			love.audio.play(all_sounds['break1'])

		elseif type_a == 'Wall' and type_b == 'Bird' then 
			love.audio.play(all_sounds['bounce'])
		end 

	elseif a_res_speed < 400 and b_res_speed < 400 then 

		if type_a == 'Bird' and type_b == 'Obstacle' then 

	 		if b_body:getUserData() == 'false' then 
		 		b_body:setUserData('true')
				love.audio.play(all_sounds['break3'])
			end

		elseif type_a == 'Wall' and type_b == 'Obstacle' then 
			if b_res_speed > 200 then 
				if b_body:getUserData() == 'false' then 
					b_body:setUserData('true')
					love.audio.play(all_sounds['break3'])
				end
			end

		elseif type_a == 'Obstacle' and type_b == 'Obstacle' then 
			if a_res_speed > 200 or b_res_speed > 200 then 

				if a_body:getUserData() == 'false' or b_body:getUserData() == 'false' then 
					b_body:setUserData('true')
					a_body:setUserData('true')
					love.audio.play(all_sounds['break3'])
				end
			end
		end
	end

end

 
function endContact(a, b, coll)
 
end
 
function preSolve(a, b, coll)
 
end
 
function postSolve(a, b, coll, normalimpulse, tangentimpulse)
 
end

function PlayState:draw()
    -- title

    
    self.sprite:draw()
    if self.follow_alien and not self.has_launched then 
    	love.graphics.setColor(0.8, 0, 0, 1)
    	circle = love.graphics.circle('fill', 
    								init_sprite_x, 
    								init_sprite_y, 
    								5)
    	love.graphics.setColor(1, 1, 1, 1)
    end

    for key, value in pairs(self.obstacles) do
    	for key, obstacle in pairs(value) do 
    		if not obstacle.body:isDestroyed() then  

	   			obstacle:draw()
	   		end
   		end
   	end

end


