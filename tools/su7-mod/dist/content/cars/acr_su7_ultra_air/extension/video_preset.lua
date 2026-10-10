local player = ui.MediaPlayer()
player:setSource("example.mp4"):setAutoPlay(true)
player:setLooping(true)
player:setVolume(0)

function script.update(dt)
	-- ui.drawImage(player, vec2(0, 0), vec2(1080, 1080))
	display.image({image = player, pos = vec2(), size = vec2(1080,1080), color = rgbm.colors.white, uvStart = vec2(0, 0), uvEnd = vec2(1, 1)})
	if ac.getCar(0).extraF == true then
		player:setCurrentTime(0)
	end
end
