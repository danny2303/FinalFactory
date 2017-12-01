require "scroll"

input = {}

function input.load()

	lastHovered = {5,5}


end

function input.update()

prevLdown = ldown
ldown = love.mouse.isDown(1)

	if ldown == true and prevLdown == false then
		mouseClicked()
	end
	if ldown == false and prevLdown == true then
		mouseReleased()
	end

findHoveredTile()


end

function mouseClicked()

	x,y = love.mouse.getPosition()

	--tile selection

	clickPos = findSelectedTile(x,y)
	tilePressX,tilePressY = clickPos[1], clickPos[2]

end

function findHoveredTile()

	hoverPos = findSelectedTile(love.mouse.getX(),love.mouse.getY())
	tileX,tileY = hoverPos[1], hoverPos[2]

	if not({tileX,tileY} == lastHovered) then

		if checkIfInMap(tileX,tileY) == true then

			map[lastHovered[1]][lastHovered[2]][1][7] = false
			map[tileX][tileY][1][7] = true
			lastHovered = {tileX,tileY}
		end
	end

end

function checkIfInMap(x,y)

	check = true

	if (x < 1) or (y < 1) or (x > mapLength) or (y > mapHeight) then
		check = false
	end

	return check

end

function findSelectedTile(x,y)

	tileX = math.floor(((x-(tileSize*cameraX))/(tileSize*zoom)))
	tileY = math.floor(((y-(tileSize*cameraY))/(tileSize*zoom)))

	return {tileX,tileY}

end

function mouseReleased()

	x,y = love.mouse.getPosition()

	releasePos = findSelectedTile(x,y)
	tileReleaseX, tileReleaseY = releasePos[1], releasePos[2]

	scroll.selectArea(tilePressX,tilePressY,tileReleaseX,tileReleaseY)

end