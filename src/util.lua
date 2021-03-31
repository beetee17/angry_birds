function GenerateQuadPaddles(atlas)
	local x = 0
	local y = 64

	local count = 1
	local quads = {}

	-- for each of 4 colors
	for i = 1, 4 do
		-- small paddle
		quads[count] = love.graphics.newQuad(x, y, 32, 16, atlas:getDimensions())
		count = count + 1

		-- med paddle
		quads[count] = love.graphics.newQuad(x + 32, y, 64, 16, atlas:getDimensions())
		count = count + 1

		-- large paddle
		quads[count] = love.graphics.newQuad(x + 64, y, 96, 16, atlas:getDimensions())
		count = count + 1

		-- XL paddle
		quads[count] = love.graphics.newQuad(x + 96, y + 16, 128, 16, atlas:getDimensions())
		count = count + 1

		y = y + 32
		x = 0

	end

	return quads

end

function GenerateQuadBalls(atlas)
	local x = 96
	local y = 48

	local count = 1
	local quads = {}

	-- get first row of ball skins
	for i = 1, 4 do 
		quads[count] = love.graphics.newQuad(x, y, 8, 8, atlas:getDimensions())
		count = count + 1
		x = x + 8
	end

	-- second row
	x = 96
	y = y + 8
	for i = 1, 3 do
		quads[count] = love.graphics.newQuad(x, y, 8, 8, atlas:getDimensions())
		count = count + 1
		x = x + 8
	end

	return quads
end

function GenerateQuadBricks(atlas)
	local x = 0
	local y = 0

	local count = 1
	local quads = {}

	--first 3 rows of bricks
	for row = 1, 3 do
		for numBrick = 1, 6 do 
			quads[count] = love.graphics.newQuad(x, y, 32, 16, atlas:getDimensions())
			count = count + 1
			x = x + 32
		end
		x = 0
		y = y + 16
	end

	-- last row
	for numBrick = 1, 3 do
		quads[count] = love.graphics.newQuad(x, y, 32, 16, atlas:getDimensions())
		count = count + 1
		x = x + 32
	end

	return quads
end

function GenerateQuadHealths(atlas)
	local x = 128
	local y = 48

	local count = 1
	local quads = {}

	for heart = 1, 2 do 
		quads[count] = love.graphics.newQuad(x, y, 10, 10, atlas:getDimensions())
		count = count + 1
		x = x + 10
	end

	return quads
end

function GenerateQuadArrows(atlas)
	local x = 0
	local y = 0

	local count = 1
	local quads = {}

	for arrow = 1, 2 do 
		quads[count] = love.graphics.newQuad(x, y, 24, 24, atlas:getDimensions())
		count = count + 1
		x = x + 24
	end

	return quads
end

