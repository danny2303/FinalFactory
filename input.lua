require "scroll"
require "UI"

input = {}

function input.load()

	lastHovered = {1,1}
	lastRightClicked = {1,1}

end

function input.update()

prevLdown = ldown
prevRdown = rdown
ldown = love.mouse.isDown(1)
rdown = love.mouse.isDown(2)

	if ldown == true and prevLdown == false then
		lmouseClicked()
	end
	if ldown == false and prevLdown == true then
		lmouseReleased()
	end

findHoveredTile()

if rdown == false and prevRdown == true then --rMouse released

	manageRightClick(love.mouse.getX(),love.mouse.getY())

end


end

function manageRightClick(x,y)

	clickPos = findSelectedTile(x,y)
	x,y  = clickPos[1], clickPos[2]

	if not(clickPos == lastRightClicked) and infoBoard == false and map[x][y][3] == true then

		infoBoardAnimationStage = 0 --reset the opening animation
		infoBoardAnimationComplete = false
		infoBoard = true
		infoTile = clickPos
		lastRightClicked = clickpos

	elseif not(clickPos == lastRightClicked) then

		infoBoard = false

	end



end

function lmouseClicked()

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

function lmouseReleased()

	x,y = love.mouse.getPosition()

	releasePos = findSelectedTile(x,y)
	tileReleaseX, tileReleaseY = releasePos[1], releasePos[2]
	scroll.selectArea(tilePressX,tilePressY,tileReleaseX,tileReleaseY)

end