--require classes

require "scroll"

function love.load()

	scroll.load()

end

function love.conf(t)

end

function love.draw()

	scroll.draw()

end

function love.update(dt)

	scroll.update()

end