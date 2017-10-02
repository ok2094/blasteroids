require 'player'
require 'bullet'

function love.update(dt)
  bullet_update(dt)
  player_update(dt)
end

function love.draw()
  bullet_draw()
  player_draw()
end
