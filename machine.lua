require "resource"
require "scroll"

machine = {}

function machine.load()

	defaultInSide = 3
	defaultOutSide = 4

	escalator = love.graphics.newImage("images/tiles/escalator.png")

	--template: {ID,texture,{inputSlots,inputSlotCapcity},{outputSlots,outputSlotCapcity},{itemsPerProccessingCycle,processingDuration(secs),proccessID},{requiredVoltage,requiredFrequency,requiredCurrent},machineName}
	machineTypes = {
	{1,escalator,{2,10},{2,10},{5,2,1},{3,50,20},"Escalator"}
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

	machineType = 0 --unknown
	for x = 1,mapLength do
		for y = 1,mapHeight do --for every tile 
			if map[x][y][3] == true then	--if it is a machine
				if #map[x][y][4][2] > 0 then	--if it has an item in its input buffer
					if #map[x][y][4][4] < 1	then	--if it is not processing anything atm
						machineType = map[x][y][4][1]
						--move the largest amount of items allowed into the processing slot:

						itemsToMove = {}
						itemsPerProccessingCycle = machineTypes[machineType][5][1]
						maxNumItemsToMove = #map[x][y][4][2]

						if #map[x][y][4][2] > itemsPerProccessingCycle then --means that if there are more items in the input buffer that allowed per cycle, not all will go through
							maxNumItemsToMove = itemsPerProccessingCycle
						end
					
						for i=1, maxNumItemsToMove do

							itemsToMove[#itemsToMove+1] = map[x][y][4][2][i]
						end

						map[x][y][4][2] = deleteFromArray(map[x][y][4][2],1,maxNumItemsToMove)

						map[x][y][4][4] = addItemsToInventory(map[x][y][4][4],itemsToMove)

					end
				end
			end
		end
	end

end

function deleteFromArray(array,start,stop)

	for i = stop,start,-1 do --this iterates the array in reverse to avoid indexes changing mid-loop from deletion
		table.remove(array,i)
	end

	return array

end

function addItemsToInventory(inventory,items)

--TODO take care of item stacking and such

	for i=1,#items do

		inventory[#inventory+1] = items[i] --the next slot in the inventory is the iterated item
	end

	return inventory

end

function addItemsToMachine(x,y,items)--input buffer

	map[x][y][4][2] = addItemsToInventory(map[x][y][4][2],items)

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

	--the first indexed slot of an inventory is the first in line
	inventory = {}

	return inventory

end

