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

	tilePressX = round((x-(cameraX*tileSize)+(50*mapLength)-50)/(tileSize*zoom)+0.5,0)
	tilePressY = round((y-(cameraY*tileSize)+(50*mapHeight)-50)/(tileSize*zoom)+0.5,0)

end

function round(num, numDecimalPlaces)
  local mult = 10^(numDecimalPlaces or 0)
  return math.floor(num * mult + 0.5) / mult
end

function mouseReleased()

	x,y = love.mouse.getPosition()

	tileReleaseX = round((x-(cameraX*tileSize)+(50*mapLength)-50)/(tileSize*zoom)+0.5,0)
	tileReleaseY = round((y-(cameraY*tileSize)+(50*mapHeight)-50)/(tileSize*zoom)+0.5,0)

	scroll.selectArea(tilePressX,tilePressY,tileReleaseX,tileReleaseY)

end