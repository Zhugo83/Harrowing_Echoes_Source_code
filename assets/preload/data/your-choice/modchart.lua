function start (song)
    print("Song: " .. song .. " @ " .. bpm .. " donwscroll: " .. downscroll)
end


function update (elapsed)
    local currentBeat = (songPos / 1000)*(bpm/60) -- chart move
        for i=0,7 do
        setActorY(defaultStrum0Y + 6 * math.cos((currentBeat + i*0.25) * math.pi), i)
        end
    if curStep >= 1024 and curStep < 1200 then
        showOnlyStrums = true
        for i = 0, 3 do -- fuk outta here
            tweenFadeOut(i,0,2)
        end
        for i = 4, 7 do -- go to the center
            tweenPosXAngle(i, _G['defaultStrum'..i..'X'] - 275,0,0.25, 'setDefault')
        end
    end
    if curStep >= 1216 and curStep < 1279 then
        for i = 4, 7 do -- here it goes
            tweenFadeOut(i,0,200)
        end
    end
end

function beatHit (beat)
    if curStep >= 256 and curStep < 284 then
    tweenCameraZoom(1.10,(crochet * 20) / 1000)
    end
    if curStep >= 570 and curStep < 670 then
    tweenCameraZoom(1.05,(crochet * 20) / 1000)
    end
    if curStep >= 958 and curStep < 1004 then
    tweenCameraZoom(1.10,(crochet * 20) / 1000)
    end
    if curStep >= 1024 and curStep < 1068 then
    tweenCameraZoom(1.075,(crochet * 20) / 1000)  
    end
end

function stepHit (step)
    if curStep == 64 then
        for i = 7, 7 do
            tweenPosXAngle(i, _G['defaultStrum'..i..'X'],getActorAngle(i) + 360, 14, 'setDefault')
        end
    end
    if curStep == 80 then
        for i = 6, 6 do
            tweenPosXAngle(i, _G['defaultStrum'..i..'X'],getActorAngle(i) + 360, 12.5, 'setDefault')
        end
    end
    if curStep == 96 then
        for i = 5, 5 do
            tweenPosXAngle(i, _G['defaultStrum'..i..'X'],getActorAngle(i) + 360, 10, 'setDefault')
        end
    end
    if curStep == 112 then
        for i = 4, 4 do
            tweenPosXAngle(i, _G['defaultStrum'..i..'X'],getActorAngle(i) + 360, 8.5, 'setDefault')
        end
    end
    if curStep == 128 then
        for i = 3, 3 do
            tweenPosXAngle(i, _G['defaultStrum'..i..'X'],getActorAngle(i) + 360, 6.5, 'setDefault')
        end
    end
    if curStep == 144 then
        for i = 2, 2 do
            tweenPosXAngle(i, _G['defaultStrum'..i..'X'],getActorAngle(i) + 360, 5, 'setDefault')
        end
    end
    if curStep == 160 then
        for i = 1, 1 do
            tweenPosXAngle(i, _G['defaultStrum'..i..'X'],getActorAngle(i) + 360, 3, 'setDefault')
        end
    end
    if curStep == 176 then
        for i = 0, 0 do
            tweenPosXAngle(i, _G['defaultStrum'..i..'X'],getActorAngle(i) + 360, 1.5, 'setDefault')
        end
    end
end

function playerTwoTurn()
    if curStep >= 0 and curStep < 170 then
    tweenCameraZoom(0.90,(crochet * 20) / 1000)
    end
    if curStep >= 400 and curStep < 454 then
    tweenCameraZoom(1.05,(crochet * 11) / 1000)
    end
end

function playerOneTurn()
    if curStep >= 0 and curStep < 170 then
    tweenCameraZoom(1,(crochet * 20) / 1000)
    end
    if curStep >= 400 and curStep < 486 then
    tweenCameraZoom(1,(crochet * 11) / 1000)
    end
end