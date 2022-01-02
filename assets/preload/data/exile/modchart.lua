function start (song)
showOnlyStrums = true -- stroom
	for i=0,7 do
        tweenFadeOut(i,0,0.1) -- note gone
	end
	for i=1,7 do
        tweenFadeOut(i,0,0.1) -- note gone
	end
	for i=2,7 do
        tweenFadeOut(i,0,0.1) -- note gone
	end
	for i=3,7 do
        tweenFadeOut(i,0,0.1) -- note gone
	end
	for i=4,7 do
        tweenFadeOut(i,0,0.1) -- note gone
	end
	for i=5,7 do
        tweenFadeOut(i,0,0.1) -- note gone
	end
	for i=6,7 do
        tweenFadeOut(i,0,0.1) -- note gone
	end
	for i=7,7 do
        tweenFadeOut(i,0,0.1) -- note gone 
	end
for i=0,7 do
        tweenFadeOut(i,0,32) -- note gone
	end
	for i=1,7 do
        tweenFadeOut(i,0,32) -- note gone
	end
	for i=2,7 do
        tweenFadeOut(i,0,32) -- note gone
	end
	for i=3,7 do
        tweenFadeOut(i,0,32) -- note gone
	end
	for i=4,7 do
        tweenFadeOut(i,0,32) -- note gone
	end
	for i=5,7 do
        tweenFadeOut(i,0,32) -- note gone
	end
	for i=6,7 do
        tweenFadeOut(i,0,32) -- note gone
	end
	for i=7,7 do
        tweenFadeOut(i,0,32) -- note gone 
	end
    showOnlyStrums = true -- stroom
end

function update (elapsed)

end

function stepHit (step)
    if curStep >= 64 and curStep < 512 then
	for i=4,4 do 
    tweenFadeIn(i,0.65,0.5)
	end
    end
    if curStep >= 64 and curStep < 528 then
	for i=5,5 do 
    tweenFadeIn(i,0.65,0.5)
	end
    end
    if curStep >= 64 and curStep < 544 then
	for i=6,6 do 
    tweenFadeIn(i,0.65,0.5)
	end
    end
    if curStep >= 64 and curStep < 560 then
	for i=7,7 do 
    tweenFadeIn(i,0.65,0.5)
	end
    end
    if curStep >= 128 and curStep < 512 then
	for i=3,3 do 
    tweenFadeIn(i,0.65,0.5)
	end
    end
    if curStep >= 128 and curStep < 528 then
	for i=2,2 do 
    tweenFadeIn(i,0.65,0.5)
	end
    end
    if curStep >= 128 and curStep < 544 then
	for i=1,1 do 
    tweenFadeIn(i,0.65,0.5)
	end
    end
    if curStep >= 128 and curStep < 560 then
	for i=0,0 do 
    tweenFadeIn(i,0.65,0.5)
	end
    end
    if curStep >= 320 and curStep < 383 then
    tweenCameraZoom(1.3,(crochet * 60) / 1000)
    end
    if curStep >= 388 and curStep < 448 then
    tweenCameraZoom(1.2,(crochet * 60) / 1000)
    end
    if curStep >= 448 then
    tweenCameraZoom(1,(crochet * 60) / 1000)
    end
    if curStep >= 1 and curStep < 130 then
    tweenCameraZoom(1.2,(crochet * 125) / 1000)
    end
    if curStep >= 448 then
    tweenCameraZoom(0.9,(crochet * 60) / 1000)
    end
    if curStep >= 192 then
        showOnlyStrums = false
    end
    if curStep >= 512 then
        showOnlyStrums = true
    end
    if curStep >= 512 then
        for i = 4, 4 do -- here it goes
            tweenFadeOut(i,0,3)
        for i = 3, 3 do -- here it goes
            tweenFadeOut(i,0,3)
	end
        end
    end
    if curStep >= 528 then
        for i = 5, 5 do -- here it goes
            tweenFadeOut(i,0,3)
        for i = 2, 2 do -- here it goes
            tweenFadeOut(i,0,3)
	end
        end
    end
    if curStep >= 544 then
        for i = 6, 6 do -- here it goes
            tweenFadeOut(i,0,3)
        for i = 1, 1 do -- here it goes
            tweenFadeOut(i,0,3)
	end
        end
    end
    if curStep >= 560 then
        for i = 7, 7 do -- here it goes
            tweenFadeOut(i,0,3)
        for i = 0, 0 do -- here it goes
            tweenFadeOut(i,0,3)
	end
        end
    end
end

function playerTwoTurn()

end

function playerOneTurn()

end