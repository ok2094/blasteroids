asteroidBigModel = {
  0, 5,
  40, 5,
  58, 10,
  65, 45,
  44, 50,
  30, 60,
  5, 44,
  0, 5,
}
asteroidSmallModel = {
  8, 5,
  10, 7,
  16, 12,
  30, 20,
  15, 30,
  5, 20,
  8, 5,
}
asteroidTimerMax = 0.3
asteroidTimer = asteroidTimerMax
asteroidBig = { }
dead_asteroidBig = { }
asteroidSmall = { }
dead_asteroidSmall = { }

function asteroid_load()
  asteroidBigCanvas = love.graphics.newCanvas(65, 65)
  love.graphics.setCanvas(asteroidBigCanvas)
  love.graphics.setLineWidth(2)
  love.graphics.setLineJoin("miter")
  love.graphics.setColor(255, 255, 255)
  love.graphics.line(asteroidBigModel)
  love.graphics.setCanvas()

  asteroidSmallCanvas = love.graphics.newCanvas(30, 30)
  love.graphics.setCanvas(asteroidSmallCanvas)
  love.graphics.setLineWidth(2)
  love.graphics.setLineJoin("miter")
  love.graphics.setColor(255, 255, 255)
  love.graphics.line(asteroidSmallModel)
  love.graphics.setCanvas()
end

function asteroid_update(dt)
  asteroidTimer = asteroidTimer - (1 * dt)
  if asteroidTimer < 0 then
    asteroidTimer = asteroidTimerMax
    --where to spawn
    where = love.math.random(1, 4)
    if where == 1 then
      --left
      rndh = love.math.random(-30, love.graphics.getHeight() + 30)
      rndw = -30
      rndr = love.math.random(0, 3)
    elseif where == 2 then
      --right
      rndh = love.math.random(-30, love.graphics.getHeight() + 30)
      rndw = love.graphics.getWidth() + 30
      rndr = love.math.random(3, 6)
    elseif where == 3 then
      --top
      rndh = -30
      rndw = love.math.random(-30, love.graphics.getWidth() + 30)
      rndr = love.math.random(1.5, 4.5)
    else
      --bottom
      rndh = love.graphics.getHeight() + 30
      rndw = love.math.random(-30, love.graphics.getWidth() + 30)
      if love.math.random(0, 1) == 1 then
        rndr = love.math.random(4.5, 6)
      else
        rndr = love.math.random(0, 1.5)
      end
    end
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
  if (b.x < -40) or (b.x > love.graphics.getWidth() + 40)
  or (b.y < -40) or (b.y > love.graphics.getHeight() + 40) then
    asteroidBigDies(i, false, i)
  end
  end

  for i = #asteroidSmall, 1, -1 do
  local b = asteroidSmall[i]
  if (b.x < -40) or (b.x > love.graphics.getWidth() + 40)
  or (b.y < -40) or (b.y > love.graphics.getHeight() + 40) then
    table.insert(dead_asteroidSmall, table.remove(asteroidSmall, i))
  end
  end

  for i, o in ipairs(asteroidBig) do
    o.x = o.x + math.cos(o.dir) * o.speed * dt
    o.y = o.y + math.sin(o.dir) * o.speed * dt
    o.rotation = o.rotation + (o.rotationspeed * dt)
  end

  for i, o in ipairs(asteroidSmall) do
    o.x = o.x + math.cos(o.dir) * o.speed * dt
    o.y = o.y + math.sin(o.dir) * o.speed * dt
    o.rotation = o.rotation + (o.rotationspeed * dt)
  end
end

function asteroid_draw()
  for i, o in ipairs(asteroidBig) do
		love.graphics.draw(asteroidBigCanvas, o.x, o.y, o.rotation, 1, 1, 32.5, 32.5)
	end
  for i, o in ipairs(asteroidSmall) do
    love.graphics.draw(asteroidSmallCanvas, o.x, o.y, o.rotation, 1, 1, 15, 15)
  end
end

function asteroidBigDies(i, shot, o)
  if shot then
    rndrs = love.math.random(0, 5)
    if #dead_asteroidSmall > 0 then
      --revive small asteroid 1
      da = table.remove(dead_asteroidSmall, 1)
			da.x = o.x
			da.y = o.y
			da.dir = 1.2
      da.rotation = 1.2
      da.rotationspeed = rndrs
			table.insert(asteroidSmall, da)
    else
      table.insert(asteroidSmall, { x = o.x, y = o.y, dir = 1, rotation = 1, rotationspeed = rndrs, speed = 80})
    end
    if #dead_asteroidSmall > 0 then
      --revive small asteroid 2
      da = table.remove(dead_asteroidSmall, 1)
      da.x = o.x
      da.y = o.y
      da.dir = 3.5
      da.rotation = 3.5
      da.rotationspeed = rndrs
      table.insert(asteroidSmall, da)
    else
      table.insert(asteroidSmall, { x = o.x, y = o.y, dir = 3, rotation = 3, rotationspeed = rndrs, speed = 80})
    end
    if #dead_asteroidSmall > 0 then
      --revive small asteroid 3
      da = table.remove(dead_asteroidSmall, 1)
      da.x = o.x
      da.y = o.y
      da.dir = 4.8
      da.rotation = 4.8
      da.rotationspeed = rndrs
      table.insert(asteroidSmall, da)
    else
      table.insert(asteroidSmall, { x = o.x, y = o.y, dir = 4, rotation = 4, rotationspeed = rndrs, speed = 80})
    end
    if #dead_asteroidSmall > 0 then
      --revive small asteroid 4
      da = table.remove(dead_asteroidSmall, 1)
      da.x = o.x
      da.y = o.y
      da.dir = 5.2
      da.rotation = 5.2
      da.rotationspeed = rndrs
      table.insert(asteroidSmall, da)
    else
      table.insert(asteroidSmall, { x = o.x, y = o.y, dir = 5, rotation = 5, rotationspeed = rndrs, speed = 80})
    end
  end
  table.insert(dead_asteroidBig, table.remove(asteroidBig, i))
end
