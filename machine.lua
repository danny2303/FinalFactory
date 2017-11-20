machine = {}

function machine.load()

	defaultInSide = 3
	defaultOutSide = 4

	--template: {ID,typeName,{inputSlots,inputSlotCapcity},{outputSlots,outputSlotCapcity},{itemsPerProccessingCycle,processingDuration(secs),proccessID},{requiredVoltage,requiredFrequency,requiredCurrent}}
	machineTypes = {
	{1,"testMachine",{2,10},{2,10},{5,2,1},{3,50,20}}
}

	--template: {ID,proccessName,inputsArrray{ID,materialID},outputsArray{ID,materialID}}
	processTypes = {
	{1,"testProcess",{{1,1}},{{1,2}}}
}

end

function machine.update()



end

function machine.draw()



end

function machine.createMachineData(typeID)

	--machineDataModel: {typeID,inputBuffer,outputBuffer,processing,outputSide,inputSide}

	machineData = {typeID,createInventory(machineTypes[typeID][3][1]),createInventory(machineTypes[typeID][4][1]),createInventory(machineTypes[typeID][5][1]),defaultInSide,defaultOutSide}

	return machineData

end

function createInventory(size)

	--slot template = {itemNameHolding,amount}

	inventory = {}

	for i = 1, size do

		inventory[i] = {"none",0}
	end

	return inventory

end

