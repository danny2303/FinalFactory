require "scroll"

input = {}

function input.load()



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

end

function mouseClicked()

	x,y = love.mouse.getPosition()

	--tile selection

	tilePressX = math.floor(((x-(tileSize*cameraX))/(tileSize*zoom)))
	tilePressY = math.floor(((y-(tileSize*cameraY))/(tileSize*zoom)))

end

function round(num, numDecimalPlaces)
  local mult = 10^(numDecimalPlaces or 0)
  return math.floor(num * mult + 0.5) / mult
end

function mouseReleased()

	x,y = love.mouse.getPosition()

	tileReleaseX = math.floor(((x-(tileSize*cameraX))/(tileSize*zoom)))
	tileReleaseY = math.floor(((y-(tileSize*cameraY))/(tileSize*zoom)))
	print(zoom)

	scroll.selectArea(tilePressX,tilePressY,tileReleaseX,tileReleaseY)

end