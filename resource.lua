require "scroll"

resource = {}

function resource.load()

	realResourceSize = 0.2

	resourceSpeed = 0.001

	woodItem = love.graphics.newImage("images/resources/items/wood.png") --item size is 100x100 as are all textures
	coalItem = love.graphics.newImage("images/resources/items/coal.png")

	--template: {ID,resourceName,texture,itemTexture}
	resourceTypes = {
	{1,"wood",a,woodItem},
	{2,"coal",b,coalItem}
	}

	itemAnimations = {}

	--animation template = {ID,texture,vector{x,y},{x,y},{endX,endY},depleted?}

	resource.newItemAnimation(2,{1,1},{1.5,1.5},{1,1})

end

function resource.draw()

	if #itemAnimations > 0 then
		for i = 1, #itemAnimations do
			resource.drawItem(itemAnimations[i][2],itemAnimations[i][4][1],itemAnimations[i][4][2])
		end
	end

end

function resource.update()

	removeUnusedAnimations()
	applyVectors()

end

function applyVectors()

	if #itemAnimations > 0 then

		for i=1,#itemAnimations do

			itemAnimations[i][4][1], itemAnimations[i][4][2] = itemAnimations[i][4][1] + itemAnimations[i][3][1]*resourceSpeed, itemAnimations[i][4][2] + itemAnimations[i][3][2]*resourceSpeed
		end
	end

end

function removeUnusedAnimations()

	indexesToRemove = {}
	if #itemAnimations > 0 then
		for i = #itemAnimations,1,-1 do --this iterates the array in reverse to avoid indexes changing mid-loop from deletion
			print("3")
			if itemAnimations[i][6] == true then
				table.remove(itemAnimations,i)
			end
		end
	end

end

function resource.drawItem(texture,tileX,tileY)

	love.graphics.draw(texture,applyScrollX(tileX-0.1),applyScrollY(tileY-0.1),0,zoom*realResourceSize,zoom*realResourceSize) -- the -0.1 accounts for lua drawing the top left of the item as the center
end

function resource.newItemAnimation(resourceID,vector,startPos,endPos)

	indexToUse = #itemAnimations + 1
	itemAnimations[indexToUse] = {indexToUse,resourceTypes[resourceID][4],vector,startPos,endPos,false}

end