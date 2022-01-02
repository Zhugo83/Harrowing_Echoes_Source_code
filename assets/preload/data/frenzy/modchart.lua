function start (song)
    showOnlyStrums = true
end

function update (elapsed)
    if curStep >= 1 and curStep < 2 then
    tweenCameraZoom(1.2,(crochet * 14) / 1000) -- zoom when beno and bf are singing
    end
    if curStep >= 0 and curStep < 16 then
    showOnlyStrums = true
    end
    if curStep >= 16 then
    showOnlyStrums = false -- stroom
    end
end

function stepHit (beat)

end

function playerTwoTurn()

end

function playerOneTurn()

end


function keyPressed (key)

end
