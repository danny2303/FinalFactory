--require classes

require "scroll"
require "input"

function love.load()

	input.load()
	scroll.load()

end

function love.conf(t)

end

function love.draw()

	scroll.draw()

end

function love.update(dt)

	input.update()
	scroll.update()

end