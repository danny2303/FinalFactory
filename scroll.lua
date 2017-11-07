scroll = {}

function scroll.load()

	factoryFloor = love.graphics.newImage("images/tiles/factoryFloor.png") --tile size is currently 100x100px
	tileSize = 100

	mapLength,mapHeight = 20,10
	zoom, zoomSpeed = 1, 0.001
	cameraX,cameraY = mapLength/2+0.5,mapHeight/2+0.5 --in fractions of a tile - start in the middle of the map
	cameraSpeed = 0.01
	zoomOffset = 0.01

	map = {}

	for x = 1,mapLength do
		map[x] = {}

		for y = 1,mapHeight do
			map[x][y] = {} --tile data

		end
	end

end

function scroll.draw()

	for x=0,mapLength-1 do
		for y=0, mapHeight-1 do
			love.graphics.draw(factoryFloor,applyScrollX(x),applyScrollY(y),0,zoom,zoom)
		end
	end

	love.graphics.print("X: " .. cameraX,0,0)
	love.graphics.print("Y: " .. cameraY,0,20)

end

function scroll.update()

	if love.keyboard.isDown('w') then cameraY = cameraY + cameraSpeed end
	if love.keyboard.isDown('a') then cameraX = cameraX + cameraSpeed end
	if love.keyboard.isDown('s') then cameraY = cameraY - cameraSpeed end
	if love.keyboard.isDown('d') then cameraX = cameraX - cameraSpeed end

	if love.keyboard.isDown('lshift') then 
		zoom = zoom + zoomSpeed 
		cameraX,cameraY = cameraX - zoomOffset, cameraY - zoomOffset
	end
	if love.keyboard.isDown('lctrl') then 
		zoom = zoom - zoomSpeed 
		cameraX,cameraY = cameraX + zoomOffset, cameraY + zoomOffset
	end

end

function applyScrollX(num) --num is x position in tiles
	
	return num*zoom*tileSize+(cameraX*tileSize)-((mapLength/2+0.5)*100)

end

function applyScrollY(num)
	
	return num*zoom*tileSize+(cameraY*tileSize)-((mapHeight/2+0.5)*100)

end