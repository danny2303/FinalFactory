--require classes

require "scroll"
require "input"
require "machine"
require "resource"

function love.load()

	input.load()
	machine.load()
	scroll.load()
	resource.load()

end

function love.conf(t)

end

function love.draw()

	scroll.draw()
	machine.draw()
	resource.draw()

end

function love.update(dt)

	scroll.update()
	input.update()
	machine.update()
	resource.update()

end