function start (song)
	print("Song: " .. song .. " @ " .. bpm .. " donwscroll: " .. downscroll)
end



function update (elapsed)

end

function beatHit (beat)
    if curStep >= 256 and curStep < 288 then
    tweenCameraZoom(1.15,(crochet * 20) / 1000)
    end
end

function playerTwoTurn()
    if curStep >= 48 and curStep < 192 then
    tweenCameraZoom(0.90,(crochet * 12) / 1000)
    end
    if curStep >= 288 and curStep < 300 then
    tweenCameraZoom(0.95,(crochet * 12) / 1000)
    end
    if curStep >= 320 and curStep < 450 then
    tweenCameraZoom(1,(crochet * 5) / 1000)
    end
end

function playerOneTurn()
    if curStep >= 48 and curStep < 192 then
    tweenCameraZoom(1.10,(crochet * 12) / 1000)
    end
    if curStep >= 288 and curStep < 300 then
    tweenCameraZoom(1.15,(crochet * 12) / 1000)
    end
    if curStep >= 320 and curStep < 450 then
    tweenCameraZoom(1.20,(crochet * 5) / 1000)
    end
end

function keyPressed (key)

end