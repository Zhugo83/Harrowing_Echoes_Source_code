function start(song)
        showOnlyStrums = true
end

function update (elapsed)
    if curStep >= 272 and curStep < 400 then
        for i = 4, 7 do -- bruh moment
            tweenPosXAngle(i, _G['defaultStrum'..i..'X'] - 370,0,3, 'setDefault')
        end
        for i = 0, 3 do -- mmm
            tweenPosXAngle(i, _G['defaultStrum'..i..'X'] + 370,0,3, 'setDefault')
        end
    end
    if curStep >= 272 then
	for i=3,3 do 
    tweenFadeOut(i,0,20)
	for i=4,4 do 
    tweenFadeOut(i,0,20)
	end
	end
    end
    if curStep >= 288 then
	for i=2,2 do 
    tweenFadeOut(i,0,15)
	for i=5,5 do 
    tweenFadeOut(i,0,15)
	end
	end
    end
    if curStep >= 12 and curStep < 13 then
    	tweenCameraZoom(0.8,(crochet * 1) / 1000)
    end
    if curStep >= 140 and curStep < 141 then
    	tweenCameraZoom(0.8,(crochet * 1) / 1000)
    end
    if curStep >= 1 and curStep < 2 then
    	tweenCameraZoom(1.1,(crochet * 10) / 1000)
    end
end

function beatHit(beat) -- do nothing

end

function stepHit(step) -- do nothing

end

function playerTwoTurn()
    tweenCameraZoom(1.3,(crochet * 1) / 1000)
end

function playerOneTurn() -- no bf zoom because nothing work with it bruh

end