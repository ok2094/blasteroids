require 'player'

bullets = { }
dead_bullets = { }

function bullet_load()
  bulletcanvas = love.graphics.newCanvas(12, 4)
  love.graphics.setCanvas(bulletcanvas)
	love.graphics.translate(0, 0)
  love.graphics.setColor(255, 255, 255)
	love.graphics.rectangle('fill', 0, 0, 12, 4)
  love.graphics.setCanvas()
end

function bullet_update(dt)
	--shoot
	if love.keyboard.isDown"x" and player.currentcd <= 0 then
		if #dead_bullets > 0 then
			db = table.remove(dead_bullets, 1)
			db.x = player.x
			db.y = player.y
			db.dir = player.rotation
			table.insert(bullets, db)
		else
			table.insert(bullets, {x = player.x, y = player.y, dir = player.rotation, speed = 400})
		end
		player.currentcd = player.cd
  end
	player.currentcd = math.max(0, player.currentcd - dt)

	--update bullet
	for i, o in ipairs(bullets) do
		o.x = o.x + math.cos(o.dir) * o.speed * dt
		o.y = o.y + math.sin(o.dir) * o.speed * dt
	end

	--clean up bullets
	for i = #bullets, 1, -1 do
	local b = bullets[i]
	if (b.x < -10) or (b.x > love.graphics.getWidth() + 10)
	or (b.y < -10) or (b.y > love.graphics.getHeight() + 10) then
		table.insert(dead_bullets, table.remove(bullets, i))
	end
	end
end

function bullet_draw()
	for i, o in ipairs(bullets) do
		love.graphics.draw(bulletcanvas, o.x, o.y, o.dir)
	end
end
