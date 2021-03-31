LevelMaker = Class{}

function LevelMaker.createMap(world, level)
	local all_obstacles = {}

	if level == 1 then 

		all_obstacles[1] = createHouse(world, WINDOW_WIDTH*0.8, WINDOW_HEIGHT*0.9)
		all_obstacles[2] = {Pig(world, WINDOW_WIDTH*0.8 + 55, WINDOW_HEIGHT*0.7)}
	end

	if level == 2 then 
		all_obstacles[1] = createHouse(world, WINDOW_WIDTH*0.8, WINDOW_HEIGHT*0.9)
		all_obstacles[2] = createHouse(world, WINDOW_WIDTH*0.8, WINDOW_HEIGHT*0.7)

		all_obstacles[3] = {Pig(world, WINDOW_WIDTH*0.8 + 55, WINDOW_HEIGHT*0.5),
							Pig(world, WINDOW_WIDTH*0.95, WINDOW_HEIGHT*0.95)}
	end

	if level == 3 then 
		all_obstacles[1] = createHouse(world, WINDOW_WIDTH*0.8, WINDOW_HEIGHT*0.9)
		all_obstacles[2] = createHouse(world, WINDOW_WIDTH*0.8, WINDOW_HEIGHT*0.7)

		all_obstacles[3] = {Pig(world, WINDOW_WIDTH*0.8 + 55, WINDOW_HEIGHT*0.5),
							Pig(world, WINDOW_WIDTH*0.95, WINDOW_HEIGHT*0.95),
							Pig(world, WINDOW_WIDTH*0.6 + 55, WINDOW_HEIGHT*0.7)}

		all_obstacles[4] = createHouse(world, WINDOW_WIDTH*0.6, WINDOW_HEIGHT*0.9)

	end

	if level == 4 then 
		all_obstacles[1] = createHouse(world, WINDOW_WIDTH*0.67, WINDOW_HEIGHT*0.9)
		all_obstacles[2] = createHouse(world, WINDOW_WIDTH*0.9, WINDOW_HEIGHT*0.9)
		all_obstacles[3] = {Pig(world, WINDOW_WIDTH*0.8, WINDOW_HEIGHT*0.9)}
		all_obstacles[4] = createHouse(world, WINDOW_WIDTH*0.56, WINDOW_HEIGHT*0.9)
	end
	if level == 5 then 
		all_obstacles[1] = createHouse(world, WINDOW_WIDTH*0.32, WINDOW_HEIGHT*0.9)
		all_obstacles[2] = createHouse(world, WINDOW_WIDTH*0.44, WINDOW_HEIGHT*0.9)
		all_obstacles[3] = {Pig(world, WINDOW_WIDTH*0.6, WINDOW_HEIGHT*0.9)}
		
	end
	return all_obstacles 
end


function createHouse(world, x, y)

	obstacles = {}

	-- left wall
	obstacles[1] = Obstacle(world, 'vertical', x, y)

	--right
	obstacles[2] = Obstacle(world, 'vertical', x + 80, y)

	-- roof
	obstacles[3] = Obstacle(world, 'horizontal', x + 42, y - 80)

	return obstacles
end


