asteroidBigModel = {
  -30, -25,
  10, -25,
  18, -20,
  25, 15,
  14, 20,
  0, 30,
  -25, 14,
  -30, -25,
}
asteroidTimerMax = 1
asteroidTimer = asteroidTimerMax
asteroidBig = { }
dead_asteroidBig = { }

function asteroid_load()
  asteroidCanvas = love.graphics.newCanvas(60, 60)
  love.graphics.setCanvas(asteroidCanvas)
  love.graphics.translate(30, 30)
  love.graphics.setLineWidth(2)
  love.graphics.setLineJoin("miter")
  love.graphics.setColor(255, 255, 255)
  love.graphics.line(asteroidBigModel)
  love.graphics.setCanvas()
end

function asteroid_update(dt)
  asteroidTimer = asteroidTimer - (1 * dt)
  if asteroidTimer < 0 then
    asteroidTimer = asteroidTimerMax
    rndh = love.math.random(10, love.graphics.getHeight() - 10)
    rndw = love.math.random(10, love.graphics.getWidth() - 10)
    rndr = love.math.random(0, 360)
    rndrs = love.math.random(0, 5)

    if #dead_asteroidBig > 0 then
      --revive enemy
      da = table.remove(dead_asteroidBig, 1)
			da.x = rndw
			da.y = rndh
			da.dir = rndr
      da.rotation = rndr
      da.rotationspeed = rndrs
			table.insert(asteroidBig, da)
    else
    	-- Create enemy
    	table.insert(asteroidBig, { x = rndw, y = rndh, dir = rndr, rotation = rndr, rotationspeed = rndrs, speed = 100})
    end
  end

  for i = #asteroidBig, 1, -1 do
  local b = asteroidBig[i]
  if (b.x < -30) or (b.x > love.graphics.getWidth() + 30)
  or (b.y < -30) or (b.y > love.graphics.getHeight() + 30) then
    table.insert(dead_asteroidBig, table.remove(asteroidBig, i))
  end
  end

  for i, o in ipairs(asteroidBig) do
    o.x = o.x + math.cos(o.dir) * o.speed * dt
    o.y = o.y + math.sin(o.dir) * o.speed * dt
    o.rotation = o.rotation + (o.rotationspeed * dt)
  end
end

function asteroid_draw()
  for i, o in ipairs(asteroidBig) do
		love.graphics.draw(asteroidCanvas, o.x, o.y, o.rotation, 1, 1, 30, 30)
	end
end
