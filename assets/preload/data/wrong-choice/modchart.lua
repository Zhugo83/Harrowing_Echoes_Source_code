function start (song)
    print("Song: " .. song .. " @ " .. bpm .. " donwscroll: " .. downscroll)
end


function update (elapsed)
    local currentBeat = (songPos / 1000)*(bpm/60) -- chart move
        for i=0,7 do
        setActorY(defaultStrum0Y + 12 * math.cos((currentBeat + i*0.25) * math.pi), i)
        end
    if curStep >= 867 and curStep < 1200 then
        for i = 4, 7 do -- go to the center
            tweenPosXAngle(i, _G['defaultStrum'..i..'X'] - 300,0,0.25, 'setDefault')
        end
    end
    if curStep >= 1061 and curStep < 1200 then
        for i = 4, 7 do -- here it goes
            tweenFadeOut(i,0,20)
        end
    end
	if curStep >= 1 and curStep < 3 then
        for i = 0, 7 do 
            tweenFadeOut(i,0,0.01)
	showOnlyStrums = true
        end
    end
end
function beatHit (beat)
	if curStep >= 32 and curStep < 288 then
		tweenCameraZoom(1.00,(crochet * 0.5) / 1000)
	        end
	if curStep >= 351 and curStep < 544 then
		tweenCameraZoom(1.00,(crochet * 0.5) / 1000)
	        end
	if curStep >= 607 and curStep < 703 then
		tweenCameraZoom(1.00,(crochet * 0.5) / 1000)
	        end
	if curStep >= 739 and curStep < 928 then
		tweenCameraZoom(1.00,(crochet * 0.5) / 1000)
	        end
end
function stepHit (step)
    if curStep >= 867 and curStep < 1200 then
        for i = 0, 3 do -- fuk outta here
            tweenPosXAngle(i, _G['defaultStrum'..i..'X'] - 10000,0,0.25, 'setDefault')
        end
    end
	if curStep == 598 or curStep == 601 or curStep == 605 or curStep == 606 then
tweenCameraZoom(1.00,(crochet * 0.1) / 1000)
end
	if curStep >= 4 and curStep < 31 then
        for i = 0, 7 do 
            tweenFadeIn(i,1,1)
        end
    end
	if curStep >= 288 and curStep < 319 then
        for i = 4, 7 do 
            tweenFadeOut(i,0.2,0.01)
        end
    end
	if curStep >= 319 and curStep < 351 then
        for i = 4, 7 do 
            tweenFadeIn(i,1,0.01)
        for i = 0, 3 do 
            tweenFadeOut(i,0.2,0.01)
        end
    end
	end
	if curStep >= 351 and curStep < 384 then
        for i = 0, 3 do 
            tweenFadeIn(i,1,0.01)
        for i = 4, 7 do 
            tweenFadeOut(i,0.2,0.01)
        end
    end
	end
	if curStep >= 384 and curStep < 416 then
        for i = 4, 7 do 
            tweenFadeIn(i,1,0.01)
        for i = 0, 3 do 
            tweenFadeOut(i,0.2,0.01)
        end
    end
	end
	if curStep >= 416 and curStep < 1200 then
        for i = 0, 7 do 
            tweenFadeIn(i,1,0.01)
        end
    end
end

function playerTwoTurn()

end

function playerOneTurn()

end