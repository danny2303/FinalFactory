require "scroll"

UI = {}

function UI.load()

	infoBoard = false
	infoTile = {1,1}
	infoBoardWidth = 500
	infoBoardAnimationStage = 0
	infoBoardAnimationSpeed = 1.5
	infoBoardColor = {122,122,122}
	infoBoardAnimationComplete = false
	beamRadius = 25
	beamFrequency = 20

end

function UI.draw()

	if infoBoard == true then

		drawInfoBoard()

	end

end

function UI.update()

	if infoBoardAnimationComplete == false and infoBoard == true then

		infoBoardAnimationStage = infoBoardAnimationStage + infoBoardAnimationSpeed

		if infoBoardAnimationStage > infoBoardWidth then infoBoardAnimationStage = infoBoardAnimationStage - infoBoardAnimationSpeed*0.9 end

		if not (infoBoardAnimationStage < infoBoardWidth+beamRadius) then infoBoardAnimationComplete = true end

	end

end

function drawInfoBoard()

	if infoBoardAnimationComplete == true then

		drawBeam()

	end

	if infoBoardAnimationStage > infoBoardWidth then

		love.graphics.setColor(infoBoardColor[1],infoBoardColor[2],infoBoardColor[3])
		love.graphics.ellipse("fill",2000-infoBoardWidth,500,infoBoardAnimationStage-infoBoardWidth)

	end

	love.graphics.setColor(infoBoardColor[1],infoBoardColor[2],infoBoardColor[3])
	love.graphics.rectangle("fill",2000,0,-infoBoardAnimationStage+beamRadius,1000)

	love.graphics.setColor(0,0,0)
	love.graphics.print(machineTypes[map[infoTile[1]][infoTile[2]][4][1]][7],2000-(infoBoardWidth/2)-50,10,0,1.5,1.5)
	love.graphics.print("Input Buffer:",2000-(infoBoardWidth/2)-150,80,0,1.2,1.2)
	love.graphics.print("Processing:",2000-(infoBoardWidth/2)-150,130,0,1.2,1.2)
	love.graphics.print("Output Buffer:",2000-(infoBoardWidth/2)-150,180,0,1.2,1.2)

end

function drawBeam()

	infoTileRealPos = {applyScrollX(infoTile[1])+50*zoom,applyScrollY(infoTile[2])+50*zoom}

	for i=1,math.random(1,beamFrequency) do
		color = math.random(0,255)
		love.graphics.setColor(100+color,100+color,100+color)
		love.graphics.line(2000-infoBoardWidth,500+math.random(-beamRadius,beamRadius),infoTileRealPos[1],infoTileRealPos[2])
	end

end
