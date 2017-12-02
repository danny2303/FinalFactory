--require classes

require "scroll"
require "input"
require "machine"
require "resource"
require "UI"

function love.load()

	cursor = love.mouse.newCursor("images/UI/cursor.png", 31, 31 )
	love.mouse.setCursor(cursor)

	UI.load()
	machine.load()
	scroll.load()
	resource.load()
	input.load()

end

function love.conf(t)

end

function love.draw()

	scroll.draw()
	machine.draw()
	resource.draw()
	UI.draw()

end

function love.update(dt)

	scroll.update()
	input.update()
	machine.update()
	resource.update()
	UI.update()

end