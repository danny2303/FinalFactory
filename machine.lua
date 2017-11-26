require "resource"
require "scroll"

machine = {}

function machine.load()

	defaultInSide = 3
	defaultOutSide = 4

	escalator = love.graphics.newImage("images/tiles/escalator.png")

	--template: {ID,texture,{inputSlots,inputSlotCapcity},{outputSlots,outputSlotCapcity},{itemsPerProccessingCycle,processingDuration(secs),proccessID},{requiredVoltage,requiredFrequency,requiredCurrent}}
	machineTypes = {
	{1,escalator,{2,10},{2,10},{5,2,1},{3,50,20}}
}

	--template: {ID,proccessName,inputsArrray{ID,materialID},outputsArray{ID,materialID}}
	processTypes = {
	{1,"testProcess",{{1,1}},{{1,2}}}
}

end

function machine.update()

	flowInputBuffers()

end

function machine.draw()


end

function flowInputBuffers()

	for x = 1,mapLength do
		for y = 1,mapHeight do --for every tile 
			if map[x][y][3] == true then	--if it is a machine
				if #map[x][y][4][2] > 0 then	--if it has an item in its input buffer
					if #map[x][y][4][4] > 0		--if it is not processing anything atm
						machineType = map[x][y][4][1]
						addItemsInOrderToProcess(x,y,machineType)
					end
				end
			end
		end
	end

end

function addItemsInOrderToProcess(x,y,machineType)

	itemsPerProccessingCycle = machineTypes[map[x][y][4][1]][5][1]

	for i=1,itemsPerProccessingCycle do
		addItemToInventory(map[x][y][4][4],map[x][y][4][2])
	end

end

function addItemToInventory(inventory,item)

--TODO take care of item stacking and such

	return finnishedInventory

end

function machine.getMachineType(typeID)

	return machineTypes[typeID]

end

function machine.createMachineData(typeID)

	--machineDataModel: {typeID,inputBuffer,outputBuffer,processing,outputSide,inputSide}

	machineData = {typeID,createInventory(machineTypes[typeID][3][1]),createInventory(machineTypes[typeID][4][1]),createInventory(machineTypes[typeID][5][1]),defaultInSide,defaultOutSide}

	return machineData

end

function machine.createItemPath(typeID)

	itemPath = {1,2} -- by default left to right

	return itemPath

end

function createInventory(size)

	--slot template = {itemNameHolding,amount}

	inventory = {}

	for i = 1, size do

		inventory[i] = {"none",0}
	end

	return inventory

end

