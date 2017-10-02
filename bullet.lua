require 'player'

bullets = { }
dead_bullets = { }

function bullet_update(dt)
	--shoot
	if love.keyboard.isDown"x" and player.currentcd <= 0 then
		if #dead_bullets > 0 then
			deadbullet = table.remove(bullets, 1)
			deadbullet.x = player.x
			deadbullet.y = player.y
			table.insert(bullets, deadbullet)
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
	local o = bullets[i]
	if (o.x < -10) or (o.x > love.graphics.getWidth() + 10)
	or (o.y < -10) or (o.y > love.graphics.getHeight() + 10) then
		table.insert(dead_bullets, table.remove(bullets, i))
	end
	end
end

function bullet_draw()
	for i, o in ipairs(bullets) do
		love.graphics.rectangle('fill', o.x, o.y, 12, 6)
	end
end
