player = {
  x = love.graphics.getWidth() / 2,
  y = love.graphics.getHeight() / 2,
  xvel = 0,
  yvel = 0,
  rotation = 0,
  angaccel = 4,
  accel = 400,
  cd = 0.1,
  currentcd = 0
}
playermodel = {
  -20, -20,
  20, 0,
  -20, 20,
  -5, 0,
  -20, -20,
}

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

  local wrapBorder = 0
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
	love.graphics.setColor(255, 255, 255)
	love.graphics.translate(player.x, player.y)
	love.graphics.rotate(player.rotation)
  love.graphics.setLineWidth(2)
  love.graphics.setLineJoin("miter")
  love.graphics.line(playermodel)
end
