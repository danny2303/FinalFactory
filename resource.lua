require "scroll"

resource = {}

function resource.load()

	woodItem = love.graphics.newImage("images/resources/items/wood.png") --item size is 100x100 as are all textures
	coalItem = love.graphics.newImage("images/resources/items/coal.png")

	--template: {ID,resourceName,texture,itemTexture}
	resourceTypes = {
	{1,"wood",a,woodItem},
	{2,"coal",b,coalItem}
}

end

function resource.draw()

	

end

function resource.drawItem(resourceID,tileX,tileY)

	love.graphics.draw(resourceTypes[resourceID][4],applyScrollX(tileX),applyScrollY(tileY),0,zoom,zoom)

end