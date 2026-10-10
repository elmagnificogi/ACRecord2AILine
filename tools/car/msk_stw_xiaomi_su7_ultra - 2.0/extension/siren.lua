
local carSounds2 = ui.MediaPlayer()



function update(dt)

    if (car.extraF) then
        -- if(carSounds:playing() ~= true) then
        carSounds2:setSource('./sounds/siren.mp3'):setAutoPlay(true)
        carSounds2:setVolume(ac.getAudioVolume('main') * 0.9)
        carSounds2:play()
        -- carSounds:setLooping(true)
        -- end
    else
        carSounds2:pause()
        carSounds2:setCurrentTime(0)
    end

end