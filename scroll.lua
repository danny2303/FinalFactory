scroll = {}

function scroll.load()

	factoryFloor = love.graphics.newImage("images/tiles/factoryFloor.png") --tile size is currently 100x100px

	mapLength,mapHeight = 10,10
	zoom = 1
	cameraX,cameraY = 1,1

	map = {}

	for x = 1,mapLength do
		map[x] = {}

		for y = 1,mapHeight do
			map[x][y] = {} --tile data

		end
	end

end

function scroll.draw()

	love.graphics.draw(factoryFloor,100,100)

end

function scroll.update()



end