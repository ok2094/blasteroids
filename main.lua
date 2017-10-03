require 'player'
require 'bullet'
require 'asteroid'
require 'collision'
require 'ui'

function love.load()
  bullet_load()
  asteroid_load()
  player_load()
end

function love.update(dt)
  bullet_update(dt)
  asteroid_update(dt)
  player_update(dt)
  collision_update()
end

function love.draw()
  bullet_draw()
  asteroid_draw()
  player_draw()
  ui_draw()
end
