scroll = {}

function scroll.load()

	factoryFloor = love.graphics.newImage("images/tiles/factoryFloor.png") --tile size is currently 100x100px
	border = love.graphics.newImage("images/boarder.png") --size is 15 x 100
	tileSize = 100
	borderSize = 15

	mapLength,mapHeight = 20,10
	zoom, zoomSpeed = 1, 0.001
	cameraX,cameraY = mapLength/2+0.5,mapHeight/2+0.5 --in fractions of a tile - start in the middle of the map
	cameraSpeed = 0.01
	zoomOffset = 0.01

	map = {}

	for x = 0,mapLength+1 do
		map[x] = {}

		for y = 0,mapHeight+1 do

			invisibleBorderTile = false
			if (x == 0) or (x == mapLength+1) or (y == 0) or (y == mapLength+1) then
				invisibleBorderTile = true
			end
			map[x][y] = {{false,false,false,false,false,false},invisibleBorderTile,false,"none"} --tile data {selectionMatrix{selected?,selectonBoarders,hasBorder},isInvisible,isMachine,machineType}

		end
	end



end

function scroll.draw()

	for x=1,mapLength do
		for y=1, mapHeight do
			if map[x][y][2] == false then
				if map[x][y][1][1] == true then
					love.graphics.setColor(200,200,200)
				else love.graphics.setColor(255,255,255) end
				love.graphics.draw(factoryFloor,applyScrollX(x),applyScrollY(y),0,zoom,zoom)
			end
		end
	end

	love.graphics.print("X: " .. cameraX,0,0)
	love.graphics.print("Y: " .. cameraY,0,20)

	drawBorders()

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

	workOutBorders()

end

function applyScrollX(num) --num is x position in tiles
	
	return num*zoom*tileSize+(cameraX*tileSize)-((50*mapLength)+50)

end

function applyScrollY(num)
	
	return num*zoom*tileSize+(cameraY*tileSize)-((mapHeight/2+0.5)*100)

end

function drawBorders()

	for x=1,mapLength do
		for y=1, mapHeight do
			if map[x][y][1][2] == true then
				love.graphics.draw(border,applyScrollX(x),applyScrollY(y),0,zoom,zoom) --left
			end
			if map[x][y][1][3] == true then
				love.graphics.draw(border,applyScrollX(x+(tileSize-borderSize)/100),applyScrollY(y),0,zoom,zoom) --right
			end
			if map[x][y][1][4] == true then
				love.graphics.draw(border,applyScrollX(x),applyScrollY(y),4.71239,zoom,zoom) --up
			end
			if map[x][y][1][5] == true then
				love.graphics.draw(border,applyScrollX(x),applyScrollY(y+1),4.71239,zoom,zoom) --down
			end
		end
	end

end

function workOutBorders()

	for x=1,mapLength do
		for y=1, mapHeight do
			if map[x][y][1][1] == true then

				if map[x][y-1][1][1] == false then
					map[x][y][1][4] = true
				else map[x][y][1][4] = false end
				if map[x][y+1][1][1] == false then
					map[x][y][1][5] = true
				else map[x][y][1][5] = false end
				if map[x-1][y][1][1] == false then
					map[x][y][1][2] = true
				else map[x][y][1][2] = false end
				if map[x+1][y][1][1] == false then
					map[x][y][1][3] = true
				else map[x][y][1][3] = false end

				if map[x][y][1][2] == true or map[x][y][1][3] == true or map[x][y][1][4] == true or map[x][y][1][5] == true then

					map[x][y][1][6] = true

				else

					map[x][y][1][6] = false

				end

			else

				map[x][y][1][2], map[x][y][1][3], map[x][y][1][4], map[x][y][1][5] = false, false, false ,false

			end

		end
	end

	print(map[1][1][1][3])

end

function scroll.select(x,y)

if not((x < 0) or (x > mapLength+1) or (y < 0) or (y > mapLength+1)) then

	if map[x][y][1][1] == false then
		map[x][y][1][1] = true
	else
		map[x][y][1][1] = false
	end

end

end

function scroll.selectArea(startX,startY,endX,endY)

	singleSelection = false

	if endX == startX and endY == startY then
		singleSelection = true
	end

		--orients the press and release value for the for loops
	temp = 0
	if startX > endX then
		temp = startX
		startX = endX
		endX = temp
	end

	if startY > endY then
		temp = startY
		startY = endY
		endY = temp
	end

	selectionIntersects = false

	for x = startX, endX do

		for y = startY, endY do

			if map[x][y][1][6] == true then
				selectionIntersects = true
			end
		end
	end

	if selectionIntersects == false  or singleSelection == true then
			for x = startX, endX do

				for y = startY, endY do

					scroll.select(x,y)
				end
			end
	end

end