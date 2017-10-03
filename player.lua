player = {
  x = love.graphics.getWidth() / 2,
  y = love.graphics.getHeight() / 2,
  xvel = 0,
  yvel = 0,
  rotation = 0,
  angaccel = 4,
  accel = 400,
  cd = 0.2,
  currentcd = 0
}
playermodel = {
  -28, -18,
  12, 2,
  -28, 22,
  -12, 2,
  -28, -18,
}

function player_load()
  playercanvas = love.graphics.newCanvas(44, 55)
  love.graphics.setCanvas(playercanvas)
  love.graphics.setLineWidth(2)
  love.graphics.setLineJoin("miter")
  love.graphics.setColor(255, 255, 255)
  love.graphics.line(playermodel)
  love.graphics.setCanvas()
end

function player_update(dt)
	--turning
  if love.keyboard.isDown"right" then
    player.rotation = player.rotation + player.angaccel*dt
  end
  if love.keyboard.isDown"left" then
    player.rotation = player.rotation - player.angaccel*dt
  end

	--forward and back
	if love.keyboard.isDown"down" then
    player.xvel = player.xvel - player.accel*dt * math.cos(player.rotation)
    player.yvel = player.yvel - player.accel*dt * math.sin(player.rotation)
  end
  if love.keyboard.isDown"up" then
    player.xvel = player.xvel + player.accel*dt * math.cos(player.rotation)
    player.yvel = player.yvel + player.accel*dt * math.sin(player.rotation)
  end

	player.x = player.x + player.xvel*dt
  player.y = player.y + player.yvel*dt
  player.xvel = player.xvel * 0.99
  player.yvel = player.yvel * 0.99

  local wrapBorder = 30
  local wrapZone = {
    x = -wrapBorder,
    y = -wrapBorder,
    w = love.graphics.getWidth() + wrapBorder*2,
    h = love.graphics.getHeight() + wrapBorder*2,
  }
  player.x = ((player.x - wrapZone.x) % wrapZone.w) + wrapZone.x
  player.y = ((player.y - wrapZone.y) % wrapZone.h) + wrapZone.y
end

function player_draw()
  love.graphics.draw(playercanvas, player.x, player.y, player.rotation, 1, 1, 30, 30)
end
